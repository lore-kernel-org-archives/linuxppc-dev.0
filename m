Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B88FDDF64
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 04:34:35 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3CIYWO5030082
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 14:34:32 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CIYWHJ188198
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 12:34:32 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CIYVrR011967
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 12:34:31 -0600
Subject: [PATCH v2] powerpc: Fix PowerPC 750CL and 750GX CPU features
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Thu, 12 Apr 2007 13:33:25 -0500
Message-Id: <1176402805.6379.84.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PowerPC 750CL has high BATs.  The patch below adds a CPU_FTRS_750CL that
includes that.  Without it, the original firmware mappings in the high BATs
aren't cleared which continue to override the linux translations.

It also adds CPU_FTR_COMMON to CPU_FTRS_750GX for completeness.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cputable.c |    4 ++--
 include/asm-powerpc/cputable.h |   10 +++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

--- linux-2.6.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6/arch/powerpc/kernel/cputable.c
@@ -562,12 +562,12 @@ static struct cpu_spec cpu_specs[] = {
 		.pvr_mask		= 0xfffff0f0,
 		.pvr_value		= 0x00087010,
 		.cpu_name		= "750CL",
-		.cpu_features		= CPU_FTRS_750,
+		.cpu_features		= CPU_FTRS_750CL,
 		.cpu_user_features	= COMMON_USER | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
-		.cpu_setup		= __setup_cpu_750cx,
+		.cpu_setup		= __setup_cpu_750,
 		.platform		= "ppc750",
 	},
 	{	/* 745/755 */
--- linux-2.6.orig/include/asm-powerpc/cputable.h
+++ linux-2.6/include/asm-powerpc/cputable.h
@@ -223,6 +223,10 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_PPC_LE)
+#define CPU_FTRS_750CL	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
+	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
+	    CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
 #define CPU_FTRS_750FX1	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
@@ -235,9 +239,9 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
 	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
-#define CPU_FTRS_750GX	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
-	    CPU_FTR_USE_TB | CPU_FTR_L2CR | CPU_FTR_TAU | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
+#define CPU_FTRS_750GX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
+	    CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS | CPU_FTR_PPC_LE)
 #define CPU_FTRS_7400_NOTAU	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | CPU_FTR_L2CR | \
