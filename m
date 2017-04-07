Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w002T5NRHzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 22:56:33 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 79so15458254pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 05:56:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/powernv: POWER9 support for msgsnd/doorbell IPI
Date: Fri,  7 Apr 2017 22:56:02 +1000
Message-Id: <20170407125602.31146-6-npiggin@gmail.com>
In-Reply-To: <20170407125602.31146-1-npiggin@gmail.com>
References: <20170407125602.31146-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 requires msgsync for receiver-side synchronization,
and a DD1 workaround that uses the darn instruction.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/dbell.h          |  8 ++++++++
 arch/powerpc/include/asm/feature-fixups.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/ppc-opcode.h     |  6 ++++++
 arch/powerpc/include/asm/ppc_asm.h        | 15 +++++++++++++++
 arch/powerpc/platforms/powernv/smp.c      |  8 ++++++--
 5 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 8ad66ccb7180..2cdad4381045 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -51,6 +51,14 @@ static inline void ppc_msgsnd_sync(void)
 /* sync after taking message interrupt */
 static inline void ppc_msgsync(void)
 {
+	/* sync is not required when taking messages from the same core */
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && cpu_has_feature(CPU_FTR_HVMODE)) {
+		unsigned long reg;
+		__asm__ __volatile__ (ASM_FTR_IFCLR(
+			PPC_MSGSYNC " ; lwsync",
+			PPC_DARN(%0, 2) " ; lwsync",
+			%1) : "=r" (reg) : "i" (CPU_FTR_POWER9_DD1) : "memory");
+	}
 }
 
 #else /* CONFIG_PPC_BOOK3S */
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index ddf54f5bbdd1..d6b8c9a20496 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -66,7 +66,14 @@ label##5:							\
 #define END_FTR_SECTION(msk, val)		\
 	END_FTR_SECTION_NESTED(msk, val, 97)
 
+#define END_FTR_SECTION_NESTED_IFSET(msk, label) \
+	END_FTR_SECTION_NESTED((msk), (msk), label)
+
 #define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
+
+#define END_FTR_SECTION_NESTED_IFCLR(msk, label) \
+	END_FTR_SECTION_NESTED((msk), 0, label)
+
 #define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
 
 /* CPU feature sections with alternatives, use BEGIN_FTR_SECTION to start */
@@ -153,12 +160,25 @@ label##5:							\
 	section_else "; "					\
 	stringify_in_c(ALT_FTR_SECTION_END((msk), (val)))
 
+#define ASM_FTR_IF_NESTED(section_if, section_else, msk, val, label)	\
+	stringify_in_c(BEGIN_FTR_SECTION_NESTED(label))		\
+	section_if "; "						\
+	stringify_in_c(FTR_SECTION_ELSE_NESTED(label))		\
+	section_else "; "					\
+	stringify_in_c(ALT_FTR_SECTION_END_NESTED((msk), (val), label))
+
 #define ASM_FTR_IFSET(section_if, section_else, msk)	\
 	ASM_FTR_IF(section_if, section_else, (msk), (msk))
 
+#define ASM_FTR_IFSET_NESTED(section_if, section_else, msk, label)	\
+	ASM_FTR_IF(section_if, section_else, (msk), (msk), label)
+
 #define ASM_FTR_IFCLR(section_if, section_else, msk)	\
 	ASM_FTR_IF(section_if, section_else, (msk), 0)
 
+#define ASM_FTR_IFCLR_NESTED(section_if, section_else, msk, label)	\
+	ASM_FTR_IF(section_if, section_else, (msk), 0, label)
+
 #define ASM_MMU_FTR_IF(section_if, section_else, msk, val)	\
 	stringify_in_c(BEGIN_MMU_FTR_SECTION)			\
 	section_if "; "						\
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index e7d6d86563ee..44009dfeab69 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -134,6 +134,7 @@
 #define PPC_INST_COPY			0x7c00060c
 #define PPC_INST_COPY_FIRST		0x7c20060c
 #define PPC_INST_CP_ABORT		0x7c00068c
