Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA5FCDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 04:09:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SI9R9q025854
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 14:09:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7SI9N9u170342
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 12:09:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7SI9NVF028477
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 12:09:23 -0600
Date: Tue, 28 Aug 2007 13:09:21 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/4] PowerPC 440EPx: Sequoia bootwrapper
Message-ID: <20070828130921.13809093@weaponx.rchland.ibm.com>
In-Reply-To: <20070828165610.GA1552@ru.mvista.com>
References: <20070828165321.GA1501@ru.mvista.com>
	<20070828165610.GA1552@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 20:56:10 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> +/* 4xx DDR1/2 Denali memory controller support */
> +/* DDR0 registers */
> +#define DDR0_02			2
> +#define DDR0_08			8
> +#define DDR0_10			10
> +#define DDR0_14			14
> +#define DDR0_42			42
> +#define DDR0_43			43
> +
> +/* DDR0_02 */
> +#define DDR_START		0x1
> +#define DDR_START_SHIFT		0
> +#define DDR_MAX_CS_REG		0x3
> +#define DDR_MAX_CS_REG_SHIFT	24
> +#define DDR_MAX_COL_REG		0xf
> +#define DDR_MAX_COL_REG_SHIFT	16
> +#define DDR_MAX_ROW_REG		0xf
> +#define DDR_MAX_ROW_REG_SHIFT	8
> +/* DDR0_08 */
> +#define DDR_DDR2_MODE		0x1
> +#define DDR_DDR2_MODE_SHIFT	0
> +/* DDR0_10 */
> +#define DDR_CS_MAP		0x3
> +#define DDR_CS_MAP_SHIFT	8
> +/* DDR0_14 */
> +#define DDR_REDUC		0x1
> +#define DDR_REDUC_SHIFT		16
> +/* DDR0_42 */
> +#define DDR_APIN		0x7
> +#define DDR_APIN_SHIFT		24
> +/* DDR0_43 */
> +#define DDR_COL_SZ		0x7
> +#define DDR_COL_SZ_SHIFT	8
> +#define DDR_BANK8		0x1
> +#define DDR_BANK8_SHIFT		0
> +
> +#define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))

Hm.  Having these as just DDR_... seems like it would lead to confusion
if there are other DDR controllers that get added later.  But I'm not
too picky either way.

> diff -ruN linux-2.6.orig/arch/powerpc/boot/4xx.h linux-2.6/arch/powerpc/boot/4xx.h
> --- linux-2.6.orig/arch/powerpc/boot/4xx.h	2007-08-27 14:08:42.000000000 +0400
> +++ linux-2.6/arch/powerpc/boot/4xx.h	2007-08-28 17:04:51.000000000 +0400
> @@ -12,6 +12,7 @@
>  #define _POWERPC_BOOT_4XX_H_
> 
>  void ibm4xx_fixup_memsize(void);
> +void ibm4xx_denali_fixup_memsize(void);
>  void ibm44x_dbcr_reset(void);
>  void ibm40x_dbcr_reset(void);
>  void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1);
> diff -ruN linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c linux-2.6/arch/powerpc/boot/cuboot-sequoia.c
> --- linux-2.6.orig/arch/powerpc/boot/cuboot-sequoia.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6/arch/powerpc/boot/cuboot-sequoia.c	2007-08-28 17:21:55.000000000 +0400
> @@ -0,0 +1,67 @@

<snip>

> +
> +#include <stdarg.h>
> +#include <stddef.h>
> +#include "types.h"
> +#include "elf.h"
> +#include "string.h"
> +#include "stdio.h"
> +#include "page.h"
> +#include "ops.h"
> +#include "dcr.h"
> +#include "4xx.h"
> +#include "44x.h"
> +#include "cuboot.h"
> +
> +#define TARGET_4xx
> +#define TARGET_44x
> +#include "ppcboot.h"
> +
> +static bd_t bd;
> +static u8 *sequoia_mac0, *sequoia_mac1;
> +
> +extern char _dtb_start[];
> +extern char _dtb_end[];

These got added to ops.h in commit 2f1d4899321be so you don't need to
specify them here anymore.

josh
