Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80g52gQzF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:55 +1000 (AEST)
Message-Id: <c41b20f071c376087f0fac8c0bf95c9b6046dd65.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 13/14] powerpc: split reg.h in two parts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:51 +0000 (UTC)
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
 arch/powerpc/include/asm/reg-ftr.h       | 63 ++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg.h           | 36 ------------------
 arch/powerpc/kernel/entry_64.S           |  1 +
 arch/powerpc/kernel/exceptions-64s.S     |  1 +
 arch/powerpc/kernel/head_64.S            |  1 +
 arch/powerpc/kernel/idle_book3s.S        |  1 +
 arch/powerpc/kernel/paca.c               |  1 +
 arch/powerpc/kernel/tm.S                 |  1 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  1 +
 arch/powerpc/kvm/book3s_rmhandlers.S     |  1 +
 arch/powerpc/kvm/book3s_segment.S        |  1 +
 12 files changed, 73 insertions(+), 36 deletions(-)
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
index 000000000000..ec2e53c500c2
--- /dev/null
+++ b/arch/powerpc/include/asm/reg-ftr.h
@@ -0,0 +1,63 @@
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
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_REG_FTR_H */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index b59a633dc349..69dcf26a02a8 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -14,7 +14,6 @@
 #include <linux/stringify.h>
 #include <asm/cputable.h>
 #include <asm/asm-const.h>
-#include <asm/feature-fixups.h>
 
 /* Pickup Book E specific registers. */
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
@@ -1084,38 +1083,6 @@
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
@@ -1129,9 +1096,6 @@
 #define SPRN_SPRG_VDSO_READ	SPRN_USPRG7
 #define SPRN_SPRG_VDSO_WRITE	SPRN_SPRG7
 
-#define SET_PACA(rX)	mtspr	SPRN_SPRG_PACA,rX
-#define GET_PACA(rX)	mfspr	rX,SPRN_SPRG_PACA
-
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_32
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 768e5b766e12..c8cd671afa31 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -44,6 +44,7 @@
 #include <asm/exception-64e.h>
 #endif
 #include <asm/feature-fixups.h>
+#include <asm/reg-ftr.h>
 
 /*
  * System calls.
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d15c01198573..da7fde072364 100644
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
 
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index f717e1f50faf..19bece0292e2 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -11,6 +11,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/ptrace.h>
 #include <asm/reg.h>
+#include <asm/reg-ftr.h>
 #include <asm/bug.h>
 #include <asm/feature-fixups.h>
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index a919676fb60f..79f9badd02c5 100644
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
index 4b0fffd1937b..a3d3a3a96d41 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -21,6 +21,7 @@
 
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
+#include <asm/reg-ftr.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 
-- 
2.13.3
