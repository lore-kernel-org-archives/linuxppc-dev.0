Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44E901A0186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:44:44 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/booke: Define MSR bits the same way as reg.h
Date: Wed, 23 Jul 2014 20:44:28 -0500
Message-ID: <1406166269-22796-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This ensures that all MSR definitions are consistently unsigned long,
and that MSR_CM does not become 0xffffffff80000000 (this is usually
harmless because MSR is 32-bit on booke and is mainly noticeable when
debugging, but still I'd rather avoid it).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/reg_booke.h | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 6148292..da42982 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -16,15 +16,25 @@
 #define __ASM_POWERPC_REG_BOOKE_H__
 
 /* Machine State Register (MSR) Fields */
-#define MSR_GS		(1<<28) /* Guest state */
-#define MSR_UCLE	(1<<26)	/* User-mode cache lock enable */
-#define MSR_SPE		(1<<25)	/* Enable SPE */
-#define MSR_DWE		(1<<10)	/* Debug Wait Enable */
-#define MSR_UBLE	(1<<10)	/* BTB lock enable (e500) */
-#define MSR_IS		MSR_IR	/* Instruction Space */
-#define MSR_DS		MSR_DR	/* Data Space */
-#define MSR_PMM		(1<<2)	/* Performance monitor mark bit */
-#define MSR_CM		(1<<31) /* Computation Mode (0=32-bit, 1=64-bit) */
+#define MSR_GS_LG	28	/* Guest state */
+#define MSR_UCLE_LG	26	/* User-mode cache lock enable */
+#define MSR_SPE_LG	25	/* Enable SPE */
+#define MSR_DWE_LG	10	/* Debug Wait Enable */
+#define MSR_UBLE_LG	10	/* BTB lock enable (e500) */
+#define MSR_IS_LG	MSR_IR_LG /* Instruction Space */
+#define MSR_DS_LG	MSR_DR_LG /* Data Space */
+#define MSR_PMM_LG	2	/* Performance monitor mark bit */
+#define MSR_CM_LG	31	/* Computation Mode (0=32-bit, 1=64-bit) */
+
+#define MSR_GS		__MASK(MSR_GS_LG)
+#define MSR_UCLE	__MASK(MSR_UCLE_LG)
+#define MSR_SPE		__MASK(MSR_SPE_LG)
+#define MSR_DWE		__MASK(MSR_DWE_LG)
+#define MSR_UBLE	__MASK(MSR_UBLE_LG)
+#define MSR_IS		__MASK(MSR_IS_LG)
+#define MSR_DS		__MASK(MSR_DS_LG)
+#define MSR_PMM		__MASK(MSR_PMM_LG)
+#define MSR_CM		__MASK(MSR_CM_LG)
 
 #if defined(CONFIG_PPC_BOOK3E_64)
 #define MSR_64BIT	MSR_CM
-- 
1.9.1
