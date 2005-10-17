Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (adsl-203-134.38-151.net24.it [151.38.134.203])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED9E2685A9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Oct 2005 02:51:25 +1000 (EST)
Received: from mail.gnudd.com (rubini@localhost [127.0.0.1])
	by mail.gnudd.com (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	j9HGgrNu021942
	for <linuxppc-embedded@ozlabs.org>; Mon, 17 Oct 2005 18:42:53 +0200
Received: (from rubini@localhost)
	by mail.gnudd.com (8.12.3/8.12.3/Debian-7.1) id j9HGgroq021941
	for linuxppc-embedded@ozlabs.org; Mon, 17 Oct 2005 18:42:53 +0200
Date: Mon, 17 Oct 2005 18:42:53 +0200
From: Alessandro Rubini <rubini@gnudd.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051017164253.GA21936@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@ar.linux.it
Subject: flash for lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello.

I'm using linux-2.6.14-rc3-g4c234921 from denx, and I need to access
the flash device.  While in 2.4 there is drivers/mtd/maps/icecube.c
(by Wolfgang Denk himself, it seems), I managed to see the flash
using the physmap driver and cmdline partitions.

Does it make sense to add the correct MTD settings to
arch/ppc/configs/lite5200_defconfig (and some hints in
Documentation/powerpc/mpc52xx.txt) without porting the whole of
maps/icecube.c or is there a specific advantage in add a file in maps?
-- well, besides having sensible partitions already ported from 2.4?

In either case, I'm willing to contribute the patch.

These are the winning settings for me, but it doesn't cope with
lite5200 speciments with 8MBi of flash (are there any still around?)
[there's more than strictly needed, actually]

CONFIG_MTD=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_CFI=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_AMDSTD_RETRY=0
CONFIG_MTD_CFI_UTIL=y

CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=0xff000000
CONFIG_MTD_PHYSMAP_LEN=0x1000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=1


/alessandro
