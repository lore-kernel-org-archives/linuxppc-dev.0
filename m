Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGCbb0HZpzDqxk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 17:26:18 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6O7OBXF130793
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 03:26:17 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bw86cqx54-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 03:26:16 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 24 Jul 2017 03:26:15 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Disable registering 16G hugepage size for powernv
 platform
Date: Mon, 24 Jul 2017 12:56:07 +0530
Message-Id: <1500881167-9389-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't support allocating them runtime. Only supported mechanism as of now is
HMC based hypervisor interface. So disable 16G hugetlb on powernv platform

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

May be this should go to -stable ?. To show the 16G pagesize in
/sys/kernel/mm/hugepages/ confuse users

 arch/powerpc/mm/hugetlbpage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e1bf5ca397fe..28ea94da0707 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -24,6 +24,7 @@
 #include <asm/tlb.h>
 #include <asm/setup.h>
 #include <asm/hugetlb.h>
+#include <asm/machdep.h>
 
 #ifdef CONFIG_HUGETLB_PAGE
 
@@ -749,7 +750,8 @@ static int __init add_huge_page_size(unsigned long long size)
 				return -EINVAL;
 		}
 	} else {
-		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
+		if ((mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
+		    || (mmu_psize == MMU_PAGE_16G && machine_is(powernv)))
 			return -EINVAL;
 	}
 #endif
-- 
2.7.4
