Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B9001DDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 02:00:11 +1000 (EST)
Date: Wed, 11 Jun 2008 10:59:59 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
Subject: Re: [RFC] Kprobes for book-e
In-Reply-To: <CB93E897-6E25-4F80-86D1-00A80B1B1967@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0806111055130.4745@blarg.am.freescale.net>
References: <7B7EF7F090B9804A830ACC82F2CDE95D28F98D@insardxms01.ap.sony.com>
	<CB93E897-6E25-4F80-86D1-00A80B1B1967@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


---

Here's a cleaned up version of my patch incorporating the changes we've
discussed and some minor tweaks to traps.c.  Can you take a look and test
it out.  I'm wondering about having to clear MSR_EE & MSR_CE in
prepare_singlestep().  Doesnt seem like we need to do that at all.

- k

 Documentation/kprobes.txt     |    1 +
 arch/powerpc/kernel/kprobes.c |   23 +++++++++++++++++++----
 arch/powerpc/kernel/misc_32.S |    2 +-
 arch/powerpc/kernel/traps.c   |   32 +++++++++++++++++---------------
 include/asm-powerpc/system.h  |    9 +++++++++
 5 files changed, 47 insertions(+), 20 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 6877e71..a79633d 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -172,6 +172,7 @@ architectures:
 - ia64 (Does not support probes on instruction slot1.)
 - sparc64 (Return probes not yet implemented.)
 - arm
+- ppc

 3. Configuring Kprobes

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 23545a2..0dca55e 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -34,6 +34,13 @@
 #include <asm/cacheflush.h>
 #include <asm/sstep.h>
 #include <asm/uaccess.h>
+#include <asm/system.h>
+
+#ifdef CONFIG_BOOKE
+#define MSR_SINGLESTEP	(MSR_DE)
+#else
+#define MSR_SINGLESTEP	(MSR_SE)
+#endif

 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -53,7 +60,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		ret = -EINVAL;
 	}

-	/* insn must be on a special executable page on ppc64 */
+	/* insn must be on a special executable page on ppc64.  This is
+	 * not explicitly required on ppc32 (right now), but it doesn't hurt */
 	if (!ret) {
 		p->ainsn.insn = get_insn_slot();
 		if (!p->ainsn.insn)
@@ -95,7 +103,14 @@ void __kprobes arch_remove_kprobe(struct kprobe *p)

 static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
+#ifdef CONFIG_BOOKE
+	regs->msr &= ~(MSR_EE); /* Turn off 'Externel Interrupt' bits */
+	regs->msr &= ~(MSR_CE); /* Turn off 'Critical Interrupt' bits */
+	regs->msr |= MSR_DE;
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#else
 	regs->msr |= MSR_SE;
+#endif

 	/*
 	 * On powerpc we should single step on the original
@@ -158,7 +173,7 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			kprobe_opcode_t insn = *p->ainsn.insn;
 			if (kcb->kprobe_status == KPROBE_HIT_SS &&
 					is_trap(insn)) {
-				regs->msr &= ~MSR_SE;
+				regs->msr &= ~MSR_SINGLESTEP; /* Turn off 'trace' bits */
 				regs->msr |= kcb->kprobe_saved_msr;
 				goto no_kprobe;
 			}
@@ -398,7 +413,7 @@ out:
 	 * will have SE set, in which case, continue the remaining processing
 	 * of do_debug, as if this is not a probe hit.
 	 */
-	if (regs->msr & MSR_SE)
+	if (single_stepping(regs))
 		return 0;

 	return 1;
@@ -421,7 +436,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * normal page fault.
 		 */
 		regs->nip = (unsigned long)cur->addr;
-		regs->msr &= ~MSR_SE;
+		regs->msr &= ~MSR_SINGLESTEP; /* Turn off 'trace' bits */
 		regs->msr |= kcb->kprobe_saved_msr;
 		if (kcb->kprobe_status == KPROBE_REENTER)
 			restore_previous_kprobe(kcb);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 89aaaa6..6321ae3 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -489,7 +489,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
  *
  * flush_icache_range(unsigned long start, unsigned long stop)
  */
-_GLOBAL(__flush_icache_range)
+_KPROBE(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4b5b7ff..985bff5 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -316,10 +316,6 @@ static inline int check_io_access(struct pt_regs *regs)
 #define REASON_PRIVILEGED	ESR_PPR
 #define REASON_TRAP		ESR_PTR

-/* single-step stuff */
-#define single_stepping(regs)	(current->thread.dbcr0 & DBCR0_IC)
-#define clear_single_step(regs)	(current->thread.dbcr0 &= ~DBCR0_IC)
-
 #else
 /* On non-4xx, the reason for the machine check or program
    exception is in the MSR. */
@@ -330,8 +326,6 @@ static inline int check_io_access(struct pt_regs *regs)
 #define REASON_PRIVILEGED	0x40000
 #define REASON_TRAP		0x20000

-#define single_stepping(regs)	((regs)->msr & MSR_SE)
-#define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
 #endif

 #if defined(CONFIG_4xx)
@@ -1030,21 +1024,29 @@ void SoftwareEmulation(struct pt_regs *regs)

 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)

-void DebugException(struct pt_regs *regs, unsigned long debug_status)
+void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
 	if (debug_status & DBSR_IC) {	/* instruction completion */
 		regs->msr &= ~MSR_DE;
+
+		/* Disable instruction completion */
+		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
+		/* Clear the instruction completion event */
+		mtspr(SPRN_DBSR, DBSR_IC);
+
+		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
+			       5, SIGTRAP) == NOTIFY_STOP) {
+			return;
+		}
+
+		if (debugger_sstep(regs))
+			return;
+
 		if (user_mode(regs)) {
 			current->thread.dbcr0 &= ~DBCR0_IC;
-		} else {
-			/* Disable instruction completion */
-			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
-			/* Clear the instruction completion event */
-			mtspr(SPRN_DBSR, DBSR_IC);
-			if (debugger_sstep(regs))
-				return;
 		}
-		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
+
+		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
 	}
 }
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index df781ad..2926e29 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -66,6 +66,15 @@
 struct task_struct;
 struct pt_regs;

+/* single-step stuff */
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#define single_stepping(regs)	(current->thread.dbcr0 & DBCR0_IC)
+#define clear_single_step(regs)	(current->thread.dbcr0 &= ~DBCR0_IC)
+#else
+#define single_stepping(regs)	((regs)->msr & MSR_SE)
+#define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
+#endif
+
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)

 extern int (*__debugger)(struct pt_regs *regs);
-- 
1.5.5.1
