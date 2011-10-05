Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
	[IPv6:2001:470:1f0b:1c35:abcd:42:0:1])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A48CB6F9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 02:31:54 +1100 (EST)
Date: Wed, 5 Oct 2011 17:31:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [patch 0/4] powerpc: Mark various interrupts IRQF_NO_THREAD
In-Reply-To: <20111005132949.GA25028@iram.es>
Message-ID: <alpine.LFD.2.02.1110051722140.18778@ionos>
References: <20111005122122.553832402@linutronix.de>
	<20111005132949.GA25028@iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Oct 2011, Gabriel Paubert wrote:

> On Wed, Oct 05, 2011 at 12:30:49PM -0000, Thomas Gleixner wrote:
> > The following series marks the obvious interrupts IRQF_NO_THREAD to
> > prevent forced interrupt threading - no guarantee of completeness :)
> > 
> > The last patch enables the forced threading mechanism in the core
> > code, which in turn enables the "irqthreaded" commandline option.
> 
> Is there any description of what "interrupt threading" means?

That means that the interrupt handler is running in a thread. The
interrupt itself merily wakes the thread. That's a debugging option in
mainline - it comes handy when interrupt handlers crash as the system
just kills the thread, but stays otherwise alive. If the same
situation happens in the normal hard interrupt context, then it takes
them machine down completely.

Aside of that it's a prerequisite to support PREEMPT_RT on your
arch/machine.

> I'm only looking for a pointer to a web page, a mailing list thread

https://lwn.net/Articles/429690/

> (I am no more subscribed to lkml, too many things to do, so maybe
> it has been discussed but it comes out of the blue on linuxppc-dev), 
> or a well commented git commit?
> 
> >From followups, I see that cascaded interrupt controller should
> not be threaded. I suspect that the private VME bridge driver
> (Universe chip) I maintain here will need it: clients request
> a given VME interrupt (level/vector) and specify an interrupt
> handler which is called by the handler for the PCI interrupt.

Can't tell as I don't know how your code looks like. If your
subinterrupts are registered with the core interrupt system and the
drivers install their handlers via request_irq(), then yes. If you
just have your own registration and handling stuff (which you
shouldn't) then you might be better off to let the dispatch interrupt
handler be threaded so that all the demuxed ones run in that same
thread.

Thanks,

	tglx
