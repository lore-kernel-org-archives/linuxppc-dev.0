Return-Path: <anton@samba.org>
Date: Thu, 2 May 2013 16:06:33 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Emulate non privileged DSCR read and write
Message-ID: <20130502160633.624fc890@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


POWER8 allows read and write of the DSCR in userspace. We added
kernel emulation so applications could always use the instructions
regardless of the CPU type. 

Unfortunately there are two SPRs for the DSCR and we only added
emulation for the privileged one. Add code to match the non
privileged one.

A simple test was created to verify the fix:

http://ozlabs.org/~anton/junkcode/user_dscr_test.c

Without the patch we get a SIGILL and it passes with the patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: b/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -115,6 +115,10 @@
 #define PPC_INST_MFSPR_DSCR_MASK	0xfc1fffff
 #define PPC_INST_MTSPR_DSCR		0x7c1103a6
 #define PPC_INST_MTSPR_DSCR_MASK	0xfc1fffff
+#define PPC_INST_MFSPR_DSCR_USER	0x7c0302a6
+#define PPC_INST_MFSPR_DSCR_USER_MASK	0xfc1fffff
+#define PPC_INST_MTSPR_DSCR_USER	0x7c0303a6
+#define PPC_INST_MTSPR_DSCR_USER_MASK	0xfc1fffff
 #define PPC_INST_SLBFEE			0x7c0007a7
 
 #define PPC_INST_STRING			0x7c00042a
Index: b/arch/powerpc/kernel/traps.c
===================================================================
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -970,7 +970,10 @@ static int emulate_instruction(struct pt
 
 #ifdef CONFIG_PPC64
 	/* Emulate the mfspr rD, DSCR. */
-	if (((instword & PPC_INST_MFSPR_DSCR_MASK) == PPC_INST_MFSPR_DSCR) &&
+	if ((((instword & PPC_INST_MFSPR_DSCR_USER_MASK) ==
+		PPC_INST_MFSPR_DSCR_USER) ||
+	     ((instword & PPC_INST_MFSPR_DSCR_MASK) ==
+		PPC_INST_MFSPR_DSCR)) &&
 			cpu_has_feature(CPU_FTR_DSCR)) {
 		PPC_WARN_EMULATED(mfdscr, regs);
 		rd = (instword >> 21) & 0x1f;
@@ -978,7 +981,10 @@ static int emulate_instruction(struct pt
 		return 0;
 	}
 	/* Emulate the mtspr DSCR, rD. */
-	if (((instword & PPC_INST_MTSPR_DSCR_MASK) == PPC_INST_MTSPR_DSCR) &&
+	if ((((instword & PPC_INST_MTSPR_DSCR_USER_MASK) ==
+		PPC_INST_MTSPR_DSCR_USER) ||
+	     ((instword & PPC_INST_MTSPR_DSCR_MASK) ==
+		PPC_INST_MTSPR_DSCR)) &&
 			cpu_has_feature(CPU_FTR_DSCR)) {
 		PPC_WARN_EMULATED(mtdscr, regs);
 		rd = (instword >> 21) & 0x1f;
