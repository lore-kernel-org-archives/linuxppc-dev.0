Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DADBDDE9A
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 14:09:19 +1000 (EST)
Subject: Re: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <1192853044.17235.32.camel@pasglop>
References: <1192670742.12879.5.camel@pasglop>
	<200710200402.43106.maximlevitsky@gmail.com>
	<alpine.LFD.0.999.0710191924520.3794@woody.linux-foundation.org>
	<1192853044.17235.32.camel@pasglop>
Content-Type: text/plain
Date: Sat, 20 Oct 2007 14:09:10 +1000
Message-Id: <1192853350.17235.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >  - even when you ignore the interrupt (because the driver doesn't care, 
> >    it's suspending), you need to make sure the hardware gets shut up by 
> >    reading (or writing) the proper interrupt status register.
> >
> >    Otherwise, with a level interrupt, the interrupt will continue to be 
> >    held active ("screaming") and the CPU will get interrupted over and 
> >    over again, until the irq subsystem will just turn the irq off 
> >    entirely.
> 
> His suspend routine wrote to the IRQ mask (or equivalent) register in
> his code example, thus the HW should shut up eventually, thus that isn't
> strictly necessary, the IRQ in that case is just a "short
> interrupt" (noticed by the PIC and delivered but possibly not asserted
> anymore at this stage or about to go down).

In fact, he -must not- ack it. Because is the HW is really down (in D3),
got knows what accessing the ACK register will do. I can give you
ideas... from nothing on most x86 desktops to machine checks on most
powerpc machines, though I could imagine some cards bad enough to lock
your bus up if you try to access a register while they are in D3 (I've
seen some of those critters and it seems not all bridges timeout on
cards that just keep sending retries).

Cheers,
Ben.
