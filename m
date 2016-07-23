Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rxMHq6NVPzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 19:13:11 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6N9A0Y0054308
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 05:13:09 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c26kcfwc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 05:13:09 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 23 Jul 2016 03:13:08 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 V2 02/10] powerpc/mm: Convert early cpu/mmu feature
 check to use the new helpers
Date: Sat, 23 Jul 2016 14:42:35 +0530
In-Reply-To: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1469265163-1491-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This switch the early feature check to use the non static key
variant of the function. In later patches we will be switching
cpu_has_feature and mmu_has_feature to use static keys and we can use
them only after static key/jump label is initialized. Any check for
feature before jump label init should be done using this new helper.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 ++--
 arch/powerpc/kernel/paca.c                    |  2 +-
 arch/powerpc/kernel/setup_64.c                |  4 ++--
 arch/powerpc/mm/hash_native_64.c              |  2 +-
 arch/powerpc/mm/hash_utils_64.c               | 10 +++++-----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index e4e1e64e2c8d..ceba5472fe58 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -278,7 +278,7 @@ static inline unsigned long hpte_encode_avpn(unsigned long vpn, int psize,
 	 */
 	v = (vpn >> (23 - VPN_SHIFT)) & ~(mmu_psize_defs[psize].avpnm);
 	v <<= HPTE_V_AVPN_SHIFT;
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+	if (!__cpu_has_feature(CPU_FTR_ARCH_300))
 		v |= ((unsigned long) ssize) << HPTE_V_SSIZE_SHIFT;
 	return v;
 }
@@ -306,7 +306,7 @@ static inline unsigned long hpte_encode_r(unsigned long pa, int base_psize,
 					  int actual_psize, int ssize)
 {
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (__cpu_has_feature(CPU_FTR_ARCH_300))
 		pa |= ((unsigned long) ssize) << HPTE_R_3_0_SSIZE_SHIFT;
 
 	/* A 4K page needs no special encoding */
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 93dae296b6be..1b0b89e80824 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -184,7 +184,7 @@ void setup_paca(struct paca_struct *new_paca)
 	 * if we do a GET_PACA() before the feature fixups have been
 	 * applied
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE))
+	if (__cpu_has_feature(CPU_FTR_HVMODE))
 		mtspr(SPRN_SPRG_HPACA, local_paca);
 #endif
 	mtspr(SPRN_SPRG_PACA, local_paca);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d8216aed22b7..042d20a740ab 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -227,8 +227,8 @@ static void __init configure_exceptions(void)
 			opal_configure_cores();
 
 		/* Enable AIL if supported, and we are in hypervisor mode */
-		if (cpu_has_feature(CPU_FTR_HVMODE) &&
-		    cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		if (__cpu_has_feature(CPU_FTR_HVMODE) &&
+		    __cpu_has_feature(CPU_FTR_ARCH_207S)) {
 			unsigned long lpcr = mfspr(SPRN_LPCR);
 			mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
 		}
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index d2d8efd79cbf..b6565c50cabf 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -746,6 +746,6 @@ void __init hpte_init_native(void)
 	mmu_hash_ops.flush_hash_range = native_flush_hash_range;
 	mmu_hash_ops.hugepage_invalidate   = native_hugepage_invalidate;
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (__cpu_has_feature(CPU_FTR_ARCH_300))
 		ppc_md.register_process_table = native_register_proc_table;
 }
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 341632471b9d..a688f6c2b403 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -530,7 +530,7 @@ static bool might_have_hea(void)
 	 * we will never see an HEA ethernet device.
 	 */
 #ifdef CONFIG_IBMEBUS
-	return !cpu_has_feature(CPU_FTR_ARCH_207S) &&
+	return !__cpu_has_feature(CPU_FTR_ARCH_207S) &&
 		!firmware_has_feature(FW_FEATURE_SPLPAR);
 #else
 	return false;
@@ -561,7 +561,7 @@ static void __init htab_init_page_sizes(void)
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
 	 */
-	if (mmu_has_feature(MMU_FTR_16M_PAGE))
+	if (__mmu_has_feature(MMU_FTR_16M_PAGE))
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
 found:
@@ -591,7 +591,7 @@ found:
 		mmu_vmalloc_psize = MMU_PAGE_64K;
 		if (mmu_linear_psize == MMU_PAGE_4K)
 			mmu_linear_psize = MMU_PAGE_64K;
-		if (mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
+		if (__mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
 			/*
 			 * When running on pSeries using 64k pages for ioremap
 			 * would stop us accessing the HEA ethernet. So if we
@@ -765,7 +765,7 @@ static void __init htab_initialize(void)
 	/* Initialize page sizes */
 	htab_init_page_sizes();
 
-	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
+	if (__mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
 		mmu_kernel_ssize = MMU_SEGSIZE_1T;
 		mmu_highuser_ssize = MMU_SEGSIZE_1T;
 		printk(KERN_INFO "Using 1TB segments\n");
@@ -824,7 +824,7 @@ static void __init htab_initialize(void)
 		/* Initialize the HPT with no entries */
 		memset((void *)table, 0, htab_size_bytes);
 
-		if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		if (!__cpu_has_feature(CPU_FTR_ARCH_300))
 			/* Set SDR1 */
 			mtspr(SPRN_SDR1, _SDR1);
 		else
-- 
2.7.4
