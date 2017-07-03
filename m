Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1Jjb1yZHzDr4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 17:31:46 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v637Sg8X073623
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 03:31:44 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bf1f245g1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 03:31:43 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 3 Jul 2017 17:31:41 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v637VcPU60555458
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 17:31:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v637VTci022136
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jul 2017 17:31:29 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH] powerpc/mm: Check gigantic page range correctly inside
 memblock
Date: Mon,  3 Jul 2017 13:01:30 +0530
Message-Id: <20170703073130.27258-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The gigantic page range received from platform actually extends
upto (block_size * expeted_pages) starting at any given address
instead of just a single 16GB page.

Fixes: 4792adbac9eb ("powerpc: Don't use a 16G page if beyond mem= limits")
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Though in actual experiments never seen multiple gigantic pages (16GB)
starting at the same address. But again its very much possible looking
at the device tree property interfaces and depending upon what PowerVM
provides.

 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f2095ce..a3f1e7d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -507,7 +507,7 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
 	printk(KERN_INFO "Huge page(16GB) memory: "
 			"addr = 0x%lX size = 0x%lX pages = %d\n",
 			phys_addr, block_size, expected_pages);
-	if (phys_addr + (16 * GB) <= memblock_end_of_DRAM()) {
+	if (phys_addr + block_size * expected_pages <= memblock_end_of_DRAM()) {
 		memblock_reserve(phys_addr, block_size * expected_pages);
 		add_gpage(phys_addr, block_size, expected_pages);
 	}
-- 
1.8.5.6
