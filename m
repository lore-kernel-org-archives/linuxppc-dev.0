Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5AB1DE076
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:36 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/22] [POWERPC] Add cpu feature for SPE handling
Date: Thu, 13 Sep 2007 16:07:52 -0500
Message-Id: <11897177032288-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897177013875-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
	<11897177013875-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make it so that SPE support can be determined at runtime.  This is similiar
to how we handle AltiVec.  This allows us to have SPE support built in and
work on processors with and without SPE.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/cputable.c |   23 +++++++----------------
 arch/powerpc/kernel/entry_32.S |    4 ++++
 arch/powerpc/kernel/process.c  |   15 +++++++++++----
 arch/powerpc/kernel/ptrace.c   |    6 ++----
 include/asm-powerpc/cputable.h |   26 ++++++++++++++++++++++----
 5 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 5873073..8eb8087 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -68,15 +68,6 @@ extern void __restore_cpu_ppc970(void);
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
 
-/* We only set the spe features if the kernel was compiled with
- * spe support
- */
-#ifdef CONFIG_SPE
-#define PPC_FEATURE_SPE_COMP	PPC_FEATURE_HAS_SPE
-#else
-#define PPC_FEATURE_SPE_COMP	0
-#endif
-
 static struct cpu_spec cpu_specs[] = {
 #ifdef CONFIG_PPC64
 	{	/* Power3 */
@@ -1261,8 +1252,8 @@ static struct cpu_spec cpu_specs[] = {
 		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
 		.cpu_features		= CPU_FTRS_E200,
 		.cpu_user_features	= COMMON_USER_BOOKE |
-			PPC_FEATURE_SPE_COMP |
-			PPC_FEATURE_HAS_EFP_SINGLE |
+			PPC_FEATURE_HAS_SPE_COMP |
+			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
 			PPC_FEATURE_UNIFIED_CACHE,
 		.dcache_bsize		= 32,
 		.platform		= "ppc5554",
@@ -1274,8 +1265,8 @@ static struct cpu_spec cpu_specs[] = {
 		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
 		.cpu_features		= CPU_FTRS_E500,
 		.cpu_user_features	= COMMON_USER_BOOKE |
-			PPC_FEATURE_SPE_COMP |
-			PPC_FEATURE_HAS_EFP_SINGLE,
+			PPC_FEATURE_HAS_SPE_COMP |
+			PPC_FEATURE_HAS_EFP_SINGLE_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
@@ -1290,9 +1281,9 @@ static struct cpu_spec cpu_specs[] = {
 		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
 		.cpu_features		= CPU_FTRS_E500_2,
 		.cpu_user_features	= COMMON_USER_BOOKE |
-			PPC_FEATURE_SPE_COMP |
-			PPC_FEATURE_HAS_EFP_SINGLE |
-			PPC_FEATURE_HAS_EFP_DOUBLE,
+			PPC_FEATURE_HAS_SPE_COMP |
+			PPC_FEATURE_HAS_EFP_SINGLE_COMP |
+			PPC_FEATURE_HAS_EFP_DOUBLE_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 4074c0b..21d889e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -504,9 +504,11 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
+BEGIN_FTR_SECTION
 	oris	r0,r0,MSR_SPE@h	 /* Disable SPE */
 	mfspr	r12,SPRN_SPEFSCR /* save spefscr register value */
 	stw	r12,THREAD+THREAD_SPEFSCR(r2)
+END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 #endif /* CONFIG_SPE */
 	and.	r0,r0,r11	/* FP or altivec or SPE enabled? */
 	beq+	1f
@@ -542,8 +544,10 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
+BEGIN_FTR_SECTION
 	lwz	r0,THREAD+THREAD_SPEFSCR(r2)
 	mtspr	SPRN_SPEFSCR,r0		/* restore SPEFSCR reg */
+END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 #endif /* CONFIG_SPE */
 
 	lwz	r0,_CCR(r1)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e477c9d..57c589c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -669,9 +669,13 @@ int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
 	 * mode (asyn, precise, disabled) for 'Classic' FP. */
 	if (val & PR_FP_EXC_SW_ENABLE) {
 #ifdef CONFIG_SPE
-		tsk->thread.fpexc_mode = val &
-			(PR_FP_EXC_SW_ENABLE | PR_FP_ALL_EXCEPT);
-		return 0;
+		if (cpu_has_feature(CPU_FTR_SPE)) {
+			tsk->thread.fpexc_mode = val &
+				(PR_FP_EXC_SW_ENABLE | PR_FP_ALL_EXCEPT);
+			return 0;
+		} else {
+			return -EINVAL;
+		}
 #else
 		return -EINVAL;
 #endif
@@ -697,7 +701,10 @@ int get_fpexc_mode(struct task_struct *tsk, unsigned long adr)
 
 	if (tsk->thread.fpexc_mode & PR_FP_EXC_SW_ENABLE)
 #ifdef CONFIG_SPE
-		val = tsk->thread.fpexc_mode;
+		if (cpu_has_feature(CPU_FTR_SPE))
+			val = tsk->thread.fpexc_mode;
+		else
+			return -EINVAL;
 #else
 		return -EINVAL;
 #endif
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8a177bd..fb8866e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -576,8 +576,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 #ifdef CONFIG_SPE
 	case PTRACE_GETEVRREGS:
 		/* Get the child spe register state. */
-		if (child->thread.regs->msr & MSR_SPE)
-			giveup_spe(child);
+		flush_spe_to_thread(child);
 		ret = get_evrregs((unsigned long __user *)data, child);
 		break;
 
@@ -585,8 +584,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		/* Set the child spe register state. */
 		/* this is to clear the MSR_SPE bit to force a reload
 		 * of register state from memory */
-		if (child->thread.regs->msr & MSR_SPE)
-			giveup_spe(child);
+		flush_spe_to_thread(child);
 		ret = set_evrregs(child, (unsigned long __user *)data);
 		break;
 #endif
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 3dc8e2d..f62cffd 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -136,6 +136,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
 #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)
 #define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
+#define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -180,6 +181,21 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define PPC_FEATURE_HAS_ALTIVEC_COMP    0
 #endif
 
+/* We only set the spe features if the kernel was compiled with spe
+ * support
+ */
+#ifdef CONFIG_SPE
+#define CPU_FTR_SPE_COMP	CPU_FTR_SPE
+#define PPC_FEATURE_HAS_SPE_COMP PPC_FEATURE_HAS_SPE
+#define PPC_FEATURE_HAS_EFP_SINGLE_COMP PPC_FEATURE_HAS_EFP_SINGLE
+#define PPC_FEATURE_HAS_EFP_DOUBLE_COMP PPC_FEATURE_HAS_EFP_DOUBLE
+#else
+#define CPU_FTR_SPE_COMP	0
+#define PPC_FEATURE_HAS_SPE_COMP    0
+#define PPC_FEATURE_HAS_EFP_SINGLE_COMP 0
+#define PPC_FEATURE_HAS_EFP_DOUBLE_COMP 0
+#endif
+
 /* We need to mark all pages as being coherent if we're SMP or we
  * have a 74[45]x and an MPC107 host bridge. Also 83xx requires
  * it for PCI "streaming/prefetch" to work properly.
@@ -310,10 +326,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTRS_8XX	(CPU_FTR_USE_TB)
 #define CPU_FTRS_40X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | \
-	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
-#define CPU_FTRS_E500	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_E500_2	(CPU_FTR_USE_TB | \
+#define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
+	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
+	    CPU_FTR_UNIFIED_ID_CACHE)
+#define CPU_FTRS_E500	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
+	    CPU_FTR_NODSISRALIGN)
+#define CPU_FTRS_E500_2	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
-- 
1.5.2.4
