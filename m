Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D3A91B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 05:46:26 +1000 (EST)
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.112])
	by ozlabs.org (Postfix) with ESMTP id 226D1DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 05:46:24 +1000 (EST)
Date: Tue, 09 Jun 2009 21:46:14 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [PATCH] powerpc/mpc52xx/mtd: fix mtd-ram access for 16-bit Local
	Plus Bus
To: grant.likely@secretlab.ca, dwmw2@infradead.org
Message-Id: <1244576781.3455.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-zG+VAC3z0POAIM5D5WCy"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-zG+VAC3z0POAIM5D5WCy
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

this patch adds support for RAM chips connected to the Local Plus Bus =20
of a MPC5200B in 16-bit mode.  As no single byte write accesses are =20
allowed by the bus in this mode, a byte write has to be split into a =20
word read - modify - write sequence (mpc52xx_memcpy2lpb16, as =20
fix/extension for memcpy_toio; note that memcpy_fromio *does* work just =20
fine).  It has been tested in conjunction with Wolfram Sang's mtd-ram =20
[1] and Sascha Hauer's jffs unaligned access [2] patches on 2.6.29.1, =20
with a Renesas static RAM connected in 16-bit "Large Flash" mode.

[1] =20
<http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072794.html>
[2] <http://article.gmane.org/gmane.linux.drivers.mtd/21521>

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org

---

diff -u =20
linux-2.6.29.1.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c =20
linux-2.6.29.1/arch/powerpc/platforms/52xx/mpc52xx_common.c
--- linux-2.6.29.1.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c    =20
2009-04-02 22:55:27.000000000 +0200
+++ linux-2.6.29.1/arch/powerpc/platforms/52xx/mpc52xx_common.c =20
2009-06-09 21:16:22.000000000 +0200
@@ -225,3 +225,59 @@

         while (1);
  }
+
+/**
+ * mpc52xx_memcpy2lpb16: copy data to the Local Plus Bus in 16-bit =20
mode which
+ * doesn't allow byte accesses
+ */
+void
+mpc52xx_memcpy2lpb16(volatile void __iomem *dest, const void *src,
+                    unsigned long n)
+{
+       void *vdest =3D (void __force *) dest;
+
+       __asm__ __volatile__ ("sync" : : : "memory");
+
+       if (((unsigned long) vdest & 1) !=3D 0) {
+               u8 buf[2];
+
+               *(u16 *)buf =3D *((volatile u16 *)(vdest - 1));
+               buf[1] =3D *((u8 *)src);
+               *((volatile u16 *)(vdest - 1)) =3D *(u16 *)buf;
+               src++;
+               vdest++;
+               n--;
+       }
+
+       /* looks weird, but helps the optimiser... */
+       if (n >=3D 4) {
+               unsigned long chunks =3D n >> 2;
+               volatile u32 * _dst =3D (volatile u32 *)(vdest - 4);
+               volatile u32 * _src =3D (volatile u32 *)(src - 4);
+
+               vdest +=3D chunks << 2;
+               src +=3D chunks << 2;
+               do {
+                       *++_dst =3D *++_src;
+               } while (--chunks);
+               n &=3D 3;
+       }
+
+       if (n >=3D 2) {
+               *((volatile u16 *)vdest) =3D *((volatile u16 *)src);
+               src +=3D 2;
+               vdest +=3D 2;
+               n -=3D 2;
+       }
+
+       if (n > 0) {
+               u8 buf[2];
+
+               *(u16 *)buf =3D *((volatile u16 *)vdest);
+               buf[0] =3D *((u8 *)src);
+               *((volatile u16 *)vdest) =3D *(u16 *)buf;
+       }
+
+       __asm__ __volatile__ ("sync" : : : "memory");
+}
+EXPORT_SYMBOL(mpc52xx_memcpy2lpb16);
diff -u linux-2.6.29.1.orig/arch/powerpc/include/asm/mpc52xx.h =20
linux-2.6.29.1/arch/powerpc/include/asm/mpc52xx.h
--- linux-2.6.29.1.orig/arch/powerpc/include/asm/mpc52xx.h      =20
2009-04-02 22:55:27.000000000 +0200
+++ linux-2.6.29.1/arch/powerpc/include/asm/mpc52xx.h   2009-06-09 =20
21:14:31.000000000 +0200
@@ -274,6 +274,8 @@
  extern void mpc52xx_map_common_devices(void);
  extern int mpc52xx_set_psc_clkdiv(int psc_id, int clkdiv);
  extern void mpc52xx_restart(char *cmd);
+extern void mpc52xx_memcpy2lpb16(volatile void __iomem *dest, const =20
void *src,
+                                unsigned long n);

  /* mpc52xx_pic.c */
  extern void mpc52xx_init_irq(void);
diff -u linux-2.6.29.1.orig/include/linux/mtd/map.h =20
linux-2.6.29.1/include/linux/mtd/map.h
--- linux-2.6.29.1.orig/include/linux/mtd/map.h 2009-04-02 =20
22:55:27.000000000 +0200
+++ linux-2.6.29.1/include/linux/mtd/map.h      2009-06-08 =20
14:28:05.000000000 +0200
@@ -13,6 +13,9 @@
  #include <asm/unaligned.h>
  #include <asm/system.h>
  #include <asm/io.h>
+#ifdef CONFIG_PPC_MPC52xx
+#include <asm/mpc52xx.h>
+#endif

  #ifdef CONFIG_MTD_MAP_BANK_WIDTH_1
  #define map_bankwidth(map) 1
@@ -417,6 +420,11 @@

  static inline void inline_map_copy_to(struct map_info *map, unsigned =20
long to, const void *from, ssize_t len)
  {
+#ifdef CONFIG_PPC_MPC52xx
+       if (map->bankwidth =3D=3D 2)
+               mpc52xx_memcpy2lpb16(map->virt + to, from, len);
+       else
+#endif
         memcpy_toio(map->virt + to, from, len);
  }


--=-zG+VAC3z0POAIM5D5WCy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKLrwNn/9unNAn/9ERApjkAKClNPO5D1Ai7zg+PJDF1Dk8rTMuiwCdHn54
DPsaM1/g8UDmbcdw69vSRIs=
=CHVG
-----END PGP SIGNATURE-----

--=-zG+VAC3z0POAIM5D5WCy--
