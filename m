Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 79C96DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 22:23:59 +1000 (EST)
Message-ID: <46C2F022.8070106@ru.mvista.com>
Date: Wed, 15 Aug 2007 16:22:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] PowerPC 440EPx: Sequoia bootwrapper
References: <20070814184107.GA6696@ru.mvista.com>
	<20070814185355.GA12472@ru.mvista.com>
	<20070815034622.GB22849@localhost.localdomain>
In-Reply-To: <20070815034622.GB22849@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Aug 14, 2007 at 10:53:55PM +0400, Valentine Barshak wrote:
>> Bootwrapper code for AMCC 440EPx Sequoia board.
>> The DDR2 Denali controller support has been moved to
>>  arch/powerpc/boot/4xx.c
>> The code also uses 440EP clocking fixups
>> initially provided for 440EP Bamboo.
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> [snip]
>> diff -ruN linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c linux-2.6/arch/powerpc/boot/cuboot-sequoia.c
>> --- linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c	1970-01-01 03:00:00.000000000 +0300
>> +++ linux-2.6/arch/powerpc/boot/cuboot-sequoia.c	2007-08-14 17:25:37.000000000 +0400
>> @@ -0,0 +1,31 @@
>> +/*
>> + * Old U-boot compatibility for Sequoia
>> + *
>> + * Based on Ebony code by David Gibson <david@gibson.dropbear.id.au>
>> + *
>> + * Copyright 2007 David Gibson, IBM Corporatio.
>> + *   Based on cuboot-83xx.c, which is:
>> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation.
>> + */
>> +
>> +#include "ops.h"
>> +#include "stdio.h"
>> +#include "44x.h"
>> +#include "cuboot.h"
>> +
>> +#define TARGET_4xx
>> +#define TARGET_44x
> 
> Surely you need to be more specific than that to select the correct
> bd_t structure?
> 

Both TARGET_4xx and TARGET_44x should be selected for 44x. Otherwise I 
get wrong bd_t structure (wrong offsets to the eth0/eth1 MAC addresses). 
In the older arch/ppc code it used to be CONFIG_4xx and it was selected 
for CONFIG_40x and CONFIG_44x as well.

>> +#include "ppcboot.h"
>> +
>> +static bd_t bd;
>> +
>> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>> +                   unsigned long r6, unsigned long r7)
>> +{
>> +	CUBOOT_INIT();
>> +	sequoia_init(&bd.bi_enetaddr, &bd.bi_enet1addr);
>> +}
>> diff -ruN linux-2.6.orig/arch/powerpc/boot/Makefile linux-2.6/arch/powerpc/boot/Makefile
>> --- linux-2.6.orig/arch/powerpc/boot/Makefile	2007-08-14 17:11:16.000000000 +0400
>> +++ linux-2.6/arch/powerpc/boot/Makefile	2007-08-14 17:25:38.000000000 +0400
>> @@ -44,10 +44,11 @@
>>  src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
>>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
>>  		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
>> -		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c
>> +		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
>> +		sequoia.c
>>  src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
>>  		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
>> -		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c
>> +		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-sequoia.c
>>  src-boot := $(src-wlib) $(src-plat) empty.c
>>  
>>  src-boot := $(addprefix $(obj)/, $(src-boot))
>> @@ -143,6 +144,7 @@
>>  image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
>>  image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
>>  image-$(CONFIG_BAMBOO)			+= treeImage.bamboo
>> +image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
>>  endif
>>  
>>  # For 32-bit powermacs, build the COFF and miboot images
>> diff -ruN linux-2.6.orig/arch/powerpc/boot/sequoia.c linux-2.6/arch/powerpc/boot/sequoia.c
>> --- linux-2.6.orig/arch/powerpc/boot/sequoia.c	1970-01-01 03:00:00.000000000 +0300
>> +++ linux-2.6/arch/powerpc/boot/sequoia.c	2007-08-14 20:52:10.000000000 +0400
> 
> Unless another bootloader is expected to come along for Sequoia,
> there's no reason to separate sequoia.c from cuboot-sequoia.c
> 

The previous version of Sequoia series had treeboot-sequoia.c, but I've 
removed it since only u-boot is used now.
I'm not sure if there are any other bootloaders expected, but is it OK 
if I leave 2 separate files just in case? :)

>> @@ -0,0 +1,48 @@
>> +/*;5A
>> + * Valentine Barshak <vbarshak@ru.mvista.com>
>> + * Copyright 2007 MontaVista Software, Inc
>> + *
>> + * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> + * Copyright IBM Corporation, 2007
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; version 2 of the License
>> + */
>> +#include <stdarg.h>
>> +#include <stddef.h>
>> +#include "types.h"
>> +#include "elf.h"
>> +#include "string.h"
>> +#include "stdio.h"
>> +#include "page.h"
>> +#include "ops.h"
>> +#include "dcr.h"
>> +#include "4xx.h"
>> +#include "44x.h"
>> +
>> +extern char _dtb_start[];
>> +extern char _dtb_end[];
>> +
>> +static u8 *sequoia_mac0, *sequoia_mac1;
>> +
>> +
>> +static void sequoia_fixups(void)
>> +{
>> +	unsigned long sysclk = 33333333;
>> +
>> +	ibm440ep_fixup_clocks(sysclk, 11059200);
>> +	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
>> +	ibm4xx_denali_fixup_memsize();
>> +	dt_fixup_mac_addresses(sequoia_mac0, sequoia_mac1);
>> +}
>> +
>> +void sequoia_init(void *mac0, void *mac1)
>> +{
>> +	platform_ops.fixups = sequoia_fixups;
>> +	platform_ops.exit = ibm44x_dbcr_reset;
>> +	sequoia_mac0 = mac0;
>> +	sequoia_mac1 = mac1;
>> +	ft_init(_dtb_start, 0, 32);
>> +	serial_console_init();
>> +}
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
