Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17008DDF6E
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 11:14:01 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l831E2NQ010761
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:14:02 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l831HXte210992
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:17:33 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l832DxdU002510
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 12:13:59 +1000
Date: Mon, 3 Sep 2007 11:13:52 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 6/6] Walnut zImage wrapper
Message-ID: <20070903011352.GF31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>>
	<20070831200643.675381000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070831200643.675381000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2007 at 03:04:55PM -0500, Josh Boyer wrote:
> Add zImage wrapper for walnut board
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

[snip]
> --- /dev/null
> +++ linux-2.6/arch/powerpc/boot/treeboot-walnut.c
> @@ -0,0 +1,133 @@
> +/*
> + * Old U-boot compatibility for Walnut
> + *
> + * Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + *
> + * Copyright 2007 IBM Corporation
> + *   Based on cuboot-83xx.c, which is:
> + * Copyright (c) 2007 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include "ops.h"
> +#include "stdio.h"
> +#include "dcr.h"
> +#include "4xx.h"
> +#include "io.h"
> +
> +BSS_STACK(4096);
> +
> +void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
> +{
> +	u32 pllmr = mfdcr(0xb0);

Please add #defines for the DCR numbers, rather than using literals.

> +	u32 cpc0_cr0 = mfdcr(0xb1);
> +	u32 cpc0_cr1 = mfdcr(0xb2);
> +	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
> +	u32 fwdv, fbdv, cbdv, opdv, epdv, udiv;
> +
> +	fwdv = (8 - ((pllmr & 0xe0000000) >> 29));
> +	fbdv = (pllmr & 0x1e000000) >> 25;
> +	cbdv = ((pllmr & 0x00060000) >> 17) + 1;
> +	opdv = ((pllmr & 0x00018000) >> 15) + 1;
> +	epdv = ((pllmr & 0x00001800) >> 13) + 2;
> +	udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1;
> +
> +	m = fwdv * fbdv * cbdv;
> +
> +	cpu = sysclk * m / fwdv;
> +	plb = cpu / cbdv;
> +	opb = plb / opdv;
> +	ebc = plb / epdv;
> +
> +	if (cpc0_cr0 & 0x80) {
> +		/* uart0 uses the external clock */
> +		uart0 = ser_clk;
> +	} else {
> +		uart0 = cpu / udiv;
> +	}
> +
> +	if (cpc0_cr0 & 0x40) {
> +		/* uart1 uses the external clock */
> +		uart1 = ser_clk;
> +	} else {
> +		uart1 = cpu / udiv;
> +	}
> +
> +	/* setup the timebase clock to tick at the cpu frequency */
> +	cpc0_cr1 = cpc0_cr1 & ~ 0x00800000;
> +	mtdcr(0xb2, cpc0_cr1);
> +	tb = cpu;
> +
> +	dt_fixup_cpu_clocks(cpu, tb, 0);
> +	dt_fixup_clock("/plb", plb);
> +	dt_fixup_clock("/plb/opb", opb);
> +	dt_fixup_clock("/plb/ebc", ebc);
> +	dt_fixup_clock("/plb/opb/serial@300", uart0);
> +	dt_fixup_clock("/plb/opb/serial@400", uart1);
> +}
> +
> +static void walnut_flashsel_fixup(void)
> +{
> +	void *devp, *sram;
> +	u32 reg_flash[3] = {0x0, 0x0, 0x80000};
> +	u32 reg_sram[3] = {0x0, 0x0, 0x80000};
> +	u8 *fpga;
> +	u8 fpga_brds1 = 0x0;
> +
> +	devp = finddevice("/plb/ebc/fpga");
> +	if (!devp)
> +		fatal("Couldn't locate FPGA node\n\r");
> +
> +	if (getprop(devp, "virtual-reg", &fpga, sizeof(fpga)) != sizeof(fpga))
> +		fatal("no virtual-reg property\n\r");
> +
> +	fpga_brds1 = in_8(fpga);
> +
> +	printf("FPGA_BRDS1: %08x\n", fpga_brds1);
> +
> +	devp = finddevice("/plb/ebc/flash");
> +	if (!devp)
> +		fatal("Couldn't locate flash node\n\r");
> +
> +	if (getprop(devp, "reg", reg_flash, sizeof(reg_flash)) != sizeof(reg_flash))
> +		fatal("flash reg property has unexpected size\n\r");
> +
> +	sram = finddevice("/plb/ebc/sram");
> +	if (!sram)
> +		fatal("Couldn't locate sram node\n\r");
> +
> +	if (getprop(sram, "reg", reg_sram, sizeof(reg_sram)) != sizeof(reg_sram))
> +		fatal("sram reg property has unexpected size\n\r");
> +
> +	if (fpga_brds1 & 0x1) {
> +		reg_flash[1] ^= 0x80000;
> +		reg_sram[1] ^= 0x80000;
> +	}
> +
> +	setprop(devp, "reg", reg_flash, sizeof(reg_flash));
> +	setprop(sram, "reg", reg_sram, sizeof(reg_sram));
> +}
> +
> +static void walnut_fixups(void)
> +{
> +	ibm4xx_fixup_memsize();
> +	ibm405gp_fixup_clocks(33330000, 0xa8c000);
> +	ibm4xx_quiesce_eth((u32 *)0xef600800, NULL);
> +	ibm4xx_fixup_ebc_ranges("/plb/ebc");
> +	walnut_flashsel_fixup();
> +}
> +
> +void platform_init(void)
> +{
> +	unsigned long end_of_ram = 0x2000000;
> +	unsigned long avail_ram = end_of_ram - (unsigned long) _end;
> +
> +	simple_alloc_init(_end, avail_ram, 32, 32);
> +	platform_ops.fixups = walnut_fixups;
> +	platform_ops.exit = ibm40x_dbcr_reset;
> +	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
> +	serial_console_init();
> +}
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
