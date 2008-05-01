Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36FB9DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 16:01:25 +1000 (EST)
Message-Id: <A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18457.1279.401197.763726@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Date: Thu, 1 May 2008 01:01:16 -0500
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 6:47 PM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> If we don't handle reschedule or signal will we actually not function
>> properly?  I assume reschedule isn't an issue, but could we lose a
>> signal?
>
> It depends on whether a critical or machine check handler can ever do
> anything to generate a signal or a reschedule.  If they can't, then
> there is no problem.

They can if the come from user space.  I'm question what it means to  
send a signal based on receiving an async exception.

> If they can, then we have to be very careful.  If a critical or
> machine check happens at a point where normal interrupts are disabled
> then we have to be extremely careful not to do anything that the code
> we've interrupted assumes can't happen - so we'd better not try to
> take any spinlocks, for example.  That severely limits what the
> handler can do.  It probably shouldn't even call printk, for
> instance, or wake any process up, and definitely shouldn't call
> schedule (or schedule_preempt) on the way out.

how do we provide someone stick a kprobe on such code today?

> If the critical/mcheck interrupt happens at a point where a normal
> interrupt could have happened (including when userspace is running)
> then we could treat it pretty much as a normal interrupt, including
> handling signals or reschedules on the way out if appropriate.

So we have 4 actual exceptions:
* CriticalInput (some external device signaled this.  There are two  
concepts of critical.  One is error the other is high priority)   
However this would have the same caveats as any ExternalInput handler.

* Watchdog - pretty severe if this fires.

* Debug - user space debug is pretty straight forward.  However we  
have features like kprobes that require kernel level support.

* MachineCheck - pretty serve if this fires.

So I'm not if there is any good way to preclude the handlers  
associated with these exceptions from doing the things you listed.

- k
