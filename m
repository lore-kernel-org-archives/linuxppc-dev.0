Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96285DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 06:51:27 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n32JpNHV004710
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 14:51:24 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Move SPEFSCR defines to common header
Date: Thu,  2 Apr 2009 14:51:23 -0500
Message-Id: <1238701883-19101-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

SPEFSCR is a user space register and doesn't conflict with anything.
Moving the defines of the various bit fields makes some emulation
code have fewer ifdefs

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/reg.h       |   30 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg_booke.h |   30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c9ff1ec..e8018d5 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -143,6 +143,36 @@
 #define FPSCR_NI	0x00000004	/* FPU non IEEE-Mode */
 #define FPSCR_RN	0x00000003	/* FPU rounding control */
 
+/* Bit definitions for SPEFSCR. */
+#define SPEFSCR_SOVH	0x80000000	/* Summary integer overflow high */
+#define SPEFSCR_OVH	0x40000000	/* Integer overflow high */
+#define SPEFSCR_FGH	0x20000000	/* Embedded FP guard bit high */
+#define SPEFSCR_FXH	0x10000000	/* Embedded FP sticky bit high */
+#define SPEFSCR_FINVH	0x08000000	/* Embedded FP invalid operation high */
+#define SPEFSCR_FDBZH	0x04000000	/* Embedded FP div by zero high */
+#define SPEFSCR_FUNFH	0x02000000	/* Embedded FP underflow high */
+#define SPEFSCR_FOVFH	0x01000000	/* Embedded FP overflow high */
+#define SPEFSCR_FINXS	0x00200000	/* Embedded FP inexact sticky */
+#define SPEFSCR_FINVS	0x00100000	/* Embedded FP invalid op. sticky */
+#define SPEFSCR_FDBZS	0x00080000	/* Embedded FP div by zero sticky */
+#define SPEFSCR_FUNFS	0x00040000	/* Embedded FP underflow sticky */
+#define SPEFSCR_FOVFS	0x00020000	/* Embedded FP overflow sticky */
+#define SPEFSCR_MODE	0x00010000	/* Embedded FP mode */
+#define SPEFSCR_SOV	0x00008000	/* Integer summary overflow */
+#define SPEFSCR_OV	0x00004000	/* Integer overflow */
+#define SPEFSCR_FG	0x00002000	/* Embedded FP guard bit */
+#define SPEFSCR_FX	0x00001000	/* Embedded FP sticky bit */
+#define SPEFSCR_FINV	0x00000800	/* Embedded FP invalid operation */
+#define SPEFSCR_FDBZ	0x00000400	/* Embedded FP div by zero */
+#define SPEFSCR_FUNF	0x00000200	/* Embedded FP underflow */
+#define SPEFSCR_FOVF	0x00000100	/* Embedded FP overflow */
+#define SPEFSCR_FINXE	0x00000040	/* Embedded FP inexact enable */
+#define SPEFSCR_FINVE	0x00000020	/* Embedded FP invalid op. enable */
+#define SPEFSCR_FDBZE	0x00000010	/* Embedded FP div by zero enable */
+#define SPEFSCR_FUNFE	0x00000008	/* Embedded FP underflow enable */
+#define SPEFSCR_FOVFE	0x00000004	/* Embedded FP overflow enable */
+#define SPEFSCR_FRMC 	0x00000003	/* Embedded FP rounding mode control */
+
 /* Special Purpose Registers (SPRNs)*/
 #define SPRN_CTR	0x009	/* Count Register */
 #define SPRN_DSCR	0x11
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index a56f4d6..601ddbc 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -423,36 +423,6 @@
 #define SGR_NORMAL	0		/* Speculative fetching allowed. */
 #define SGR_GUARDED	1		/* Speculative fetching disallowed. */
 
-/* Bit definitions for SPEFSCR. */
-#define SPEFSCR_SOVH	0x80000000	/* Summary integer overflow high */
-#define SPEFSCR_OVH	0x40000000	/* Integer overflow high */
-#define SPEFSCR_FGH	0x20000000	/* Embedded FP guard bit high */
-#define SPEFSCR_FXH	0x10000000	/* Embedded FP sticky bit high */
-#define SPEFSCR_FINVH	0x08000000	/* Embedded FP invalid operation high */
-#define SPEFSCR_FDBZH	0x04000000	/* Embedded FP div by zero high */
-#define SPEFSCR_FUNFH	0x02000000	/* Embedded FP underflow high */
-#define SPEFSCR_FOVFH	0x01000000	/* Embedded FP overflow high */
-#define SPEFSCR_FINXS	0x00200000	/* Embedded FP inexact sticky */
-#define SPEFSCR_FINVS	0x00100000	/* Embedded FP invalid op. sticky */
-#define SPEFSCR_FDBZS	0x00080000	/* Embedded FP div by zero sticky */
-#define SPEFSCR_FUNFS	0x00040000	/* Embedded FP underflow sticky */
-#define SPEFSCR_FOVFS	0x00020000	/* Embedded FP overflow sticky */
-#define SPEFSCR_MODE	0x00010000	/* Embedded FP mode */
-#define SPEFSCR_SOV	0x00008000	/* Integer summary overflow */
-#define SPEFSCR_OV	0x00004000	/* Integer overflow */
-#define SPEFSCR_FG	0x00002000	/* Embedded FP guard bit */
-#define SPEFSCR_FX	0x00001000	/* Embedded FP sticky bit */
-#define SPEFSCR_FINV	0x00000800	/* Embedded FP invalid operation */
-#define SPEFSCR_FDBZ	0x00000400	/* Embedded FP div by zero */
-#define SPEFSCR_FUNF	0x00000200	/* Embedded FP underflow */
-#define SPEFSCR_FOVF	0x00000100	/* Embedded FP overflow */
-#define SPEFSCR_FINXE	0x00000040	/* Embedded FP inexact enable */
-#define SPEFSCR_FINVE	0x00000020	/* Embedded FP invalid op. enable */
-#define SPEFSCR_FDBZE	0x00000010	/* Embedded FP div by zero enable */
-#define SPEFSCR_FUNFE	0x00000008	/* Embedded FP underflow enable */
-#define SPEFSCR_FOVFE	0x00000004	/* Embedded FP overflow enable */
-#define SPEFSCR_FRMC 	0x00000003	/* Embedded FP rounding mode control */
-
 /*
  * The IBM-403 is an even more odd special case, as it is much
  * older than the IBM-405 series.  We put these down here incase someone
-- 
1.5.6.6
