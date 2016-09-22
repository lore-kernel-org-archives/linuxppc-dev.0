Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sftn63fMmzDsgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 21:00:10 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sftn55Xrmz9t15
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 21:00:09 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8MAwQDg129816
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 07:00:07 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25mb2685t7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 07:00:07 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 16:30:03 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9DE983940062
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 16:30:00 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8MAxp8416842770
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 16:29:51 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8MAujXC014175
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Sep 2016 16:29:59 +0530
Subject: [PATCH] ppc64/book3s: export mmu type info
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 22 Sep 2016 16:10:27 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <147454082746.29894.18039461805068392404.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel now supports both radix and hash MMU modes. Tools like crash
and makedumpfile need to know, the current MMU mode the kernel is using
to debug/analyze the kernel. The current MMU mode depends on H/W support
and also whether disable_radix cmdline parameter is passed to the kernel.
The mmu_features member of cpu_spec structure holds the current MMU mode
a cpu is using. But the above mentioned tools need to know, the MMU mode
early in their init process when they have no access to offset info of
structure members. A hard-coded offset may help but it won't be robust.

This patch introduces a new global variable, which holds the current MMU
mode the kernel is running in and can be accessed by tools early in thier
init process, helping tools to initialize accurately for each MMU mode.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h     |    5 +++++
 arch/powerpc/include/asm/book3s/64/pgtable.h |    6 ++++++
 arch/powerpc/kernel/machine_kexec.c          |    3 +++
 arch/powerpc/mm/hash_utils_64.c              |    2 ++
 arch/powerpc/mm/pgtable-radix.c              |    2 ++
 arch/powerpc/mm/pgtable_64.c                 |    6 ++++++
 6 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 8afb0e0..af68df3 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -30,6 +30,11 @@ extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
 #ifndef __ASSEMBLY__
 /*
+ * current MMU mode
+ */
+extern unsigned int current_mmu_mode;
+
+/*
  * ISA 3.0 partiton and process table entry format
  */
 struct prtb_entry {
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 263bf39..f7faebd 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -2,6 +2,12 @@
 #define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 
 /*
+ * Possible MMU modes
+ */
+#define HASH_MMU_MODE		0
+#define RADIX_MMU_MODE		1
+
+/*
  * Common bits between hash and Radix page table
  */
 #define _PAGE_BIT_SWAP_TYPE	0
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 2694d07..4ecc184 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -77,6 +77,9 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
+#ifdef CONFIG_PPC_BOOK3S
+	VMCOREINFO_SYMBOL(current_mmu_mode);
+#endif
 	VMCOREINFO_SYMBOL(vmemmap_list);
 	VMCOREINFO_SYMBOL(mmu_vmemmap_psize);
 	VMCOREINFO_SYMBOL(mmu_psize_defs);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556..3c7855a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -886,6 +886,8 @@ void __init hash__early_init_devtree(void)
 
 void __init hash__early_init_mmu(void)
 {
+	current_mmu_mode = HASH_MMU_MODE;
+
 	htab_init_page_sizes();
 
 	/*
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index af897d9..98fbc97 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -298,6 +298,8 @@ void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
 
+	current_mmu_mode = RADIX_MMU_MODE;
+
 #ifdef CONFIG_PPC_64K_PAGES
 	/* PAGE_SIZE mappings */
 	mmu_virtual_psize = MMU_PAGE_64K;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index f5e8d4e..04319ac 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -63,6 +63,12 @@
 
 #ifdef CONFIG_PPC_BOOK3S_64
 /*
+ * current MMU mode
+ */
+unsigned int current_mmu_mode;
+EXPORT_SYMBOL(current_mmu_mode);
+
+/*
  * partition table and process table for ISA 3.0
  */
 struct prtb_entry *process_tb;
