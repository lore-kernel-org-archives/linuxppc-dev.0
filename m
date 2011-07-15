Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: add CFAR to oops output
Date: Fri, 15 Jul 2011 15:25:12 +1000
Message-ID: <4843.1310707512@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we have the CFAR saved add it to the oops output.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 91e52df..b14ab9e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -650,6 +650,8 @@ void show_regs(struct pt_regs * regs)
 	printbits(regs->msr, msr_bits);
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
+	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
+		printk("CFAR: "REG"\n", regs->orig_gpr3);
 	if (trap == 0x300 || trap == 0x600)
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 		printk("DEAR: "REG", ESR: "REG"\n", regs->dar, regs->dsisr);
