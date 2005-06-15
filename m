Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0947167A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 20:43:03 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j5FIJ4C4020647
	for <linuxppc-embedded@ozlabs.org>; Wed, 15 Jun 2005 18:19:04 GMT
	(envelope-from rober@opnet.com.tw)
From: Rober Hsu <rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Message-Id: <1118830434.4813.10.camel@orange.opnet.com.tw>
Mime-Version: 1.0
Date: Wed, 15 Jun 2005 18:13:54 +0800
Subject: How to change SDRAM from HYNIX to AMIC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

    I used HY57641620 * 2 at my MPC852T, the ram size is 16M, Now i want
to change to AMIC A43L3616-6 * 2 32M.

    I modify my ppboot's as follow, but i don't know how to modfiy my
sdram_table, anybody know what's the meaning of sdram_table?

PS:I system hold at ## Starting linux kernel at 0x00580000 ...

Boot Loader v1.0.0 (Jun 15 2005 - 15:38:51)
 
CPU:   MPC852T (0x08010004) at 100.00 MHz: 4 kB I-Cache 4 kB D-Cache FEC
presentDRAM:  32 MB
Not load linux now? (enter anykey):
Kernel file size :3d7832(hex)
Loading kernel ... ...
## Starting linux kernel at 0x00580000 ...
     
       
#include <ppcboot.h>
#include "mpc8xx.h"

/*
------------------------------------------------------------------------- */

static long int dram_size (long int, long int *, long int);

/*
------------------------------------------------------------------------- */

#define	_NOT_USED_	0xFFFFFFFF

const uint sdram_table[] =
{
	/* Single Read. (offset 0x0-0x4 in UPM RAM)     */
	/* Precharge and MRS(offset 0x5-0x7 in UPM RAM) */
	0x1F07FC04, 0xEEAEFC04, 0x11ADFC04, 0xEFBBBC00,
	0x1FF77C47, 0x1FF77C35, 0xEFEABC34, 0x1FB57C35,

	/* Burst Read. (offset 0x8-0xf in UPM RAM) */
	0x1F07FC04, 0xEEAEFC04, 0x10ADFC04, 0xF0AFFC00,
	0xF0AFFC00, 0xF1AFFC00, 0xEFBBBC00, 0x1FF77C47,
	_NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,
	_NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

	/* Single Write. (offset 0x18-0x1F in UPM RAM) */
	0x1F27FC04, 0xEEAEBC00, 0x01B93C04, 0x1FF77C47,
	_NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

	/* Burst Write. (offset 20-2F in UPM RAM) */
	0x1F07FC04, 0xEEAEBC00, 0x10AD7C00, 0xF0AFFC00,
	0xF0AFFC00, 0xE1BBBC04, 0x1FF77C47, _NOT_USED_, 
	_NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,
	_NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

	/* Refresh timer expired (offset 30-3B in UPM RAM) */
	0x1FF5FC84, 0xFFFFFC04, 0xFFFFFC04, 0xFFFFFC04,
	0xFFFFFC84, 0xFFFFFC07, 0xffffffff, _NOT_USED_, 
	_NOT_USED_, _NOT_USED_, _NOT_USED_, _NOT_USED_,

	/* Exception. (offset 3c-3f in UPM RAM) */
	0x7FFFFC07, _NOT_USED_, _NOT_USED_, _NOT_USED_ 
};

/*
------------------------------------------------------------------------- */


/*
 * Check Board Identity:
 *
 * Test TQ ID string (TQM8xx...)
 * If present, check for "L" type (no second DRAM bank),
 * otherwise "L" type is assumed as default.
 *
 * Return 1 for "L" type, 0 else.
 */

int checkboard (void)
{
    return 0;
}

/*
------------------------------------------------------------------------- */

long int initdram(int board_type)
{
	volatile immap_t     *immap = (immap_t *)CFG_IMMR;
	volatile memctl8xx_t *memctl = &immap->im_memctl;

	upmconfig(UPMA, (uint *)sdram_table, sizeof(sdram_table)/sizeof(uint));
  
	memctl->memc_mptpr = 0x0400;

	/*
	 * Configure the refresh (mostly).  This needs to be
	 * based upon processor clock speed and optimized to provide
	 * the highest level of performance.  For multiple banks,
	 * this time has to be divided by the number of banks.
	 * Although it is not clear anywhere, it appears the
	 * refresh steps through the chip selects for this UPM
	 * on each refresh cycle.
	 * We have to be careful changing
	 * UPM registers after we ask it to run these commands.
	 */

	memctl->memc_mamr = 0xD0904114;
	memctl->memc_mar = 0x00000088;
	udelay(200);

	memctl->memc_mcr = 0x80004105;     /* precharge */
	udelay(200);

	memctl->memc_mamr = 0xD0904114;
	memctl->memc_mcr = 0x80004830;     /* refresh */
	udelay(200);

	memctl->memc_mamr = 0xD0904114;
	memctl->memc_mcr = 0x80004106; 
	udelay(200);

	memctl->memc_or2 = 0xFE000A00;
	memctl->memc_br2 = 0x00000081;

	return (32 * 1024 *1024);
}	/* end of initdram */
