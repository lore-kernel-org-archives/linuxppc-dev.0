Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id AE4C867CB9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 08:21:29 +1100 (EST)
Date: Mon, 20 Nov 2006 22:21:27 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
In-Reply-To: <20061120130455.GB22330@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.60.0611202210400.5957@poirot.grange>
References: <200611201200.36780.ml@stefan-roese.de>
	<20061120114248.60bb0869@localhost.localdomain>
	<200611201255.37754.ml@stefan-roese.de>
	<20061120121015.2fb667d0@localhost.localdomain>
	<20061120130455.GB22330@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 20 Nov 2006, Russell King wrote:

> > On Mon, 20 Nov 2006 12:54:32 +0100 (MET)
> > Stefan Roese <ml@stefan-roese.de> wrote:
> > > Let's see, if I got this right. You mean that on such a platform, where 0 is a 
> > > valid physical IRQ, we should assign another value as virtual IRQ number (not 
> > > 0 and not -1 of course). And then the platform "pic" implementation should 
> > > take care of the remapping of these virtual IRQ numbers to the physical 
> > > numbers.
> 
> Since IRQ0 is not valid, can we arrange for the generic interrupt
> infrastructure to always fail it's allocation, and then remove the
> utterly unused bloatful irq_desc[0] ?
> 
> Didn't think so since x86 folk would scream.  Wait a moment, x86 can
> map IRQ0 to some other number for the timer interrupt, just like
> other architectures are being forced to map their UART interrupts.

I think, what Russell means, is this:

#define is_real_interrupt(irq) ((irq) != NO_IRQ)

where the NO_IRQ macro has been introduced a LONG time ago specifically 
for this purpose, and is conveniently defined on some platforms to 
(unsigned int)-1 or similar, including asm-powerpc/irq.h. And yes, this 
has been discussed MANY times.

Thanks
Guennadi
---
Guennadi Liakhovetski
