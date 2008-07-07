Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C916FDED8F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 02:49:48 +1000 (EST)
Date: Mon, 7 Jul 2008 11:49:28 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: update crypto node definition and device
	tree instances
Message-Id: <20080707114928.c75a03a2.kim.phillips@freescale.com>
In-Reply-To: <4278f6a4bcd22a0d3e185c47e6c76bab@kernel.crashing.org>
References: <20080703141845.af88fd51.kim.phillips@freescale.com>
	<4278f6a4bcd22a0d3e185c47e6c76bab@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 5 Jul 2008 00:45:50 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > +- compatible : Should contain entries for this and backward compatible
> > +  SEC versions, high to low, e.g., "fsl,sec2.1", "fsl,sec2.0"
> 
> First entry should state the _exact_ version of the device.  "sec-N.M"

thus the "this and" in the sentence.

> isn't good enough; there can be implementation bugs.

we already went over this here:

http://patchwork.ozlabs.org/linuxppc/patch?order=date&id=19313

> There can be more entries; you make it sound like each device tree
> should list _all_ compatible devices, which isn't the case.

again, I believe this was covered here:

http://patchwork.ozlabs.org/linuxppc/patch?order=date&id=18726

and "backward compatible" terminology started in v2 of the patch.

> A device binding should not (and can not) say how "compatible"
> should be used; instead, it should list what values of "compatible"
> this binding applies to.  You can give recommendations of course.

Not sure I understand this; you want this binding list all possible
values and be updated every time freescale makes a new version of the
SEC?  why?

> > +- interrupts : <a b> where a is the interrupt number and b is a
> > +  field that represents an encoding of the sense and level
> > +  information for the interrupt.  This should be encoded based on
> > +  the information in section 2) depending on the type of interrupt
> > +  controller you have.
> 
> #interrupt-cells isn't always 2.  Your device binding shouldn't describe
> how interrupt encoding works (that's described in the imap recommended
> practice, already); instead, it should describe which device interrupts
> are listed here, and in what order.  Sounds like you only have one
> interrupt, so that should be easy ;-)
> 
> > +- interrupt-parent : the phandle for the interrupt controller that
> > +  services interrupts for this device.
> 
> "interrupt-parent" isn't a required property.  It isn't part of this
> device binding, either.

ok, those parts were copied over verbatim, I can resubmit with better
#interrupt-cells text and without interrupt-parent.

Kim
