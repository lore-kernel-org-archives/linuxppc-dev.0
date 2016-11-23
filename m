Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP04H3fcSzDw3p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 22:10:23 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uANB8teS138754
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:10:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26w6ybjepr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:10:20 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 04:10:19 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v5 3/7] powerpc/mm/hugetlb: Handle hugepage size supported by
 hash config
Date: Wed, 23 Nov 2016 16:39:59 +0530
In-Reply-To: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161123111003.459-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

W.r.t hash page table config, we support 16MB and 16GB as the hugepage
size. Update the hstate_get_psize to handle 16M and 16G.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 499268045306..d9c283f95e05 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -21,6 +21,10 @@ static inline int hstate_get_psize(struct hstate *hstate)
 		return MMU_PAGE_2M;
 	else if (shift == mmu_psize_defs[MMU_PAGE_1G].shift)
 		return MMU_PAGE_1G;
+	else if (shift == mmu_psize_defs[MMU_PAGE_16M].shift)
+		return MMU_PAGE_16M;
+	else if (shift == mmu_psize_defs[MMU_PAGE_16G].shift)
+		return MMU_PAGE_16G;
 	else {
 		WARN(1, "Wrong huge page shift\n");
 		return mmu_virtual_psize;
-- 
2.10.2
