Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix single step emulation of 32bit overflowed
 branches
Date: Mon, 06 May 2013 21:32:40 +1000
Message-ID: <25892.1367839960@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check truncate_if_32bit() on final write to nip.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index e15c521..99c7fc1 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -580,7 +580,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		if (instr & 1)
 			regs->link = regs->nip;
 		if (branch_taken(instr, regs))
-			regs->nip = imm;
+			regs->nip = truncate_if_32bit(regs->msr, imm);
 		return 1;
 #ifdef CONFIG_PPC64
 	case 17:	/* sc */
