Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPlND2D3KzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 20:41:16 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Jack Miller <jack@codezen.org>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org,
 cyrilbur@gmail.com
Subject: [PATCH v6 2/3] powerpc: Load Monitor Register Support
Date: Wed,  8 Jun 2016 20:38:35 +1000
Message-Id: <1465382316-18588-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1465382316-18588-1-git-send-email-mikey@neuling.org>
References: <1462501822-11262-1-git-send-email-mikey@neuling.org>
 <1465382316-18588-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jack Miller <jack@codezen.org>

This enables new registers, LMRR and LMSER, that can trigger an EBB in
userspace code when a monitored load (via the new ldmx instruction)
loads memory from a monitored space. This facility is controlled by a
new FSCR bit, LM.

This patch disables the FSCR LM control bit on task init and enables
that bit when a load monitor facility unavailable exception is taken
for using it. On context switch, this bit is then used to determine
whether the two relevant registers are saved and restored. This is
done lazily for performance reasons.

Signed-off-by: Jack Miller <jack@codezen.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/processor.h |  2 ++
 arch/powerpc/include/asm/reg.h       |  5 +++++
 arch/powerpc/kernel/process.c        | 18 ++++++++++++++++++
 arch/powerpc/kernel/traps.c          |  4 ++++
 4 files changed, 29 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 1833fe9..ac7670d 100644
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
index a0948f4..ce44fe2 100644
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
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 74ea8db..2e22f60 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1009,6 +1009,14 @@ static inline void save_sprs(struct thread_struct *t)
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
 
@@ -1044,6 +1052,16 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 		if (old_thread->tar != new_thread->tar)
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		/* Conditionally restore Load Monitor registers, if enabled */
+		if (new_thread->fscr & FSCR_LM) {
+			if (old_thread->lmrr != new_thread->lmrr)
+				mtspr(SPRN_LMRR, new_thread->lmrr);
+			if (old_thread->lmser != new_thread->lmser)
+				mtspr(SPRN_LMSER, new_thread->lmser);
+		}
+	}
 #endif
 }
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a4b00ee..aabdeac 100644
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
@@ -1433,6 +1434,9 @@ void facility_unavailable_exception(struct pt_regs *regs)
 			emulate_single_step(regs);
 		}
 		return;
+	} else if ((status == FSCR_LM_LG) && cpu_has_feature(CPU_FTR_ARCH_300)) {
+		mtspr(SPRN_FSCR, value | FSCR_LM);
+		return;
 	}
 
 	if ((status < ARRAY_SIZE(facility_strings)) &&
-- 
2.7.4
