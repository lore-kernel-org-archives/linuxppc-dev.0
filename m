Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58B5F1A0985
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2014 15:47:17 +1100 (AEDT)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Fix compilation of emulate_step()
Date: Mon,  3 Nov 2014 15:46:43 +1100
Message-Id: <1414990003-6104-2-git-send-email-paulus@samba.org>
In-Reply-To: <1414990003-6104-1-git-send-email-paulus@samba.org>
References: <1414990003-6104-1-git-send-email-paulus@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit be96f63375a1 ("powerpc: Split out instruction analysis
part of emulate_step()") added some calls to do_fp_load()
and do_fp_store(), which fail to compile on configs with
CONFIG_PPC_FPU=n and CONFIG_PPC_EMULATE_SSTEP=y.  This fixes
the compile by adding #ifdef CONFIG_PPC_FPU around the code
that calls these functions.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/lib/sstep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 54651fc..dc885b3 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1865,6 +1865,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		}
 		goto ldst_done;
 
+#ifdef CONFIG_PPC_FPU
 	case LOAD_FP:
 		if (regs->msr & MSR_LE)
 			return 0;
@@ -1873,7 +1874,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		else
 			err = do_fp_load(op.reg, do_lfd, op.ea, size, regs);
 		goto ldst_done;
-
+#endif
 #ifdef CONFIG_ALTIVEC
 	case LOAD_VMX:
 		if (regs->msr & MSR_LE)
@@ -1919,6 +1920,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		err = write_mem(op.val, op.ea, size, regs);
 		goto ldst_done;
 
+#ifdef CONFIG_PPC_FPU
 	case STORE_FP:
 		if (regs->msr & MSR_LE)
 			return 0;
@@ -1927,7 +1929,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		else
 			err = do_fp_store(op.reg, do_stfd, op.ea, size, regs);
 		goto ldst_done;
-
+#endif
 #ifdef CONFIG_ALTIVEC
 	case STORE_VMX:
 		if (regs->msr & MSR_LE)
-- 
2.1.1
