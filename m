Return-Path: <B13201@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D696B6F6F
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Sep 2011 20:05:40 +1000 (EST)
From: Liu Yu <yu.liu@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/3] math_emu/efp: Code cleanup
Date: Mon, 5 Sep 2011 17:01:21 +0800
Message-ID: <1315213283-3800-2-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1315213283-3800-1-git-send-email-yu.liu@freescale.com>
References: <1315213283-3800-1-git-send-email-yu.liu@freescale.com>
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

Use pr_debug instead of printk

Signed-off-by: Liu Yu <yu.liu@freescale.com>
---
 arch/powerpc/math-emu/math_efp.c |   83 +++++++++++++++++---------------------
 1 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 6227920..10fda0f 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -212,12 +212,10 @@ int do_spe_mathemu(struct pt_regs *regs)
 
 	__FPU_FPSCR = mfspr(SPRN_SPEFSCR);
 
-#ifdef DEBUG
-	printk("speinsn:%08lx spefscr:%08lx\n", speinsn, __FPU_FPSCR);
-	printk("vc: %08x  %08x\n", vc.wp[0], vc.wp[1]);
-	printk("va: %08x  %08x\n", va.wp[0], va.wp[1]);
-	printk("vb: %08x  %08x\n", vb.wp[0], vb.wp[1]);
-#endif
+	pr_debug("speinsn:%08lx spefscr:%08lx\n", speinsn, __FPU_FPSCR);
+	pr_debug("vc: %08x  %08x\n", vc.wp[0], vc.wp[1]);
+	pr_debug("va: %08x  %08x\n", va.wp[0], va.wp[1]);
+	pr_debug("vb: %08x  %08x\n", vb.wp[0], vb.wp[1]);
 
 	switch (src) {
 	case SPFP: {
@@ -235,10 +233,8 @@ int do_spe_mathemu(struct pt_regs *regs)
 			break;
 		}
 
-#ifdef DEBUG
-		printk("SA: %ld %08lx %ld (%ld)\n", SA_s, SA_f, SA_e, SA_c);
-		printk("SB: %ld %08lx %ld (%ld)\n", SB_s, SB_f, SB_e, SB_c);
-#endif
+		pr_debug("SA: %ld %08lx %ld (%ld)\n", SA_s, SA_f, SA_e, SA_c);
+		pr_debug("SB: %ld %08lx %ld (%ld)\n", SB_s, SB_f, SB_e, SB_c);
 
 		switch (func) {
 		case EFSABS:
@@ -305,10 +301,10 @@ int do_spe_mathemu(struct pt_regs *regs)
 			FP_DECL_D(DB);
 			FP_CLEAR_EXCEPTIONS;
 			FP_UNPACK_DP(DB, vb.dp);
-#ifdef DEBUG
-			printk("DB: %ld %08lx %08lx %ld (%ld)\n",
+
+			pr_debug("DB: %ld %08lx %08lx %ld (%ld)\n",
 					DB_s, DB_f1, DB_f0, DB_e, DB_c);
-#endif
+
 			FP_CONV(S, D, 1, 2, SR, DB);
 			goto pack_s;
 		}
@@ -332,9 +328,8 @@ int do_spe_mathemu(struct pt_regs *regs)
 		break;
 
 pack_s:
-#ifdef DEBUG
-		printk("SR: %ld %08lx %ld (%ld)\n", SR_s, SR_f, SR_e, SR_c);
-#endif
+		pr_debug("SR: %ld %08lx %ld (%ld)\n", SR_s, SR_f, SR_e, SR_c);
+
 		FP_PACK_SP(vc.wp + 1, SR);
 		goto update_regs;
 
@@ -365,12 +360,10 @@ cmp_s:
 			break;
 		}
 
-#ifdef DEBUG
-		printk("DA: %ld %08lx %08lx %ld (%ld)\n",
+		pr_debug("DA: %ld %08lx %08lx %ld (%ld)\n",
 				DA_s, DA_f1, DA_f0, DA_e, DA_c);
-		printk("DB: %ld %08lx %08lx %ld (%ld)\n",
+		pr_debug("DB: %ld %08lx %08lx %ld (%ld)\n",
 				DB_s, DB_f1, DB_f0, DB_e, DB_c);
-#endif
 
 		switch (func) {
 		case EFDABS:
@@ -438,10 +431,10 @@ cmp_s:
 			FP_DECL_S(SB);
 			FP_CLEAR_EXCEPTIONS;
 			FP_UNPACK_SP(SB, vb.wp + 1);
-#ifdef DEBUG
-			printk("SB: %ld %08lx %ld (%ld)\n",
+
+			pr_debug("SB: %ld %08lx %ld (%ld)\n",
 					SB_s, SB_f, SB_e, SB_c);
-#endif
+
 			FP_CONV(D, S, 2, 1, DR, SB);
 			goto pack_d;
 		}
@@ -471,10 +464,9 @@ cmp_s:
 		break;
 
 pack_d:
-#ifdef DEBUG
-		printk("DR: %ld %08lx %08lx %ld (%ld)\n",
+		pr_debug("DR: %ld %08lx %08lx %ld (%ld)\n",
 				DR_s, DR_f1, DR_f0, DR_e, DR_c);
-#endif
+
 		FP_PACK_DP(vc.dp, DR);
 		goto update_regs;
 
@@ -511,12 +503,14 @@ cmp_d:
 			break;
 		}
 
-#ifdef DEBUG
-		printk("SA0: %ld %08lx %ld (%ld)\n", SA0_s, SA0_f, SA0_e, SA0_c);
-		printk("SA1: %ld %08lx %ld (%ld)\n", SA1_s, SA1_f, SA1_e, SA1_c);
-		printk("SB0: %ld %08lx %ld (%ld)\n", SB0_s, SB0_f, SB0_e, SB0_c);
-		printk("SB1: %ld %08lx %ld (%ld)\n", SB1_s, SB1_f, SB1_e, SB1_c);
-#endif
+		pr_debug("SA0: %ld %08lx %ld (%ld)\n",
+				SA0_s, SA0_f, SA0_e, SA0_c);
+		pr_debug("SA1: %ld %08lx %ld (%ld)\n",
+				SA1_s, SA1_f, SA1_e, SA1_c);
+		pr_debug("SB0: %ld %08lx %ld (%ld)\n",
+				SB0_s, SB0_f, SB0_e, SB0_c);
+		pr_debug("SB1: %ld %08lx %ld (%ld)\n",
+				SB1_s, SB1_f, SB1_e, SB1_c);
 
 		switch (func) {
 		case EVFSABS:
@@ -605,10 +599,11 @@ cmp_d:
 		break;
 
 pack_vs:
-#ifdef DEBUG
-		printk("SR0: %ld %08lx %ld (%ld)\n", SR0_s, SR0_f, SR0_e, SR0_c);
-		printk("SR1: %ld %08lx %ld (%ld)\n", SR1_s, SR1_f, SR1_e, SR1_c);
-#endif
+		pr_debug("SR0: %ld %08lx %ld (%ld)\n",
+				SR0_s, SR0_f, SR0_e, SR0_c);
+		pr_debug("SR1: %ld %08lx %ld (%ld)\n",
+				SR1_s, SR1_f, SR1_e, SR1_c);
+
 		FP_PACK_SP(vc.wp, SR0);
 		FP_PACK_SP(vc.wp + 1, SR1);
 		goto update_regs;
@@ -646,14 +641,12 @@ update_regs:
 	current->thread.evr[fc] = vc.wp[0];
 	regs->gpr[fc] = vc.wp[1];
 
-#ifdef DEBUG
-	printk("ccr = %08lx\n", regs->ccr);
-	printk("cur exceptions = %08x spefscr = %08lx\n",
+	pr_debug("ccr = %08lx\n", regs->ccr);
+	pr_debug("cur exceptions = %08x spefscr = %08lx\n",
 			FP_CUR_EXCEPTIONS, __FPU_FPSCR);
-	printk("vc: %08x  %08x\n", vc.wp[0], vc.wp[1]);
-	printk("va: %08x  %08x\n", va.wp[0], va.wp[1]);
-	printk("vb: %08x  %08x\n", vb.wp[0], vb.wp[1]);
-#endif
+	pr_debug("vc: %08x  %08x\n", vc.wp[0], vc.wp[1]);
+	pr_debug("va: %08x  %08x\n", va.wp[0], va.wp[1]);
+	pr_debug("vb: %08x  %08x\n", vb.wp[0], vb.wp[1]);
 
 	return 0;
 
@@ -661,9 +654,7 @@ illegal:
 	if (have_e500_cpu_a005_erratum) {
 		/* according to e500 cpu a005 erratum, reissue efp inst */
 		regs->nip -= 4;
-#ifdef DEBUG
-		printk(KERN_DEBUG "re-issue efp inst: %08lx\n", speinsn);
-#endif
+		pr_debug("re-issue efp inst: %08lx\n", speinsn);
 		return 0;
 	}
 
-- 
1.6.4
