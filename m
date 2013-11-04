Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1C" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED8972C065D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 03:55:11 +1100 (EST)
Date: Mon, 4 Nov 2013 16:55:05 +0000
From: "Joseph S. Myers" <joseph@codesourcery.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 6/6] powerpc: fix e500 SPE float SIGFPE generation
In-Reply-To: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
Message-ID: <Pine.LNX.4.64.1311041654520.4290@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: Joseph Myers <joseph@codesourcery.com>
Cc: Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
 Shan Hai <shan.hai@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joseph Myers <joseph@codesourcery.com>

The e500 SPE floating-point emulation code is called from
SPEFloatingPointException and SPEFloatingPointRoundException in
arch/powerpc/kernel/traps.c.  Those functions have support for
generating SIGFPE, but do_spe_mathemu and speround_handler don't
generate a return value to indicate that this should be done.  Such a
return value should depend on whether an exception is raised that has
been set via prctl to generate SIGFPE.  This patch adds the relevant
logic in these functions so that SIGFPE is generated as expected by
the glibc testsuite.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

Previous submission: <http://lkml.org/lkml/2013/10/10/626>.

diff --git a/arch/powerpc/math-emu/math_efp.c b/arch/powerpc/math-emu/math_efp.c
index 01a0abb..28337c9 100644
--- a/arch/powerpc/math-emu/math_efp.c
+++ b/arch/powerpc/math-emu/math_efp.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/prctl.h>
 
 #include <asm/uaccess.h>
 #include <asm/reg.h>
@@ -691,6 +692,23 @@ update_regs:
 	pr_debug("va: %08x  %08x\n", va.wp[0], va.wp[1]);
 	pr_debug("vb: %08x  %08x\n", vb.wp[0], vb.wp[1]);
 
+	if (current->thread.fpexc_mode & PR_FP_EXC_SW_ENABLE) {
+		if ((FP_CUR_EXCEPTIONS & FP_EX_DIVZERO)
+		    && (current->thread.fpexc_mode & PR_FP_EXC_DIV))
+			return 1;
+		if ((FP_CUR_EXCEPTIONS & FP_EX_OVERFLOW)
+		    && (current->thread.fpexc_mode & PR_FP_EXC_OVF))
+			return 1;
+		if ((FP_CUR_EXCEPTIONS & FP_EX_UNDERFLOW)
+		    && (current->thread.fpexc_mode & PR_FP_EXC_UND))
+			return 1;
+		if ((FP_CUR_EXCEPTIONS & FP_EX_INEXACT)
+		    && (current->thread.fpexc_mode & PR_FP_EXC_RES))
+			return 1;
+		if ((FP_CUR_EXCEPTIONS & FP_EX_INVALID)
+		    && (current->thread.fpexc_mode & PR_FP_EXC_INV))
+			return 1;
+	}
 	return 0;
 
 illegal:
@@ -867,6 +885,8 @@ int speround_handler(struct pt_regs *regs)
 
 	pr_debug("  to fgpr: %08x  %08x\n", fgpr.wp[0], fgpr.wp[1]);
 
+	if (current->thread.fpexc_mode & PR_FP_EXC_SW_ENABLE)
+		return (current->thread.fpexc_mode & PR_FP_EXC_RES) ? 1 : 0;
 	return 0;
 }
 

-- 
Joseph S. Myers
joseph@codesourcery.com
