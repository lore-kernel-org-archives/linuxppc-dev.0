Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 6B8EAB7BF4
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jan 2010 20:23:44 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1NTB4H-0002Kv-V1
	for linuxppc-dev@ozlabs.org; Fri, 08 Jan 2010 01:23:41 -0800
Message-ID: <27073289.post@talk.nabble.com>
Date: Fri, 8 Jan 2010 01:23:41 -0800 (PST)
From: Dario Presti <dario.pr@tiscali.it>
To: linuxppc-dev@ozlabs.org
Subject: Re: kernel panic on MPC8323 custom board
In-Reply-To: <4B46209D.5000605@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <27059752.post@talk.nabble.com> <4B46209D.5000605@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Scott Wood-2 wrote:
> 
> Dario Presti wrote:
>> Hello,
>> I'm working on MPC8323_rdb board whit 1 new flash device S29GL512P
>> instead
>> of original flash devices.
>> the bootloader is u-boot 1.1.6 (I know is too old and I'm going to
>> upgrade
>> it) and the kernel is 2.6.20.
> 
> 2.6.20 is also too old. :-)
> 
>> I did this modification to the bootloader to support new flash:
>> 
>> 1)I modified the board/mpc8323rdb/config.mk file to set TEXT_BASE from
>> 0xFE000000 TO  0xFC000000
>> 2)I modified the file /include/configs/MPC8323RDB.h: 
>> 
>> #define CFG_FLASH_BASE		0xFC000000	/* FLASH base address */ 
>> #define CFG_FLASH_SIZE		64	/* FLASH size is 64M */ 
>> #define CFG_LBLAWBAR0_PRELIM	CFG_FLASH_BASE	/* Window base at flash base
>> */
>> #define CFG_LBLAWAR0_PRELIM	0x80000019	/* 64MB window size */ 
>> #define CFG_OR0_PRELIM		0xfc006ff7	/* 64MB Flash size */ 
>> #define CFG_MAX_FLASH_BANKS	1		/* number of banks */
>> #define CFG_MAX_FLASH_SECT	512		/* sectors per device */ 
>> 
>> 3)I modify and recompiled .dts file 
>> 
>> flash@fc000000 {
>> 		device_type = "jedec-flash";
>> 		compatible = "direct-mapped";
>> 		probe-type = "CFI";
>> 		reg = <0xfc000000 0x1000000>;
>> 		bank-width = <0x2>;
>> 		partitions = <0x0 0x80001 0x80000 0x20000 0xa0000 0x180000 0x220000
>> 0xde0000>;
>> 		partition-names = "U-Boot", "dtb", "Kernel", "rootfs";
>> 	};
>> 
>> but the kernel find the flash at 0xFE000000 and the boot stop because
>> kernel
>> panic. The log is:
> 
> Is the kernel even using that node, or some other means to determine the 
> flash location?  The "MPC8323RDB Flash Bank 1" messages make me think 
> you've got a custom flash map driver.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

Thanks Scott, 
I did not find where the custom map flash driver is in the kernel source,
where it is?
How can I say to the kernel to use device tree instead of custom map of
flash?

Regards
Dario
-- 
View this message in context: http://old.nabble.com/kernel-panic-on-MPC8323-custom-board-tp27059752p27073289.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
