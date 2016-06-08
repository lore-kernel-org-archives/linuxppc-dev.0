Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNN2GFmzDqxM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:44 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:26:42 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 04/10] powerpc/mm/radix: Update LPCR HR bit as per ISA
Date: Wed,  8 Jun 2016 19:55:52 +0530
Message-Id: <1465395958-21349-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerISA 3.0 requires the MMU mode (radix vs. hash) of the hypervisor
to be mirrored in the LPCR register, in addition to the partition table.
This is done to avoid fetching from the table when deciding, among other
things, how to perform transitions to HV mode on some interrupts.
So let's set it up appropriately

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h  | 1 +
 arch/powerpc/mm/pgtable-radix.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a0948f40bc7b..466816ede138 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -348,6 +348,7 @@
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
 #define   LPCR_UPRT    0x00400000      /* Use Process Table (ISA 3) */
+#define	  LPCR_HR      0x00100000
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c939e6e57a9e..73aa402047ef 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -340,7 +340,7 @@ void __init radix__early_init_mmu(void)
 	radix_init_page_sizes();
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		lpcr = mfspr(SPRN_LPCR);
-		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
 	}
 
@@ -355,7 +355,7 @@ void radix__early_init_mmu_secondary(void)
 	 */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		lpcr = mfspr(SPRN_LPCR);
-		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 
 		mtspr(SPRN_PTCR,
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
-- 
2.7.4
