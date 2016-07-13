Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDGd6j9mzDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:35:53 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YEnt043754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:35:51 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 245hgabjuq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:35:51 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:35:50 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 02/12] powerpc/mm/radix: Update LPCR HR bit as per ISA
Date: Wed, 13 Jul 2016 15:05:21 +0530
In-Reply-To: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402531-4914-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 320136f5fe28..a5ba263e0353 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -354,6 +354,7 @@
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
 #define   LPCR_UPRT    0x00400000      /* Use Process Table (ISA 3) */
+#define   LPCR_HR      0x00100000
 #ifndef SPRN_LPID
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
 #endif
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index e58707deef5c..f8a3bec315f7 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -337,7 +337,7 @@ void __init radix__early_init_mmu(void)
 	radix_init_page_sizes();
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		lpcr = mfspr(SPRN_LPCR);
-		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
 	}
 
@@ -352,7 +352,7 @@ void radix__early_init_mmu_secondary(void)
 	 */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		lpcr = mfspr(SPRN_LPCR);
-		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT);
+		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 
 		mtspr(SPRN_PTCR,
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
-- 
2.7.4
