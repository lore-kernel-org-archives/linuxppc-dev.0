Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 09F51B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2012 07:24:41 +1000 (EST)
Message-ID: <1334957071.3197.28.camel@pasglop>
Subject: Re: pci node question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 21 Apr 2012 07:24:31 +1000
In-Reply-To: <4F91CCCA.1050204@freescale.com>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <4F91B335.4010501@freescale.com>
 <EDA55B32-FD14-4B5C-90AF-7FC5F77898E0@kernel.crashing.org>
 <4F91CCCA.1050204@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Between the root complex and whatever's plugged in?

Yes.

> > so that is what the node represents.  Its always been a bit confusing to me as its not 100% standardized by PCI sig.

It's absolutely standard. The only case where you have "siblings" to
that RC is when it's some kind of integrated chipset with non-PCI
devices in it (still common in Intel world).

Any real PCIe device -must- have a P2P above it with the PCIe capability
& associated control registers.

> Is it documented anywhere (e.g. in the chip manual)?  Is it common (even
> if 100% standardized), or a Freescale-ism?

PCIe spec.

> Is there an actual PCIe-to-PCIe bridge that shows up in the root
> complex's config space

Yes.

>  (not talking about the host bridge PCI device
> that has always been there on FSL PCI controllers, which we didn't
> represent in the device tree on non-express PCI)?  Why does this bridge
> need to be represented in the device tree (assuming no ISA devices need
> to be represented), when other PCI devices (including bridges) don't?

You don't have to, but we sometimes do it so we can put the
interrupt-map in the right place. But again, since on PCIe the device
underneath should always have dev 0 for non-SRIOV stuff, the swizzling
shall be NOP and so having the interrupt-map all the way at the top
might work. However I'm not sure if that will work with PFs and ARI
where the dev is non-0.

> > Maybe Ben's got some comments to add here from a generic PCIe point of view.
> > 
> >>>> Do we really need the error interrupt specified twice?
> >>>
> >>> I put it twice because it has multiple purposes, one has to do with interrupts defined by the PCI spec vs ones defined via FSL controller.
> >>
> >> There are PCI-defined error conditions that cause a host controller
> >> interrupt.  What does this have to do with the bridge node?
> > 
> > Think of the "error" IRQ as shared between to classes of interrupts.  One set are controller errors defined by FSL, the other are errors defined by PCI sig / bus point of view.
> > 
> > I'd expect controller errors to be handled by something like EDAC would bind at "fsl,qoriq-pcie-v2.2" level node.  The PCI bus code would looks at the virtual bridge down.
> 
> This shouldn't be about where a specific piece of Linux code looks.
> 
> I don't see why the split of PCI-defined errors versus FSL-defined
> errors maps to bridge node versus controller node.  What if we didn't
> have the bridge?  We'd still have PCI-defined errors, right?

The linux generic PCIe port driver looks for the interrupt of the bridge
for standardized PCIe AER interrupts.

Cheers,
Ben.

> -Scott
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
