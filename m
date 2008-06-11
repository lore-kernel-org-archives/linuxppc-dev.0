Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F2775DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 11:19:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PPC to PowerPC Migration
Date: Tue, 10 Jun 2008 18:19:39 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6022A3E4A@uss-am-xch-01.am.trimblecorp.net>
In-Reply-To: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
References: <c443b0db0806101048t1df8c11ag456fbc352709966b@mail.gmail.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Andy Schmidt" <andrewgschmidt@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Great Idea Andrew. I am no long-serving expert, but over the past few
years I've had some ARM-linux and more recently mpc5200 Linux exposure.
For the mpc5200 we started as ppc under 2.6.16 a few months ago. I
recently migrated to 2.6.24 with ARCH=3Dpowerpc.

These were the conceptual difficulties I had at first:

1) Where the *%$# are the register address defines?
	-Ahhh, the register definition header file maps to HW via the
device tree. Cool. Now how the $%# do I interface to the tree from my
drivers?
3) How do I request an IRQ?
  You need to create a "device" in the device tree. This is
non-intuitive because most of what you see in the tree when you start
represents actual, "devices": SOC peripherals and such. I looked and
looked for how to request
IRQ3. It was so easy when I created a, "device" and specified the
interrupt according to instructions in
Documentation/powerpc/mpc5200xx-device-tree-bindings.txt.txt
4) How do I traverse the device tree from my code: my device drivers?
  -functions like mpc52xx_find_and_map("name_from_dev_tree") are used to
map peripheral registers to the relevant defined struct from your
register definition header file.
 - Also look for, "open firmware" (of) functions like
irq_of_parse_and_map(node,0).
- basically, the "find_and_map", and "parse_and_map" means your driver
is traversing the device tree data. Grep on this sort of thing to find
examples
Of how various drivers interface to the device tree info.

This is all very simple for so many of you, but I did wrestle with some
conceptual difficulties. Andrew, if this makes any sense to you perhaps
you
Can roll it into your HOWTO. Perhaps we can collaborate offline and
publish something more useful than what I just wrote above.

-Mike

=20
-----Original Message-----
From: linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+mike_timmons=3Dtrimble.com@ozlabs.org]
On Behalf Of Andy Schmidt
Sent: Tuesday, June 10, 2008 12:49 PM
To: linuxppc-embedded@ozlabs.org
Subject: PPC to PowerPC Migration

I am wondering if anyone has seen any good documentation for migrating
from the arch/ppc to arch/powerpc.  Specifically, I am working with a
Xilinx board so I am more accustom to the xparamters.h vs. device
trees.  I am very willing to build a (or multiple) tutorials to help
others in my situation, I just need some initial help getting started.
 If anyone can point me in the right direction, I will be sure to keep
the group (or those interested) updated on the documentation.

Thank you,
Andrew
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
