Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 8FDBCB6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:19:52 +1100 (EST)
Received: by ywh17 with SMTP id 17so4641053ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:19:50 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:19:30 -0700
Message-ID: <fa686aa40911221519w6b11fd93j9ed51b00fad2ad0e@mail.gmail.com>
Subject: Re: [RFC PATCH 05/19] powerpc: wii: bootwrapper bits
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Add support for the Nintendo Wii video game console to the powerpc
> bootwrapper.
>
> dtbImage.wii is a wrapped image that contains a flat device tree,
> an entry point compatible with the Homebrew Channel and BootMii,
> and an optional initrd.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/boot/Makefile | =A0 =A03 +-
> =A0arch/powerpc/boot/wii.c =A0 =A0| =A0173 ++++++++++++++++++++++++++++++=
++++++++++++++
> =A0arch/powerpc/boot/wrapper =A0| =A0 =A03 +
> =A03 files changed, 178 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/wii.c
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index b2f06b0..fbaf101 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -77,7 +77,7 @@ src-plat :=3D of.c cuboot-52xx.c cuboot-824x.c cuboot-8=
3xx.c cuboot-85xx.c holly.c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yo=
semite.c simpleboot.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0virtex405-head.S virtex.c redboot-83xx.c c=
uboot-sam440ep.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cuboot-acadia.c cuboot-amigaone.c cuboot-k=
ilauea.c \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gamecube.c
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gamecube.c wii.c
> =A0src-boot :=3D $(src-wlib) $(src-plat) empty.c
>
> =A0src-boot :=3D $(addprefix $(obj)/, $(src-boot))
> @@ -256,6 +256,7 @@ image-$(CONFIG_STORCENTER) =A0 =A0 =A0 =A0 =A0+=3D cu=
Image.storcenter
> =A0image-$(CONFIG_MPC7448HPC2) =A0 =A0 =A0 =A0 =A0 =A0+=3D cuImage.mpc744=
8hpc2
> =A0image-$(CONFIG_PPC_C2K) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D cuImage.c2k
> =A0image-$(CONFIG_GAMECUBE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D dtbImage.gam=
ecube
> +image-$(CONFIG_WII) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dtbImage=
.wii
>
> =A0# Board port in arch/powerpc/platform/amigaone/Kconfig
> =A0image-$(CONFIG_AMIGAONE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D cuImage.amig=
aone
> diff --git a/arch/powerpc/boot/wii.c b/arch/powerpc/boot/wii.c
> new file mode 100644
> index 0000000..65b73a1
> --- /dev/null
> +++ b/arch/powerpc/boot/wii.c
> @@ -0,0 +1,173 @@
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
> +
> +BSS_STACK(8192);
> +
> +/*
> + * We enter with an unknown cache, high BATs and MMU status.
> + *
> + * We enable the MMU with an identity mapped memory scheme as expected
> + * by the start code.
> + *
> + */
> +asm ("\n\
> +.text\n\
> +.globl _zimage_start\n\
> +_zimage_start:\n\
> +\n\
> + =A0 =A0 =A0 mfmsr =A0 9\n\
> + =A0 =A0 =A0 andi. =A0 0, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */\n\
> + =A0 =A0 =A0 bcl =A0 =A0 20, 31, 1f\n\
> +1: \n\
> + =A0 =A0 =A0 mflr =A0 =A08\n\
> + =A0 =A0 =A0 clrlwi =A08, 8, 3 =A0 =A0 =A0 =A0 /* convert to a real addr=
ess */\n\
> + =A0 =A0 =A0 addi =A0 =A08, 8, _mmu_off - 1b\n\
> + =A0 =A0 =A0 andc =A0 =A09, 9, 0\n\
> + =A0 =A0 =A0 mtspr =A0 0x01a, 8 =A0 =A0 =A0 =A0/* SRR0 */\n\
> + =A0 =A0 =A0 mtspr =A0 0x01b, 9 =A0 =A0 =A0 =A0/* SRR1 */\n\
> + =A0 =A0 =A0 sync\n\
> + =A0 =A0 =A0 rfi\n\
> +_mmu_off: \n\
> + =A0 =A0 =A0 /* MMU disabled */\n\
> +\n\
> + =A0 =A0 =A0 /* Setup BATs */\n\
> + =A0 =A0 =A0 isync\n\
> + =A0 =A0 =A0 li =A0 =A0 =A08, 0\n\
> + =A0 =A0 =A0 mtspr =A0 0x210, 8 =A0 =A0 =A0 =A0/* IBAT0U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x211, 8 =A0 =A0 =A0 =A0/* IBAT0L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x212, 8 =A0 =A0 =A0 =A0/* IBAT1U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x213, 8 =A0 =A0 =A0 =A0/* IBAT1L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x214, 8 =A0 =A0 =A0 =A0/* IBAT2U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x215, 8 =A0 =A0 =A0 =A0/* IBAT2L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x216, 8 =A0 =A0 =A0 =A0/* IBAT3U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x217, 8 =A0 =A0 =A0 =A0/* IBAT3L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x218, 8 =A0 =A0 =A0 =A0/* DBAT0U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x219, 8 =A0 =A0 =A0 =A0/* DBAT0L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21a, 8 =A0 =A0 =A0 =A0/* DBAT1U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21b, 8 =A0 =A0 =A0 =A0/* DBAT1L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21c, 8 =A0 =A0 =A0 =A0/* DBAT2U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21d, 8 =A0 =A0 =A0 =A0/* DBAT2L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21e, 8 =A0 =A0 =A0 =A0/* DBAT3U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21f, 8 =A0 =A0 =A0 =A0/* DBAT3L */\n\
> +\n\
> + =A0 =A0 =A0 mtspr =A0 0x230, 8 =A0 =A0 =A0 =A0/* IBAT4U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x231, 8 =A0 =A0 =A0 =A0/* IBAT4L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x232, 8 =A0 =A0 =A0 =A0/* IBAT5U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x233, 8 =A0 =A0 =A0 =A0/* IBAT5L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x234, 8 =A0 =A0 =A0 =A0/* IBAT6U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x235, 8 =A0 =A0 =A0 =A0/* IBAT6L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x236, 8 =A0 =A0 =A0 =A0/* IBAT7U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x237, 8 =A0 =A0 =A0 =A0/* IBAT7L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x238, 8 =A0 =A0 =A0 =A0/* DBAT4U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x239, 8 =A0 =A0 =A0 =A0/* DBAT4L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x23a, 8 =A0 =A0 =A0 =A0/* DBAT5U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x23b, 8 =A0 =A0 =A0 =A0/* DBAT5L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x23c, 8 =A0 =A0 =A0 =A0/* DBAT6U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x23d, 8 =A0 =A0 =A0 =A0/* DBAT6L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x23e, 8 =A0 =A0 =A0 =A0/* DBAT7U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x23f, 8 =A0 =A0 =A0 =A0/* DBAT7L */\n\
> +\n\
> + =A0 =A0 =A0 isync\n\
> + =A0 =A0 =A0 li =A0 =A0 =A08, 0x01ff =A0 =A0 =A0 /* first 16MiB */\n\
> + =A0 =A0 =A0 li =A0 =A0 =A09, 0x0002 =A0 =A0 =A0 /* rw */\n\
> + =A0 =A0 =A0 mtspr =A0 0x210, 8 =A0 =A0 =A0 =A0/* IBAT0U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x211, 9 =A0 =A0 =A0 =A0/* IBAT0L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x218, 8 =A0 =A0 =A0 =A0/* DBAT0U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x219, 9 =A0 =A0 =A0 =A0/* DBAT0L */\n\
> +\n\
> + =A0 =A0 =A0 lis =A0 =A0 8, 0xcc00 =A0 =A0 =A0 /* I/O mem */\n\
> + =A0 =A0 =A0 ori =A0 =A0 8, 8, 0x3ff =A0 =A0 /* 32MiB */\n\
> + =A0 =A0 =A0 lis =A0 =A0 9, 0x0c00\n\
> + =A0 =A0 =A0 ori =A0 =A0 9, 9, 0x002a =A0 =A0/* uncached, guarded, rw */=
\n\
> + =A0 =A0 =A0 mtspr =A0 0x21a, 8 =A0 =A0 =A0 =A0/* DBAT1U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21b, 9 =A0 =A0 =A0 =A0/* DBAT1L */\n\
> +\n\
> + =A0 =A0 =A0 lis =A0 =A0 8, 0x0100 =A0 =A0 =A0 /* next 8MiB */\n\
> + =A0 =A0 =A0 ori =A0 =A0 8, 8, 0x00ff =A0 =A0/* 8MiB */\n\
> + =A0 =A0 =A0 lis =A0 =A0 9, 0x0100 =A0 =A0 =A0 /* next 8MiB */\n\
> + =A0 =A0 =A0 ori =A0 =A0 9, 9, 0x0002 =A0 =A0/* rw */\n\
> + =A0 =A0 =A0 mtspr =A0 0x214, 8 =A0 =A0 =A0 =A0/* IBAT2U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x215, 9 =A0 =A0 =A0 =A0/* IBAT2L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21c, 8 =A0 =A0 =A0 =A0/* DBAT2U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21d, 9 =A0 =A0 =A0 =A0/* DBAT2L */\n\
> +\n\
> + =A0 =A0 =A0 lis =A0 =A0 8, 0x1000 =A0 =A0 =A0 /* MEM2 */\n\
> + =A0 =A0 =A0 ori =A0 =A0 8, 8, 0x07ff =A0 =A0/* 64MiB */\n\
> + =A0 =A0 =A0 lis =A0 =A0 9, 0x1000\n\
> + =A0 =A0 =A0 ori =A0 =A0 9, 9, 0x0002 =A0 =A0/* rw */\n\
> + =A0 =A0 =A0 mtspr =A0 0x216, 8 =A0 =A0 =A0 =A0/* IBAT3U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x217, 9 =A0 =A0 =A0 =A0/* IBAT3L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21e, 8 =A0 =A0 =A0 =A0/* DBAT3U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21f, 9 =A0 =A0 =A0 =A0/* DBAT3L */\n\
> +\n\
> + =A0 =A0 =A0 sync\n\
> + =A0 =A0 =A0 isync\n\
> +\n\
> + =A0 =A0 =A0 /* enable high BATs */\n\
> + =A0 =A0 =A0 lis =A0 =A0 8, 0x8200\n\
> + =A0 =A0 =A0 mtspr =A0 0x3f3, 8 =A0 =A0 =A0 =A0/* HID4 */\n\
> +\n\
> + =A0 =A0 =A0 /* enable caches */\n\
> + =A0 =A0 =A0 mfspr =A0 8, 0x3f0\n\
> + =A0 =A0 =A0 ori =A0 =A0 8, 8, 0xc000\n\
> + =A0 =A0 =A0 mtspr =A0 0x3f0, 8 =A0 =A0 =A0 =A0/* HID0 */\n\
> + =A0 =A0 =A0 isync\n\
> +\n\
> + =A0 =A0 =A0 li =A0 =A0 =A03, 0\n\
> + =A0 =A0 =A0 li =A0 =A0 =A04, 0\n\
> + =A0 =A0 =A0 li =A0 =A0 =A05, 0\n\
> +\n\
> + =A0 =A0 =A0 bcl =A0 =A0 20, 31, 1f\n\
> +1: \n\
> + =A0 =A0 =A0 mflr =A0 =A08\n\
> + =A0 =A0 =A0 addi =A0 =A08, 8, _mmu_on - 1b\n\
> + =A0 =A0 =A0 mfmsr =A0 9\n\
> + =A0 =A0 =A0 ori =A0 =A0 9, 9, (1<<4)|(1<<5) /* MSR_DR|MSR_IR */\n\
> + =A0 =A0 =A0 mtspr =A0 0x01a, 8 =A0 =A0 =A0 =A0/* SRR0 */\n\
> + =A0 =A0 =A0 mtspr =A0 0x01b, 9 =A0 =A0 =A0 =A0/* SRR1 */\n\
> + =A0 =A0 =A0 sync\n\
> + =A0 =A0 =A0 rfi\n\
> +_mmu_on: \n\
> + =A0 =A0 =A0 /* turn on the front blue led (aka: yay! we got here!) */\n=
\
> + =A0 =A0 =A0 lis =A0 =A0 8, 0xcd00\n\
> + =A0 =A0 =A0 ori =A0 =A0 8, 8, 0x00c0\n\
> + =A0 =A0 =A0 lwz =A0 =A0 9, 0(8)\n\
> + =A0 =A0 =A0 ori =A0 =A0 9, 9, 0x20\n\
> + =A0 =A0 =A0 stw =A0 =A0 9, 0(8)\n\
> + =A0 =A0 =A0 b _zimage_start_lib\n\
> +");
> +
> +/*
> + *
> + */
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
> +{
> + =A0 =A0 =A0 u32 heapsize =3D 24*1024*1024 - (u32)_end;
> +
> + =A0 =A0 =A0 simple_alloc_init(_end, heapsize, 32, 64);
> + =A0 =A0 =A0 fdt_init(_dtb_start);
> +
> + =A0 =A0 =A0 if (!ug_grab_io_base() && ug_is_adapter_present())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_ops.write =3D ug_console_write;
> +}
> +
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index ac9e9a5..0e9ce10 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -230,6 +230,9 @@ xpedite52*)
> =A0 =A0 link_address=3D'0x1400000'
> =A0 =A0 platformo=3D$object/cuboot-85xx.o
> =A0 =A0 ;;
> +wii|gamecube)
> + =A0 =A0link_address=3D'0x600000'
> + =A0 =A0;;
> =A0esac
>
> =A0vmz=3D"$tmpdir/`basename \"$kernel\"`.$ext"
> --
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
