Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdrDW3MvczDrS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 16:02:51 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3xdrDW1w42z9sRY
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2017 16:02:51 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 07/10] powerpc: Handle vector element load/stores in
 emulation code
Date: Fri, 25 Aug 2017 15:41:59 +1000
Message-Id: <1503639722-19121-8-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
References: <1503639722-19121-1-git-send-email-paulus@ozlabs.org>
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
 arch/powerpc/lib/sstep.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 0b295fb..82b1e69 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -475,7 +475,7 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 		return -EFAULT;
 	/* align to multiple of size */
 	ea &= ~(size - 1);
-	err = copy_mem_in(u.b, ea, size);
+	err = copy_mem_in(&u.b[ea & 0xf], ea, size);
 	if (err)
 		return err;
 
@@ -507,7 +507,7 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 	else
 		u.v = current->thread.vr_state.vr[rn];
 	preempt_enable();
-	return copy_mem_out(u.b, ea, size);
+	return copy_mem_out(&u.b[ea & 0xf], ea, size);
 }
 #endif /* CONFIG_ALTIVEC */
 
@@ -1808,6 +1808,31 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			break;
 
 #ifdef CONFIG_ALTIVEC
+		/*
+		 * Note: for the load/store vector element instructions,
+		 * bits of the EA say which field of the VMX register to use.
+		 */
+		case 7:		/* lvebx */
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->type = MKOP(LOAD_VMX, 0, 1);
+			op->element_size = 1;
+			break;
+
+		case 39:	/* lvehx */
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->type = MKOP(LOAD_VMX, 0, 2);
+			op->element_size = 2;
+			break;
+
+		case 71:	/* lvewx */
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->type = MKOP(LOAD_VMX, 0, 4);
+			op->element_size = 4;
+			break;
+
 		case 103:	/* lvx */
 		case 359:	/* lvxl */
 			if (!(regs->msr & MSR_VEC))
@@ -1816,6 +1841,27 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->element_size = 16;
 			break;
 
+		case 135:	/* stvebx */
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->type = MKOP(STORE_VMX, 0, 1);
+			op->element_size = 1;
+			break;
+
+		case 167:	/* stvehx */
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->type = MKOP(STORE_VMX, 0, 2);
+			op->element_size = 2;
+			break;
+
+		case 199:	/* stvewx */
+			if (!(regs->msr & MSR_VEC))
+				goto vecunavail;
+			op->type = MKOP(STORE_VMX, 0, 4);
+			op->element_size = 4;
+			break;
+
 		case 231:	/* stvx */
 		case 487:	/* stvxl */
 			if (!(regs->msr & MSR_VEC))
-- 
2.7.4
