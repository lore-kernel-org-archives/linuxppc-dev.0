Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B6E9DE0DA
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 05:42:56 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m2SIgfs7015084
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 13:42:52 -0500
Date: Fri, 28 Mar 2008 13:38:52 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Move phys_addr_t definition into asm/types.h
Message-ID: <Pine.LNX.4.64.0803281338360.15109@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved phys_addr_t out of mmu-*.h and into asm/types.h so we can use it in
places that before would have caused recursive includes.

For example to use phys_addr_t in <asm/page.h> we would have included
<asm/mmu.h> which would have possibly included <asm/mmu-hash64.h> which
includes <asm/page.h>.  Wheeee recursive include.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-powerpc/mmu-40x.h       |    2 --
 include/asm-powerpc/mmu-44x.h       |    2 --
 include/asm-powerpc/mmu-8xx.h       |    2 --
 include/asm-powerpc/mmu-fsl-booke.h |    6 ------
 include/asm-powerpc/mmu-hash32.h    |    2 --
 include/asm-powerpc/mmu-hash64.h    |    3 ---
 include/asm-powerpc/types.h         |    7 +++++++
 7 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/asm-powerpc/mmu-40x.h b/include/asm-powerpc/mmu-40x.h
index 7d37f77..3d10867 100644
--- a/include/asm-powerpc/mmu-40x.h
+++ b/include/asm-powerpc/mmu-40x.h
@@ -53,8 +53,6 @@

 #ifndef __ASSEMBLY__

-typedef unsigned long phys_addr_t;
-
 typedef struct {
 	unsigned long id;
 	unsigned long vdso_base;
diff --git a/include/asm-powerpc/mmu-44x.h b/include/asm-powerpc/mmu-44x.h
index 62772ae..c8b02d9 100644
--- a/include/asm-powerpc/mmu-44x.h
+++ b/include/asm-powerpc/mmu-44x.h
@@ -53,8 +53,6 @@

 #ifndef __ASSEMBLY__

-typedef unsigned long long phys_addr_t;
-
 typedef struct {
 	unsigned long id;
 	unsigned long vdso_base;
diff --git a/include/asm-powerpc/mmu-8xx.h b/include/asm-powerpc/mmu-8xx.h
index 952bd88..9db877e 100644
--- a/include/asm-powerpc/mmu-8xx.h
+++ b/include/asm-powerpc/mmu-8xx.h
@@ -136,8 +136,6 @@
 #define SPRN_M_TW	799

 #ifndef __ASSEMBLY__
-typedef unsigned long phys_addr_t;
-
 typedef struct {
 	unsigned long id;
 	unsigned long vdso_base;
diff --git a/include/asm-powerpc/mmu-fsl-booke.h b/include/asm-powerpc/mmu-fsl-booke.h
index 3758000..925d93c 100644
--- a/include/asm-powerpc/mmu-fsl-booke.h
+++ b/include/asm-powerpc/mmu-fsl-booke.h
@@ -73,12 +73,6 @@

 #ifndef __ASSEMBLY__

-#ifndef CONFIG_PHYS_64BIT
-typedef unsigned long phys_addr_t;
-#else
-typedef unsigned long long phys_addr_t;
-#endif
-
 typedef struct {
 	unsigned long id;
 	unsigned long vdso_base;
diff --git a/include/asm-powerpc/mmu-hash32.h b/include/asm-powerpc/mmu-hash32.h
index 4bd735b..6e21ca6 100644
--- a/include/asm-powerpc/mmu-hash32.h
+++ b/include/asm-powerpc/mmu-hash32.h
@@ -84,8 +84,6 @@ typedef struct {
 	unsigned long vdso_base;
 } mm_context_t;

-typedef unsigned long phys_addr_t;
-
 #endif /* !__ASSEMBLY__ */

 #endif /* _ASM_POWERPC_MMU_HASH32_H_ */
diff --git a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
index 2864fa3..0dff767 100644
--- a/include/asm-powerpc/mmu-hash64.h
+++ b/include/asm-powerpc/mmu-hash64.h
@@ -469,9 +469,6 @@ static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
 				 VSID_MODULUS_256M)
 #define KERNEL_VSID(ea)		VSID_SCRAMBLE(GET_ESID(ea))

-/* Physical address used by some IO functions */
-typedef unsigned long phys_addr_t;
-
 #endif /* __ASSEMBLY__ */

 #endif /* _ASM_POWERPC_MMU_HASH64_H_ */
diff --git a/include/asm-powerpc/types.h b/include/asm-powerpc/types.h
index 903fd19..020db52 100644
--- a/include/asm-powerpc/types.h
+++ b/include/asm-powerpc/types.h
@@ -50,6 +50,13 @@ typedef struct {
 	__u32 u[4];
 } __attribute__((aligned(16))) __vector128;

+/* Physical address used by some IO functions */
+#ifndef CONFIG_PHYS_64BIT
+typedef unsigned long phys_addr_t;
+#else
+typedef unsigned long long phys_addr_t;
+#endif
+
 #endif /* __ASSEMBLY__ */

 #ifdef __KERNEL__
-- 
1.5.4.1
