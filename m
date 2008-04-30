Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9695DDF1C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:22:16 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 01 May 2008 08:22:10 +1000
Message-Id: <1209594130.18023.258.camel@pasglop>
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


On Wed, 2008-04-30 at 17:13 -0500, Kumar Gala wrote:
> 
> If we don't handle reschedule or signal will we actually not
> function  
> properly?  I assume reschedule isn't an issue, but could we lose a  
> signal?

Well, you can be in trouble if you lose TIF_SIGPENDING. You don't -have-
to actually take the signal, it will then be done on the next return to
userspace (next timer interrupt, next syscall, ...), but TIF_SIGPENDING
must not be lost. 

> > Nothing specific to your patch, but those level##_STACK_TOP seem to
> > be pretty badly named if you end up -adding- THREAD_SIZE to actually
> > get to the stack's top. Do they really contain the stack top or do
> > they in fact contain the stack base/bottom ?
> 
> That might be stale from how the old code worked.  I can never  
> remember what we consider the top and bottom of the stack.  (please  
> remind me and I'll fixup the comments and variables).

Well, top is the high address and bottom is the low address in my view
of things :-)

> I thought about that.  The only case its a bit of an issue is for  
> CriticalInput.  I don't see Watchdog, Debug, or MachineCheck as
> being  
> performance critical.  I can use r10 if I save and restored the CR
> or  
> some other register.

You can save CR first yeah and then interleave a bit using 2 registers
(ie. 2 loads, 2 stores, or something like load 1, load 2, store 1, load
3, store 2, etc...)

> just leaving it to C code.  I assume that preempt_count should be
> the  
> same value on entry and exit.  Do think we should set HARDIRQ_OFFSET  
> for debug level exceptions?

Well... I think all those things should run with EE disabled, and thus
be considered as far as linux is concerned, as interrupts. So the C code
should do irq_enter/exit.

> Where should I look for an example of how to convey that information  
> to lockdep?

The irqtrace stuff in the asm would do maybe unless transfer_to_handler
does it already, I have to look at the code with all your patches
applied...

Ben.
