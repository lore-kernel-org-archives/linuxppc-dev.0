Return-Path: <david.hagood@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 109A4B70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 04:02:20 +1100 (EST)
Received: by gxk28 with SMTP id 28so1334383gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 10:02:19 -0700 (PDT)
Message-ID: <9af5fd3c8f713d261c7acdc1d195fb84.squirrel@localhost>
In-Reply-To: <20101011105031.52a5c06a@udp111988uds.am.freescale.net>
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>
	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>
	<20100921170700.53a99e56@udp111988uds.am.freescale.net>
	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>
	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
	<20101011105031.52a5c06a@udp111988uds.am.freescale.net>
Date: Mon, 11 Oct 2010 12:02:15 -0500
Subject: Re: Questions on interrupt vector assignment on MPC8641D
From: david.hagood@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Re-ordering your questions a bit:

> What board are you using?  What kernel?

One of 2 boards: Either an Embedded Planet or a Performance Tech uTCA
board based on the MPC8641D, running the 2.6.26 as supplied by EP.


> On Sat, 9 Oct 2010 10:52:49 -0500
> Documentation/powerpc/dts-bindings/fsl/mpic.txt
Not present in the version I have.

>
> Plus the chip manual, for the register offsets.
I have that now, so at least one part of the fog is a bit less dense.

> If it's not in the dts, add it.  If for whatever reason that's not an
> option, you can use irq_create_mapping() as I mentioned in the previous
> e-mail.
And as I've said previously, I have no good info on HOW to add the nodes,
WHAT to add, or WHERE. You may as well be saying "Bargle the Narbog".

And when I try to use irq_create_mapping() it seg faults, which doesn't
exactly help me get my interrupt hooked up.

(crotchety old man mode)Kids these day - when I was a kid, you just
grabbed the IRQ vector into your assembly code and away you went. Now GET
OFF MY YARD!(/crotchety old man mode).

> If you grep arch/powerpc/boot/dts for msi in a reasonably recent kernel
> you should find msi nodes.

ddhagood@WIC-102362:..Workspace/Linux_Kernel_for_PPC> grep msi
arch/powerpc/boot/dts  -ir
arch/powerpc/boot/dts/glacier.dts:			enable-msi-hole;
arch/powerpc/boot/dts/taishan.dts:			enable-msi-hole;
arch/powerpc/boot/dts/canyonlands.dts:			enable-msi-hole;
arch/powerpc/boot/dts/katmai.dts:			enable-msi-hole;

> What did I get signed up for? :-)

It sounds like Tiejun thinks you might be working on, well, basically what
I am working on - a generic interface to allow user space to support being
a endpoint, with the ability to generate interrupts to the host root
complex, get interrupts from the host root complex, provide memory to be
accessed by the host root complex via the PPC's BARs, and to access the
host root complex's PCI address space via the OATMU windows. Something to
allow a person to use a PPC SOC as an endpoint, and to get on with the job
of providing functionality rather than having to deal with esoterica.

I'm hoping to make an interface generic enough to support not only the
PPC, but other devices as well (things I cannot go into due to NDAs at
this time). As a systems programmer, I am tired of re-inventing the wheel
when dealing with being an endpoint - I want to invent the wheel, and push
it uphill to the greater Linux community so that a) others are spared the
pain I am suffering, and b) maybe other SOC vendors will implement my
interface (and thus I won't have to).
