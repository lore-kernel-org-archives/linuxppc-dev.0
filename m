Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6F34DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 02:07:00 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l62G6vga010090
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 12:06:57 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l62G6vbd259330
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 10:06:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l62G6vvx016499
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 10:06:57 -0600
Received: from [9.10.86.36] (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l62G6s59016188
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 10:06:54 -0600
Subject: [PATCH] Consolidate PowerPC 750 cputable features
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 02 Jul 2007 11:06:53 -0500
Message-Id: <1183392413.16523.25.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 750 CPU_FTR macros have quite a bit of duplication in them.  Consolidate
them to use CPU_FTRS_750 and only list the unique features for derivatives.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 include/asm-powerpc/cputable.h |   26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

--- linux-2.6.orig/include/asm-powerpc/cputable.h
+++ linux-2.6/include/asm-powerpc/cputable.h
@@ -225,26 +225,12 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_PPC_LE)
-#define CPU_FTRS_750CL	(CPU_FTR_COMMON | \
-	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750FX1	(CPU_FTR_COMMON | \
-	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750FX2	(CPU_FTR_COMMON | \
-	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_NO_DPM | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750FX	(CPU_FTR_COMMON | \
-	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750GX	(CPU_FTR_COMMON | \
-	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
-	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
+#define CPU_FTRS_750CL	(CPU_FTRS_750 | CPU_FTR_HAS_HIGH_BATS)
+#define CPU_FTRS_750FX1	(CPU_FTRS_750 | CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM)
+#define CPU_FTRS_750FX2	(CPU_FTRS_750 | CPU_FTR_NO_DPM)
+#define CPU_FTRS_750FX	(CPU_FTRS_750 | CPU_FTR_DUAL_PLL_750FX | \
+		CPU_FTR_HAS_HIGH_BATS)
+#define CPU_FTRS_750GX	(CPU_FTRS_750FX)
 #define CPU_FTRS_7400_NOTAU	(CPU_FTR_COMMON | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE | \
