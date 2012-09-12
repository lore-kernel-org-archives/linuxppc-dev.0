Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D8FC52C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 18:42:14 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v4][PATCH 4/4] powerpc/kprobe: don't emulate store when kprobe stwu
 r1
Date: Wed, 12 Sep 2012 16:42:05 +0800
Message-ID: <1347439325-5563-4-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1347439325-5563-1-git-send-email-tiejun.chen@windriver.com>
References: <1347439325-5563-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't do the real store operation for kprobing 'stwu Rx,(y)R1'
since this may corrupt the exception frame, now we will do this
operation safely in exception return code after migrate current
exception frame below the kprobed function stack.

So we only update gpr[1] here and trigger a thread flag to mask
this.

Note we should make sure if we trigger kernel stack over flow.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/lib/sstep.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 9a52349..e15c521 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -566,7 +566,7 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 	unsigned long int ea;
 	unsigned int cr, mb, me, sh;
 	int err;
-	unsigned long old_ra;
+	unsigned long old_ra, val3;
 	long ival;
 
 	opcode = instr >> 26;
@@ -1486,11 +1486,43 @@ int __kprobes emulate_step(struct pt_regs *regs, unsigned int instr)
 		goto ldst_done;
 
 	case 36:	/* stw */
-	case 37:	/* stwu */
 		val = regs->gpr[rd];
 		err = write_mem(val, dform_ea(instr, regs), 4, regs);
 		goto ldst_done;
 
+	case 37:	/* stwu */
+		val = regs->gpr[rd];
+		val3 = dform_ea(instr, regs);
+		/*
+		 * For PPC32 we always use stwu to change stack point with r1. So
+		 * this emulated store may corrupt the exception frame, now we
+		 * have to provide the exception frame trampoline, which is pushed
+		 * below the kprobed function stack. So we only update gpr[1] but
+		 * don't emulate the real store operation. We will do real store
+		 * operation safely in exception return code by checking this flag.
+		 */
+		if ((ra == 1) && !(regs->msr & MSR_PR) \
+			&& (val3 >= (regs->gpr[1] - STACK_INT_FRAME_SIZE))) {
+			/*
+			 * Check if we will touch kernel sack overflow
+			 */
+			if (val3 - STACK_INT_FRAME_SIZE <= current->thread.ksp_limit) {
+				printk(KERN_CRIT "Can't kprobe this since Kernel stack overflow.\n");
+				err = -EINVAL;
+				break;
+			}
+
+			/*
+			 * Check if we already set since that means we'll
+			 * lose the previous value.
+			 */
+			WARN_ON(test_thread_flag(TIF_EMULATE_STACK_STORE));
+			set_thread_flag(TIF_EMULATE_STACK_STORE);
+			err = 0;
+		} else
+			err = write_mem(val, val3, 4, regs);
+		goto ldst_done;
+
 	case 38:	/* stb */
 	case 39:	/* stbu */
 		val = regs->gpr[rd];
-- 
1.7.9.5
