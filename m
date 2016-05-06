Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1G3P6G3JzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 12:30:41 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Jack Miller <jack@codezen.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	anton@samba.org,
	mikey@neuling.org
Subject: [PATCH v5 1/3] powerpc: Improve FSCR init and context switching
Date: Fri,  6 May 2016 12:30:20 +1000
Message-Id: <1462501822-11262-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1462501822-11262-1-git-send-email-mikey@neuling.org>
References: <1462360567-4360-1-git-send-email-mikey@neuling.org>
 <1462501822-11262-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a few issues with FSCR init and switching.

In this patch:
    powerpc: Create context switch helpers save_sprs() and restore_sprs()
    Author: Anton Blanchard <anton@samba.org>
    commit 152d523e6307c7152f9986a542f873b5c5863937
We moved the setting of the FSCR register from inside an
CPU_FTR_ARCH_207S section to inside just a CPU_FTR_ARCH_DSCR section.
Hence we are setting FSCR on POWER6/7 where the FSCR doesn't
exist. This is harmless but we shouldn't do it.

Also, we can simplify the FSCR context switch. We don't need to go
through the calculation involving dscr_inherit. We can just restore
what we saved last time.

Also, we currently don't explicitly init the FSCR for userspace
applications. Currently we init FSCR on boot in __init_fscr: and then
the first task inherits based on that. Currently it works but is
delicate. This adds init_fscr() to explicitly set the FSCR for
userspace applications and removes __init_fscr: boot time init.

Based on patch by Jack Miller.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cpu_setup_power.S | 10 ----------
 arch/powerpc/kernel/process.c         | 23 +++++++++++++++--------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 584e119..75f98c8 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -49,7 +49,6 @@ _GLOBAL(__restore_cpu_power7)
 
 _GLOBAL(__setup_cpu_power8)
 	mflr	r11
-	bl	__init_FSCR
 	bl	__init_PMU
 	bl	__init_hvmode_206
 	mtlr	r11
@@ -67,7 +66,6 @@ _GLOBAL(__setup_cpu_power8)
 
 _GLOBAL(__restore_cpu_power8)
 	mflr	r11
-	bl	__init_FSCR
 	bl	__init_PMU
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
@@ -86,7 +84,6 @@ _GLOBAL(__restore_cpu_power8)
 
 _GLOBAL(__setup_cpu_power9)
 	mflr	r11
-	bl	__init_FSCR
 	bl	__init_hvmode_206
 	mtlr	r11
 	beqlr
@@ -102,7 +99,6 @@ _GLOBAL(__setup_cpu_power9)
 
 _GLOBAL(__restore_cpu_power9)
 	mflr	r11
-	bl	__init_FSCR
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	mtlr	r11
@@ -155,12 +151,6 @@ __init_LPCR:
 	isync
 	blr
 
-__init_FSCR:
-	mfspr	r3,SPRN_FSCR
-	ori	r3,r3,FSCR_TAR|FSCR_DSCR|FSCR_EBB
-	mtspr	SPRN_FSCR,r3
-	blr
-
 __init_HFSCR:
 	mfspr	r3,SPRN_HFSCR
 	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_BHRB|HFSCR_PM|\
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ea8a28f..e934677 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1023,18 +1023,11 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
 		u64 dscr = get_paca()->dscr_default;
-		u64 fscr = old_thread->fscr & ~FSCR_DSCR;
-
-		if (new_thread->dscr_inherit) {
+		if (new_thread->dscr_inherit)
 			dscr = new_thread->dscr;
-			fscr |= FSCR_DSCR;
-		}
 
 		if (old_thread->dscr != dscr)
 			mtspr(SPRN_DSCR, dscr);
-
-		if (old_thread->fscr != fscr)
-			mtspr(SPRN_FSCR, fscr);
 	}
 
 	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
@@ -1045,6 +1038,9 @@ static inline void restore_sprs(struct thread_struct *old_thread,
 		if (old_thread->ebbrr != new_thread->ebbrr)
 			mtspr(SPRN_EBBRR, new_thread->ebbrr);
 
+		if (old_thread->fscr != new_thread->fscr)
+			mtspr(SPRN_FSCR, new_thread->fscr);
+
 		if (old_thread->tar != new_thread->tar)
 			mtspr(SPRN_TAR, new_thread->tar);
 	}
@@ -1391,6 +1387,15 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
 #endif
 }
 
+#ifdef CONFIG_PPC64
+void init_fscr(struct task_struct *tsk)
+{
+	tsk->thread.fscr = FSCR_TAR|FSCR_EBB;
+	if (current->thread.dscr_inherit)
+		tsk->thread.fscr |= FSCR_DSCR;
+}
+#endif
+
 /*
  * Copy a thread..
  */
@@ -1484,6 +1489,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 		p->thread.dscr_inherit = current->thread.dscr_inherit;
 		p->thread.dscr = mfspr(SPRN_DSCR);
 	}
+	init_fscr(p);
 	if (cpu_has_feature(CPU_FTR_HAS_PPR))
 		p->thread.ppr = INIT_PPR;
 #endif
@@ -1574,6 +1580,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 		regs->gpr[2] = 0;
 		regs->msr = MSR_USER32;
 	}
+	init_fscr(current);
 #endif
 #ifdef CONFIG_VSX
 	current->thread.used_vsr = 0;
-- 
2.7.4
