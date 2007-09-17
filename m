Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70F77DDFF0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:58:55 +1000 (EST)
Date: Mon, 17 Sep 2007 11:58:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 23/28] mpc82xx: Define CPU_FTR_NEED_COHERENT
Message-ID: <20070917165815.GW6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 8272 (and presumably other PCI PQ2 chips) appear to have the
same issue as the 83xx regarding PCI streaming DMA.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 include/asm-powerpc/cputable.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index f62cffd..c9b8f64 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -196,12 +196,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define PPC_FEATURE_HAS_EFP_DOUBLE_COMP 0
 #endif
 
-/* We need to mark all pages as being coherent if we're SMP or we
- * have a 74[45]x and an MPC107 host bridge. Also 83xx requires
- * it for PCI "streaming/prefetch" to work properly.
+/* We need to mark all pages as being coherent if we're SMP or we have a
+ * 74[45]x and an MPC107 host bridge. Also 83xx and PowerQUICC II
+ * require it for PCI "streaming/prefetch" to work properly.
  */
 #if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
-	|| defined(CONFIG_PPC_83xx)
+	|| defined(CONFIG_PPC_83xx) || defined(CONFIG_8260)
 #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
 #else
 #define CPU_FTR_COMMON                  0
@@ -313,7 +313,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_PPC_LE)
 #define CPU_FTRS_82XX	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
-#define CPU_FTRS_G2_LE	(CPU_FTR_MAYBE_CAN_DOZE | \
+#define CPU_FTRS_G2_LE	(CPU_FTR_COMMON | CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS)
 #define CPU_FTRS_E300	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS | \
-- 
1.5.3.1
