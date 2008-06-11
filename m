Return-Path: <madhvesh.s@ap.sony.com>
Received: from mail36-sin-R.bigfish.com (mail-sin.bigfish.com [207.46.51.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 288A5DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 00:44:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Kprobes for book-e
Date: Wed, 11 Jun 2008 19:48:42 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D28F98D@insardxms01.ap.sony.com>
From: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, rsmadhvesh@vsnl.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

I could switch to different version of binutils and
boot the recent git for ebony target. The kprobes
booke patches attached below got applied and
i didnot see any issues.  These patches can be=20
now pushed to main line?

Below is the revised patch set after addressing some=20
cleanups in traps.c and bug fixes to kprobes.c discussed=20
earlier. Also added the support to Documentation/kprobes.txt=20
and KRETPROBES check in powerpc/Kconfig file.

-Madhvesh

---------------------------------------------------------------------
arch/powerpc/kernel/kprobes.c |   35 +++++++++++++++++++++++++++++++----
 arch/powerpc/kernel/misc_32.S |    2 +-
 arch/powerpc/kernel/traps.c   |   26 +++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 6 deletions(-)

Index: b/arch/powerpc/kernel/kprobes.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -35,6 +35,21 @@
 #include <asm/sstep.h>
 #include <asm/uaccess.h>
=20
+
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#define single_stepping(regs)	(current->thread.dbcr0 & DBCR0_IC)
+#define clear_single_step(regs)	(current->thread.dbcr0 &=3D
~DBCR0_IC)
+#else
+#define single_stepping(regs)	((regs)->msr & MSR_SE)
+#define clear_single_step(regs)	((regs)->msr &=3D ~MSR_SE)
+#endif
+
+#ifdef CONFIG_BOOKE
+#define MSR_SINGLESTEP	(MSR_DE)
+#else
+#define MSR_SINGLESTEP	(MSR_SE)
+#endif
+
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) =3D NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
=20
@@ -53,7 +68,8 @@ int __kprobes arch_prepare_kprobe(struct
 		ret =3D -EINVAL;
 	}
=20
-	/* insn must be on a special executable page on ppc64 */
+	/* insn must be on a special executable page on ppc64.  This is
+	 * explicitly not required on ppc32 (right now), but it doesn't
hurt */
 	if (!ret) {
 		p->ainsn.insn =3D get_insn_slot();
 		if (!p->ainsn.insn)
@@ -95,7 +111,14 @@ void __kprobes arch_remove_kprobe(struct
=20
 static void __kprobes prepare_singlestep(struct kprobe *p, struct
pt_regs *regs)
 {
+#ifdef CONFIG_BOOKE
+	regs->msr &=3D ~(MSR_EE); /* Turn off 'Externel Interrupt' bits */
+	regs->msr &=3D ~(MSR_CE); /* Turn off 'Critical Interrupt' bits */
+	regs->msr |=3D MSR_DE;
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#else
 	regs->msr |=3D MSR_SE;
+#endif
=20
 	/*
 	 * On powerpc we should single step on the original
@@ -158,7 +181,7 @@ static int __kprobes kprobe_handler(stru
 			kprobe_opcode_t insn =3D *p->ainsn.insn;
 			if (kcb->kprobe_status =3D=3D KPROBE_HIT_SS &&
 					is_trap(insn)) {
-				regs->msr &=3D ~MSR_SE;
+				regs->msr &=3D ~MSR_SINGLESTEP; /* Turn
off 'trace' bits */
 				regs->msr |=3D kcb->kprobe_saved_msr;
 				goto no_kprobe;
 			}
@@ -398,7 +421,7 @@ out:
 	 * will have SE set, in which case, continue the remaining
processing
 	 * of do_debug, as if this is not a probe hit.
 	 */
-	if (regs->msr & MSR_SE)
+	if (single_stepping(regs))
 		return 0;
=20
 	return 1;
@@ -421,7 +444,7 @@ int __kprobes kprobe_fault_handler(struc
 		 * normal page fault.
 		 */
 		regs->nip =3D (unsigned long)cur->addr;
-		regs->msr &=3D ~MSR_SE;
+		regs->msr &=3D ~MSR_SINGLESTEP; /* Turn off 'trace' bits
*/
 		regs->msr |=3D kcb->kprobe_saved_msr;
 		if (kcb->kprobe_status =3D=3D KPROBE_REENTER)
 			restore_previous_kprobe(kcb);
Index: b/arch/powerpc/kernel/misc_32.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -489,7 +489,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID
  *
  * flush_icache_range(unsigned long start, unsigned long stop)
  */
-_GLOBAL(__flush_icache_range)
+_KPROBE(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
Index: b/arch/powerpc/kernel/traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1030,7 +1030,7 @@ void SoftwareEmulation(struct pt_regs *r
=20
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
=20
-void DebugException(struct pt_regs *regs, unsigned long debug_status)
+void __kprobes DebugException(struct pt_regs *regs, unsigned long
debug_status)
 {
 	if (debug_status & DBSR_IC) {	/* instruction completion */
 		regs->msr &=3D ~MSR_DE;
@@ -1041,6 +1041,12 @@ void DebugException(struct pt_regs *regs
 			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) &
~DBCR0_IC);
 			/* Clear the instruction completion event */
 			mtspr(SPRN_DBSR, DBSR_IC);
+#ifdef CONFIG_KPROBES
+			if (notify_die(DIE_SSTEP, "single_step", regs,
5,
+			       5, SIGTRAP) =3D=3D NOTIFY_STOP) {
+				return;
+			}
+#endif
 			if (debugger_sstep(regs))
 				return;
 		}
Index: b/Documentation/kprobes.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -172,6 +172,7 @@ architectures:
 - ia64 (Does not support probes on instruction slot1.)
 - sparc64 (Return probes not yet implemented.)
 - arm
+- ppc32
=20
 3. Configuring Kprobes
=20
Index: b/arch/powerpc/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -108,7 +108,7 @@ config PPC
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
-	select HAVE_KRETPROBES
+	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_LMB
=20
 config EARLY_PRINTK


-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