+#define PPC_INST_DARN			0x7c0005e6
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
@@ -161,6 +162,7 @@
 #define PPC_INST_MFTMR			0x7c0002dc
 #define PPC_INST_MSGSND			0x7c00019c
 #define PPC_INST_MSGCLR			0x7c0001dc
+#define PPC_INST_MSGSYNC		0x7c0006ec
 #define PPC_INST_MSGSNDP		0x7c00011c
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
@@ -310,6 +312,7 @@
 #define __PPC_XS(s)	((((s) & 0x1f) << 21) | (((s) & 0x20) >> 5))
 #define __PPC_XT(s)	__PPC_XS(s)
 #define __PPC_T_TLB(t)	(((t) & 0x3) << 21)
+#define __PPC_L_DARN(l)	(((l) & 0x3) << 16)
 #define __PPC_WC(w)	(((w) & 0x3) << 21)
 #define __PPC_WS(w)	(((w) & 0x1f) << 11)
 #define __PPC_SH(s)	__PPC_WS(s)
@@ -333,6 +336,8 @@
 
 /* Deal with instructions that older assemblers aren't aware of */
 #define	PPC_CP_ABORT		stringify_in_c(.long PPC_INST_CP_ABORT)
+#define	PPC_DARN(t, l)		stringify_in_c(.long PPC_INST_DARN | \
+					___PPC_RT(t) | __PPC_L_DARN(l))
 #define	PPC_DCBAL(a, b)		stringify_in_c(.long PPC_INST_DCBAL | \
 					__PPC_RA(a) | __PPC_RB(b))
 #define	PPC_DCBZL(a, b)		stringify_in_c(.long PPC_INST_DCBZL | \
@@ -345,6 +350,7 @@
 					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
 					___PPC_RB(b))
+#define PPC_MSGSYNC		stringify_in_c(.long PPC_INST_MSGSYNC)
 #define PPC_MSGCLR(b)		stringify_in_c(.long PPC_INST_MSGCLR | \
 					___PPC_RB(b))
 #define PPC_MSGSNDP(b)		stringify_in_c(.long PPC_INST_MSGSNDP | \
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 359c44341761..8ab5dc554ca5 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -402,6 +402,21 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	FTR_SECTION_ELSE_NESTED(848);	\
 	mtocrf (FXM), RS;		\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_NOEXECUTE, 848)
+
+#if defined(CONFIG_BOOKS)
+#define MSGSYNC(reg)			\
+	BEGIN_FTR_SECTION_NESTED(849);	\
+					\
+	BEGIN_FTR_SECTION_NESTED(850);	\
+	PPC_MSGSYNC;			\
+	lwsync;				\
+	FTR_SECTION_ELSE_NESTED(850);	\
+	PPC_DARN(reg, 2);		\
+	lwsync;				\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POWER9_DD1, 850); \
+					\
+	END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE|CPU_FTR_ARCH_300, 849)
+#endif
 #endif
 
 /*
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c86b3693bcae..45a7efa3f03c 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -249,6 +249,7 @@ static int pnv_cpu_bootable(unsigned int nr)
 
 static void pnv_cause_ipi(int cpu)
 {
+	/* Pre-POWER9 has only core-local dbell IPIs. Must fall back to IC. */
 	if (try_core_doorbell_cause_ipi(cpu))
 		return;
 	icp_ops->cause_ipi(cpu);
@@ -258,8 +259,11 @@ static __init void pnv_smp_probe(void)
 {
 	xics_smp_probe();
 
-	if (cpu_has_feature(CPU_FTR_DBELL) && !cpu_has_feature(CPU_FTR_ARCH_300)) {
-		smp_ops->cause_ipi = pnv_cause_ipi;
+	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			smp_ops->cause_ipi = global_doorbell_cause_ipi;
+		else
+			smp_ops->cause_ipi = pnv_cause_ipi;
 	} else {
 		smp_ops->cause_ipi = icp_ops->cause_ipi;
 	}
-- 
2.11.0
