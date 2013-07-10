Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5AE02C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 11:44:21 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/math-emu: remove the dead code in math.c
Date: Wed, 10 Jul 2013 09:43:42 +0800
Message-ID: <1373420623-24869-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373420623-24869-1-git-send-email-haokexin@gmail.com>
References: <1373420623-24869-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The math.c is only built when CONFIG_MATH_EMULATION is enabled.
So we would never get into the case that CONFIG_MATH_EMULATION
is not defined in this file.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/math-emu/math.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 0328e66..cefb4f2 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -231,47 +231,6 @@ do_mathemu(struct pt_regs *regs)
 	if (get_user(insn, (u32 *)pc))
 		return -EFAULT;
 
-#ifndef CONFIG_MATH_EMULATION
-	switch (insn >> 26) {
-	case LFD:
-		idx = (insn >> 16) & 0x1f;
-		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
-		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
-		lfd(op0, op1, op2, op3);
-		break;
-	case LFDU:
-		idx = (insn >> 16) & 0x1f;
-		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
-		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
-		lfd(op0, op1, op2, op3);
-		regs->gpr[idx] = (unsigned long)op1;
-		break;
-	case STFD:
-		idx = (insn >> 16) & 0x1f;
-		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
-		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
-		stfd(op0, op1, op2, op3);
-		break;
-	case STFDU:
-		idx = (insn >> 16) & 0x1f;
-		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
-		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
-		stfd(op0, op1, op2, op3);
-		regs->gpr[idx] = (unsigned long)op1;
-		break;
-	case OP63:
-		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
-		op1 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
-		fmr(op0, op1, op2, op3);
-		break;
-	default:
-		goto illegal;
-	}
-#else /* CONFIG_MATH_EMULATION */
 	switch (insn >> 26) {
 	case LFS:	func = lfs;	type = D;	break;
 	case LFSU:	func = lfs;	type = DU;	break;
@@ -485,7 +444,6 @@ do_mathemu(struct pt_regs *regs)
 	default:
 		break;
 	}
-#endif /* CONFIG_MATH_EMULATION */
 
 	regs->nip += 4;
 	return 0;
-- 
1.8.1.4
