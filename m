Return-Path: <millerjo@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpd4g5bvkzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 05:09:55 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 18 Apr 2016 13:09:53 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AE87019D8051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 12:57:41 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IJ9oxO44892306
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 12:09:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IJ9oho012521
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 13:09:50 -0600
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, anton@samba.org
Subject: [PATCH 2/3] powerpc: Load Monitor Register Support
Date: Mon, 18 Apr 2016 14:08:01 -0500
Message-Id: <1461006482-20595-3-git-send-email-jack@codezen.org>
In-Reply-To: <1461006482-20595-1-git-send-email-jack@codezen.org>
References: <1461006482-20595-1-git-send-email-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables new registers, LMRR and LMSER, that can trigger an EBB in
userspace code when a monitored load (via the new ldmx instruction)
loads memory from a monitored space. This facility is controlled by a
new FSCR bit, LM.

This patch disables the control bit on CPU setup and enables that bit
when a facility unavailable exception is taken for using it. On context
switch, this bit is then used to determine whether the two relevant
registers are saved and restored. This is done lazily for performance
reasons.

Signed-off-by: Jack Miller <jack@codezen.org>
---
 arch/powerpc/include/asm/processor.h  |  2 ++
 arch/powerpc/include/asm/reg.h        |  5 +++++
 arch/powerpc/kernel/cpu_setup_power.S |  3 ++-
 arch/powerpc/kernel/process.c         | 19 +++++++++++++++++++
 arch/powerpc/kernel/traps.c           |  4 ++++
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 009fab1..2bb822b 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -314,6 +314,8 @@ struct thread_struct {
 	unsigned long	mmcr2;
 	unsigned 	mmcr0;
 	unsigned 	used_ebb;
+	unsigned long	lmrr;
+	unsigned long	lmser;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7972c9f..ab98ca4 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -282,6 +282,8 @@
 #define SPRN_HRMOR	0x139	/* Real mode offset register */
 #define SPRN_HSRR0	0x13A	/* Hypervisor Save/Restore 0 */
 #define SPRN_HSRR1	0x13B	/* Hypervisor Save/Restore 1 */
+#define SPRN_LMRR	0x32D	/* Load Monitor Region Register */
+#define SPRN_LMSER	0x32E	/* Load Monitor Section Enable Register */
 #define SPRN_IC		0x350	/* Virtual Instruction Count */
 #define SPRN_VTB	0x351	/* Virtual Time Base */
 #define SPRN_LDBAR	0x352	/* LD Base Address Register */
@@ -291,6 +293,7 @@
 #define SPRN_PMCR	0x374	/* Power Management Control Register */
 
 /* HFSCR and FSCR bit numbers are the same */
+#define FSCR_LM_LG	11	/* Enable Load Monitor Registers */
 #define FSCR_TAR_LG	8	/* Enable Target Address Register */
 #define FSCR_EBB_LG	7	/* Enable Event Based Branching */
 #define FSCR_TM_LG	5	/* Enable Transactional Memory */
@@ -300,10 +303,12 @@
 #define FSCR_VECVSX_LG	1	/* Enable VMX/VSX  */
 #define FSCR_FP_LG	0	/* Enable Floating Point */
 #define SPRN_FSCR	0x099	/* Facility Status & Control Register */
+#define   FSCR_LM	__MASK(FSCR_LM_LG)
 #define   FSCR_TAR	__MASK(FSCR_TAR_LG)
 #define   FSCR_EBB	__MASK(FSCR_EBB_LG)
 #define   FSCR_DSCR	__MASK(FSCR_DSCR_LG)
 #define SPRN_HFSCR	0xbe	/* HV=1 Facility Status & Control Register */
+#define   HFSCR_LM	__MASK(FSCR_LM_LG)
 #define   HFSCR_TAR	__MASK(FSCR_TAR_LG)
 #define   HFSCR_EBB	__MASK(FSCR_EBB_LG)
 #define   HFSCR_TM	__MASK(FSCR_TM_LG)
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 584e119..a232930 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -157,7 +157,8 @@ __init_LPCR:
 
 __init_FSCR:
 	mfspr	r3,SPRN_FSCR
-	ori	r3,r3,FSCR_TAR|FSCR_DSCR|FSCR_EBB
+	ori	r3,r3,FSCR_LM|FSCR_TAR|FSCR_DSCR|FSCR_EBB
+	xori	r3,r3,FSCR_LM
 	mtspr	SPRN_FSCR,r3
 	blr
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 00bf6f5..3e91bd6 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1005,6 +1005,14 @@ static inline void save_sprs(struct thread_struct *t)
 		 */
 		t->tar = mfspr(SPRN_TAR);
 	}
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		/* Conditionally save Load Monitor registers, if enabled */
+		if (t->fscr & FSCR_LM) {
+			t->lmrr = mfspr(SPRN_LMRR);
+			t->lmser = mfspr(SPRN_LMSER);
+		}
+	}
 #endif
 }
 
@@ -1041,6 +1049,16 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 		if (old_thread->tar != new_thread->tar)
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		/* Conditionally restore Load Monitor registers, if enabled */
+		if (new_thread->fscr & FSCR_LM) {
+			if (old_thread->lmrr != new_thread->lmrr);
+				mtspr(SPRN_LMRR, new_thread->lmrr);
+			if (old_thread->lmser != new_thread->lmser);
+				mtspr(SPRN_LMSER, new_thread->lmser);
+		}
+	}
 #endif
 }
 
@@ -1592,6 +1610,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.tm_texasr = 0;
 	current->thread.tm_tfiar = 0;
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+	current->thread.fscr &= ~FSCR_LM;
 }
 EXPORT_SYMBOL(start_thread);
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9229ba6..93ff3ac 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1376,6 +1376,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		[FSCR_TM_LG] = "TM",
 		[FSCR_EBB_LG] = "EBB",
 		[FSCR_TAR_LG] = "TAR",
+		[FSCR_LM_LG] = "LM",
 	};
 	char *facility = "unknown";
 	u64 value;
@@ -1432,6 +1433,9 @@ void facility_unavailable_exception(struct pt_regs *regs)
 			emulate_single_step(regs);
 		}
 		return;
+	} else if ((status == FSCR_LM_LG) && cpu_has_feature(CPU_FTR_ARCH_300)) {
+		mtspr(SPRN_FSCR, value | FSCR_LM);
+		return;
 	}
 
 	if ((status < ARRAY_SIZE(facility_strings)) &&
-- 
2.8.0
