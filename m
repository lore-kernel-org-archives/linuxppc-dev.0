Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 082AAB7CA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:12:05 +1100 (EST)
Received: by gxk23 with SMTP id 23so5457882gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:12:03 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:11:43 -0700
Message-ID: <fa686aa40911221511q5979d04p97d1a430803443d1@mail.gmail.com>
Subject: Re: [RFC PATCH 03/19] powerpc: gamecube: bootwrapper bits
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
> Add support for the Nintendo GameCube video game console to the powerpc
> bootwrapper.
>
> dtbImage.gamecube is a wrapped image that contains a flat device tree,
> an entry point compatible with SDload, and an optional initrd.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/powerpc/boot/Makefile =A0 | =A0 =A04 ++-
> =A0arch/powerpc/boot/gamecube.c | =A0 78 ++++++++++++++++++++++++++++++++=
++++++++++
> =A02 files changed, 81 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/gamecube.c
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 44bce21..b2f06b0 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -76,7 +76,8 @@ src-plat :=3D of.c cuboot-52xx.c cuboot-824x.c cuboot-8=
3xx.c cuboot-85xx.c holly.c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cuboot-katmai.c cuboot-rainier.c redboot-8=
xx.c ep8248e.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yo=
semite.c simpleboot.c \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0virtex405-head.S virtex.c redboot-83xx.c c=
uboot-sam440ep.c \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cuboot-acadia.c cuboot-amigaone.c cuboot-ki=
lauea.c
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cuboot-acadia.c cuboot-amigaone.c cuboot-ki=
lauea.c \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gamecube.c
> =A0src-boot :=3D $(src-wlib) $(src-plat) empty.c
>
> =A0src-boot :=3D $(addprefix $(obj)/, $(src-boot))
> @@ -254,6 +255,7 @@ image-$(CONFIG_KSI8560) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 +=3D cuImage.ksi8560
> =A0image-$(CONFIG_STORCENTER) =A0 =A0 =A0 =A0 =A0 =A0 +=3D cuImage.storce=
nter
> =A0image-$(CONFIG_MPC7448HPC2) =A0 =A0 =A0 =A0 =A0 =A0+=3D cuImage.mpc744=
8hpc2
> =A0image-$(CONFIG_PPC_C2K) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D cuImage.c2k
> +image-$(CONFIG_GAMECUBE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D dtbImage.gamec=
ube
>
> =A0# Board port in arch/powerpc/platform/amigaone/Kconfig
> =A0image-$(CONFIG_AMIGAONE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D cuImage.amig=
aone
> diff --git a/arch/powerpc/boot/gamecube.c b/arch/powerpc/boot/gamecube.c
> new file mode 100644
> index 0000000..0d6c517
> --- /dev/null
> +++ b/arch/powerpc/boot/gamecube.c
> @@ -0,0 +1,78 @@
> +/*
> + * arch/powerpc/boot/gamecube.c
> + *
> + * Nintendo GameCube bootwrapper support
> + * Copyright (C) 2004-2009 The GameCube Linux Team
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
> +/*
> + * We enter with the cache enabled, the MMU enabled and some known legac=
y
> + * memory mappings active. xBAT3 is unused.
> + *
> + * We leave the MMU enabled, but we switch to an identity mapped memory
> + * scheme as expected by the start code.
> + *
> + */
> +asm ("\n\
> +.text\n\
> +.globl _zimage_start\n\
> +_zimage_start:\n\
> +\n\
> + =A0 =A0 =A0 isync\n\
> + =A0 =A0 =A0 /* IBAT3,DBAT3 for first 16Mbytes */\n\
> + =A0 =A0 =A0 li =A0 =A0 =A08, 0x01ff =A0 =A0 =A0 /* 16MB */\n\
> + =A0 =A0 =A0 li =A0 =A0 =A09, 0x0002 =A0 =A0 =A0 /* rw */\n\
> + =A0 =A0 =A0 mtspr =A0 0x216, 8 =A0 =A0 =A0 =A0/* IBAT3U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x217, 9 =A0 =A0 =A0 =A0/* IBAT3L */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21e, 8 =A0 =A0 =A0 =A0/* DBAT3U */\n\
> + =A0 =A0 =A0 mtspr =A0 0x21f, 9 =A0 =A0 =A0 =A0/* DBAT3L */\n\
> +\n\
> + =A0 =A0 =A0 sync\n\
> + =A0 =A0 =A0 isync\n\
> +\n\
> + =A0 =A0 =A0 li =A0 =A0 =A03, 0\n\
> + =A0 =A0 =A0 li =A0 =A0 =A04, 0\n\
> + =A0 =A0 =A0 li =A0 =A0 =A05, 0\n\
> +\n\
> + =A0 =A0 =A0 bcl- =A0 =A020,4*cr7+so,1f\n\
> +1:\n\
> + =A0 =A0 =A0 mflr =A0 =A08\n\
> + =A0 =A0 =A0 clrlwi =A08, 8, 3\n\
> + =A0 =A0 =A0 addi =A0 =A08, 8, 2f - 1b\n\
> + =A0 =A0 =A0 mtlr =A0 =A08\n\
> + =A0 =A0 =A0 blr\n\
> +2:\n\
> + =A0 =A0 =A0 b _zimage_start_lib\n\
> +");
> +
> +/*
> + *
> + */
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
> +{
> + =A0 =A0 =A0 u32 heapsize =3D 16*1024*1024 - (u32)_end;
> +
> + =A0 =A0 =A0 simple_alloc_init(_end, heapsize, 32, 64);
> + =A0 =A0 =A0 fdt_init(_dtb_start);
> +
> + =A0 =A0 =A0 if (!ug_grab_io_base() && ug_is_adapter_present())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 console_ops.write =3D ug_console_write;
> +}
> +
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
