Return-Path: <andrew.dennison@motec.com.au>
Received: from mail.netspace.net.au (thunder.netspace.net.au [203.10.110.71])
	by ozlabs.org (Postfix) with ESMTP id 2CE9C2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 16:21:32 +1100 (EST)
Received: from motec.com.au (dsl-210-15-234-78.VIC.netspace.net.au
	[210.15.234.78])
	by mail.netspace.net.au (Postfix) with SMTP id 5274742F0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 16:21:24 +1100 (EST)
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 26 Nov 2004 16:21:25 +1100
Message-ID: <003401c4d377$c661e590$4000a8c0@CAT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: issues with cardbus on mpc5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm going through the process of bringing up Linux on our mpc5200 based
hardware.

I have tweaked u-boot to support our board. DDR is working, CFI can
program the flash, irq fixups done for PCI devices and I can boot into =
an
NFS root filesystem with a DENX kernel, either 2.4.23 (with RTAI =
patches)
or top of tree 2.4.25.

My problem is cardbus.

If I enable PCMCIA support in u-boot CF cards are correctly detected in
the PCMCIA sockets (haven't tried to boot from them though).

I tweaked Linux drivers/pcmcia/yenta.c to extend the IO port range, same
as seems to have been done to yenta.c in 2.6.x, so IO resources could be
allocated.

Card services detects CF cards and loads ide-cs.o, however it fails the
ide detection.
Cardbus cards cause a TEA.

I've been progressively turning on more debugging as I wade through the
code, and I have a BDI to work with, but that doesn't help much when I
don't completely understand the problem yet:)

>From my googling I know cardbus is supported on PPC, and there appear to
be several embedded PPC systems that have a PCMCIA socket so there
shouldn't be too much I need to do to make it work, however I haven't
managed to find any relevant references... Maybe there's something in =
the
linuxppc-embedded archives:(

I thought the 5200 support in Linux was doing something unusual, as
_IO_BASE was defined as 0 instead of isa_io_base, however this seems to =
be
the thing to do for embedded ppc.

Anyone with more experience in this stuff got some ideas of where I =
should
look? My PCI setup in u-boot and Linux is unchanged from the icecube
reference, so this may be a common problem?

The PCI errata doesn't seem to be relevant to what I'm experiencing as =
the
controllers are actually being detected, unlike my cardbus PCI card in =
the
lite5200.

My previous embedded Linux design used a SC520 and all this stuff just
worked. Having to learn about more than device drivers this time:)

Thanks for any help,

Andrew
