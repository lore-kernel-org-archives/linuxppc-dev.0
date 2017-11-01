Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRs4M0WtLzDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 02:06:25 +1100 (AEDT)
Date: Wed, 1 Nov 2017 16:06:19 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org
cc: pmladek@suse.com, lpechacek@suse.cz, pavel@ucw.cz,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
In-Reply-To: <20171031114853.841-2-mbenes@suse.cz>
Message-ID: <alpine.LSU.2.21.1711011602370.7846@san.suse.cz>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
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

So this is not as safe as one would hope. It tries to wake all TASK_NORMAL 
tasks, which could cause headaches. Let's make it

			wake_up_state(task, TASK_INTERRUPTIBLE);

to wake only kthreads sleeping interruptedly.

Thanks Petr for spotting this (offline).

Miroslav

> +		} else {
> +			/*
> +			 * Send fake signal to all non-kthread tasks which are
> +			 * still not migrated.
> +			 */
> +			spin_lock_irq(&task->sighand->siglock);
> +			signal_wake_up(task, 0);
> +			spin_unlock_irq(&task->sighand->siglock);
> +		}
> +	}
> +	read_unlock(&tasklist_lock);
> +}
