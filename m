Return-Path: <B13201@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD3DDB6F6F
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Sep 2011 20:05:41 +1000 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 2/3] math_emu/efp: No need to round if the result is exact
Date: Mon, 5 Sep 2011 17:01:22 +0800
Message-ID: <1315213283-3800-3-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1315213283-3800-2-git-send-email-yu.liu@freescale.com>
References: <1315213283-3800-1-git-send-email-yu.liu@freescale.com>
	<1315213283-3800-2-git-send-email-yu.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Liu Yu <yu.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/math-emu/math_efp.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 10fda0f..96dbbae 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -676,13 +676,20 @@ int speround_handler(struct pt_regs *regs)
 	type = insn_type(speinsn & 0x7ff);
 	if (type == XCR) return -ENOSYS;
 
+	__FPU_FPSCR = mfspr(SPRN_SPEFSCR);
+	pr_debug("speinsn:%08lx spefscr:%08lx\n", speinsn, __FPU_FPSCR);
+
+	/* No need to round if the result is exact */
+	if (!(__FPU_FPSCR & FP_EX_INEXACT))
+		return 0;
+
 	fc = (speinsn >> 21) & 0x1f;
 	s_lo = regs->gpr[fc] & SIGN_BIT_S;
 	s_hi = current->thread.evr[fc] & SIGN_BIT_S;
 	fgpr.wp[0] = current->thread.evr[fc];
 	fgpr.wp[1] = regs->gpr[fc];
 
-	__FPU_FPSCR = mfspr(SPRN_SPEFSCR);
+	pr_debug("round fgpr: %08x  %08x\n", fgpr.wp[0], fgpr.wp[1]);
 
 	switch ((speinsn >> 5) & 0x7) {
 	/* Since SPE instructions on E500 core can handle round to nearest
@@ -722,6 +729,8 @@ int speround_handler(struct pt_regs *regs)
 	current->thread.evr[fc] = fgpr.wp[0];
 	regs->gpr[fc] = fgpr.wp[1];
 
+	pr_debug("  to fgpr: %08x  %08x\n", fgpr.wp[0], fgpr.wp[1]);
+
 	return 0;
 }
 
-- 
1.6.4
