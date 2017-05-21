Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2P65QVfzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so14494328pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/9] powerpc/64s: paca add EX_SIZE definition for exception
 save areas
Date: Sun, 21 May 2017 23:15:46 +1000
Message-Id: <20170521131550.25813-6-npiggin@gmail.com>
In-Reply-To: <20170521131550.25813-1-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 30 +++++++++++++++++++-----------
 arch/powerpc/include/asm/paca.h          | 12 ++++++++----
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 183d73b6ed99..3edcad24684f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -24,18 +24,8 @@
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  */
-/*
- * The following macros define the code that appears as
- * the prologue to each of the exception handlers.  They
- * are split into two parts to allow a single kernel binary
- * to be used for pSeries and iSeries.
- *
- * We make as much of the exception code common between native
- * exception handlers (including pSeries LPAR) and iSeries LPAR
- * implementations as possible.
- */
-#include <asm/head-64.h>
 
+/* PACA save area offsets (exgen, exmc, etc) */
 #define EX_R9		0
 #define EX_R10		8
 #define EX_R11		16
@@ -51,6 +41,22 @@
 #define EX_PPR		88	/* SMT thread status register (priority) */
 #define EX_CTR		96
 
+#define EX_SIZE		13	/* size in u64 units */
+
+#ifdef __ASSEMBLY__
+
+/*
+ * The following macros define the code that appears as
+ * the prologue to each of the exception handlers.  They
+ * are split into two parts to allow a single kernel binary
+ * to be used for pSeries and iSeries.
+ *
+ * We make as much of the exception code common between native
+ * exception handlers (including pSeries LPAR) and iSeries LPAR
+ * implementations as possible.
+ */
+#include <asm/head-64.h>
+
 #ifdef CONFIG_RELOCATABLE
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
@@ -608,4 +614,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #define FINISH_NAP
 #endif
 
+#endif /*__ASSEMBLY__ */
+
 #endif	/* _ASM_POWERPC_EXCEPTION_H */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 1c09f8fe2ee8..8ea0907975a4 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -21,7 +21,11 @@
 #include <asm/lppaca.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
+#ifdef CONFIG_PPC_BOOK3E
 #include <asm/exception-64e.h>
+#else
+#include <asm/exception-64s.h>
+#endif
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #include <asm/kvm_book3s_asm.h>
 #endif
@@ -98,8 +102,8 @@ struct paca_struct {
 	 * Now, starting in cacheline 2, the exception save areas
 	 */
 	/* used for most interrupts/exceptions */
-	u64 exgen[13] __attribute__((aligned(0x80)));
-	u64 exslb[13];		/* used for SLB/segment table misses
+	u64 exgen[EX_SIZE] __attribute__((aligned(0x80)));
+	u64 exslb[EX_SIZE];	/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
@@ -181,8 +185,8 @@ struct paca_struct {
 
 #ifdef CONFIG_PPC_STD_MMU_64
 	/* Non-maskable exceptions that are not performance critical */
-	u64 exnmi[13];		/* used for system reset (nmi) */
-	u64 exmc[13];		/* used for machine checks */
+	u64 exnmi[EX_SIZE];	/* used for system reset (nmi) */
+	u64 exmc[EX_SIZE];	/* used for machine checks */
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Exclusive stacks for system reset and machine check exception. */
-- 
2.11.0
