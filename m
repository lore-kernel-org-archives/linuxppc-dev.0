Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc/tm: Abort on emulation and alignment faults
Date: Mon, 27 May 2013 14:09:39 +1000
Message-Id: <1369627781-31088-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1369627781-31088-1-git-send-email-mikey@neuling.org>
References: <1369627781-31088-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
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
Cc: <stable@vger.kernel.org> # v3.9
---
 Documentation/powerpc/transactional_memory.txt |    7 ++++--
 arch/powerpc/include/asm/reg.h                 |    2 ++
 arch/powerpc/kernel/traps.c                    |   29 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index 84e04a0..c54bf31 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -161,9 +161,12 @@ kernel aborted a transaction:
                         transactions for consistency will use this.
  TM_CAUSE_SIGNAL        Signal delivered.
  TM_CAUSE_MISC          Currently unused.
+ TM_CAUSE_ALIGNMENT     Alignment fault.
+ TM_CAUSE_EMULATE       Emulation that touched memory.
 
-These can be checked by the user program's abort handler as TEXASR[0:7].
-
+These can be checked by the user program's abort handler as TEXASR[0:7].  If
+bit 7 is set, it indicates that the error is consider persistent.  For example
+a TM_CAUSE_ALIGNMENT will be persistent while a TM_CAUSE_RESCHED will not.q
 
 GDB
 ===
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 8f6a94b..d0528e0 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -122,6 +122,8 @@
 #define TM_CAUSE_SYSCALL	0xd8  /* future use */
 #define TM_CAUSE_MISC		0xd6  /* future use */
 #define TM_CAUSE_SIGNAL		0xd4
+#define TM_CAUSE_ALIGNMENT	0xd2
+#define TM_CAUSE_EMULATE	0xd0
 
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
-- 
1.7.10.4
