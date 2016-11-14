Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHYrx10vFzDvd4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 02:11:44 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEF4a0F113980
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 10:11:42 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qdekf171-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 10:11:42 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 08:11:41 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 2/4] powerpc/mm: Rename hugetlb-radix.h to hugetlb.h
Date: Mon, 14 Nov 2016 20:41:26 +0530
In-Reply-To: <20161114151128.2146-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161114151128.2146-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161114151128.2146-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will start moving some book3s specific hugetlb functions there.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} | 8 ++++++--
 arch/powerpc/include/asm/hugetlb.h                                | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)
 rename arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} (78%)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
similarity index 78%
rename from arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
rename to arch/powerpc/include/asm/book3s/64/hugetlb.h
index c45189aa7476..d9c283f95e05 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
-#define _ASM_POWERPC_BOOK3S_64_HUGETLB_RADIX_H
+#ifndef _ASM_POWERPC_BOOK3S_64_HUGETLB_H
+#define _ASM_POWERPC_BOOK3S_64_HUGETLB_H
 /*
  * For radix we want generic code to handle hugetlb. But then if we want
  * both hash and radix to be enabled together we need to workaround the
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
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index c5517f463ec7..c03e0a3dd4d8 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -9,7 +9,7 @@ extern struct kmem_cache *hugepte_cache;
 
 #ifdef CONFIG_PPC_BOOK3S_64
 
-#include <asm/book3s/64/hugetlb-radix.h>
+#include <asm/book3s/64/hugetlb.h>
 /*
  * This should work for other subarchs too. But right now we use the
  * new format only for 64bit book3s
-- 
2.10.2
