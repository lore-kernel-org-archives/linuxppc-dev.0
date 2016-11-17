Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKcX60vlPzDvvd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 10:19:18 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc/mm: Update POWER9 HID on secondaries too
Date: Fri, 18 Nov 2016 10:19:02 +1100
Message-Id: <20161117231902.15919-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We need to update the HID on secondaries for the selected MMU mode.

Fixes: ad410674f5606a ("powerpc/mm: Update the HID bit when switching from radix to hash")

Reported-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/mm/hash_utils_64.c | 4 ++++
 arch/powerpc/mm/pgtable-radix.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 44d3c3a38e..5503078090 100644
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
index e93e38455d..9dfd3f1369 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -388,6 +388,10 @@ void radix__early_init_mmu_secondary(void)
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
2.9.3
