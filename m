Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from ex01.ads.ubidyne.de (mail.ubidyne.com [212.211.133.238])
	by ozlabs.org (Postfix) with ESMTP id 5DEADDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 19:55:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: Could not create MTD Partitions
Date: Wed, 28 Feb 2007 09:55:04 +0100
Message-ID: <29DC34A6B43468409F5A371CFE34E8490B621B@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Well, actually I'm not sure. But I found some details
In the manual:

32x Bus DDR
SDRAM w/ ECC

32 MByte=20
128 Mbit (8M x 16 bit) devices
2 Micron MT46V8M16TG-6T
4 MBytes x 4 banks x 2 devices =3D 32 MBytes total
2 bit bank address at 4[BA0,BA1]
12 bit row address at 4K [A0:A11]
9 bit column address at 512[A0:A8]

64 MByte=20
256 Mbit (16M x 16 bit) devices
2 Micron MT46V16M16TG-6T
8 MBytes x 4 banks x 2 devices =3D 64 MBytes total
2 bit bank address at 4[BA0,BA1]
13 bit row address at 8K [A0:A12]
9 bit column address at 512[A0:A8]

128 MByte=20
512 Mbit (32M x 16 bit) devices
2 Micron MT46V32M16TG-6T
16 MBytes x 4 banks x 2 devices =3D 128 MBytes total
2 bit bank address at 4[BA0,BA1]
13 bit row address at 8K [A0:A12]
10 bit column address at 1K[A0:A9]


Are the details for the 64MByte corresponding to that post
from Gerhard?

@Gerhard
Here are some parts of my configuration regarding the MTD settings.
Could you tell which I have to modify to get running the MTD partitions?

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dy
# CONFIG_MTD_DEBUG is not set
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=3Dy
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dy
CONFIG_MTD_BLOCK=3Dy
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=3Dy
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=3Dy
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=3Dy
# CONFIG_MTD_RAM is not set
CONFIG_MTD_ROM=3Dy
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_EP8343M=3Dy
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set


Many thanks for any advice!
Best regards
Frank






-----Urspr=FCngliche Nachricht-----
Von: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Gesendet: Dienstag, 27. Februar 2007 19:53
An: Frank Prepelica
Cc: linuxppc-embedded@ozlabs.org
Betreff: Re: Could not create MTD Partitions


On Feb 27, 2007, at 3:48 AM, Frank Prepelica wrote:

> Hi all,
>
>
>
> I got a problem during creating the MTD partitions. I'm using the
>
> ELDK 4.1 with 2.6.19.2 Kernel and the MPC8343 board with 128MB RAM
>
> and 64MB flash memory.

Are you sure its a single flash chip that is 64M or multiple flash =20
chips?

- k
