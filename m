Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4242T60wfpzF36V
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 07:01:45 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w83GYErk041672
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 12:38:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m97fatppy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 12:38:24 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 3 Sep 2018 12:38:23 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 0/3] Add support for compound page migration in
 mm_iommu_get
Date: Mon,  3 Sep 2018 22:07:30 +0530
Message-Id: <20180903163733.27965-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series add support for migrating compound pages if we find them in the
CMA area before taking long term page reference for VFIO.

Testing:
* TODO: test with hugetlb backed guest ram.
* Testing done with a code change as below

-		if (is_migrate_cma_page(pages[i]) && migrate_allow) {
+		if (migrate_allow) {

...
+	migrate_allow = false;


Aneesh Kumar K.V (3):
  mm: Export alloc_migrate_huge_page
  powerpc/mm/iommu: Allow large IOMMU page size only for hugetlb backing
  powerpc/mm/iommu: Allow migration of cma allocated pages during
    mm_iommu_get

 arch/powerpc/mm/mmu_context_iommu.c | 209 +++++++++++++++++-----------
 include/linux/hugetlb.h             |   2 +
 mm/hugetlb.c                        |   4 +-
 3 files changed, 128 insertions(+), 87 deletions(-)

-- 
2.17.1
