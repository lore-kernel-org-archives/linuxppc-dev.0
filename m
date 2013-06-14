Return-Path: <paulus@ozlabs.org>
Date: Fri, 14 Jun 2013 20:07:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix emulation of illegal instructions on PowerNV
 platform
Message-ID: <20130614100741.GA612@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Normally, the kernel emulates a few instructions that are unimplemented
on some processors (e.g. the old dcba instruction), or privileged (e.g.
mfpvr).  The emulation of unimplemented instructions is currently not
working on the PowerNV platform.  The reason is that on these machines,
unimplemented and illegal instructions cause a hypervisor emulation
assist interrupt, rather than a program interrupt as on older CPUs.
Our vector for the emulation assist interrupt just calls
program_check_exception() directly, without setting the bit in SRR1
that indicates an illegal instruction interrupt.  This fixes it by
making the emulation assist interrupt set that bit before calling
program_check_interrupt().  With this, old programs that use no-longer
implemented instructions such as dcba now work again.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 arch/powerpc/kernel/traps.c          |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e783453..40e4a17 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -683,7 +683,7 @@ machine_check_common:
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
 	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
-	STD_EXCEPTION_COMMON(0xe40, emulation_assist, .program_check_exception)
+	STD_EXCEPTION_COMMON(0xe40, emulation_assist, .emulation_assist_interrupt)
 	STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
 #ifdef CONFIG_PPC_DOORBELL
 	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .doorbell_exception)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f18c79c..c0e5caf 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1165,6 +1165,16 @@ bail:
 	exception_exit(prev_state);
 }
 
+/*
+ * This occurs when running in hypervisor mode on POWER6 or later
+ * and an illegal instruction is encountered.
+ */
+void __kprobes emulation_assist_interrupt(struct pt_regs *regs)
+{
+	regs->msr |= REASON_ILLEGAL;
+	program_check_exception(regs);
+}
+
 void alignment_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
-- 
1.7.10.4
