Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdLzw07PxzDt0f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 01:04:27 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBDDxUBX043170
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 09:04:25 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27afmmg7ge-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 09:04:25 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 09:04:24 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Chris Smart <csmart@ozlabs.au.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hugetlb: Don't panic if we don't find the default
 huge page size
Date: Tue, 13 Dec 2016 19:34:11 +0530
Message-Id: <20161213140411.20633-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

generic hugetlbfs can handle that condition correctly. With HPAGE_SHIFT = 0
we get
[0.241333] hugetlbfs: disabling because there are no supported hugepage sizes

bash-4.2# echo 30 > /proc/sys/vm/nr_hugepages
bash: echo: write error: Operation not supported

Fixes: "powerpc: get hugetlbpage handling more generic"
Reported-by: Chris Smart <csmart@ozlabs.au.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 289df38fb7e0..e46bbd716832 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -852,9 +852,6 @@ static int __init hugetlbpage_init(void)
 	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
 		HPAGE_SHIFT = mmu_psize_defs[MMU_PAGE_2M].shift;
 #endif
-	else
-		panic("%s: Unable to set default huge page size\n", __func__);
-
 	return 0;
 }
 
-- 
2.10.2
