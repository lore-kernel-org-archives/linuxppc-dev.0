Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPlNC1TggzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 20:41:15 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Jack Miller <jack@codezen.org>
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, mikey@neuling.org,
 cyrilbur@gmail.com
Subject: [PATCH v6 1/3] powerpc: Improve FSCR init and context switching
Date: Wed,  8 Jun 2016 20:38:34 +1000
Message-Id: <1465382316-18588-2-git-send-email-mikey@neuling.org>
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
delicate. This adds the initial fscr value to INIT_THREAD to
explicitly set the FSCR for userspace applications and removes
__init_fscr: boot time init.

Based on patch by Jack Miller.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/kernel/cpu_setup_power.S | 10 ----------
 arch/powerpc/kernel/process.c         | 12 ++++--------
 arch/powerpc/kernel/traps.c           |  3 ++-
 4 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 009fab1..1833fe9 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -347,6 +347,7 @@ struct thread_struct {
 	.fs = KERNEL_DS, \
 	.fpexc_mode = 0, \
 	.ppr = INIT_PPR, \
+	.fscr = FSCR_TAR | FSCR_EBB \
 }
 #endif
 
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
index e2f12cb..74ea8db 100644
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
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9229ba6..a4b00ee 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1418,7 +1418,8 @@ void facility_unavailable_exception(struct pt_regs *regs)
 			rd = (instword >> 21) & 0x1f;
 			current->thread.dscr = regs->gpr[rd];
 			current->thread.dscr_inherit = 1;
-			mtspr(SPRN_FSCR, value | FSCR_DSCR);
+			current->thread.fscr = value | FSCR_DSCR;
+			mtspr(SPRN_FSCR, current->thread.fscr);
 		}
 
 		/* Read from DSCR (mfspr RT, 0x03) */
-- 
2.7.4
