Return-Path: <jikos@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVCVQ0nVwzDr44
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 06:03:26 +1000 (AEST)
Date: Sat, 12 Aug 2017 22:03:19 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Miroslav Benes <mbenes@suse.cz>, jeyu@kernel.org, pmladek@suse.com,
 lpechacek@suse.cz, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 2/3] livepatch: send a fake signal to all blocking tasks
In-Reply-To: <20170811213046.bpbnhbbhqxn4jnmj@treble>
Message-ID: <alpine.LSU.2.20.1708122200220.30597@cbobk.fhfr.pm>
References: <20170810104815.14727-1-mbenes@suse.cz>
 <20170810104815.14727-3-mbenes@suse.cz>
 <20170811213046.bpbnhbbhqxn4jnmj@treble>
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

On Fri, 11 Aug 2017, Josh Poimboeuf wrote:

> > +	read_lock(&tasklist_lock);
> > +	for_each_process_thread(g, task) {
> > +		if (!klp_patch_pending(task))
> > +			continue;
> > +
> > +		/*
> > +		 * There is a small race here. We could see TIF_PATCH_PENDING
> > +		 * set and decide to wake up a kthread or send a fake signal.
> > +		 * Meanwhile the task could migrate itself and the action
> > +		 * would be meaningless. It is not serious though.
> > +		 */
> > +		if (task->flags & PF_KTHREAD) {
> > +			/*
> > +			 * Wake up a kthread which still has not been migrated.
> > +			 */
> > +			wake_up_process(task);
> > +		} else {
> > +			/*
> > +			 * Send fake signal to all non-kthread tasks which are
> > +			 * still not migrated.
> > +			 */
> > +			spin_lock_irq(&task->sighand->siglock);
> > +			signal_wake_up(task, 0);
> > +			spin_unlock_irq(&task->sighand->siglock);
> > +		}
> > +	}
> > +	read_unlock(&tasklist_lock);
> 
> I can't remember if we talked about this before, is it possible to also
> signal/wake the idle tasks?

Scheduler won't select idle task in case there is *anything* else runnable 
in any other sched class anyway. And if that is the case, there is no need 
for explicit wakeup, as idle task would get scheduled anyway implicitly.

So idle task is a little bit more difficult than that, unfortunately.

-- 
Jiri Kosina
SUSE Labs
