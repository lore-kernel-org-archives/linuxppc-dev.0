Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 435EFDDDF7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 11:50:02 +1100 (EST)
Subject: FSL device-trees i8259 bugs (and others too !)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 10 Dec 2007 11:35:01 +1100
Message-Id: <1197246901.6563.38.camel@pasglop>
Mime-Version: 1.0
Cc: Kumar Gala <kumar.gala@freescale.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

I've been looking into making the 8259 driver properly apply the sense
setting to the chip. We'll probably need that for PReP and I was looking
into some issues with legacy IDE controllers flipping between legacy and
native mode since that changes the IRQ as well (legacy mode is rising
edge, while native mode is level low).

A bit of grepp'ing in arch/powerpc/boot/dts/ seems to show however that
this will break a few things in FSL land though.

First, let's quickly pass on mpc8555cds.dts which seems to have a
totally bogus 8259 node... Nodes below a PCI bridge are supposed to be
PCI devices. This isn't one, and that may cause problems in the long
run.

Then, it seems that mpc8544ds, mpc8572ds and mpc8641_hpcn all declare
interrupt maps that point to the 8259 as the parent controller... and
set the sense of all PCI interrupts to 2, which for an 8259 means
falling edge... Doesn't seem correct to me. PCI interrupts are level
low.

There might be more of such things, so if your platform uses an 8259,
please double check your IRQ sense encoding. Remember, for 8259, the
encoding is specified in the OF ISA spec and is:

	0 = level low
	1 = level high
	2 = falling edge
	3 = rising edge

Of course, Pegasos is broken, as usual, but I'll do quirks for it.

Cheers,
Ben.
