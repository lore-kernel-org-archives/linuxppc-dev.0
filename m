Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id EDB362C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2012 10:57:56 +1100 (EST)
Date: Thu, 29 Nov 2012 10:57:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc: collapse some equivalent asm macros
Message-Id: <20121129105750.ed10228886a7dcd62a71eaba@canb.auug.org.au>
In-Reply-To: <20121129105525.0e47b3b3e51aebe7ded3b7b6@canb.auug.org.au>
References: <20121129105525.0e47b3b3e51aebe7ded3b7b6@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__29_Nov_2012_10_57_50_+1100_VorYa8C_m0fogY9Z"
Cc: Alan Modra <amodra@au1.ibm.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__29_Nov_2012_10_57_50_+1100_VorYa8C_m0fogY9Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since we removed the section changes from them, some of the entry point
macros are now the same, so just use the obvious ones.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/ppc_asm.h |   41 --------------------------------=
----
 arch/powerpc/kernel/head_64.S      |    6 +++---
 arch/powerpc/kernel/misc_32.S      |    2 +-
 arch/powerpc/kernel/misc_64.S      |    2 +-
 4 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/=
ppc_asm.h
index 5c9af12..896204c 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -212,32 +212,6 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
=20
-#define _INIT_GLOBAL(name) \
-	.align 2 ; \
-	.globl name; \
-	.globl GLUE(.,name); \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
-
-#define _KPROBE(name) \
-	.align 2 ; \
-	.globl name; \
-	.globl GLUE(.,name); \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
-
 #define _STATIC(name) \
 	.align 2 ; \
 	.section ".opd","aw"; \
@@ -249,17 +223,6 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
=20
-#define _INIT_STATIC(name) \
-	.align 2 ; \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
-
 #else /* 32-bit */
=20
 #define _ENTRY(n)	\
@@ -271,10 +234,6 @@ n:
 	.globl n;	\
 n:
=20
-#define _KPROBE(n)	\
-	.globl	n;	\
-n:
-
 #endif
=20
 /*=20
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 8d3edb9..721d17b 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -355,7 +355,7 @@ _GLOBAL(__start_initialization_multiplatform)
=20
 	__REF
=20
-_INIT_STATIC(__boot_from_prom)
+_STATIC(__boot_from_prom)
 #ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 	/* Save parameters */
 	mr	r31,r3
@@ -687,7 +687,7 @@ p_toc:	.llong	__toc_start + 0x8000 - 0b
 /*
  * This is where the main kernel code starts.
  */
-_INIT_STATIC(start_here_multiplatform)
+_STATIC(start_here_multiplatform)
 	/* set up the TOC (real address) */
 	bl	.relative_toc
=20
@@ -757,7 +757,7 @@ _INIT_STATIC(start_here_multiplatform)
 	b	.	/* prevent speculative execution */
 =09
 	/* This is where all platforms converge execution */
-_INIT_GLOBAL(start_here_common)
+_GLOBAL(start_here_common)
 	/* relocation is on at this point */
 	std	r1,PACAKSAVE(r13)
=20
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 342c4d9..595af40 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -328,7 +328,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
  * flush_icache_range(unsigned long start, unsigned long stop)
  */
 	.section	".kprobes.text","a"
-_KPROBE(__flush_icache_range)
+_ENTRY(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 0fbe125..bc29512 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -68,7 +68,7 @@ PPC64_CACHES:
  */
=20
 	.section	".kprobes.text","a"
-_KPROBE(__flush_icache_range)
+_GLOBAL(__flush_icache_range)
=20
 /*
  * Flush the data cache to memory=20
--=20
1.7.10.280.gaa39

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__29_Nov_2012_10_57_50_+1100_VorYa8C_m0fogY9Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQtqT+AAoJEECxmPOUX5FEh2YP/02+wEgx5WTlPb+sFTxCAhMR
sN1SqctlUBMqjsgc3nO7nwp9CAYoVii0Kl2nRc6OZwflit2xydDMh82dORtkuEpu
TKAnWx5wvZ6e3wzQyaZ728yoBYoakNsKxWPArYaia4B8jkRZ0klAKIcKofSG4qx8
vvoFkbIgA+gYlo9k7daWuYaDFHyYsuJZdyYuMK9RUcxupRV6Umxmkxdym9rERT66
ktW911sDrBSADVE9PENMrY0ZI2xbNsog+drA6jBQwuvcybH3+shlxam7FWDxxvif
A8nDpkiyEhs253RHjSW0AFgw5YJdqIymRTFa2TJ7xGjkLEY0RQ1zw6xtzUhgLyDk
LeY2GCva86N1YzaQFqXjxigMn2Upjc1ukRrLMDjw0DaO4i3NU0LpRerQtkm6WPcp
A0/APJCBvF6sN0ogQT0iRIy7VAlm9TBsC2fitPJKDTcznpvqOehAgudB21Qhi6V+
AAjllg2jk/yJUxhLgGpcHHbRtAWQefQ5k0gxFWpx6sOcK4QNdlL5b2A9qtuIHaa+
K5cSbpAgeh01og8hdbGoqLrGPX96gMssipNQQ2WeJaNw9TFAh1uvK6jcwVF6vIic
Xvbya2p11Le48tStxdzG1PBasNv+B6FBQ0K4/LqZfrgl5JJ46e62py+BYomJysvu
eLlfXDGW/O/SLsFbN8Pb
=lnkn
-----END PGP SIGNATURE-----

--Signature=_Thu__29_Nov_2012_10_57_50_+1100_VorYa8C_m0fogY9Z--
