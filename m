Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yp98f2XXJzDsFc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 21:13:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@redhat.com, jeyu@kernel.org, pmladek@suse.com, lpechacek@suse.cz,
 pavel@ucw.cz, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v4 1/2] livepatch: send a fake signal to all blocking tasks
In-Reply-To: <nycvar.YFH.7.76.1711302252480.11505@cbobk.fhfr.pm>
References: <20171115135014.20594-1-mbenes@suse.cz>
 <20171115135014.20594-2-mbenes@suse.cz>
 <nycvar.YFH.7.76.1711302252480.11505@cbobk.fhfr.pm>
Date: Fri, 01 Dec 2017 21:13:36 +1100
Message-ID: <87tvxabvsf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Kosina <jikos@kernel.org> writes:
> On Wed, 15 Nov 2017, Miroslav Benes wrote:
>> Live patching consistency model is of LEAVE_PATCHED_SET and
>> SWITCH_THREAD. This means that all tasks in the system have to be marked
>> one by one as safe to call a new patched function. Safe means when a
>> task is not (sleeping) in a set of patched functions. That is, no
>> patched function is on the task's stack. Another clearly safe place is
>> the boundary between kernel and userspace. The patching waits for all
>> tasks to get outside of the patched set or to cross the boundary. The
>> transition is completed afterwards.
...
>> 
>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: x86@kernel.org
>> ---
>>  Documentation/ABI/testing/sysfs-kernel-livepatch | 12 +++++++
>>  Documentation/livepatch/livepatch.txt            | 11 +++++--
>>  arch/powerpc/kernel/signal.c                     |  6 ++--
>>  arch/x86/entry/common.c                          |  6 ++--
>>  kernel/livepatch/core.c                          | 30 +++++++++++++++++
>>  kernel/livepatch/transition.c                    | 41 ++++++++++++++++++++++++
>>  kernel/livepatch/transition.h                    |  1 +
>>  kernel/signal.c                                  |  4 ++-
>
> I'd like to be queuing this patchset for the next merge window, so if 
> there are any objections for the out-of-kernel/livepatch/* changes, please 
> speak up now.

The powerpc changes look innocuous and in-line with the change log, no
objection from me. Have an ack if you like:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
