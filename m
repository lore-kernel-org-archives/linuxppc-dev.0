Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzr0f4PkfzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 16:54:26 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v376sLxM135731
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 02:54:24 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29p20tjtw5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 02:54:23 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 16:54:11 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v376s2MB26017818
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 16:54:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v376rTTH030182
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 16:53:29 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH] powerpc/mm: Remove reduntant initmem information from log
Date: Fri,  7 Apr 2017 12:23:11 +0530
Message-Id: <20170407065311.8599-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Generic core VM already prints these information in the log
buffer, hence there is no need for a second print. This just
removes the second print from arch powerpc NUMA init path.

Before the patch:

$dmesg | grep "Initmem"

numa: Initmem setup node 0 [mem 0x00000000-0xffffffff]
numa: Initmem setup node 1 [mem 0x100000000-0x1ffffffff]
numa: Initmem setup node 2 [mem 0x200000000-0x2ffffffff]
numa: Initmem setup node 3 [mem 0x300000000-0x3ffffffff]
numa: Initmem setup node 4 [mem 0x400000000-0x4ffffffff]
numa: Initmem setup node 5 [mem 0x500000000-0x5ffffffff]
numa: Initmem setup node 6 [mem 0x600000000-0x6ffffffff]
numa: Initmem setup node 7 [mem 0x700000000-0x7ffffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
Initmem setup node 1 [mem 0x0000000100000000-0x00000001ffffffff]
Initmem setup node 2 [mem 0x0000000200000000-0x00000002ffffffff]
Initmem setup node 3 [mem 0x0000000300000000-0x00000003ffffffff]
Initmem setup node 4 [mem 0x0000000400000000-0x00000004ffffffff]
Initmem setup node 5 [mem 0x0000000500000000-0x00000005ffffffff]
Initmem setup node 6 [mem 0x0000000600000000-0x00000006ffffffff]
Initmem setup node 7 [mem 0x0000000700000000-0x00000007ffffffff]

After the patch:

$dmesg | grep "Initmem"

Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
Initmem setup node 1 [mem 0x0000000100000000-0x00000001ffffffff]
Initmem setup node 2 [mem 0x0000000200000000-0x00000002ffffffff]
Initmem setup node 3 [mem 0x0000000300000000-0x00000003ffffffff]
Initmem setup node 4 [mem 0x0000000400000000-0x00000004ffffffff]
Initmem setup node 5 [mem 0x0000000500000000-0x00000005ffffffff]
Initmem setup node 6 [mem 0x0000000600000000-0x00000006ffffffff]
Initmem setup node 7 [mem 0x0000000700000000-0x00000007ffffffff]

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Generic core VM prints the information inside free_area_init_node
function but only when CONFIG_HAVE_MEMBLOCK_NODE_MAP is enabled.
So if there are other PPC platforms which dont enable the config,
we can put the code section inside applicable platform configs
instead of removing it completely.

 arch/powerpc/mm/numa.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 9befaee..371792e 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -875,13 +875,6 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	void *nd;
 	int tnid;
 
-	if (spanned_pages)
-		pr_info("Initmem setup node %d [mem %#010Lx-%#010Lx]\n",
-			nid, start_pfn << PAGE_SHIFT,
-			(end_pfn << PAGE_SHIFT) - 1);
-	else
-		pr_info("Initmem setup node %d\n", nid);
-
 	nd_pa = memblock_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
 	nd = __va(nd_pa);
 
-- 
1.8.3.1
