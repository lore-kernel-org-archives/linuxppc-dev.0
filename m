Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc: Correctly context switch DSCR on POWER8
Date: Mon,  5 Aug 2013 17:28:06 +1000
Message-Id: <1375687686-5633-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1375687686-5633-1-git-send-email-mikey@neuling.org>
References: <1375687686-5633-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8 allows the DSCR to be accessed directly from userspace via a new SPR
number 0x3 (Rather than 0x11.  DSCR SPR number 0x11 is still used on POWER8 but
like POWER7, is only accessible in HV and OS modes).  Currently, we allow this
by setting H/FSCR DSCR bit on boot.

Unfortunately this doesn't work, as the kernel needs to see the DSCR change so
that it knows to no longer restore the system wide version of DSCR on context
switch (ie. to set thread.dscr_inherit).

This clears the H/FSCR DSCR bit initially.  If a process then accesses the DSCR
(via SPR 0x3), it'll trap into the kernel where we set thread.dscr_inherit in
facility_unavailable_exception().

We also change _switch() so that we set or clear the H/FSCR DSCR bit based on
the thread.dscr_inherit.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cpu_setup_power.S |  8 ++++--
 arch/powerpc/kernel/entry_64.S        | 27 +++++++++++++++++-
 arch/powerpc/kernel/traps.c           | 54 +++++++++++++++++++++--------------
 3 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 18b5b9c..c7a3b81 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -123,14 +123,18 @@ __init_LPCR:
 
 __init_FSCR:
 	mfspr	r3,SPRN_FSCR
-	ori	r3,r3,FSCR_TAR|FSCR_DSCR|FSCR_EBB
+	ori	r3,r3,FSCR_TAR|FSCR_EBB
+	li	r5,HFSCR_DSCR
+	andc	r3,r3,r5
 	mtspr	SPRN_FSCR,r3
 	blr
 
 __init_HFSCR:
 	mfspr	r3,SPRN_HFSCR
 	ori	r3,r3,HFSCR_TAR|HFSCR_TM|HFSCR_BHRB|HFSCR_PM|\
-		      HFSCR_DSCR|HFSCR_VECVSX|HFSCR_FP|HFSCR_EBB
+		      HFSCR_VECVSX|HFSCR_FP|HFSCR_EBB
+	li	r5,HFSCR_DSCR
+	andc	r3,r3,r5
 	mtspr	SPRN_HFSCR,r3
 	blr
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ab15b8d..4674fe6 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -584,9 +584,34 @@ BEGIN_FTR_SECTION
 	ld	r7,DSCR_DEFAULT@toc(2)
 	ld	r0,THREAD_DSCR(r4)
 	cmpwi	r6,0
+	li	r8, FSCR_DSCR
 	bne	1f
 	ld	r0,0(r7)
-1:	cmpd	r0,r25
+	b	3f
+1:
+  BEGIN_FTR_SECTION_NESTED(70)
+	mfspr	r6, SPRN_FSCR
+	or	r6, r6, r8
+	mtspr	SPRN_FSCR, r6
+    BEGIN_FTR_SECTION_NESTED(69)
+	mfspr	r6, SPRN_HFSCR
+	or	r6, r6, r8
+	mtspr	SPRN_HFSCR, r6
+    END_FTR_SECTION_NESTED(CPU_FTR_HVMODE, CPU_FTR_HVMODE, 69)
+	b	4f
+  END_FTR_SECTION_NESTED(CPU_FTR_ARCH_207S, CPU_FTR_ARCH_207S, 70)
+3:
+  BEGIN_FTR_SECTION_NESTED(70)
+	mfspr	r6, SPRN_FSCR
+	andc	r6, r6, r8
+	mtspr	SPRN_FSCR, r6
+    BEGIN_FTR_SECTION_NESTED(69)
+	mfspr	r6, SPRN_HFSCR
+	andc	r6, r6, r8
+	mtspr	SPRN_HFSCR, r6
+    END_FTR_SECTION_NESTED(CPU_FTR_HVMODE, CPU_FTR_HVMODE, 69)
+  END_FTR_SECTION_NESTED(CPU_FTR_ARCH_207S, CPU_FTR_ARCH_207S, 70)
+4:	cmpd	r0,r25
 	beq	2f
 	mtspr	SPRN_DSCR,r0
 2:
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bf33c22..be7930e 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -44,9 +44,7 @@
 #include <asm/machdep.h>
 #include <asm/rtas.h>
 #include <asm/pmc.h>
-#ifdef CONFIG_PPC32
 #include <asm/reg.h>
-#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
@@ -1296,43 +1294,56 @@ void vsx_unavailable_exception(struct pt_regs *regs)
 	die("Unrecoverable VSX Unavailable Exception", regs, SIGABRT);
 }
 
+#ifdef CONFIG_PPC64
 void facility_unavailable_exception(struct pt_regs *regs)
 {
 	static char *facility_strings[] = {
-		"FPU",
-		"VMX/VSX",
-		"DSCR",
-		"PMU SPRs",
-		"BHRB",
-		"TM",
-		"AT",
-		"EBB",
-		"TAR",
+		[FSCR_FP_LG] = "FPU",
+		[FSCR_VECVSX_LG] = "VMX/VSX",
+		[FSCR_DSCR_LG] = "DSCR",
+		[FSCR_PM_LG] = "PMU SPRs",
+		[FSCR_BHRB_LG] = "BHRB",
+		[FSCR_TM_LG] = "TM",
+		[FSCR_EBB_LG] = "EBB",
+		[FSCR_TAR_LG] = "TAR",
 	};
-	char *facility, *prefix;
+	char *facility;
 	u64 value;
+	u8 status;
+	bool hv;
 
 	if (regs->trap == 0xf60) {
 		value = mfspr(SPRN_FSCR);
-		prefix = "";
+		hv = false;
 	} else {
 		value = mfspr(SPRN_HFSCR);
-		prefix = "Hypervisor ";
+		hv = true;
 	}
 
-	value = value >> 56;
+	status = value >> 56;
+
+	if (status < ARRAY_SIZE(facility_strings))
+		facility = facility_strings[status];
+	else
+		facility = "unknown";
+
+	if (status == FSCR_DSCR_LG) {
+		/* user wants to set it.  Hence clear the inherit bit
+		 * and allow them to set it via the H/FSCR */
+		current->thread.dscr_inherit = 1;
+		if (hv)
+			mtspr(SPRN_HFSCR, value | HFSCR_DSCR);
+		else
+			mtspr(SPRN_FSCR,  value |  FSCR_DSCR);
+		return;
+	}
 
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
-	if (value < ARRAY_SIZE(facility_strings))
-		facility = facility_strings[value];
-	else
-		facility = "unknown";
-
 	pr_err("%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
-		prefix, facility, regs->nip, regs->msr);
+	       hv ? "Hypervisor ":"", facility, regs->nip, regs->msr);
 
 	if (user_mode(regs)) {
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
@@ -1341,6 +1352,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 
 	die("Unexpected facility unavailable exception", regs, SIGABRT);
 }
+#endif
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 
-- 
1.8.1.2
