Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymH635hj1zDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 19:34:51 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAS8YnDT083565
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 03:34:49 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eh1f7f3dr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 03:34:49 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 03:34:47 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/hash: Skip non initialized page size in
 init_hpte_page_sizes
Date: Tue, 28 Nov 2017 14:04:40 +0530
Message-Id: <20171128083440.18688-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One of the easiest way to test config with 4K HPTE is to disable 64K hardware
page size like below.

int __init htab_dt_scan_page_sizes(unsigned long node,

 		size -= 3; prop += 3;
 		base_idx = get_idx_from_shift(base_shift);
-		if (base_idx < 0) {
+		if (base_idx < 0 || base_idx == MMU_PAGE_64K) {
 			/* skip the pte encoding also */
 			prop += lpnum * 2; size -= lpnum * 2;

But then this results in error in other part of the code such as MPSS parsing
where we look at 4K base page size and 64K actual page size support.

This patch fix MPSS parsing by ignoring the actual page sizes marked
unsupported. In reality this can happen only with a corrupt device tree. But it
is good to tighten the error check.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index e700660459c4..2ae18ff91390 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -601,7 +601,7 @@ static void init_hpte_page_sizes(void)
 			continue;	/* not a supported page size */
 		for (ap = bp; ap < MMU_PAGE_COUNT; ++ap) {
 			penc = mmu_psize_defs[bp].penc[ap];
-			if (penc == -1)
+			if (penc == -1 || !mmu_psize_defs[ap].shift)
 				continue;
 			shift = mmu_psize_defs[ap].shift - LP_SHIFT;
 			if (shift <= 0)
-- 
2.14.3
