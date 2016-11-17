Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKH8y240jzDvSw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 21:16:34 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAHADbJx042059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 05:16:31 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26saddrv9f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 05:16:31 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 03:16:30 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Update hid register on secondaries too
Date: Thu, 17 Nov 2016 15:46:23 +0530
Message-Id: <20161117101623.23770-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to update on secondaries for the selected MMU mode.

Fixes: ad410674f5606a ("powerpc/mm: Update the HID bit when switching from radix to hash")

Reported-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 4 ++++
 arch/powerpc/mm/pgtable-radix.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 44d3c3a38e3e..5503078090cd 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1029,6 +1029,10 @@ void hash__early_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+
+		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+			update_hid_for_hash();
+
 		if (!cpu_has_feature(CPU_FTR_ARCH_300))
 			mtspr(SPRN_SDR1, _SDR1);
 		else
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 735be6821e90..2fc7336619b3 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -404,6 +404,10 @@ void radix__early_init_mmu_secondary(void)
 	 * update partition table control register and UPRT
 	 */
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+
+		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+			update_hid_for_radix();
+
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 
-- 
2.10.2
