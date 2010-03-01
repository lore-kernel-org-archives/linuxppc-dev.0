Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/booke: Fix breakpoint/watchpoint one-shot behavior
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
In-Reply-To: <1266954197.11207.20.camel@norville.austin.ibm.com>
References: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
	<1266954197.11207.20.camel@norville.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 01 Mar 2010 08:57:34 -0600
Message-Id: <1267455454.15030.9.camel@norville.austin.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Another fix for the extended ptrace patches in the -next tree.

The handling of breakpoints and watchpoints is inconsistent.  When a
breakpoint or watchpoint is hit, the interrupt handler is clearing the
proper bits in the dbcr* registers, but leaving the dac* and iac* registers
alone.  The ptrace code to delete the break/watchpoints checks the dac* and
iac* registers for zero to determine if they are enabled.  Instead, they
should check the dbcr* bits.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/ptrace.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)


diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 0efa2e3..ed2cfe1 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -940,7 +940,7 @@ static int del_instruction_bp(struct task_struct *child, int slot)
 {
 	switch (slot) {
 	case 1:
-		if (child->thread.iac1 == 0)
+		if ((child->thread.dbcr0 & DBCR0_IAC1) == 0)
 			return -ENOENT;
 
 		if (dbcr_iac_range(child) & DBCR_IAC12MODE) {
@@ -952,7 +952,7 @@ static int del_instruction_bp(struct task_struct *child, int slot)
 		child->thread.dbcr0 &= ~DBCR0_IAC1;
 		break;
 	case 2:
-		if (child->thread.iac2 == 0)
+		if ((child->thread.dbcr0 & DBCR0_IAC2) == 0)
 			return -ENOENT;
 
 		if (dbcr_iac_range(child) & DBCR_IAC12MODE)
@@ -963,7 +963,7 @@ static int del_instruction_bp(struct task_struct *child, int slot)
 		break;
 #if CONFIG_PPC_ADV_DEBUG_IACS > 2
 	case 3:
-		if (child->thread.iac3 == 0)
+		if ((child->thread.dbcr0 & DBCR0_IAC3) == 0)
 			return -ENOENT;
 
 		if (dbcr_iac_range(child) & DBCR_IAC34MODE) {
@@ -975,7 +975,7 @@ static int del_instruction_bp(struct task_struct *child, int slot)
 		child->thread.dbcr0 &= ~DBCR0_IAC3;
 		break;
 	case 4:
-		if (child->thread.iac4 == 0)
+		if ((child->thread.dbcr0 & DBCR0_IAC4) == 0)
 			return -ENOENT;
 
 		if (dbcr_iac_range(child) & DBCR_IAC34MODE)
@@ -1054,7 +1054,7 @@ static int set_dac(struct task_struct *child, struct ppc_hw_breakpoint *bp_info)
 static int del_dac(struct task_struct *child, int slot)
 {
 	if (slot == 1) {
-		if (child->thread.dac1 == 0)
+		if ((dbcr_dac(child) & (DBCR_DAC1R | DBCR_DAC1W)) == 0)
 			return -ENOENT;
 
 		child->thread.dac1 = 0;
@@ -1070,7 +1070,7 @@ static int del_dac(struct task_struct *child, int slot)
 		child->thread.dvc1 = 0;
 #endif
 	} else if (slot == 2) {
-		if (child->thread.dac2 == 0)
+		if ((dbcr_dac(child) & (DBCR_DAC2R | DBCR_DAC2W)) == 0)
 			return -ENOENT;
 
 #ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
