Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14090DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 12:24:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: understanding an IO question
Date: Tue, 20 Feb 2007 17:13:47 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A164@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a board using an 8541 which is based on the mpc85xx_cds bsp. It
has one PCI device connected to the 8541, an ASIC we make that maps in
resources for its registers at 0x8400_0000 - 0x8400_0038.

The driver for our ASIC works in an 8241 design and I am trying to get
its register access working in the 8541 and need a little additional
understanding.

I can see in cat /proc/iomem where we have memory apparently allocated
for our registers, like this.

cat /proc/iomem
80000000-9fffffff : PCI1 host bridge
  84000000-84000038 : ichar
  88000000-8fffffff : ichar
e0003000-e00030ff : fsl-i2c.1
e0004500-e0004507 : serial

In our driver, I do an ioremap_nocache with 0x8400_0000 as an argument
to the ioremap and am returned a virtual address of the form
0xc905_8000. Unfortunately, I cannot seem to access my registers as they
all return zero when accessed with the iowrite32/ioread32 helper
functions.

A little further. We do use the Outbound Address Translation window
feature in the 8541 to get to our PCI device and I do set this up in
uboot and I can read and write registers on our ASIC from uboot. Its
just in the Linux driver that I seem to be having trouble.

So,... I am hoping someone could give me a couple of pointers on where
to look next for the missing piece of why I cannot access the registers
on our ASIC from Linux whereas things were working fine from uboot
before booting Linux.

Charles
