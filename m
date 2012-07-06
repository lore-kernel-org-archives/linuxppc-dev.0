Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D4C972C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 17:09:46 +1000 (EST)
Date: Fri, 6 Jul 2012 17:09:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: put the gpr sabe/restore functions in their own
 section
Message-Id: <20120706170940.e3457b04a58ddd18d963c14a@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__6_Jul_2012_17_09_40_+1000_R9UkDp27wTR_v4Cy"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__6_Jul_2012_17_09_40_+1000_R9UkDp27wTR_v4Cy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This allows the linker to know that calls to them do not need to switch
TOC and stop errors like the following when linking large configurations:

powerpc64-linux-ld: drivers/built-in.o: In function `.gpiochip_is_requested=
':
(.text+0x4): sibling call optimization to `_savegpr0_29' does not allow aut=
omatic multiple TOCs; recompile with -mminimal-toc or -fno-optimize-sibling=
-calls, or make `_savegpr0_29' extern

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/lib/crtsavres.S |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index 1c893f0..b2c68ce 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -41,12 +41,13 @@
 #include <asm/ppc_asm.h>
=20
 	.file	"crtsavres.S"
-	.section ".text"
=20
 #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
=20
 #ifndef CONFIG_PPC64
=20
+	.section ".text"
+
 /* Routines for saving integer registers, called by the compiler.  */
 /* Called with r11 pointing to the stack header word of the caller of the =
*/
 /* function, just beyond the end of the integer save area.  */
@@ -232,6 +233,8 @@ _GLOBAL(_rest32gpr_31_x)
=20
 #else /* CONFIG_PPC64 */
=20
+	.section ".text.save.restore","ax",@progbits
+
 .globl	_savegpr0_14
 _savegpr0_14:
 	std	r14,-144(r1)
--=20
1.7.10.280.gaa39

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__6_Jul_2012_17_09_40_+1000_R9UkDp27wTR_v4Cy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP9o80AAoJEECxmPOUX5FEWIcP/13XNygwnHx5rvaBkxhKT8PF
wnwDooamAc1EDpSrzSkd9T9t1fHq7V1hG20Mp6qw3ZpCkSdylq5Gq5r/v1GbZl0G
fS+7G5piNRt6s5Vwlc85ljZIiuA2RPKo5nC/Q1AD36evWd2IzegC+1K81DtXiWTl
uAKXf8oFsqA+4EmafFB/aIlesc/nsYdTxHzBVRZN2gGlQrJRkEyXg0vjU7a3yDE6
4aAKnixGpPW88hmmLLjUieiYqathY8erKozCQ31K0+/CeGgeBUJGMkCODot+E/av
+znq7R+lhT7MOmwLZgBP8Ggozzm11W9nh0y6EJNMNI9A/jLceKfpvDdOrq4jisgl
rtM31BHWT3ZV/GhBgMT6psDeHO0HWhHQZS7795XFX7PPsCFAF/JSte4jCdFoVmbr
9Uhi9WJSzr8l3AfKJKsT3a7LU8AmGPaSEZQZMgmJJFt0DYmk78pqnqTY36b4XrSu
BEcQjxzobWfmRJ0sOdTaYumn7MP/B2/Phq5EUIIuichCXgwaQIo9LdkxR7eIcm4n
YEPOywqsVl+TTR8NTkfeRQYJVvwiqszm6CE495L+gk5kCW8mzxtlfcXTMEtzlDDo
SOJ1bLkEHXEDRu7LSx+ETg4bISJDzl+wyufn1Q3hP9zBQWjChhepB6Ig/z697ucE
Es18QDXu9MttfU2iwNs7
=SW8P
-----END PGP SIGNATURE-----

--Signature=_Fri__6_Jul_2012_17_09_40_+1000_R9UkDp27wTR_v4Cy--
