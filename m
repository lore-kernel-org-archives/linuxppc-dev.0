Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 882E42C0361
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 21:36:08 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 2/2] powerpc/math-emu: remove the unneeded check for
 CONFIG_MATH_EMULATION in math.c
Date: Wed, 10 Jul 2013 19:34:57 +0800
Message-ID: <1373456097-31349-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373456097-31349-1-git-send-email-haokexin@gmail.com>
References: <1373456097-31349-1-git-send-email-haokexin@gmail.com>
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
So the #ifdef check for CONFIG_MATH_EMULATION in it seems redundant.
Drop all of them.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 arch/powerpc/math-emu/math.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index cefb4f2..3fe8e35 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -154,7 +154,6 @@ FLOATFUNC(fsqrts);
 #define XEU	15
 #define XFLB	10
 
-#ifdef CONFIG_MATH_EMULATION
 static int
 record_exception(struct pt_regs *regs, int eflag)
 {
@@ -212,7 +211,6 @@ record_exception(struct pt_regs *regs, int eflag)
 
 	return (fpscr & FPSCR_FEX) ? 1 : 0;
 }
-#endif /* CONFIG_MATH_EMULATION */
 
 int
 do_mathemu(struct pt_regs *regs)
@@ -222,11 +220,9 @@ do_mathemu(struct pt_regs *regs)
 	signed short sdisp;
 	u32 insn = 0;
 	int idx = 0;
-#ifdef CONFIG_MATH_EMULATION
 	int (*func)(void *, void *, void *, void *);
 	int type = 0;
 	int eflag, trap;
-#endif
 
 	if (get_user(insn, (u32 *)pc))
 		return -EFAULT;
-- 
1.8.1.4
