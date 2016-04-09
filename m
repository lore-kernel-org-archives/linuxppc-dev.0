Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmMX3HkPzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:28 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:17:26 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2D5153E4001C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:17:24 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396HO5w42467410
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 23:17:24 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396HNbP000989
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 00:17:24 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 67/68] powerpc/mm/radix: Cputable update for radix
Date: Sat,  9 Apr 2016 11:44:03 +0530
Message-Id: <1460182444-2468-68-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With P9 Radix we need to do

* set UPRT = 1
* set different TLB set count

In this patch we delay the UPRT=1 to early mmu init. This help us to
keep the cpu table setup and restore cpu callback the same across
different MMU model.

This also implies that a cpu_restore cur_cpu_spec callback won't set
UPRT=1. We currently use that for secondary cpu init and on primary
after we did an opal reinit for endian switch. In both the case
we call early_mmu_init after the above operations. This set UPRT
to correct value.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h  |  4 ++++
 arch/powerpc/kernel/cputable.c  |  2 +-
 arch/powerpc/kernel/mce_power.c |  3 ++-
 arch/powerpc/mm/pgtable-radix.c | 13 +++++++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index b546e6f28d44..3400ed884f10 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -347,6 +347,10 @@
 #define   LPCR_LPES_SH	2
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
+/*
+ * Used in asm code, hence we don't want to use PPC_BITCOUNT
+ */
+#define	  LPCR_UPRT	(ASM_CONST(0x1) << 22)
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6c662b8de90d..e009722d5914 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -514,7 +514,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_POWER9,
 		.cpu_user_features	= COMMON_USER_POWER9,
 		.cpu_user_features2	= COMMON_USER2_POWER9,
-		.mmu_features		= MMU_FTRS_POWER9,
+		.mmu_features		= MMU_FTRS_POWER9 | MMU_FTR_RADIX,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 92a66a2a9b85..4a8c3bdfce5c 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -72,10 +72,11 @@ void __flush_tlb_power8(unsigned int action)
 
 void __flush_tlb_power9(unsigned int action)
 {
+	if (radix_enabled())
+		flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
 	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
 }
 
-
 /* flush SLBs and reload */
 #ifdef CONFIG_PPC_MMU_STD_64
 static void flush_and_reload_slb(void)
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index be95d1ef35a0..89a4ee26b879 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -296,6 +296,13 @@ found:
 
 void __init rearly_init_mmu(void)
 {
+	unsigned long lpcr;
+	/*
+	 * setup LPCR UPRT based on mmu_features
+	 */
+	lpcr = mfspr(SPRN_LPCR);
+	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+
 #ifdef CONFIG_PPC_64K_PAGES
 	/* PAGE_SIZE mappings */
 	mmu_virtual_psize = MMU_PAGE_64K;
@@ -345,6 +352,12 @@ void __init rearly_init_mmu(void)
 
 void rearly_init_mmu_secondary(void)
 {
+	unsigned long lpcr;
+	/*
+	 * setup LPCR UPRT based on mmu_features
+	 */
+	lpcr = mfspr(SPRN_LPCR);
+	mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
 	/*
 	 * update partition table control register, 64 K size.
 	 */
-- 
2.5.0
