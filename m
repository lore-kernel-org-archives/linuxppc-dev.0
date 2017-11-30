Return-Path: <jikos@kernel.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynrkn55WqzDsFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 08:53:37 +1100 (AEDT)
Date: Thu, 30 Nov 2017 22:53:32 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
cc: jpoimboe@redhat.com, jeyu@kernel.org, pmladek@suse.com, lpechacek@suse.cz,
 pavel@ucw.cz, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v4 1/2] livepatch: send a fake signal to all blocking tasks
In-Reply-To: <20171115135014.20594-2-mbenes@suse.cz>
Message-ID: <nycvar.YFH.7.76.1711302252480.11505@cbobk.fhfr.pm>
References: <20171115135014.20594-1-mbenes@suse.cz>
 <20171115135014.20594-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 15 Nov 2017, Miroslav Benes wrote:

> Live patching consistency model is of LEAVE_PATCHED_SET and
> SWITCH_THREAD. This means that all tasks in the system have to be marked
> one by one as safe to call a new patched function. Safe means when a
> task is not (sleeping) in a set of patched functions. That is, no
> patched function is on the task's stack. Another clearly safe place is
> the boundary between kernel and userspace. The patching waits for all
> tasks to get outside of the patched set or to cross the boundary. The
> transition is completed afterwards.
> 
> The problem is that a task can block the transition for quite a long
> time, if not forever. It could sleep in a set of patched functions, for
> example.  Luckily we can force the task to leave the set by sending it a
> fake signal, that is a signal with no data in signal pending structures
> (no handler, no sign of proper signal delivered). Suspend/freezer use
> this to freeze the tasks as well. The task gets TIF_SIGPENDING set and
> is woken up (if it has been sleeping in the kernel before) or kicked by
> rescheduling IPI (if it was running on other CPU). This causes the task
> to go to kernel/userspace boundary where the signal would be handled and
> the task would be marked as safe in terms of live patching.
> 
> There are tasks which are not affected by this technique though. The
> fake signal is not sent to kthreads. They should be handled differently.
> They can be woken up so they leave the patched set and their
> TIF_PATCH_PENDING can be cleared thanks to stack checking.
> 
> For the sake of completeness, if the task is in TASK_RUNNING state but
> not currently running on some CPU it doesn't get the IPI, but it would
> eventually handle the signal anyway. Second, if the task runs in the
> kernel (in TASK_RUNNING state) it gets the IPI, but the signal is not
> handled on return from the interrupt. It would be handled on return to
> the userspace in the future when the fake signal is sent again. Stack
> checking deals with these cases in a better way.
> 
> If the task was sleeping in a syscall it would be woken by our fake
> signal, it would check if TIF_SIGPENDING is set (by calling
> signal_pending() predicate) and return ERESTART* or EINTR. Syscalls with
> ERESTART* return values are restarted in case of the fake signal (see
> do_signal()). EINTR is propagated back to the userspace program. This
> could disturb the program, but...
> 
> * each process dealing with signals should react accordingly to EINTR
>   return values.
> * syscalls returning EINTR happen to be quite common situation in the
>   system even if no fake signal is sent.
> * freezer sends the fake signal and does not deal with EINTR anyhow.
>   Thus EINTR values are returned when the system is resumed.
> 
> The very safe marking is done in architectures' "entry" on syscall and
> interrupt/exception exit paths, and in a stack checking functions of
> livepatch.  TIF_PATCH_PENDING is cleared and the next
> recalc_sigpending() drops TIF_SIGPENDING. In connection with this, also
> call klp_update_patch_state() before do_signal(), so that
> recalc_sigpending() in dequeue_signal() can clear TIF_PATCH_PENDING
> immediately and thus prevent a double call of do_signal().
> 
> Note that the fake signal is not sent to stopped/traced tasks. Such task
> prevents the patching to finish till it continues again (is not traced
> anymore).
> 
> Last, sending the fake signal is not automatic. It is done only when
> admin requests it by writing 1 to signal sysfs attribute in livepatch
> sysfs directory.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> ---
>  Documentation/ABI/testing/sysfs-kernel-livepatch | 12 +++++++
>  Documentation/livepatch/livepatch.txt            | 11 +++++--
>  arch/powerpc/kernel/signal.c                     |  6 ++--
>  arch/x86/entry/common.c                          |  6 ++--
>  kernel/livepatch/core.c                          | 30 +++++++++++++++++
>  kernel/livepatch/transition.c                    | 41 ++++++++++++++++++++++++
>  kernel/livepatch/transition.h                    |  1 +
>  kernel/signal.c                                  |  4 ++-

I'd like to be queuing this patchset for the next merge window, so if 
there are any objections for the out-of-kernel/livepatch/* changes, please 
speak up now.

Thanks.

-- 
Jiri Kosina
SUSE Labs
