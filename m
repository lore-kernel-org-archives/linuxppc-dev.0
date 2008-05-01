Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18803DDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 17:53:55 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<18457.1279.401197.763726@cargo.ozlabs.ibm.com>
	<A9B566F7-D00B-4202-9B85-427C38EE6070@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 01 May 2008 17:53:43 +1000
Message-Id: <1209628423.18023.286.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-05-01 at 01:01 -0500, Kumar Gala wrote:
> On Apr 30, 2008, at 6:47 PM, Paul Mackerras wrote:
> > Kumar Gala writes:
> >
> >> If we don't handle reschedule or signal will we actually not function
> >> properly?  I assume reschedule isn't an issue, but could we lose a
> >> signal?
> >
> > It depends on whether a critical or machine check handler can ever do
> > anything to generate a signal or a reschedule.  If they can't, then
> > there is no problem.
> 
> They can if the come from user space.  I'm question what it means to  
> send a signal based on receiving an async exception.

For "normal" async exceptions (ie. external interrupts), it could be
anything... EE -> network rx -> SIGIO, or you get out of EE, hit the
softirq path, figure out there was something there waiting processing
(ie, some tty task) and that results in a signal being sent...

> So we have 4 actual exceptions:
> * CriticalInput (some external device signaled this.  There are two  
> concepts of critical.  One is error the other is high priority)   
> However this would have the same caveats as any ExternalInput handler.

No, it's worse. It can interrupt code that normally has
local_irq_disabled() and thus doesn't expect to be interrupted. That
means that everything becomes unsafe including locks etc....

Note that driver that want to make active use of that probably want some
explicit local_crit_irq_disable/enable functions to be able to implement
some sort of synchronization.

> * Watchdog - pretty severe if this fires.
> 
> * Debug - user space debug is pretty straight forward.  However we  
> have features like kprobes that require kernel level support.

Which means we have to be extra careful, in fact, I consider it a design
bug of BookE to have made debug be a critical interrupt...

> * MachineCheck - pretty serve if this fires.
> 
> So I'm not if there is any good way to preclude the handlers  
> associated with these exceptions from doing the things you listed.

Ben.
