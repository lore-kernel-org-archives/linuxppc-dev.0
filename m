Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhsYJ22PXzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 14:12:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xhsYH6Ssqz9sP5
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2017 14:12:51 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 11/17] powerpc: Emulate vector element load/store
 instructions
Date: Wed, 30 Aug 2017 14:12:34 +1000
Message-Id: <1504066360-30128-12-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
References: <1504066360-30128-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds code to analyse_instr() and emulate_step() to handle the
vector element loads and stores:

lvebx, lvehx, lvewx, stvebx, stvehx, stvewx.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/sstep.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 91ae031..167d40d 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -476,7 +476,7 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 		return -EFAULT;
 	/* align to multiple of size */
 	ea &= ~(size - 1);
-	err = copy_mem_in(u.b, ea, size);
+	err = copy_mem_in(&u.b[ea & 0xf], ea, size);
 	if (err)
 		return err;
 
@@ -508,7 +508,7 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 	else
 		u.v = current->thread.vr_state.vr[rn];
 	preempt_enable();
-	return copy_mem_out(u.b, ea, size);
+	return copy_mem_out(&u.b[ea & 0xf], ea, size);
 }
 #endif /* CONFIG_ALTIVEC */
 
@@ -1807,12 +1807,46 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			break;
 
 #ifdef CONFIG_ALTIVEC
+		/*
+		 * Note: for the load/store vector element instructions,
+		 * bits of the EA say which field of the VMX register to use.
+		 */
+		case 7:		/* lvebx */
+			op->type = MKOP(LOAD_VMX, 0, 1);
+			op->element_size = 1;
+			break;
+
+		case 39:	/* lvehx */
+			op->type = MKOP(LOAD_VMX, 0, 2);
+			op->element_size = 2;
+			break;
+
+		case 71:	/* lvewx */
+			op->type = MKOP(LOAD_VMX, 0, 4);
+			op->element_size = 4;
+			break;
+
 		case 103:	/* lvx */
 		case 359:	/* lvxl */
 			op->type = MKOP(LOAD_VMX, 0, 16);
 			op->element_size = 16;
 			break;
 
+		case 135:	/* stvebx */
+			op->type = MKOP(STORE_VMX, 0, 1);
+			op->element_size = 1;
+			break;
+
+		case 167:	/* stvehx */
+			op->type = MKOP(STORE_VMX, 0, 2);
+			op->element_size = 2;
+			break;
+
+		case 199:	/* stvewx */
+			op->type = MKOP(STORE_VMX, 0, 4);
+			op->element_size = 4;
+			break;
+
 		case 231:	/* stvx */
 		case 487:	/* stvxl */
 			op->type = MKOP(STORE_VMX, 0, 16);
-- 
2.7.4
