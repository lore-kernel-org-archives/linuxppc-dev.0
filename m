Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 690992C007E
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2012 02:08:51 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 3 Dec 2012 20:38:40 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2A3F8E004A
 for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2012 20:38:18 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB3F8hrH40632368
 for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2012 20:38:43 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB3F8hZ0006370
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2012 02:08:44 +1100
Subject: [PATCH v2 2/4] powerpc: Move the single step enable code to a
 generic path
To: bigeasy@linutronix.de, oleg@redhat.com, ananth@in.ibm.com,
 srikar@linux.vnet.ibm.com
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Mon, 03 Dec 2012 20:38:37 +0530
Message-ID: <20121203150754.7727.42629.stgit@suzukikp>
In-Reply-To: <20121203150438.7727.74924.stgit@suzukikp>
References: <20121203150438.7727.74924.stgit@suzukikp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 anton@redhat.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Suzuki K. Poulose <suzuki@in.ibm.com>

This patch moves the single step enable code used by kprobe to a generic
routine header so that, it can be re-used by other code, in this case,
uprobes. No functional changes.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc:	Ananth N Mavinakaynahalli <ananth@in.ibm.com>
Cc:	Kumar Gala <galak@kernel.crashing.org>
Cc:	linuxppc-dev@ozlabs.org
---
 arch/powerpc/include/asm/probes.h |   25 +++++++++++++++++++++++++
 arch/powerpc/kernel/kprobes.c     |   21 +--------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/probes.h b/arch/powerpc/include/asm/probes.h
index 5f1e15b..f94a44f 100644
--- a/arch/powerpc/include/asm/probes.h
+++ b/arch/powerpc/include/asm/probes.h
@@ -38,5 +38,30 @@ typedef u32 ppc_opcode_t;
 #define is_trap(instr)		(IS_TW(instr) || IS_TWI(instr))
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+#define MSR_SINGLESTEP	(MSR_DE)
+#else
+#define MSR_SINGLESTEP	(MSR_SE)
+#endif
+
+/* Enable single stepping for the current task */
+static inline void enable_single_step(struct pt_regs *regs)
+{
+	regs->msr |= MSR_SINGLESTEP;
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+	/* 
+	 * We turn off Critical Input Exception(CE) to ensure that the single
+	 * step will be for the instruction we have the probe on; if we don't,
+	 * it is possible we'd get the single step reported for CE.
+	 */
+	regs->msr &= ~MSR_CE;
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#ifdef CONFIG_PPC_47x
+	isync();
+#endif
+#endif
+}
+
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_PROBES_H */
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 4901b34..92f1be7 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -36,12 +36,6 @@
 #include <asm/sstep.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
-#define MSR_SINGLESTEP	(MSR_DE)
-#else
-#define MSR_SINGLESTEP	(MSR_SE)
-#endif
-
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
@@ -104,20 +98,7 @@ void __kprobes arch_remove_kprobe(struct kprobe *p)
 
 static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
-	regs->msr |= MSR_SINGLESTEP;
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
-	/* 
-	 * We turn off Critical Input Exception(CE) to ensure that the single
-	 * step will be for the instruction we have the probe on; if we don't,
-	 * it is possible we'd get the single step reported for CE.
-	 */
-	regs->msr &= ~MSR_CE;
-	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
-#ifdef CONFIG_PPC_47x
-	isync();
-#endif
-#endif
-
+	enable_single_step(regs);
 	/*
 	 * On powerpc we should single step on the original
 	 * instruction even if the probed insn is a trap
