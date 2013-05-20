Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/tm: Abort transactions on emulation and alignment
 faults
Date: Mon, 20 May 2013 21:07:54 +1000
Message-ID: <23571.1369048074@ale.ozlabs.ibm.com>
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

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a613651..2f20a40 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -121,6 +121,8 @@
 #define TM_CAUSE_SYSCALL	0xf9 /* Persistent */
 #define TM_CAUSE_MISC		0xf6
 #define TM_CAUSE_SIGNAL		0xf4
+#define TM_CAUSE_ALIGNMENT	0xf2
+#define TM_CAUSE_EMULATE	0xf0
 
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define MSR_64BIT	MSR_SF
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a7a648f..245c1e1 100644
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
@@ -971,6 +994,8 @@ static int emulate_instruction(struct pt_regs *regs)
 
 	/* Emulate load/store string insn. */
 	if ((instword & PPC_INST_STRING_GEN_MASK) == PPC_INST_STRING) {
+		if (tm_abort_check(regs, TM_CAUSE_EMULATE))
+			return -EINVAL;
 		PPC_WARN_EMULATED(string, regs);
 		return emulate_string_inst(regs, instword);
 	}
@@ -1147,7 +1172,10 @@ void alignment_exception(struct pt_regs *regs)
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
-
+	
+	if (tm_abort_check(regs, TM_CAUSE_ALIGNMENT))
+		goto bail;
+		
 	/* we don't implement logging of alignment exceptions */
 	if (!(current->thread.align_ctl & PR_UNALIGN_SIGBUS))
 		fixed = fix_alignment(regs);
