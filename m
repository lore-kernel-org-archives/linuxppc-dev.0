Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTdTm10jqzDr5C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 07:30:52 +1000 (AEST)
Date: Fri, 11 Aug 2017 16:30:46 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jeyu@kernel.org, jikos@kernel.org, pmladek@suse.com, lpechacek@suse.cz,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v2 2/3] livepatch: send a fake signal to all blocking tasks
Message-ID: <20170811213046.bpbnhbbhqxn4jnmj@treble>
References: <20170810104815.14727-1-mbenes@suse.cz>
 <20170810104815.14727-3-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170810104815.14727-3-mbenes@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2017 at 12:48:14PM +0200, Miroslav Benes wrote:
> Last, sending the fake signal is not automatic. It is done only when
> admin requests it by writing 1 to force sysfs attribute in livepatch
> sysfs directory.

'writing 1' -> 'writing "signal"'

(unless you take my suggestion to change to two separate sysfs files)

> @@ -468,7 +468,12 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		return -EINVAL;
>  	}
>  
> -	return -EINVAL;
> +	if (!memcmp("signal", buf, min(sizeof("signal")-1, count)))
> +		klp_force_signals();

Any reason why you can't just do a strcmp()?

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
> +	pr_notice("signalling remaining tasks\n");

As a native US speaker with possible OCD spelling tendencies, it bothers
me to see "signalling" with two l's instead of one.  According to
Google, the UK spelling of the word has two l's, so maybe it's not a
typo.  I'll forgive you if you don't fix it :-)

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

I can't remember if we talked about this before, is it possible to also
signal/wake the idle tasks?

-- 
Josh
