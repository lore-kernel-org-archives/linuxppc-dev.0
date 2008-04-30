Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16DFDDDF4A
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 09:52:25 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <22842BC4-C424-4681-96DF-C14E3595E335@kernel.crashing.org>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
	<1209594130.18023.258.camel@pasglop>
	<22842BC4-C424-4681-96DF-C14E3595E335@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 01 May 2008 09:52:18 +1000
Message-Id: <1209599538.18023.271.camel@pasglop>
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


On Wed, 2008-04-30 at 18:28 -0500, Kumar Gala wrote:
> > Well, you can be in trouble if you lose TIF_SIGPENDING. You don't - 
> > have-
> > to actually take the signal, it will then be done on the next
> return  
> > to
> > userspace (next timer interrupt, next syscall, ...), but  
> > TIF_SIGPENDING
> > must not be lost.
> 
> Interesting.  It seems like causing a signal from an async interrupt  
> from kernel space shouldn't be allowed.  At worse we can store back  
> the flags into the "real" thread_info.

Why shouldn't it be allowed ? We do store back flags in the real thread
info when doing irqstacks... though I just noticed we don't do that for
softirqs... paulus, isn't there a chance that we may lose a signal
there ? I wouldn't expect softirq's to often send signals to current
thread info (ie, they would use targetted flag sending which means the
SIGPENDING flag will be set in the right thread_info obtained from the
target task struct) but it still sounds safer to copy the flags back
just in case...

> yeah, so we are now pointing to stack bottom.  will fix this up.

Call it "base" rather than "bottom", sounds nicer :-)

> I agree we run all these interrupt levels with EE disabled.  Not
> sure  
> I follow what you mean by irq_enter/ext.

That should do the right thing with preempt_count(), look at do_IRQ().

Ben.
