Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sg1zn1DRNzDsj9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:24:53 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sg1zm5PWkz9t1C
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 02:24:52 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8MGMwAA098337
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 12:24:50 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25m08ek0wa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 12:24:50 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 23 Sep 2016 02:24:48 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7D76C3578053
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 02:24:46 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8MGOk346226212
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 02:24:46 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8MGOkR4010726
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 02:24:46 +1000
Subject: [RESEND PATCH v2] powerpc/mm: export current mmu mode info
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 22 Sep 2016 21:54:42 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147456135605.22367.3026118577109449591.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel now supports both radix and hash MMU modes. Tools like crash
and makedumpfile need to know the current MMU mode the kernel is using,
to debug/analyze it.  The current MMU mode depends on hardware support
and also whether disable_radix cmdline parameter is passed to the kernel.
The mmu_features member of cpu_spec structure holds the current MMU mode
a cpu is using. But the above mentioned tools need to know the MMU mode
early in their init process, when they may not have access to offset info
of structure members. A hard-coded offset may help but it won't be robust.

This patch introduces a new global variable, which holds the current MMU
mode the kernel is running in and can be accessed by tools early in thier
init process, helping tools to initialize accurately for each MMU mode.
This patch also optimizes the radix_enabled() function call.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes from v1:
* Patch name changed from "ppc64/book3s: export mmu type info"
* Optimized radix_enabled() function
* Removed current_mmu_mode vmcoreinfo from under flags

 arch/powerpc/include/asm/mmu.h      |   22 +++++++++++++++++++++-
 arch/powerpc/kernel/machine_kexec.c |    1 +
 arch/powerpc/mm/hash_utils_64.c     |    2 ++
 arch/powerpc/mm/pgtable-radix.c     |    2 ++
 arch/powerpc/mm/pgtable.c           |    6 ++++++
 arch/powerpc/mm/tlb_hash32.c        |    1 +
 arch/powerpc/mm/tlb_nohash.c        |    2 ++
 7 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e2fb408..558987c 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -199,6 +199,21 @@ static inline void mmu_clear_feature(unsigned long feature)
 
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
+/*
+ * Possible MMU modes
+ */
+#define MMU_MODE_NONE           0
+#define MMU_MODE_RADIX          1
+#define MMU_MODE_HASH           2
+#define MMU_MODE_HASH32         3
+#define MMU_MODE_NOHASH         4
+#define MMU_MODE_NOHASH32       5
+
+/*
+ * current MMU mode
+ */
+extern unsigned int current_mmu_mode __read_mostly;
+
 #ifdef CONFIG_PPC64
 /* This is our real memory area size on ppc64 server, on embedded, we
  * make it match the size our of bolted TLB area
@@ -218,7 +233,12 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 #ifdef CONFIG_PPC_RADIX_MMU
 static inline bool radix_enabled(void)
 {
-	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
+	if (current_mmu_mode == MMU_MODE_RADIX)
+		return true;
+	else if (current_mmu_mode != MMU_MODE_NONE)
+		return false;
+	else
+		return mmu_has_feature(MMU_FTR_TYPE_RADIX);
 }
 
 static inline bool early_radix_enabled(void)
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 2694d07..2a32694 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -87,6 +87,7 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_STRUCT_SIZE(mmu_psize_def);
 	VMCOREINFO_OFFSET(mmu_psize_def, shift);
 #endif
+	VMCOREINFO_SYMBOL(current_mmu_mode);
 }
 
 /*
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556..a566a95 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -886,6 +886,8 @@ void __init hash__early_init_devtree(void)
 
 void __init hash__early_init_mmu(void)
 {
+	current_mmu_mode = MMU_MODE_HASH;
+
 	htab_init_page_sizes();
 
 	/*
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index af897d9..4b0ad48 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -298,6 +298,8 @@ void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
 
+	current_mmu_mode = MMU_MODE_RADIX;
+
 #ifdef CONFIG_PPC_64K_PAGES
 	/* PAGE_SIZE mappings */
 	mmu_virtual_psize = MMU_PAGE_64K;
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 0b6fb24..4638a00 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -31,6 +31,12 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
+/*
+ * current MMU mode
+ */
+unsigned int current_mmu_mode __read_mostly = MMU_MODE_NONE;
+EXPORT_SYMBOL(current_mmu_mode);
+
 static inline int is_exec_fault(void)
 {
 	return current->thread.regs && TRAP(current->thread.regs) == 0x400;
diff --git a/arch/powerpc/mm/tlb_hash32.c b/arch/powerpc/mm/tlb_hash32.c
index 702d768..0b55425 100644
--- a/arch/powerpc/mm/tlb_hash32.c
+++ b/arch/powerpc/mm/tlb_hash32.c
@@ -170,4 +170,5 @@ EXPORT_SYMBOL(flush_tlb_range);
 
 void __init early_init_mmu(void)
 {
+	current_mmu_mode = MMU_MODE_HASH32;
 }
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 050badc..74300a7 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -720,6 +720,7 @@ static void __init early_mmu_set_memory_limit(void)
 /* boot cpu only */
 void __init early_init_mmu(void)
 {
+	current_mmu_mode = MMU_MODE_NOHASH;
 	early_init_mmu_global();
 	early_init_this_mmu();
 	early_mmu_set_memory_limit();
@@ -772,6 +773,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 #else /* ! CONFIG_PPC64 */
 void __init early_init_mmu(void)
 {
+	current_mmu_mode = MMU_MODE_NOHASH32;
 #ifdef CONFIG_PPC_47x
 	early_init_mmu_47x();
 #endif
