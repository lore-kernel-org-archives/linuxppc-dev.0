Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2mc0qPPzDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:19:11 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA8ro0100903
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:19:09 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28pk54d0u8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:19:02 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 05:19:02 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hugetlb: Filter out hugepage size not supported by
 page table layout
Date: Sun, 19 Feb 2017 15:48:47 +0530
Message-Id: <1487499527-16166-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Without this if firmware reports 1MB page size support we will crash
trying to use 1MB as hugetlb page size.

echo 300 > /sys/kernel/mm/hugepages/hugepages-1024kB/nr_hugepages

kernel BUG at ./arch/powerpc/include/asm/hugetlb.h:19!
.....
....
[c0000000e2c27b30] c00000000029dae8 .hugetlb_fault+0x638/0xda0
[c0000000e2c27c30] c00000000026fb64 .handle_mm_fault+0x844/0x1d70
[c0000000e2c27d70] c00000000004805c .do_page_fault+0x3dc/0x7c0
[c0000000e2c27e30] c00000000000ac98 handle_page_fault+0x10/0x30

With fix, we don't enable 1MB as hugepage size.

bash-4.2# cd /sys/kernel/mm/hugepages/
bash-4.2# ls
hugepages-16384kB  hugepages-16777216kB

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 8c3389cbcd12..a4f33de4008e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -753,6 +753,24 @@ static int __init add_huge_page_size(unsigned long long size)
 	if ((mmu_psize = shift_to_mmu_psize(shift)) < 0)
 		return -EINVAL;
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/*
+	 * We need to make sure that for different page sizes reported by
+	 * firmware we only add hugetlb support for page sizes that can be
+	 * supported by linux page table layout.
+	 * For now we have
+	 * Radix: 2M
+	 * Hash: 16M and 16G
+	 */
+	if (radix_enabled()) {
+		if (mmu_psize != MMU_PAGE_2M)
+			return -EINVAL;
+	} else {
+		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
+			return -EINVAL;
+	}
+#endif
+
 	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
 
 	/* Return if huge page size has already been setup */
-- 
2.7.4
