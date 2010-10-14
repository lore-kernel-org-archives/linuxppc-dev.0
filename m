Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6DFC8B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 10:57:20 +1100 (EST)
Subject: Re: Possible kernel stack overflow due to fast interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rick Tao <tao_rick@yahoo.com>
In-Reply-To: <174398.42321.qm@web50405.mail.re2.yahoo.com>
References: <174398.42321.qm@web50405.mail.re2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Oct 2010 10:57:13 +1100
Message-ID: <1287100633.2205.80.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-10-14 at 13:45 -0700, Rick Tao wrote:
> Hi, all,

 .../...

> In the context of task A
> a. NIP would point to the instruction after switch_to(). 
> b. MSR_EE is enabled in the call trace (finish_task_switch -->finish_lock_switch-->spin_unlock_irq)
> c. do something that would trigger an interrupt later on (such as timer)
> d. call schedule() for context switch to task B.
>    In this step, 
>      task B's stack is popped INT_FRAME_SIZE size for context restore.  
>    Note that task B's ksp = X - INT_FRAME_SIZE
> 
> In the context of task B again
> a1. similar to step "a" above
>
> b1. similar to step "b" above 
> c1. interrupt occurs, go to step "1" above, and repeat!!!
> 
> As you can see, task B's kernel stack space is reduced by INT_FRAME_SIZE
> on each loop. It will eventually overflow.

So if I follow you correctly, you are worried that by the time execution
resumes in B, and before it pops the second frame off, it might get
another interrupt and re-preempt...

Now unless I missed something, that cannot happen because
preempt_schedule_irq() does increment the preempt count:

	add_preempt_count(PREEMPT_ACTIVE);
	local_irq_enable();
	schedule();
	local_irq_disable();
	sub_preempt_count(PREEMPT_ACTIVE);

Which means that it won't preempt again in finish_task_switch, and so
will eventually come back, turn EE back off, and pop off the stack
frame.

Or am I missing something ?

Cheers,
Ben.
