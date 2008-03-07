Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 308AADDF5B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 11:20:30 +1100 (EST)
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080307001025.GA27321@netgate.macqel>
References: <20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop> <47CECB21.3060704@freescale.com>
	<1204760811.21545.231.camel@pasglop>
	<20080307001025.GA27321@netgate.macqel>
Content-Type: text/plain
Date: Fri, 07 Mar 2008 11:19:57 +1100
Message-Id: <1204849197.21545.272.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-07 at 01:10 +0100, Philippe De Muyter wrote:
> 
> But I already noticed that the interrupt numbers that the arch/powerpc tree
> uses for the parts that do already work (compact-flash and serials) are
> different from the ones I saw on the running arch/ppc tree.  e.g.,
> the serial lines used irq 26 with the arch/ppc tree and now use 42 with
> the powerpc tree.  For the pci4520, irqs changed from 53, 54 and 55 in the
> arch/ppc kernel to 17, 18 and 19 with the arch/powerpc kernel.
> That's a little bit confusing.
> 
> There must be something hidden in the sources of the openpic driver to
> explain that difference.  Could it be fixed by a setting in the dts-file ?

The interrupt numbers that you see in /proc/interrupts and that drivers
see are "virtual". They have no direct relationship to the hardware
interrupt lines (well, the kernel attempts sometimes at keeping them the
same but not always).

Basially, when the kernel establishes interrupt routing when probing
devices, it gets dynamically assigned numbers and that's what drivers
and /proc/interrupts will see, and internally "binds" them to a given HW
source on a given interrupt controller.

This is done for several reasons, the main ones being that we have to
routinely deal with multiple controllers each having it's own hardware
number space, some systems have very large HW interrupt numbers not
suitable for the irq_desc array, and we reserve virtual numbers 0 as
always invalid and 1...15 for an ISA-type 8259 controller to avoid
problems with x86-oirignated legacy junk that tries to hard code those
numbers. 

There's an compile option to see the mapping between virtual numbers and
HW numbers in debugfs, try enabling debugfs, CONFIG_VIRQ_DEBUG, and
mount debugfs somewhere. You'll see a powerpc/virq_mapping file in there
with the mapping.

Ben.
