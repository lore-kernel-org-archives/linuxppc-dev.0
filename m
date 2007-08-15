Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0AA66DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 23:54:02 +1000 (EST)
Message-ID: <46C3053C.10108@ru.mvista.com>
Date: Wed, 15 Aug 2007 17:53:00 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] PowerPC 440EPx: Sequoia board support
References: <20070814184107.GA6696@ru.mvista.com>
	<20070814190409.GA12520@ru.mvista.com>
	<20070815034808.GC22849@localhost.localdomain>
In-Reply-To: <20070815034808.GC22849@localhost.localdomain>
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
> On Tue, Aug 14, 2007 at 11:04:09PM +0400, Valentine Barshak wrote:
>> AMCC 440EPx Sequoia board support.
>> The second bit (0x4) in the 440EPx/440GRx PVR value indicates
>> the Security/Kasumi engine absence if set.
>> This bit has been removed from the pvr mask to use a single
>> cputable entry for with/without Security/Kasumi cpu versions.
>>
>>
>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>> ---
>>  arch/powerpc/kernel/cputable.c       |   18 +++++++++
>>  arch/powerpc/kernel/head_44x.S       |    2 -
>>  arch/powerpc/platforms/44x/Kconfig   |   17 ++++++++-
>>  arch/powerpc/platforms/44x/Makefile  |    1 
>>  arch/powerpc/platforms/44x/sequoia.c |   66 +++++++++++++++++++++++++++++++++++
>>  5 files changed, 102 insertions(+), 2 deletions(-)
>>
>> diff -ruN linux-2.6.orig/arch/powerpc/kernel/cputable.c linux-2.6/arch/powerpc/kernel/cputable.c
>> --- linux-2.6.orig/arch/powerpc/kernel/cputable.c	2007-08-14 17:11:18.000000000 +0400
>> +++ linux-2.6/arch/powerpc/kernel/cputable.c	2007-08-14 19:37:54.000000000 +0400
>> @@ -1132,6 +1132,24 @@
>>  		.dcache_bsize		= 32,
>>  		.platform		= "ppc440",
>>  	},
>> +	{ /* 440EPX */
>> +		.pvr_mask		= 0xf0000ffb,
>> +		.pvr_value		= 0x200008D0,
>> +		.cpu_name		= "440EPX",
>> +		.cpu_features		= CPU_FTRS_44X,
>> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
>> +		.icache_bsize		= 32,
>> +		.dcache_bsize		= 32,
>> +	},
>> +	{ /* 440GRX */
>> +		.pvr_mask		= 0xf0000ffb,
>> +		.pvr_value		= 0x200008D8,
>> +		.cpu_name		= "440GRX",
>> +		.cpu_features		= CPU_FTRS_44X,
>> +		.cpu_user_features	= COMMON_USER_BOOKE,
>> +		.icache_bsize		= 32,
>> +		.dcache_bsize		= 32,
>> +	},
>>  	{	/* 440GP Rev. B */
>>  		.pvr_mask		= 0xf0000fff,
>>  		.pvr_value		= 0x40000440,
>> diff -ruN linux-2.6.orig/arch/powerpc/kernel/head_44x.S linux-2.6/arch/powerpc/kernel/head_44x.S
>> --- linux-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-08-14 17:11:19.000000000 +0400
>> +++ linux-2.6/arch/powerpc/kernel/head_44x.S	2007-08-14 17:18:43.000000000 +0400
>> @@ -217,7 +217,7 @@
>>  	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
>>  	mtspr	SPRN_IVPR,r4
>>  
>> -#ifdef CONFIG_440EP
>> +#if defined(CONFIG_440EP) || defined(CONFIG_440EPX)
> 
> Since we should now be able to support both 440GP and 440EP boards in
> the same kernel, this probably needs to become a feature section.
> 

Thanks for pointing that out.
Talking about this, there appears to be more stuff that would need to 
become feature sections. There're lots of other ifdefs in 
arch/powerpc/kernel/head_44x.S, like ifdef CONFIG_PPC_FPU or ifdef 
CONFIG_440A
Looks like all these things have to be detected dynamically and 
configured properly at runtime since we tend to support more than one 
CPU in the same kernel.
I think this should come as a separate patch, that replaces all these 
ifdefs with the FTR_SECTION stuff.
Thanks,
Valentine.

>>  	/* Clear DAPUIB flag in CCR0 (enable APU between CPU and FPU) */
>>  	mfspr	r2,SPRN_CCR0
>>  	lis	r3,0xffef
>> diff -ruN linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig linux-2.6/arch/powerpc/platforms/44x/Kconfig
>> --- linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig	2007-08-14 17:11:17.000000000 +0400
>> +++ linux-2.6/arch/powerpc/platforms/44x/Kconfig	2007-08-14 20:36:19.000000000 +0400
>> @@ -14,6 +14,14 @@
>>  	help
>>  	  This option enables support for the IBM PPC440GP evaluation board.
>>  
>> +config SEQUOIA
>> +	bool "Sequoia"
>> +	depends on 44x
>> +	default n
>> +	select 440EPX
>> +	help
>> +	  This option enables support for the AMCC PPC440EPX evaluation board.
>> +
>>  #config LUAN
>>  #	bool "Luan"
>>  #	depends on 44x
>> @@ -37,6 +45,13 @@
>>  	select IBM440EP_ERR42
>>  #	select IBM_NEW_EMAC_ZMII
>>  
>> +config 440EPX
>> +	bool
>> +	select PPC_FPU
>> +# Disabled until the new EMAC Driver is merged.
>> +#	select IBM_NEW_EMAC_EMAC4
>> +#	select IBM_NEW_EMAC_ZMII
>> +
>>  config 440GP
>>  	bool
>>  # Disabled until the new EMAC Driver is merged.
>> @@ -50,7 +65,7 @@
>>  
>>  config 440A
>>  	bool
>> -	depends on 440GX
>> +	depends on 440GX || 440EPX
>>  	default y
>>  
>>  # 44x errata/workaround config symbols, selected by the CPU models above
>> diff -ruN linux-2.6.orig/arch/powerpc/platforms/44x/Makefile linux-2.6/arch/powerpc/platforms/44x/Makefile
>> --- linux-2.6.orig/arch/powerpc/platforms/44x/Makefile	2007-08-14 17:11:17.000000000 +0400
>> +++ linux-2.6/arch/powerpc/platforms/44x/Makefile	2007-08-14 17:18:43.000000000 +0400
>> @@ -1,3 +1,4 @@
>>  obj-$(CONFIG_44x)	:= misc_44x.o
>>  obj-$(CONFIG_EBONY)	+= ebony.o
>>  obj-$(CONFIG_BAMBOO) += bamboo.o
>> +obj-$(CONFIG_SEQUOIA)	+= sequoia.o
>> diff -ruN linux-2.6.orig/arch/powerpc/platforms/44x/sequoia.c linux-2.6/arch/powerpc/platforms/44x/sequoia.c
>> --- linux-2.6.orig/arch/powerpc/platforms/44x/sequoia.c	1970-01-01 03:00:00.000000000 +0300
>> +++ linux-2.6/arch/powerpc/platforms/44x/sequoia.c	2007-08-14 20:12:26.000000000 +0400
>> @@ -0,0 +1,66 @@
>> +/*
>> + * Sequoia board specific routines
>> + *
>> + * Valentine Barshak <vbarshak@ru.mvista.com>
>> + * Copyright 2007 MontaVista Software Inc.
>> + *
>> + * Based on the Bamboo code by
>> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> + * Copyright 2007 IBM Corporation
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +#include <linux/init.h>
>> +#include <asm/machdep.h>
>> +#include <asm/prom.h>
>> +#include <asm/udbg.h>
>> +#include <asm/time.h>
>> +#include <asm/uic.h>
>> +#include <asm/of_platform.h>
>> +#include "44x.h"
>> +
>> +static struct of_device_id sequoia_of_bus[] = {
>> +	{ .compatible = "ibm,plb", },
>> +	{ .compatible = "ibm,opb", },
>> +	{ .compatible = "ibm,ebc", },
>> +	{},
>> +};
>> +
>> +static int __init sequoia_device_probe(void)
>> +{
>> +	if (!machine_is(sequoia))
>> +		return 0;
>> +
>> +	of_platform_bus_probe(NULL, sequoia_of_bus, NULL);
>> +
>> +	return 0;
>> +}
>> +device_initcall(sequoia_device_probe);
>> +
>> +static int __init sequoia_probe(void)
>> +{
>> +	unsigned long root = of_get_flat_dt_root();
>> +
>> +	if (!of_flat_dt_is_compatible(root, "amcc,sequoia"))
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +static void __init sequoia_setup_arch(void)
>> +{
>> +}
>> +
>> +define_machine(sequoia) {
>> +	.name 				= "Sequoia",
>> +	.probe 				= sequoia_probe,
>> +	.setup_arch			= sequoia_setup_arch,
>> +	.progress 			= udbg_progress,
>> +	.init_IRQ 			= uic_init_tree,
>> +	.get_irq 			= uic_get_irq,
>> +	.restart			= ppc44x_reset_system,
>> +	.calibrate_decr			= generic_calibrate_decr,
>> +};
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
