Return-Path: <AymanE@tanisys.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [206.127.28.197])
	by ozlabs.org (Postfix) with ESMTP id 51114DDFCA
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 10:42:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Help enabling PCI endpoint on 460EX, host sees disabled
Date: Wed, 10 Dec 2008 17:29:53 -0600
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F8AD@tanisys-ex2.Tanisys.Local>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My system consists of a pair of 460EXs attached by way of both PCI-E and
PCI.  Ultimately my goal is to communicate between them via pci-e (is
there anything out there that does this already?).  For a small step, I
am trying to get the PCI to work.  I already have the PCI boot ability
of the 460EXs working so the "adapter" processor is booting from the
masters main memory.  Right now I am trying to just exchange data via
the regular PCI bus.  I've looked through the kernel code and see where
it is using the "dma-ranges" from the device tree to setup the PIM
registers.  So I am good there.  When I look at the PCI bus from the
host though, I see the following output from lspci.
=20
0001:00:02.0 Class 0680: Unknown device 10e8:a003
        Subsystem: Unknown device 1014:cafe
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 22
        Memory at d80000000 (64-bit, prefetchable) [disabled]
[size=3D80000000]
        Capabilities: [c0] Message Signalled Interrupts: Mask- 64bit+
Queue=3D0/2 Enable-
        Capabilities: [d0] Power Management version 2
        Capabilities: [dc] PCI-X non-bridge device
        Capabilities: [48] Vital Product Data

I am assuming that the disabled is probably because the pci command
register on the adapter is not correct.  However I am not entirely sure.
And I assume that the disabled means I won't be able to write to it.  So
what do I need to do to get this enabled?

Thanks
