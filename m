Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M39q2lB7zF213
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 02:25:19 +1000 (AEST)
Message-Id: <2656bbe3478dea7e9e602bb970cf665dc502a31d.1530807556.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1530807556.git.christophe.leroy@c-s.fr>
References: <cover.1530807556.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 13/16] powerpc: split reg.h in two parts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 16:25:15 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move all macros involving feature-fixups in a new file reg-ftr.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/exception-64s.h |  1 +
 arch/powerpc/include/asm/reg-ftr.h       | 71 ++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg.h           | 42 -------------------
 arch/powerpc/kernel/entry_64.S           |  1 +
 arch/powerpc/kernel/exceptions-64s.S     |  1 +
 arch/powerpc/kernel/head_64.S            |  1 +
 arch/powerpc/kernel/idle_book3s.S        |  1 +
 arch/powerpc/kernel/paca.c               |  1 +
 arch/powerpc/kernel/process.c            |  1 +
 arch/powerpc/kernel/tm.S                 |  1 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  1 +
 arch/powerpc/kvm/book3s_rmhandlers.S     |  1 +
 arch/powerpc/kvm/book3s_segment.S        |  1 +
 arch/powerpc/kvm/tm.S                    |  1 +
 14 files changed, 83 insertions(+), 42 deletions(-)
 create mode 100644 arch/powerpc/include/asm/reg-ftr.h

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 1f2efc1a9769..9d748eaeb9ec 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -36,6 +36,7 @@
  */
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
+#include <asm/reg-ftr.h>
 
 /* PACA save area offsets (exgen, exmc, etc) */
 #define EX_R9		0
diff --git a/arch/powerpc/include/asm/reg-ftr.h b/arch/powerpc/include/asm/reg-ftr.h
new file mode 100644
index 000000000000..73a024af3a9a
--- /dev/null
+++ b/arch/powerpc/include/asm/reg-ftr.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Contains the definition of registers common to all PowerPC variants.
+ * If a register definition has been changed in a different PowerPC
+ * variant, we will case it in #ifndef XXX ... #endif, and have the
+ * number used in the Programming Environments Manual For 32-Bit
+ * Implementations of the PowerPC Architecture (a.k.a. Green Book) here.
+ */
+
+#ifndef _ASM_POWERPC_REG_FTR_H
+#define _ASM_POWERPC_REG_FTR_H
+#ifdef __KERNEL__
+
+#include <linux/stringify.h>
+#include <asm/cputable.h>
+#include <asm/feature-fixups.h>
+#include <asm/reg.h>
+
+#ifdef CONFIG_PPC_BOOK3S_64
+
+#define GET_PACA(rX)					\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_PACA;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_HPACA;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
+
+#define SET_PACA(rX)					\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mtspr	SPRN_SPRG_PACA,rX;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mtspr	SPRN_SPRG_HPACA,rX;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
+
+#define GET_SCRATCH0(rX)				\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_SCRATCH0;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_HSCRATCH0;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
+
+#define SET_SCRATCH0(rX)				\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mtspr	SPRN_SPRG_SCRATCH0,rX;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mtspr	SPRN_SPRG_HSCRATCH0,rX;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
+
+#else /* CONFIG_PPC_BOOK3S_64 */
+#define GET_SCRATCH0(rX)	mfspr	rX,SPRN_SPRG_SCRATCH0
+#define SET_SCRATCH0(rX)	mtspr	SPRN_SPRG_SCRATCH0,rX
+
+#endif
+
+#ifdef CONFIG_PPC_BOOK3E_64
+
+#define SET_PACA(rX)	mtspr	SPRN_SPRG_PACA,rX
+#define GET_PACA(rX)	mfspr	rX,SPRN_SPRG_PACA
+
+#endif
+
+#ifndef __ASSEMBLY__
+static inline void mtmsr_isync(unsigned long val)
+{
+	asm volatile(__MTMSR " %0; " ASM_FTR_IFCLR("isync", "nop", %1) : :
+			"r" (val), "i" (CPU_FTR_ARCH_206) : "memory");
+}
+#endif
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_REG_FTR_H */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 486b7c83b8c5..a8b62363d6ee 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -14,7 +14,6 @@
 #include <linux/stringify.h>
 #include <asm/cputable.h>
 #include <asm/asm-const.h>
-#include <asm/feature-fixups.h>
 
 /* Pickup Book E specific registers. */
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
@@ -1105,38 +1104,6 @@
 #define SPRN_SPRG_VDSO_READ	SPRN_USPRG3
 #define SPRN_SPRG_VDSO_WRITE	SPRN_SPRG3
 
