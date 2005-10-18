Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 35099685BE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 01:47:40 +1000 (EST)
Received: from White64 (p54B49B0E.dip0.t-ipconnect.de [84.180.155.14])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id j9IFNCb06912
	for <linuxppc-embedded@ozlabs.org>; Tue, 18 Oct 2005 17:23:27 +0200
Date: Tue, 18 Oct 2005 17:22:48 +0200
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051018172248.6f143a87@White64>
In-Reply-To: <20051017164253.GA21936@mail.gnudd.com>
References: <20051017164253.GA21936@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: flash for lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


The Lite5200 has an official Port to 2.6 by Sylvain Munaut
<tnt@246tNt.com>

There is an Mapping MTD driver ready.

if it's not in vanilla, you found a patchset on Mailign archive or
on Sylvain's HP.


Am Mon, 17 Oct 2005 18:42:53 +0200 schrieb Alessandro Rubini
<rubini@gnudd.com> :

> 
> Hello.
> 
> I'm using linux-2.6.14-rc3-g4c234921 from denx, and I need to access
> the flash device.  While in 2.4 there is drivers/mtd/maps/icecube.c
> (by Wolfgang Denk himself, it seems), I managed to see the flash
> using the physmap driver and cmdline partitions.
> 
> Does it make sense to add the correct MTD settings to
> arch/ppc/configs/lite5200_defconfig (and some hints in
> Documentation/powerpc/mpc52xx.txt) without porting the whole of
> maps/icecube.c or is there a specific advantage in add a file in maps?
> -- well, besides having sensible partitions already ported from 2.4?
> 
> In either case, I'm willing to contribute the patch.
> 
> These are the winning settings for me, but it doesn't cope with
> lite5200 speciments with 8MBi of flash (are there any still around?)
> [there's more than strictly needed, actually]
> 
> CONFIG_MTD=y
> CONFIG_MTD_PARTITIONS=y
> CONFIG_MTD_CMDLINE_PARTS=y
> CONFIG_MTD_CHAR=y
> CONFIG_MTD_CFI=y
> CONFIG_MTD_GEN_PROBE=y
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> CONFIG_MTD_CFI_INTELEXT=y
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_AMDSTD_RETRY=0
> CONFIG_MTD_CFI_UTIL=y
> 
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_START=0xff000000
> CONFIG_MTD_PHYSMAP_LEN=0x1000000
> CONFIG_MTD_PHYSMAP_BANKWIDTH=1
> 
> 
> /alessandro
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
