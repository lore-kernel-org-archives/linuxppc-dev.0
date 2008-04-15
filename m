Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8BE4DE673
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 05:56:30 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 09/13] [POWERPC] Move phys_addr_t definition into asm/types.h
Date: Tue, 15 Apr 2008 14:52:27 -0500
Message-Id: <1208289151-2925-10-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1208289151-2925-9-git-send-email-galak@kernel.crashing.org>
References: <1208289151-2925-1-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-2-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-3-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-4-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-5-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-6-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-7-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-8-git-send-email-galak@kernel.crashing.org>
	<1208289151-2925-9-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
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

CONFIG_PHYS_64BIT is a bit counterintuitive in light of ppc64 systems
and thus the config option is only used for ppc32 systems with >32-bit
physical addresses (44x, 85xx, 745x, etc.).

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
index 903fd19..c243a6a 100644
--- a/include/asm-powerpc/types.h
+++ b/include/asm-powerpc/types.h
@@ -84,6 +84,13 @@ typedef unsigned long long u64;
 
 typedef __vector128 vector128;
 
+/* Physical address used by some IO functions */
+#if defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
+typedef u64 phys_addr_t;
+#else
+typedef u32 phys_addr_t;
+#endif
+
 #ifdef __powerpc64__
 typedef u64 dma_addr_t;
 #else
-- 
1.5.4.1
