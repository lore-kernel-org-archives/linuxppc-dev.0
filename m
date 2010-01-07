Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B48F41007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jan 2010 04:59:46 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o07HxgBP004937
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jan 2010 10:59:43 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o07I4kq5008911
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jan 2010 12:04:46 -0600 (CST)
Message-ID: <4B46209D.5000605@freescale.com>
Date: Thu, 07 Jan 2010 11:57:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dario Presti <dario.pr@tiscali.it>
Subject: Re: kernel panic on MPC8323 custom board
References: <27059752.post@talk.nabble.com>
In-Reply-To: <27059752.post@talk.nabble.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dario Presti wrote:
> Hello,
> I'm working on MPC8323_rdb board whit 1 new flash device S29GL512P instead
> of original flash devices.
> the bootloader is u-boot 1.1.6 (I know is too old and I'm going to upgrade
> it) and the kernel is 2.6.20.

2.6.20 is also too old. :-)

> I did this modification to the bootloader to support new flash:
> 
> 1)I modified the board/mpc8323rdb/config.mk file to set TEXT_BASE from
> 0xFE000000 TO  0xFC000000
> 2)I modified the file /include/configs/MPC8323RDB.h: 
> 
> #define CFG_FLASH_BASE		0xFC000000	/* FLASH base address */ 
> #define CFG_FLASH_SIZE		64	/* FLASH size is 64M */ 
> #define CFG_LBLAWBAR0_PRELIM	CFG_FLASH_BASE	/* Window base at flash base */
> #define CFG_LBLAWAR0_PRELIM	0x80000019	/* 64MB window size */ 
> #define CFG_OR0_PRELIM		0xfc006ff7	/* 64MB Flash size */ 
> #define CFG_MAX_FLASH_BANKS	1		/* number of banks */
> #define CFG_MAX_FLASH_SECT	512		/* sectors per device */ 
> 
> 3)I modify and recompiled .dts file 
> 
> flash@fc000000 {
> 		device_type = "jedec-flash";
> 		compatible = "direct-mapped";
> 		probe-type = "CFI";
> 		reg = <0xfc000000 0x1000000>;
> 		bank-width = <0x2>;
> 		partitions = <0x0 0x80001 0x80000 0x20000 0xa0000 0x180000 0x220000
> 0xde0000>;
> 		partition-names = "U-Boot", "dtb", "Kernel", "rootfs";
> 	};
> 
> but the kernel find the flash at 0xFE000000 and the boot stop because kernel
> panic. The log is:

Is the kernel even using that node, or some other means to determine the 
flash location?  The "MPC8323RDB Flash Bank 1" messages make me think 
you've got a custom flash map driver.

-Scott
