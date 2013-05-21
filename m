Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: [PATCH v2] powerpc/tm: Abort transactions on emulation and alignment
 faults
In-reply-to: <23571.1369048074@ale.ozlabs.ibm.com>
References: <23571.1369048074@ale.ozlabs.ibm.com>
Date: Tue, 21 May 2013 11:48:05 +1000
Message-ID: <5404.1369100885@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we are emulating an instruction inside an active user transaction that
touches memory, the kernel can't emulate it as it operates in transactional
suspend context.  We need to abort these transactions and send them back to
userspace for the hardware to rollback.

We can service these if the user transaction is in suspend mode, since the
kernel will operate in the same suspend context.

This adds a check to all alignment faults and to specific instruction
emulations (only string instructions for now).  If the user process is in an
active (non-suspended) transaction, we abort the transaction go back to
userspace allowing the HW to roll back the transaction and tell the user of the
failure.  This also adds new tm abort cause codes to report the reason of the
persistent error to the user.

Crappy test case here http://neuling.org/devel/junkcode/aligntm.c

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> # v3.9 only
---
v2:
  Split persistent bit of cause into separate bit
  Mark alignment and emulation as persistent.
  syscall cause it not used currently. 

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a613651..20be907 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -115,12 +115,15 @@
    convention, bit0 is copied to TEXASR[56] (IBM bit 7) which is set if
    the failure is persistent.
 */
+#define TM_CAUSE_PERSISTENT	0x01
 #define TM_CAUSE_RESCHED	0xfe
 #define TM_CAUSE_TLBI		0xfc
 #define TM_CAUSE_FAC_UNAV	0xfa
-#define TM_CAUSE_SYSCALL	0xf9 /* Persistent */
+#define TM_CAUSE_SYSCALL	0xf8
 #define TM_CAUSE_MISC		0xf6
 #define TM_CAUSE_SIGNAL		0xf4
+#define TM_CAUSE_ALIGNMENT	0xf2
+#define TM_CAUSE_EMULATE	0xf0
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define MSR_64BIT	MSR_SF
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a7a648f..f18c79c 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -53,6 +53,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
 #include <asm/processor.h>
+#include <asm/tm.h>
 #endif
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
@@ -932,6 +933,28 @@ static int emulate_isel(struct pt_regs *regs, u32 instword)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static inline bool tm_abort_check(struct pt_regs *regs, int cause)
+{
+        /* If we're emulating a load/store in an active transaction, we cannot
+         * emulate it as the kernel operates in transaction suspended context.
+         * We need to abort the transaction.  This creates a persistent TM
+         * abort so tell the user what caused it with a new code.
+	 */
+	if (MSR_TM_TRANSACTIONAL(regs->msr)) {
+		tm_enable();
+		tm_abort(cause);
+		return true;
+	}
+	return false;
+}
+#else
+static inline bool tm_abort_check(struct pt_regs *regs, int reason)
+{
+	return false;
+}
+#endif
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -971,6 +994,9 @@ static int emulate_instruction(struct pt_regs *regs)
 
 	/* Emulate load/store string insn. */
 	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING) {
+		if (tm_abort_check(regs,
+				   TM_CAUSE_EMULATE | TM_CAUSE_PERSISTENT))
+			return -EINVAL;
 		PPC_WARN_EMULATED(string, regs);
 		return emulate_string_inst(regs, instword);
 	}
@@ -1148,6 +1174,9 @@ void alignment_exception(struct pt_regs *regs)
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
+	if (tm_abort_check(regs, TM_CAUSE_ALIGNMENT | TM_CAUSE_PERSISTENT))
+		goto bail;
+
 	/* we don't implement logging of alignment exceptions */
 	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
 		fixed = fix_alignment(regs);
