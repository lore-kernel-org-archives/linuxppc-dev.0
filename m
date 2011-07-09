Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79F0AB70F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Jul 2011 09:16:44 +1000 (EST)
Subject: Re: Analysing a kernel panic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201107080926.47588.dargaud@lpsc.in2p3.fr>
References: <201107051619.50548.dargaud@lpsc.in2p3.fr>
	<1310079493.14501.313.camel@pasglop>
	<201107080926.47588.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 10 Jul 2011 09:16:35 +1000
Message-ID: <1310253395.8267.7.camel@pasglop>
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

On Fri, 2011-07-08 at 09:26 +0200, Guillaume Dargaud wrote:
> > What is "Xad." ? (btw, coding style FAIL !)
> 
> That's the struct I use to access the control registers of the hardware.
> About the coding style, don't worry it's never going to make it into mainstream as there's only one piece of that 
> hardware ever built ! (which is also why I didn't respect things like allowing multiple devices, please don't nail me to 
> the cross for that). And it's only my 2nd real Linux driver...
> 
> > Are you trying to write to HW registers using a structure like that
> > without using the appropriate MMIO register accessors ?
> > In that case, your accesses may happen our of order since you don't have
> > memory barriers (among other potential problems).
> 
> Yes. I discovered the out() functions afterwards. But I insert asm(eieio) to avoid 'out of order' problems.

Yeah well, you may have the compiler playing tricks too. Use
{read,write}{b,w,l} instead, or the _be variants to avoid byteswap.

> > The crash looks like you aren't properly clearing the interrupt
> > condition on the HW, it remains asserted, tho it shouldn't overflow like
> > that, something seems wrong with your PIC.
> 
> Is there some constraints I should tell the electronics guys ? Should the interrupt be raised for less than some max 
> duration ? It's on a raising signal, so I don't see why that should be an issue.

What do you mean by "raising signal" ? It's meant to be positive edge
sensitive ? Maybe that's your problem, ie, maybe you haven't configued
the interrupt controller for edge trigger but for level trigger
instead ?

> > What HW is this ? What PIC ? It looks like the interrupt source isn't
> > masked on the PIC itself while it's being handled or something...
> 
> The hardware is a heavily modified Xilinx ML405 derivative.
> The PIC is a XPS_INTC (in VHDL)

Ok, I'm not familiar with that PIC. You need to check what's going on
between the PIC, your interrupt source and the kernel.

Normally, if it's an edge interrupt,  it's a single event that gets
latched by the PIC. The kernel will then call ack() on that PIC driver
(irq_chip) which should clear that latch -before- getting into your
device driver for processing.

Also, the interrupt shall either be masked while processing or if it
re-enters, the PIC code shall try to mask it (lazy masking) until the
original handler completes at which point it gets unmasked. That shall
be handled by the standard flow handlers, so it really depends on how
you hookup your PIC in SW.

It looks like one of these things isn't happening, but it's hard to tell
without seeing more of the code & vhdl

Cheers,
Ben.
