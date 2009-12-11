Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66B29B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 08:59:33 +1100 (EST)
Subject: Re: [RFC PATCH v2 2/6] powerpc: wii: bootwrapper bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1259880447-5008-3-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<1259880447-5008-3-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 08:59:27 +1100
Message-ID: <1260568767.16132.361.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 23:47 +0100, Albert Herranz wrote:
> Add support for the Nintendo Wii video game console to the powerpc
> bootwrapper.
> 
> dtbImage.wii is a wrapped image that contains a flat device tree,
> an entry point compatible with the Homebrew Channel and BootMii,
> and an optional initrd.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> v1 -> v2
> - Save one asm instruction in a non-critical path.
>   Suggestion by Segher Boessenkool.
> - Use easier to read mtsrr0 and mtsrr1 mnemonics.
>   Suggestion by Segher Boessenkool.
> - Get rid of sync before rfi.
>   Suggestion by Segher Boessenkool.
> - Zero a BAT by simply zeroing the upper BAT instead of both lower
>   and upper BATs. Suggestion by Segher Boessenkool.
> - Get rid of unneeded isync. Suggestion by Segher Boessenkool.
> - Write first the lower BAT then the upper BAT.
>   Suggestion by Segher Boessenkool.
> - Get rid of unneeded "sync; isync". Suggestion by Segher Boessenkool.
> - Use read/modify/write to update HID4 instead of setting it to a known
>   value. Suggestion by Segher Boessenkool.
> - Add an isync after modifying HID4. Suggestion by Segher Boessenkool.
> - Invalidate caches before enabling them. Suggestion by Segher Boessenkool.
> - Enable caches only if not enabled already.
> - Make sure EXI is enabled before probing for a USB Gecko.
> 
>  arch/powerpc/boot/Makefile   |    3 +-
>  arch/powerpc/boot/wii-head.S |  142 ++++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/wii.c      |   46 ++++++++++++++
>  arch/powerpc/boot/wrapper    |    2 +-
>  4 files changed, 191 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/boot/wii-head.S
>  create mode 100644 arch/powerpc/boot/wii.c
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 3e70aab..bb2465b 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -77,7 +77,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
>  		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
>  		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
>  		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
> -		gamecube-head.S gamecube.c
> +		gamecube-head.S gamecube.c wii-head.S wii.c
>  src-boot := $(src-wlib) $(src-plat) empty.c
>  
>  src-boot := $(addprefix $(obj)/, $(src-boot))
> @@ -256,6 +256,7 @@ image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
>  image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
>  image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
>  image-$(CONFIG_GAMECUBE)		+= dtbImage.gamecube
> +image-$(CONFIG_WII)			+= dtbImage.wii
>  
>  # Board port in arch/powerpc/platform/amigaone/Kconfig
>  image-$(CONFIG_AMIGAONE)		+= cuImage.amigaone
> diff --git a/arch/powerpc/boot/wii-head.S b/arch/powerpc/boot/wii-head.S
> new file mode 100644
> index 0000000..edd79b8
> --- /dev/null
> +++ b/arch/powerpc/boot/wii-head.S
> @@ -0,0 +1,142 @@
> +/*
> + * arch/powerpc/boot/wii-head.S
> + *
> + * Nintendo Wii bootwrapper entry.
> + * Copyright (C) 2008-2009 The GameCube Linux Team
> + * Copyright (C) 2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include "ppc_asm.h"
> +
> +/*
> + * The entry code does no assumptions regarding:
> + * - if the data and instruction caches are enabled or not
> + * - if the MMU is enabled or not
> + * - if the high BATs are enabled or not
> + *
> + * We enable the high BATs, enable the caches if not already enabled,
> + * enable the MMU with an identity mapping scheme and jump to the start code.
> + */
> +
> +	.text
> +
> +	.globl _zimage_start
> +_zimage_start:
> +
> +	/* turn the MMU off */
> +	mfmsr	9
> +	rlwinm	9, 9, 0, ~((1<<4)|(1<<5)) /* MSR_DR|MSR_IR */
> +	bcl	20, 31, 1f
> +1:
> +	mflr	8
> +	clrlwi	8, 8, 3		/* convert to a real address */
> +	addi	8, 8, _mmu_off - 1b
> +	mtsrr0	8
> +	mtsrr1	9
> +	rfi
> +_mmu_off:
> +	/* MMU disabled */
> +
> +	/* setup BATs */
> +	isync
> +	li      8, 0
> +	mtspr	0x210, 8	/* IBAT0U */
> +	mtspr	0x212, 8	/* IBAT1U */
> +	mtspr	0x214, 8	/* IBAT2U */
> +	mtspr	0x216, 8	/* IBAT3U */
> +	mtspr	0x218, 8	/* DBAT0U */
> +	mtspr	0x21a, 8	/* DBAT1U */
> +	mtspr	0x21c, 8	/* DBAT2U */
> +	mtspr	0x21e, 8	/* DBAT3U */
> +
> +	mtspr	0x230, 8	/* IBAT4U */
> +	mtspr	0x232, 8	/* IBAT5U */
> +	mtspr	0x234, 8	/* IBAT6U */
> +	mtspr	0x236, 8	/* IBAT7U */
> +	mtspr	0x238, 8	/* DBAT4U */
> +	mtspr	0x23a, 8	/* DBAT5U */
> +	mtspr	0x23c, 8	/* DBAT6U */
> +	mtspr	0x23e, 8	/* DBAT7U */
> +
> +	li	8, 0x01ff	/* first 16MiB */
> +	li	9, 0x0002	/* rw */
> +	mtspr	0x211, 9	/* IBAT0L */
> +	mtspr	0x210, 8	/* IBAT0U */
> +	mtspr	0x219, 9	/* DBAT0L */
> +	mtspr	0x218, 8	/* DBAT0U */
> +
> +	lis	8, 0x0c00	/* I/O mem */
> +	ori	8, 8, 0x3ff	/* 32MiB */
> +	lis	9, 0x0c00
> +	ori	9, 9, 0x002a	/* uncached, guarded, rw */
> +	mtspr	0x21b, 9	/* DBAT1L */
> +	mtspr	0x21a, 8	/* DBAT1U */
> +
> +	lis	8, 0x0100	/* next 8MiB */
> +	ori	8, 8, 0x00ff	/* 8MiB */
> +	lis	9, 0x0100
> +	ori	9, 9, 0x0002	/* rw */
> +	mtspr	0x215, 9	/* IBAT2L */
> +	mtspr	0x214, 8	/* IBAT2U */
> +	mtspr	0x21d, 9	/* DBAT2L */
> +	mtspr	0x21c, 8	/* DBAT2U */
> +
> +	lis	8, 0x1000	/* MEM2 */
> +	ori	8, 8, 0x07ff	/* 64MiB */
> +	lis	9, 0x1000
> +	ori	9, 9, 0x0002	/* rw */
> +	mtspr	0x216, 8	/* IBAT3U */
> +	mtspr	0x217, 9	/* IBAT3L */
> +	mtspr	0x21e, 8	/* DBAT3U */
> +	mtspr	0x21f, 9	/* DBAT3L */
> +
> +	/* enable the high BATs */
> +	mfspr	8, 0x3f3	/* HID4 */
> +	oris	8, 8, 0x0200
> +	mtspr	0x3f3, 8	/* HID4 */
> +
> +	/* enable and invalidate the caches if not already enabled */
> +	mfspr	8, 0x3f0	/* HID0 */
> +	andi.	0, 8, (1<<15)		/* HID0_ICE */
> +	bne	1f
> +	ori	8, 8, (1<<15)|(1<<11)	/* HID0_ICE|HID0_ICFI*/
> +1:
> +	andi.	0, 8, (1<<14)		/* HID0_DCE */
> +	bne	1f
> +	ori	8, 8, (1<<14)|(1<<10)	/* HID0_DCE|HID0_DCFI*/
> +1:
> +	mtspr	0x3f0, 8	/* HID0 */
> +	isync
> +
> +	/* initialize arguments */
> +	li	3, 0
> +	li	4, 0
> +	li	5, 0
> +
> +	/* turn the MMU on */
> +	bcl	20, 31, 1f
> +1:
> +	mflr	8
> +	addi	8, 8, _mmu_on - 1b
> +	mfmsr	9
> +	ori	9, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */
> +	mtsrr0	8
> +	mtsrr1	9
> +	sync
> +	rfi
> +_mmu_on:
> +	/* turn on the front blue led (aka: yay! we got here!) */
> +	lis	8, 0x0d00
> +	ori	8, 8, 0x00c0
> +	lwz	9, 0(8)
> +	ori	9, 9, 0x20
> +	stw	9, 0(8)
> +
> +	b _zimage_start_lib
> +
> diff --git a/arch/powerpc/boot/wii.c b/arch/powerpc/boot/wii.c
> new file mode 100644
> index 0000000..d0e2625
> --- /dev/null
> +++ b/arch/powerpc/boot/wii.c
> @@ -0,0 +1,46 @@
> +/*
> + * arch/powerpc/boot/wii.c
> + *
> + * Nintendo Wii bootwrapper support
> + * Copyright (C) 2008-2009 The GameCube Linux Team
> + * Copyright (C) 2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <stddef.h>
> +#include "stdio.h"
> +#include "types.h"
> +#include "io.h"
> +#include "ops.h"
> +
> +#include "ugecon.h"
> +
> +BSS_STACK(8192);
> +
> +#define HW_REG(x)	((void *)(x))
> +
> +#define EXI_CTRL	HW_REG(0x0d800070)
> +#define EXI_CTRL_ENABLE	(1<<0)
> +
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
> +{
> +	u32 heapsize = 24*1024*1024 - (u32)_end;
> +
> +	simple_alloc_init(_end, heapsize, 32, 64);
> +	fdt_init(_dtb_start);
> +
> +	/*
> +	 * 'mini' boots the Broadway processor with EXI disabled.
> +	 * We need it enabled before probing for the USB Gecko.
> +	 */
> +	out_be32(EXI_CTRL, in_be32(EXI_CTRL) | EXI_CTRL_ENABLE);
> +
> +	if (ug_probe())
> +		console_ops.write = ug_console_write;
> +}
> +
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 5b9206f..390512a 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -230,7 +230,7 @@ xpedite52*)
>      link_address='0x1400000'
>      platformo=$object/cuboot-85xx.o
>      ;;
> -gamecube)
> +gamecube|wii)
>      link_address='0x600000'
>      platformo="$object/$platform-head.o $object/$platform.o"
>      ;;
