Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRsVY24MPzDqcm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 19:25:09 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G9NrKt127434
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:25:03 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afs4senm4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:25:03 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 May 2017 03:25:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hugetlb: Add support for reserving gigantic huge
 pages via kernel command line
Date: Tue, 16 May 2017 14:54:51 +0530
Message-Id: <1494926691-24664-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use the kernel command line to do reservation of hugetlb pages. The code
duplcation here is mostly to make it simpler. With 64 bit book3s, we need to
support either 16G or 1G gigantic hugepage. Whereas the FSL_BOOK3E
implementation needs to support multiple gigantic hugepage. We avoid the
gpage_npages array and use a gpage_npage count for ppc64. We also cannot use the
generic code to do the gigantic page allocation because that will require
conditonal to handle the pseries allocation, where the memory is already
reserved by the hypervisor.

Inorder to keep it simpler, book3s 64 implements a version that keeps it simpler
and working with pseries.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hugetlb.h |  8 +---
 arch/powerpc/mm/hugetlbpage.c      | 78 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 7f4025a6c69e..03401a17d1da 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -218,13 +218,7 @@ static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
-/*
- * FSL Book3E platforms require special gpage handling - the gpages
- * are reserved early in the boot process by memblock instead of via
- * the .dts as on IBM platforms.
- */
-#if defined(CONFIG_HUGETLB_PAGE) && (defined(CONFIG_PPC_FSL_BOOK3E) || \
-    defined(CONFIG_PPC_8xx))
+#ifdef CONFIG_HUGETLB_PAGE
 extern void __init reserve_hugetlb_gpages(void);
 #else
 static inline void reserve_hugetlb_gpages(void)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 1816b965a142..4ebaa18f2495 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/string_helpers.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -373,6 +374,83 @@ int alloc_bootmem_huge_page(struct hstate *hstate)
 	m->hstate = hstate;
 	return 1;
 }
+
+static unsigned long gpage_npages;
+static int __init do_gpage_early_setup(char *param, char *val,
+				       const char *unused, void *arg)
+{
+	unsigned long npages;
+	static unsigned long size = 0;
+	unsigned long gpage_size = 1UL << 34;
+
+	if (radix_enabled())
+		gpage_size = 1UL << 30;
+
+	/*
+	 * The hugepagesz and hugepages cmdline options are interleaved.  We
+	 * use the size variable to keep track of whether or not this was done
+	 * properly and skip over instances where it is incorrect.  Other
+	 * command-line parsing code will issue warnings, so we don't need to.
+	 *
+	 */
+	if ((strcmp(param, "default_hugepagesz") == 0) ||
+	    (strcmp(param, "hugepagesz") == 0)) {
+		size = memparse(val, NULL);
+		/*
+		 * We want to handle on 16GB gigantic huge page here.
+		 */
+		if (size != gpage_size)
+			size = 0;
+	} else if (strcmp(param, "hugepages") == 0) {
+		if (size != 0) {
+			if (sscanf(val, "%lu", &npages) <= 0)
+				npages = 0;
+			if (npages > MAX_NUMBER_GPAGES) {
+				pr_warn("MMU: %lu 16GB pages requested, "
+					"limiting to %d pages\n", npages,
+					MAX_NUMBER_GPAGES);
+				npages = MAX_NUMBER_GPAGES;
+			}
+			gpage_npages = npages;
+			size = 0;
+		}
+	}
+	return 0;
+}
+
+/*
+ * This will just do the necessary memblock reservations. Every else is
+ * done by core, based on kernel command line parsing.
+ */
+void __init reserve_hugetlb_gpages(void)
+{
+	char buf[10];
+	phys_addr_t base;
+	unsigned long gpage_size = 1UL << 34;
+	static __initdata char cmdline[COMMAND_LINE_SIZE];
+
+	if (radix_enabled())
+		gpage_size = 1UL << 30;
+
+	strlcpy(cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	parse_args("hugetlb gpages", cmdline, NULL, 0, 0, 0,
+		   NULL, &do_gpage_early_setup);
+
+	if (!gpage_npages)
+		return;
+
+	string_get_size(gpage_size, 1, STRING_UNITS_2, buf, sizeof(buf));
+	pr_info("Trying to reserve %ld %s pages\n", gpage_npages, buf);
+
+	/* Allocate one page at a time */
+	while(gpage_npages) {
+		base = memblock_alloc_base(gpage_size, gpage_size,
+					   MEMBLOCK_ALLOC_ANYWHERE);
+		add_gpage(base, gpage_size, 1);
+		gpage_npages--;
+	}
+}
+
 #endif
 
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
-- 
2.7.4
