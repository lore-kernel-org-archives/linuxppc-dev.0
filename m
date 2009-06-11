Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 54440B715D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 02:28:17 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 593BEDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 02:28:15 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so724484ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 09:28:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1244576781.3455.0@antares>
References: <1244576781.3455.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Jun 2009 10:27:53 -0600
Message-ID: <fa686aa40906110927w60a5a74alaa3420b9bf3f3e44@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx/mtd: fix mtd-ram access for 16-bit Local
	Plus Bus
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 9, 2009 at 1:46 PM, Albrecht Dre=DF<albrecht.dress@arcor.de> wr=
ote:
> Hi all,
>
> this patch adds support for RAM chips connected to the Local Plus Bus of =
a
> MPC5200B in 16-bit mode. =A0As no single byte write accesses are allowed =
by
> the bus in this mode, a byte write has to be split into a word read - mod=
ify
> - write sequence (mpc52xx_memcpy2lpb16, as fix/extension for memcpy_toio;
> note that memcpy_fromio *does* work just fine). =A0It has been tested in
> conjunction with Wolfram Sang's mtd-ram [1] and Sascha Hauer's jffs
> unaligned access [2] patches on 2.6.29.1, with a Renesas static RAM
> connected in 16-bit "Large Flash" mode.
>
> [1] <http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072794.html=
>
> [2] <http://article.gmane.org/gmane.linux.drivers.mtd/21521>
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linuxppc-dev@ozlabs.org
>
> ---
>
> diff -u linux-2.6.29.1.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
> linux-2.6.29.1/arch/powerpc/platforms/52xx/mpc52xx_common.c
> --- linux-2.6.29.1.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
> =A02009-04-02 22:55:27.000000000 +0200
> +++ linux-2.6.29.1/arch/powerpc/platforms/52xx/mpc52xx_common.c 2009-06-0=
9
> 21:16:22.000000000 +0200
> @@ -225,3 +225,59 @@
>
> =A0 =A0 =A0 =A0while (1);
> =A0}
> +
> +/**
> + * mpc52xx_memcpy2lpb16: copy data to the Local Plus Bus in 16-bit mode
> which
> + * doesn't allow byte accesses
> + */
> +void
> +mpc52xx_memcpy2lpb16(volatile void __iomem *dest, const void *src,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long n)
> +{
> + =A0 =A0 =A0 void *vdest =3D (void __force *) dest;
> +
> + =A0 =A0 =A0 __asm__ __volatile__ ("sync" : : : "memory");
> +
> + =A0 =A0 =A0 if (((unsigned long) vdest & 1) !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 buf[2];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u16 *)buf =3D *((volatile u16 *)(vdest - =
1));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[1] =3D *((u8 *)src);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((volatile u16 *)(vdest - 1)) =3D *(u16 *)=
buf;

what is the purpose of volatile here?  If you need io barriers, then
use the in_/out_be16 macros.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdest++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* looks weird, but helps the optimiser... */
> + =A0 =A0 =A0 if (n >=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long chunks =3D n >> 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volatile u32 * _dst =3D (volatile u32 *)(vd=
est - 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volatile u32 * _src =3D (volatile u32 *)(sr=
c - 4);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdest +=3D chunks << 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src +=3D chunks << 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *++_dst =3D *++_src;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (--chunks);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n &=3D 3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (n >=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((volatile u16 *)vdest) =3D *((volatile u1=
6 *)src);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src +=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdest +=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n -=3D 2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (n > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 buf[2];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *(u16 *)buf =3D *((volatile u16 *)vdest);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[0] =3D *((u8 *)src);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((volatile u16 *)vdest) =3D *(u16 *)buf;

ditto.

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 __asm__ __volatile__ ("sync" : : : "memory");
> +}
> +EXPORT_SYMBOL(mpc52xx_memcpy2lpb16);
> diff -u linux-2.6.29.1.orig/arch/powerpc/include/asm/mpc52xx.h
> linux-2.6.29.1/arch/powerpc/include/asm/mpc52xx.h
> --- linux-2.6.29.1.orig/arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0200=
9-04-02
> 22:55:27.000000000 +0200
> +++ linux-2.6.29.1/arch/powerpc/include/asm/mpc52xx.h =A0 2009-06-09
> 21:14:31.000000000 +0200
> @@ -274,6 +274,8 @@
> =A0extern void mpc52xx_map_common_devices(void);
> =A0extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
> =A0extern void mpc52xx_restart(char *cmd);
> +extern void mpc52xx_memcpy2lpb16(volatile void __iomem *dest, const void
> *src,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned=
 long n);
>
> =A0/* mpc52xx_pic.c */
> =A0extern void mpc52xx_init_irq(void);
> diff -u linux-2.6.29.1.orig/include/linux/mtd/map.h
> linux-2.6.29.1/include/linux/mtd/map.h
> --- linux-2.6.29.1.orig/include/linux/mtd/map.h 2009-04-02
> 22:55:27.000000000 +0200
> +++ linux-2.6.29.1/include/linux/mtd/map.h =A0 =A0 =A02009-06-08
> 14:28:05.000000000 +0200
> @@ -13,6 +13,9 @@
> =A0#include <asm/unaligned.h>
> =A0#include <asm/system.h>
> =A0#include <asm/io.h>
> +#ifdef CONFIG_PPC_MPC52xx
> +#include <asm/mpc52xx.h>
> +#endif
>
> =A0#ifdef CONFIG_MTD_MAP_BANK_WIDTH_1
> =A0#define map_bankwidth(map) 1
> @@ -417,6 +420,11 @@
>
> =A0static inline void inline_map_copy_to(struct map_info *map, unsigned l=
ong
> to, const void *from, ssize_t len)
> =A0{
> +#ifdef CONFIG_PPC_MPC52xx
> + =A0 =A0 =A0 if (map->bankwidth =3D=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_memcpy2lpb16(map->virt + to, from, =
len);
> + =A0 =A0 =A0 else
> +#endif
> =A0 =A0 =A0 =A0memcpy_toio(map->virt + to, from, len);
> =A0}

Blech.  ugly #ifdef and not really multiplatform safe (yeah, I know it
shouldn't break non-5200 platforms, but it does have an undesirable
impact).  There's got to be a better way.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
