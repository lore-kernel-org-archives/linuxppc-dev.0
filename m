Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36908DE1D6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Oct 2008 02:47:07 +1100 (EST)
Message-ID: <48EF7859.8030503@freescale.com>
Date: Fri, 10 Oct 2008 10:44:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alemao <xcarandiru@gmail.com>
Subject: Re: MTD map drivers (FSL UPM NAND)
References: <d970ff420810091404j49492e80xcd9250d0ffdcd592@mail.gmail.com>	<48EE74FF.9000809@freescale.com>
	<d970ff420810100558i126acd8cof9e6dcd564931933@mail.gmail.com>
In-Reply-To: <d970ff420810100558i126acd8cof9e6dcd564931933@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alemao wrote:
> Here is an output from someone using it:
> 
> -----
> 
> 070500 U-Boot 1.1.2 (May 30 2007 - 20:20:09)
> 
> Motorola PowerPC
> Board: GDA Technologies CSC-PP MPC8560 [PowerQUICC III]
> CPU: 660 MHz
> CCB: 330 MHz
> DDR: 165 MHz
> 
> Creating 7 MTD partitions on "CSC flash":
> 0x00f80000-0x01000000 : "uboot"
> 0x00d00000-0x00e00000 : "kernel0"
> 0x00e00000-0x00f00000 : "kernel1"
> 0x00700000-0x00d00000 : "app"
> 0x00000000-0x00380000 : "root0"
> 0x00380000-0x00700000 : "root1"
> 0x00f00000-0x00f80000 : "env"
> 
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xca
> Scanning device for bad blocks
> Bad eraseblock 1780 at 0x0de80000
> Creating 1 MTD partitions on "NAND 256MiB 3,3V 16-bit":
> 0x00000000-0x10000000 : "NAND Partition"
> 
> -----
> 
> Thats exactly what I want to do. If you say not to use physmap with
> NAND, how he is doing this? Through the device tree source?

I see nothing in that output to suggest that physmap is being used for NAND.

NAND is not directly mapped like NOR is; you cannot just give an address 
range with no knowledge of the controller and expect it to work.

Note that if you look in drivers/mtd/maps/physmap.c, the supported probe 
types are CFI, JEDEC, and ROM.

-Scott
