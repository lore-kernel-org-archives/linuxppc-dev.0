Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3cCT4pRyzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:16:53 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c198so10001117pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 03:16:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/powernv: POWER9 support for msgsnd/doorbell IPI
Date: Thu, 13 Apr 2017 20:16:24 +1000
Message-Id: <20170413101624.26628-5-npiggin@gmail.com>
In-Reply-To: <20170413101624.26628-1-npiggin@gmail.com>
References: <20170413101624.26628-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 requires msgsync for receiver-side synchronization, and a DD1
workaround restricts IPIs to core-local.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/dbell.h          |  3 +++
 arch/powerpc/include/asm/feature-fixups.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/ppc-opcode.h     |  2 ++
 arch/powerpc/include/asm/ppc_asm.h        |  8 ++++++++
 arch/powerpc/platforms/powernv/smp.c      | 28 ++++++++++++++++++++++++++--
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 040944659a20..f70cbfe0ec04 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -51,6 +51,9 @@ static inline void ppc_msgsnd_sync(void)
 /* sync after taking message interrupt */
 static inline void ppc_msgsync(void)
 {
+	/* sync is not required when taking messages from the same core */
+	__asm__ __volatile__ (ASM_FTR_IFSET(PPC_MSGSYNC " ; lwsync", "", %0)
+				: : "i" (CPU_FTR_HVMODE|CPU_FTR_ARCH_300));
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
index e7d6d86563ee..142d78d645f4 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -161,6 +161,7 @@
 #define PPC_INST_MFTMR			0x7c0002dc
 #define PPC_INST_MSGSND			0x7c00019c
 #define PPC_INST_MSGCLR			0x7c0001dc
+#define PPC_INST_MSGSYNC		0x7c0006ec
 #define PPC_INST_MSGSNDP		0x7c00011c
 #define PPC_INST_MTTMR			0x7c0003dc
 #define PPC_INST_NOP			0x60000000
@@ -345,6 +346,7 @@
 					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
 					___PPC_RB(b))
+#define PPC_MSGSYNC		stringify_in_c(.long PPC_INST_MSGSYNC)
 #define PPC_MSGCLR(b)		stringify_in_c(.long PPC_INST_MSGCLR | \
 					___PPC_RB(b))
 #define PPC_MSGSNDP(b)		stringify_in_c(.long PPC_INST_MSGSNDP | \
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 359c44341761..4d9cac8b1066 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -402,6 +402,14 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	FTR_SECTION_ELSE_NESTED(848);	\
 	mtocrf (FXM), RS;		\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_NOEXECUTE, 848)
+
+#if defined(CONFIG_BOOKS)
+#define MSGSYNC(reg)			\
+	BEGIN_FTR_SECTION_NESTED(849);	\
+	PPC_MSGSYNC;			\
+	lwsync;				\
+	END_FTR_SECTION_NESTED_IFSET(CPU_FTR_HVMODE|CPU_FTR_ARCH_300, 849)
+#endif
 #endif
 
 /*
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 33bd4dd2cb41..951a2e230cfa 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -257,6 +257,23 @@ static void pnv_cause_ipi(int cpu)
 	icp_ops->cause_ipi(cpu);
 }
 
+static void pnv_p9_dd1_cause_ipi(int cpu)
+{
+	int this_cpu = get_cpu();
+
+	/*
+	 * POWER9 DD1 has a global addressed msgsnd, but for now we restrict
+	 * IPIs to same core, because it requires additional synchronization
+	 * for inter-core doorbells which we do not implement.
+	 */
+	if (cpumask_test_cpu(cpu, cpu_sibling_mask(this_cpu)))
+		doorbell_global_ipi(cpu);
+	else
+		icp_ops->cause_ipi(cpu);
+
+	put_cpu();
+}
+
 static void __init pnv_smp_probe(void)
 {
 	if (xive_enabled())
@@ -264,8 +281,15 @@ static void __init pnv_smp_probe(void)
 	else
 		xics_smp_probe();
 
-	if (cpu_has_feature(CPU_FTR_DBELL) && !cpu_has_feature(CPU_FTR_ARCH_300)) {
-		smp_ops->cause_ipi = pnv_cause_ipi;
+	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+				smp_ops->cause_ipi = pnv_p9_dd1_cause_ipi;
+			else
+				smp_ops->cause_ipi = doorbell_global_ipi;
+		} else {
+			smp_ops->cause_ipi = pnv_cause_ipi;
+		}
 	} else {
 		smp_ops->cause_ipi = icp_ops->cause_ipi;
 	}
-- 
2.11.0
