Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6FDn0zGVzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 03:12:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3HH91WY120905
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:12:06 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29w0p637jj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 13:12:06 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 13:12:05 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 0/7] HugeTLB migration support for PPC64
Date: Mon, 17 Apr 2017 22:41:39 +0530
Message-Id: <1492449106-27467-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series add support for hugetlb page migration.

Aneesh Kumar K.V (6):
  mm/hugetlb/migration: Use set_huge_pte_at instead of set_pte_at
  mm/follow_page_mask: Split follow_page_mask to smaller functions.
  mm/hugetlb: export hugetlb_entry_migration helper
  mm/follow_page_mask: Add support for hugepage directory entry
  powerpc/hugetlb: Add follow_huge_pd implementation for ppc64.
  powerpc/hugetlb: Enable hugetlb migration for ppc64

Anshuman Khandual (1):
  mm/follow_page_mask: Add support for hugetlb pgd entries.

 arch/powerpc/mm/hugetlbpage.c          |  43 ++++++++
 arch/powerpc/platforms/Kconfig.cputype |   5 +
 include/linux/hugetlb.h                |   9 ++
 mm/gup.c                               | 186 +++++++++++++++++++++++----------
 mm/hugetlb.c                           |  25 ++++-
 mm/migrate.c                           |  21 ++--
 6 files changed, 219 insertions(+), 70 deletions(-)

-- 
2.7.4
