Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yp1Bv3qT5zDsFS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 15:15:01 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id m26so4096415pfj.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 20:15:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] powerpc/64s: ISAv3 initialize MMU registers before setting
 partition table
Date: Fri,  1 Dec 2017 14:14:48 +1000
Message-Id: <20171201041448.28053-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec can leave MMU registers set, PIDR in particular, when booting the
new kernel. The boot sequence does not zero PIDR ever, and it only gets
changed as CPUs first switch to userspace processes. This can leave a
window where speculative accesses from a CPU to quadrant 0 can pick up
translations in the partition table that may be set up for processes
running on other CPUs. These cached translations will not be involved in
the invalidation protocol, so we can end with stable TLB and PWC.

This can cause the kernel to hang in infinite page fault loops (usually
in schedule_tail, which is usually the first quardant 0 access to a new
PID.

Fix this by zeroing out PIDR before setting PTCR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/hash_utils_64.c |  6 ++++++
 arch/powerpc/mm/pgtable-radix.c | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 655a5a9a183d..9176e1dda8e0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1029,6 +1029,9 @@ void __init hash__early_init_mmu(void)
 	pci_io_base = ISA_IO_BASE;
 #endif
 
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		mtspr(SPRN_PID, 0);
+
 	/* Select appropriate backend */
 	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
 		ps3_early_mm_init();
@@ -1055,6 +1058,9 @@ void __init hash__early_init_mmu(void)
 void hash__early_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		mtspr(SPRN_PID, 0);
+
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 
 		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfbbee941a76..88430acf4b85 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -563,12 +563,25 @@ void __init radix__early_init_mmu(void)
 	__pte_frag_nr = H_PTE_FRAG_NR;
 	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
 
+	/*
+	 * kexec kernels can boot into the new kernel with PIDR non-zero.
+	 *
+	 * PIDR should be zeroed before we set the partition table,
+	 * to ensure no speculative TLB fill goes off to non-zero PIDs.
+	 * This shouldn't be a problem in real-mode, but I have not
+	 * found definitively in the ISA.
+	 *
+	 * We do need to ensure all CPUs have PID=0 when the MMU
+	 * is turned on.
+	 */
+	mtspr(SPRN_PID, 0);
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
 		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
 			update_hid_for_radix();
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
+		mtspr(SPRN_LPID, 0);
 		radix_init_partition_table();
 		radix_init_amor();
 	} else {
@@ -587,6 +600,7 @@ void radix__early_init_mmu_secondary(void)
 	/*
 	 * update partition table control register and UPRT
 	 */
+	mtspr(SPRN_PID, 0);
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 
 		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
@@ -595,6 +609,7 @@ void radix__early_init_mmu_secondary(void)
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 
+		mtspr(SPRN_LPID, 0);
 		mtspr(SPRN_PTCR,
 		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
 		radix_init_amor();
-- 
2.15.0
