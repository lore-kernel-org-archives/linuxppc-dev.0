Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRsF35zX9zDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 02:13:59 +1100 (AEDT)
Date: Wed, 1 Nov 2017 16:13:55 +0100
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
 lpechacek@suse.cz, pavel@ucw.cz, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
Message-ID: <20171101151355.GG20040@pathway.suse.cz>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171031114853.841-2-mbenes@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2017-10-31 12:48:52, Miroslav Benes wrote:
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
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index b004a1fb6032..6700d3b22615 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -577,3 +577,43 @@ void klp_copy_process(struct task_struct *child)
>  
>  	/* TIF_PATCH_PENDING gets copied in setup_thread_stack() */
>  }
> +
> +/*
> + * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
> + * Kthreads with TIF_PATCH_PENDING set are woken up. Only admin can request this
> + * action currently.
> + */
> +void klp_force_signals(void)
> +{
> +	struct task_struct *g, *task;
> +
> +	pr_notice("signaling remaining tasks\n");
> +
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task) {
> +		if (!klp_patch_pending(task))
> +			continue;
> +
> +		/*
> +		 * There is a small race here. We could see TIF_PATCH_PENDING
> +		 * set and decide to wake up a kthread or send a fake signal.
> +		 * Meanwhile the task could migrate itself and the action
> +		 * would be meaningless. It is not serious though.
> +		 */
> +		if (task->flags & PF_KTHREAD) {
> +			/*
> +			 * Wake up a kthread which still has not been migrated.
> +			 */
> +			wake_up_process(task);

I have just noticed that freezer used wake_up_state(p, TASK_INTERRUPTIBLE);
IMHO, we should do so as well.

wake_up_process() wakes also tasks in TASK_UNINTERRUPTIBLE state.
These might not be ready for an unexpected wakeup. For example,
see concat_dev_erase() in drivers/mtd/mtdcontact.c.

With this change, feel free to use

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