-#define GET_PACA(rX)					\
-	BEGIN_FTR_SECTION_NESTED(66);			\
-	mfspr	rX,SPRN_SPRG_PACA;			\
-	FTR_SECTION_ELSE_NESTED(66);			\
-	mfspr	rX,SPRN_SPRG_HPACA;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
-
-#define SET_PACA(rX)					\
-	BEGIN_FTR_SECTION_NESTED(66);			\
-	mtspr	SPRN_SPRG_PACA,rX;			\
-	FTR_SECTION_ELSE_NESTED(66);			\
-	mtspr	SPRN_SPRG_HPACA,rX;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
-
-#define GET_SCRATCH0(rX)				\
-	BEGIN_FTR_SECTION_NESTED(66);			\
-	mfspr	rX,SPRN_SPRG_SCRATCH0;			\
-	FTR_SECTION_ELSE_NESTED(66);			\
-	mfspr	rX,SPRN_SPRG_HSCRATCH0;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
-
-#define SET_SCRATCH0(rX)				\
-	BEGIN_FTR_SECTION_NESTED(66);			\
-	mtspr	SPRN_SPRG_SCRATCH0,rX;			\
-	FTR_SECTION_ELSE_NESTED(66);			\
-	mtspr	SPRN_SPRG_HSCRATCH0,rX;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
-
-#else /* CONFIG_PPC_BOOK3S_64 */
-#define GET_SCRATCH0(rX)	mfspr	rX,SPRN_SPRG_SCRATCH0
-#define SET_SCRATCH0(rX)	mtspr	SPRN_SPRG_SCRATCH0,rX
-
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E_64
@@ -1150,9 +1117,6 @@
 #define SPRN_SPRG_VDSO_READ	SPRN_USPRG7
 #define SPRN_SPRG_VDSO_WRITE	SPRN_SPRG7
 
-#define SET_PACA(rX)	mtspr	SPRN_SPRG_PACA,rX
-#define GET_PACA(rX)	mfspr	rX,SPRN_SPRG_PACA
-
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_32
@@ -1338,12 +1302,6 @@
 #define __MTMSR		"mtmsr"
 #endif
 
-static inline void mtmsr_isync(unsigned long val)
-{
-	asm volatile(__MTMSR " %0; " ASM_FTR_IFCLR("isync", "nop", %1) : :
-			"r" (val), "i" (CPU_FTR_ARCH_206) : "memory");
-}
-
 #define mfspr(rn)	({unsigned long rval; \
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 31068be6be59..5651d50d8d10 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -45,6 +45,7 @@
 #include <asm/exception-64e.h>
 #endif
 #include <asm/feature-fixups.h>
+#include <asm/reg-ftr.h>
 
 /*
  * System calls.
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a3c79aed2f61..06907e5e16a7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,6 +19,7 @@
 #include <asm/cpuidle.h>
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
+#include <asm/reg-ftr.h>
 
 /*
  * There are a few constraints to be concerned with.
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4898e9491a1c..fb959742aaa2 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -25,6 +25,7 @@
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <asm/reg.h>
+#include <asm/reg-ftr.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/ppc_asm.h>
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 0cb6ffe992c2..c87aaacda6d7 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -25,6 +25,7 @@
 #include <asm/mmu.h>
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
+#include <asm/reg-ftr.h>
 
 #undef DEBUG
 
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0ee3e6d50f28..75ae2a48d02d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -17,6 +17,7 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/kexec.h>
+#include <asm/reg-ftr.h>
 
 #include "setup.h"
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 6061efb369e8..402a0ce96d6a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -65,6 +65,7 @@
 #include <asm/livepatch.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
+#include <asm/reg-ftr.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index c0dcdd57cd7f..ac833198f308 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -11,6 +11,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/ptrace.h>
 #include <asm/reg.h>
+#include <asm/reg-ftr.h>
 #include <asm/bug.h>
 #include <asm/export.h>
 #include <asm/feature-fixups.h>
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ac53be00039a..2d01fcf44991 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -20,6 +20,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/kvm_asm.h>
 #include <asm/reg.h>
+#include <asm/reg-ftr.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index b0089e04c8c8..17a08780fb63 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -20,6 +20,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/kvm_asm.h>
 #include <asm/reg.h>
+#include <asm/reg-ftr.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index e5c542a7c5ac..6cb740cd8af4 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -21,6 +21,7 @@
 
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
+#include <asm/reg-ftr.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 
diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index 90e330f21356..112b8dee5a6d 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -15,6 +15,7 @@
  */
 
 #include <asm/reg.h>
+#include <asm/reg-ftr.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/export.h>
-- 
2.13.3
