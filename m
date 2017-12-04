Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqpz85p56zDrZW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 13:41:08 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id a90so7462199pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Dec 2017 18:41:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2] powerpc/64s: ISAv3 initialize MMU registers before setting
 partition table
Date: Mon,  4 Dec 2017 12:40:55 +1000
Message-Id: <20171204024055.11108-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kexec can leave MMU registers set when booting into a new kernel, PIDR
in particular. The boot sequence does not zero PIDR, so it only gets
set when CPUs first switch to a userspace processes (until then it's
running a kernel thread with effective PID = 0).

This leaves a window where a process table entry and page tables are
set up due to user processes running on other CPUs, that happen to
match with a stale PID. The CPU with that PID may cause speculative
accesses that address quadrant 0, which will result in cached
translations and PWC for that process, on a CPU which is not in the
mm_cpumask and so they will not get invalidated properly.

The most common result is the kernel hanging in infinite page fault
loops soon after kexec (usually in schedule_tail, which is usually the
first non-speculative quardant 0 access to a new PID) due to a stale
PWC. However being a stale translation erorr, it could result in
anything up to security and data corruption errors.

Fix this by zeroing out PIDR before setting PTCR.

LPIDR is also not initialized, and may cause a similar issue with
speculative access to quadrant 1/2. This has not been observed, but
LPIDR is cleared to prevent that possibility.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Aneesh noticed hash was not clearing LPID
- Improved changelog
- Improved comments

Please review.

Thanks,
Nick

 arch/powerpc/mm/hash_utils_64.c | 19 +++++++++++++++++--
 arch/powerpc/mm/pgtable-radix.c | 10 ++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 655a5a9a183d..d9f3a72f3981 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1029,13 +1029,24 @@ void __init hash__early_init_mmu(void)
 	pci_io_base = ISA_IO_BASE;
 #endif
 
+	/*
+	 * kexec kernels can boot into the new kernel with PID and LPID
+	 * registers non-zero. Zero them to prevent speculative accesses
+	 * setting up cached translations when we turn the MMU on and
+	 * process/partition table entries start being added.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		mtspr(SPRN_PID, 0);
+
 	/* Select appropriate backend */
 	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
 		ps3_early_mm_init();
 	else if (firmware_has_feature(FW_FEATURE_LPAR))
 		hpte_init_pseries();
-	else if (IS_ENABLED(CONFIG_PPC_NATIVE))
+	else if (IS_ENABLED(CONFIG_PPC_NATIVE)) {
+		mtspr(SPRN_LPID, 0);
 		hpte_init_native();
+	}
 
 	if (!mmu_hash_ops.hpte_insert)
 		panic("hash__early_init_mmu: No MMU hash ops defined!\n");
@@ -1055,11 +1066,15 @@ void __init hash__early_init_mmu(void)
 void hash__early_init_mmu_secondary(void)
 {
 	/* Initialize hash table for that CPU */
-	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		mtspr(SPRN_PID, 0);
 
+	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
 			update_hid_for_hash();
 
+		mtspr(SPRN_LPID, 0);
+
 		if (!cpu_has_feature(CPU_FTR_ARCH_300))
 			mtspr(SPRN_SDR1, _SDR1);
 		else
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index cfbbee941a76..0c13355ddc2a 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -563,10 +563,18 @@ void __init radix__early_init_mmu(void)
 	__pte_frag_nr = H_PTE_FRAG_NR;
 	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
 
+	/*
+	 * kexec kernels can boot into the new kernel with PID and LPID
+	 * registers non-zero. Zero them to prevent speculative accesses
+	 * setting up cached translations when we turn the MMU on and
+	 * process/partition table entries start being added.
+	 */
+	mtspr(SPRN_PID, 0);
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
 		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
 			update_hid_for_radix();
+		mtspr(SPRN_LPID, 0);
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
@@ -587,10 +595,12 @@ void radix__early_init_mmu_secondary(void)
 	/*
 	 * update partition table control register and UPRT
 	 */
+	mtspr(SPRN_PID, 0);
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 
 		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
 			update_hid_for_radix();
+		mtspr(SPRN_LPID, 0);
 
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
-- 
2.15.0
