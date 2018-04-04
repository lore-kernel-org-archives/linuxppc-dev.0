Return-Path: <srs0=3oul=gz=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GXcY2HHFzF1sg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 03:14:05 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40GXcX6t5Vz8sy5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 03:14:04 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40GXcX2kHlz9rxs
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2018 03:14:04 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w34HDscE022760
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2018 13:14:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h52x0802c-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2018 13:14:02 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 4 Apr 2018 18:14:00 +0100
Subject: [PATCH 2/2] powerpc/fadump: Do not use hugepages when fadump is active
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 04 Apr 2018 22:43:54 +0530
In-Reply-To: <152286202560.2738.7385812464895685351.stgit@hbathini.in.ibm.com>
References: <152286202560.2738.7385812464895685351.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152286203493.2738.5640751706531312099.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FADump capture kernel boots in a restricted memory environment saving the
context of previous kernel to capture vmcore. Having hugepages support in
such environment would make things unnecessarily complicated, as hugepages
need memory set aside for them and this would mean too much memory wasted
in supporting hugepages in capture kernel. Also, if there is a shortfall
in memory, capture kernel fails to boot. So, disable hugepages when fadump
is active to avoid boot issues in FADump capture kernel.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |   11 +++++++++--
 arch/powerpc/mm/hugetlbpage.c   |   11 +++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index cf290d41..703cde2 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -571,8 +571,15 @@ static void __init htab_scan_page_sizes(void)
 	}
 
 #ifdef CONFIG_HUGETLB_PAGE
-	/* Reserve 16G huge page memory sections for huge pages */
-	of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
+	/*
+	 * FADump capture kernel doesn't care much about hugepages.
+	 * Moreover, handling hugepages in capture kernel is asking
+	 * for trouble. So, skip this when fadump is active.
+	 */
+	if (!is_fadump_active()) {
+		/* Reserve 16G huge page memory sections for huge pages */
+		of_scan_flat_dt(htab_dt_scan_hugepage_blocks, NULL);
+	}
 #endif /* CONFIG_HUGETLB_PAGE */
 }
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 876da2b..3d47fb6 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -23,6 +23,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/setup.h>
+#include <asm/fadump.h>
 #include <asm/hugetlb.h>
 #include <asm/pte-walk.h>
 
@@ -653,6 +654,16 @@ static int __init hugetlbpage_init(void)
 {
 	int psize;
 
+	/*
+	 * FADump capture kernel doesn't care much about hugepages.
+	 * Moreover, handling hugepages in capture kernel is asking
+	 * for trouble. So, skip this when fadump is active.
+	 */
+	if (is_fadump_active()) {
+		pr_info("Huge pages are not supported when fadump is active\n");
+		return 0;
+	}
+
 #if !defined(CONFIG_PPC_FSL_BOOK3E) && !defined(CONFIG_PPC_8xx)
 	if (!radix_enabled() && !mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
