Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A1474DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 22:43:50 +1000 (EST)
Received: from [192.168.12.21] (unknown [10.149.0.1])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 81F5C8815
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 17:43:48 +0500 (SAMST)
Message-ID: <46AF2E4A.4040904@ru.mvista.com>
Date: Tue, 31 Jul 2007 16:42:50 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] PowerPC 440EPx: Sequoia bootwrapper
References: <20070730151445.GA5075@ru.mvista.com>
	<200707310754.56665.sr@denx.de> <46AF1ADA.10404@ru.mvista.com>
	<200707311342.46555.sr@denx.de>
In-Reply-To: <200707311342.46555.sr@denx.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Tuesday 31 July 2007, Valentine Barshak wrote:
>>> Is treeboot-* really needed on Sequoia? From my understanding this is
>>> only needed for platforms using OpenBIOS as bootloader.
>> Right, it's not used for u-boot. I've included it just in case.
> 
> I think we should drop it, when it's not used at all.
> 
> You didn't comment on my review down below in the code. Perhaps you didn't see 
> it. Here again the original review with 2 small comments.
> 

Oops, sorry, I've missed it  :)  Thanks for review. I'll modify the code 
according to your comments.
Thanks,
Valentine.

> Thanks for the good work.
> 
>> +++ linux/arch/powerpc/boot/sequoia.c 2007-07-27 20:59:09.000000000 +0400
>> @@ -0,0 +1,234 @@
>> +/*
>> + * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> + * Copyright IBM Corporation, 2007
>> + *
>> + * Based on ebony wrapper:
>> + * Copyright 2007 David Gibson, IBM Corporation.
>> + *
>> + * Clocking code based on code by:
>> + * Stefan Roese <sr@denx.de>
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
>> +#include "44x.h"
>> +
>> +extern char _dtb_start[];
>> +extern char _dtb_end[];
>> +
>> +static u8 *sequoia_mac0, *sequoia_mac1;
>> +
>> +#define SPRN_CCR1 0x378
>> +void ibm440ep_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
>> +{
>> +     u32 cpu, plb, opb, ebc, tb, uart0, m, vco;
>> +     u32 reg;
>> +     u32 fwdva, fwdvb, fbdv, lfbdv, opbdv0, perdv0, spcid0, prbdv0, tmp;
>> +
>> +     mtdcr(DCRN_CPR0_ADDR, CPR0_PLLD0);
>> +     reg = mfdcr(DCRN_CPR0_DATA);
> 
> How about adding mfcpr functions to access the CPR regs. Makes the source 
> better readable:
> 
> static inline u32 mfcpr(u32 reg)
> {
>         mtdcr(DCRN_CPR0_ADDR, reg);
>         return mfdcr(DCRN_CPR0_DATA);
> }
> 
>> +     tmp = (reg & 0x000F0000) >> 16;
>> +     fwdva = tmp ? tmp : 16;
>> +     tmp = (reg & 0x00000700) >> 8;
>> +     fwdvb = tmp ? tmp : 8;
>> +     tmp = (reg & 0x1F000000) >> 24;
>> +     fbdv = tmp ? tmp : 32;
>> +     lfbdv = (reg & 0x0000007F);
>> +
>> +     mtdcr(DCRN_CPR0_ADDR, CPR0_OPBD0);
>> +     reg = mfdcr(DCRN_CPR0_DATA);
>> +     tmp = (reg & 0x03000000) >> 24;
>> +     opbdv0 = tmp ? tmp : 4;
>> +
>> +     mtdcr(DCRN_CPR0_ADDR, CPR0_PERD0);
>> +     reg = mfdcr(DCRN_CPR0_DATA);
>> +     tmp = (reg & 0x07000000) >> 24;
>> +     perdv0 = tmp ? tmp : 8;
>> +
>> +     mtdcr(DCRN_CPR0_ADDR, CPR0_PRIMBD0);
>> +     reg = mfdcr(DCRN_CPR0_DATA);
>> +     tmp = (reg & 0x07000000) >> 24;
>> +     prbdv0 = tmp ? tmp : 8;
>> +
>> +     mtdcr(DCRN_CPR0_ADDR, CPR0_SCPID);
>> +     reg = mfdcr(DCRN_CPR0_DATA);
>> +     tmp = (reg & 0x03000000) >> 24;
>> +     spcid0 = tmp ? tmp : 4;
>> +
>> +     /* Calculate M */
>> +     mtdcr(DCRN_CPR0_ADDR, CPR0_PLLC0);
>> +     reg = mfdcr(DCRN_CPR0_DATA);
>> +     tmp = (reg & 0x03000000) >> 24;
>> +     if (tmp == 0) { /* PLL output */
>> +             tmp = (reg & 0x20000000) >> 29;
>> +             if (!tmp) /* PLLOUTA */
>> +                     m = fbdv * lfbdv * fwdva;
>> +             else
>> +                     m = fbdv * lfbdv * fwdvb;
>> +     }
>> +     else if (tmp == 1) /* CPU output */
>> +             m = fbdv * fwdva;
>> +     else
>> +             m = perdv0 * opbdv0 * fwdvb;
>> +
>> +     vco = (m * sysclk) + (m >> 1);
>> +     cpu = vco / fwdva;
>> +     plb = vco / fwdvb / prbdv0;
>> +     opb = plb / opbdv0;
>> +     ebc = plb / perdv0;
>> +
>> +     /* FIXME */
>> +     uart0 = ser_clk;
>> +
>> +     /* Figure out timebase.  Either CPU or default TmrClk */
>> +     asm volatile (
>> +                     "mfspr  %0,%1\n"
>> +                     :
>> +                     "=&r"(reg) : "i"(SPRN_CCR1));
>> +     if (reg & 0x0080)
>> +             tb = 25000000; /* TmrClk is 25MHz */
>> +     else
>> +             tb = cpu;
>> +
>> +     dt_fixup_cpu_clocks(cpu, tb, 0);
>> +     dt_fixup_clock("/plb", plb);
>> +     dt_fixup_clock("/plb/opb", opb);
>> +     dt_fixup_clock("/plb/opb/ebc", ebc);
>> +     dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
>> +     dt_fixup_clock("/plb/opb/serial@ef600400", uart0);
>> +     dt_fixup_clock("/plb/opb/serial@ef600500", uart0);
>> +     dt_fixup_clock("/plb/opb/serial@ef600600", uart0);
>> +}
>> +
>> +
>> +/*
>> + * 440EPx DDR1/2 memory controller code
>> + * TODO: move to generic 44x code
>> + */
>> +
>> +/* DDR0_02 */
>> +#define DDR_START            0x1
>> +#define DDR_START_SHIFT              0
>> +#define DDR_MAX_CS_REG               0x3
>> +#define DDR_MAX_CS_REG_SHIFT 24
>> +#define DDR_MAX_COL_REG              0xf
>> +#define DDR_MAX_COL_REG_SHIFT        16
>> +#define DDR_MAX_ROW_REG              0xf
>> +#define DDR_MAX_ROW_REG_SHIFT        8
>> +/* DDR0_08 */
>> +#define DDR_DDR2_MODE                0x1
>> +#define DDR_DDR2_MODE_SHIFT  0
>> +/* DDR0_10 */
>> +#define DDR_CS_MAP           0x3
>> +#define DDR_CS_MAP_SHIFT     8
>> +/* DDR0_14 */
>> +#define DDR_REDUC            0x1
>> +#define DDR_REDUC_SHIFT              16
>> +/* DDR0_42 */
>> +#define DDR_APIN             0x7
>> +#define DDR_APIN_SHIFT               24
>> +/* DDR0_43 */
>> +#define DDR_COL_SZ           0x7
>> +#define DDR_COL_SZ_SHIFT     8
>> +#define DDR_BANK8            0x1
>> +#define DDR_BANK8_SHIFT              0
>> +
>> +#define DDR_GET_VAL(val, mask, shift)        (((val) >> (shift)) & (mask))
>> +
>> +static void ibm440epx_fixup_memsize(void)
>> +{
>> +     unsigned long val, max_cs, max_col, max_row;
>> +     unsigned long cs, col, row, bank, dpath;
>> +     unsigned long memsize;
>> +
>> +     mtdcr(DCRN_SDRAM0_CFGADDR, 2);
>> +     val = mfdcr(DCRN_SDRAM0_CFGDATA);
> 
> Again, mfsdram() functions would be handy here.
> 
>> +     if (!DDR_GET_VAL(val, DDR_START, DDR_START_SHIFT))
>> +             fatal("DDR controller is not initialized\n");
>> +
>> +     /* get maximum cs col and row values */
>> +     max_cs  = DDR_GET_VAL(val, DDR_MAX_CS_REG, DDR_MAX_CS_REG_SHIFT);
>> +     max_col = DDR_GET_VAL(val, DDR_MAX_COL_REG, DDR_MAX_COL_REG_SHIFT);
>> +     max_row = DDR_GET_VAL(val, DDR_MAX_ROW_REG, DDR_MAX_ROW_REG_SHIFT);
>> +
>> +     /* get CS value */
>> +     mtdcr(DCRN_SDRAM0_CFGADDR, 10);
>> +     val = mfdcr(DCRN_SDRAM0_CFGDATA);
>> +
>> +     val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
>> +     cs = 0;
>> +     while (val) {
>> +             if (val && 0x1)
>> +                     cs++;
>> +             val = val >> 1;
>> +     }
>> +
>> +     if (!cs)
>> +             fatal("No memory installed\n");
>> +     if (cs > max_cs)
>> +             fatal("DDR wrong CS configuration\n");
>> +
>> +     /* get data path bytes */
>> +     mtdcr(DCRN_SDRAM0_CFGADDR, 14);
>> +     val = mfdcr(DCRN_SDRAM0_CFGDATA);
>> +
>> +     if (DDR_GET_VAL(val, DDR_REDUC, DDR_REDUC_SHIFT))
>> +             dpath = 8; /* 64 bits */
>> +     else
>> +             dpath = 4; /* 32 bits */
>> +
>> +     /* get adress pins (rows) */
>> +     mtdcr(DCRN_SDRAM0_CFGADDR, 42);
>> +     val = mfdcr(DCRN_SDRAM0_CFGDATA);
>> +
>> +     row = DDR_GET_VAL(val, DDR_APIN, DDR_APIN_SHIFT);
>> +     if (row > max_row)
>> +             fatal("DDR wrong APIN configuration\n");
>> +     row = max_row - row;
>> +
>> +     /* get collomn size and banks */
>> +     mtdcr(DCRN_SDRAM0_CFGADDR, 43);
>> +     val = mfdcr(DCRN_SDRAM0_CFGDATA);
>> +
>> +     col = DDR_GET_VAL(val, DDR_COL_SZ, DDR_COL_SZ_SHIFT);
>> +     if (col > max_col)
>> +             fatal("DDR wrong COL configuration\n");
>> +     col = max_col - col;
>> +
>> +     if (DDR_GET_VAL(val, DDR_BANK8, DDR_BANK8_SHIFT))
>> +             bank = 8; /* 8 banks */
>> +     else
>> +             bank = 4; /* 4 banks */
>> +
>> +     memsize = cs * (1 << (col+row)) * bank * dpath;
>> +     dt_fixup_memory(0, memsize);
>> +}
>> +
>> +static void sequoia_fixups(void)
>> +{
>> +     unsigned long sysclk = 33333333;
> 
> Blank line after variable declaration please.
> 
>> +     ibm440ep_fixup_clocks(sysclk, 11059200);
>> +     ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
>> +     ibm440epx_fixup_memsize();
>> +     dt_fixup_mac_addresses(sequoia_mac0, sequoia_mac1);
>> +}
>> +
>> +void sequoia_init(void *mac0, void *mac1)
>> +{
>> +     platform_ops.fixups = sequoia_fixups;
>> +     platform_ops.exit = ibm44x_dbcr_reset;
>> +     sequoia_mac0 = mac0;
>> +     sequoia_mac1 = mac1;
>> +     ft_init(_dtb_start, 0, 32);
>> +     serial_console_init();
>> +}
>> diff -ruN linux.orig/arch/powerpc/boot/treeboot-sequoia.c
>> linux/arch/powerpc/boot/treeboot-sequoia.c ---
>> linux.orig/arch/powerpc/boot/treeboot-sequoia.c       1970-01-01
>> 03:00:00.000000000 +0300 +++
>> linux/arch/powerpc/boot/treeboot-sequoia.c    2007-07-27 20:44:26.000000000
>> +0400 @@ -0,0 +1,27 @@
>> +/*
>> + * Based on Bamboo code by Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> + * Copyright IBM Corporation, 2007
>> + *
>> + * Based on ebony wrapper:
>> + * Copyright 2007 David Gibson, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; version 2 of the License
>> + */
>> +#include "ops.h"
>> +#include "stdio.h"
>> +#include "44x.h"
>> +
>> +extern char _end[];
>> +
>> +BSS_STACK(4096);
>> +
>> +void platform_init(void)
>> +{
>> +     unsigned long end_of_ram = 0x10000000;
>> +     unsigned long avail_ram = end_of_ram - (unsigned long)_end;
>> +
>> +     simple_alloc_init(_end, avail_ram, 32, 64);
>> +     sequoia_init(NULL, NULL);
>> +}
> 
> Best regards,
> Stefan
