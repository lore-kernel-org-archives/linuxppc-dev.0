Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK2FV6b82zDrd2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 19:34:22 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7O9SfSL079235
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 05:34:20 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 250wun89sp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 05:34:20 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 24 Aug 2016 03:34:19 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc/mm: Update the HID bit when switching from radix
 to hash
Date: Wed, 24 Aug 2016 15:03:39 +0530
In-Reply-To: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1472031219-18759-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power9 DD1 requires to update the hid0 register when switching from
hash to radix.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/reg.h  |  3 +++
 arch/powerpc/mm/hash_utils_64.c | 25 +++++++++++++++++++++++++
 arch/powerpc/mm/pgtable-radix.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f69f40f1519a..9dddabc2fced 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -475,6 +475,9 @@
 #define HID0_POWER8_1TO4LPAR	__MASK(51)
 #define HID0_POWER8_DYNLPARDIS	__MASK(48)
 
+/* POWER9 HID0 bits */
+#define HID0_POWER9_RADIX	__MASK(63 - 8)
+
 #define SPRN_HID1	0x3F1		/* Hardware Implementation Register 1 */
 #ifdef CONFIG_6xx
 #define HID1_EMCP	(1<<31)		/* 7450 Machine Check Pin Enable */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556e16f4..35a6721b3d25 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -711,6 +711,29 @@ int remove_section_mapping(unsigned long start, unsigned long end)
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+static void update_hid_for_hash(void)
+{
+	unsigned long hid0;
+	unsigned long rb = 3UL << PPC_BITLSHIFT(53); /* IS = 3 */
+
+	asm volatile("ptesync": : :"memory");
+	/* prs = 0, ric = 2, rs = 0, r = 1 is = 3 */
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(0), "i"(0), "i"(2), "r"(0) : "memory");
+	asm volatile("eieio; tlbsync; ptesync; isync; slbia": : :"memory");
+	/*
+	 * now switch the HID
+	 */
+	hid0  = mfspr(SPRN_HID0);
+	hid0 &= ~HID0_POWER9_RADIX;
+	mtspr(SPRN_HID0, hid0);
+	asm volatile("isync": : :"memory");
+
+	/* Wait for it to happen */
+	while ((mfspr(SPRN_HID0) & HID0_POWER9_RADIX))
+		cpu_relax();
+}
+
 static void __init hash_init_partition_table(phys_addr_t hash_table,
 					     unsigned long htab_size)
 {
@@ -737,6 +760,8 @@ static void __init hash_init_partition_table(phys_addr_t hash_table,
 	 */
 	partition_tb->patb1 = 0;
 	pr_info("Partition table %p\n", partition_tb);
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+		update_hid_for_hash();
 	/*
 	 * update partition table control register,
 	 * 64 K size.
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index af897d91d09f..8f086352e421 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -294,6 +294,32 @@ found:
 	return;
 }
 
+static void update_hid_for_radix(void)
+{
+	unsigned long hid0;
+	unsigned long rb = 3UL << PPC_BITLSHIFT(53); /* IS = 3 */
+
+	asm volatile("ptesync": : :"memory");
+	/* prs = 0, ric = 2, rs = 0, r = 1 is = 3 */
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(1), "i"(0), "i"(2), "r"(0) : "memory");
+	/* prs = 1, ric = 2, rs = 0, r = 1 is = 3 */
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(1), "i"(1), "i"(2), "r"(0) : "memory");
+	asm volatile("eieio; tlbsync; ptesync; isync; slbia": : :"memory");
+	/*
+	 * now switch the HID
+	 */
+	hid0  = mfspr(SPRN_HID0);
+	hid0 |= HID0_POWER9_RADIX;
+	mtspr(SPRN_HID0, hid0);
+	asm volatile("isync": : :"memory");
+
+	/* Wait for it to happen */
+	while (!(mfspr(SPRN_HID0) & HID0_POWER9_RADIX))
+		cpu_relax();
+}
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
@@ -345,6 +371,8 @@ void __init radix__early_init_mmu(void)
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
+		if (cpu_has_feature(CPU_FTR_POWER9_DD1))
+			update_hid_for_radix();
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
 		radix_init_partition_table();
-- 
2.7.4
