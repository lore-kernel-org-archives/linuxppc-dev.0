Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRsSy4xPnzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 19:23:46 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G9Nc8A149728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:23:41 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2afr988qt2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:23:41 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 May 2017 03:23:39 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 0/9] HugeTLB migration support for PPC64
Date: Tue, 16 May 2017 14:53:23 +0530
Message-Id: <1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HugeTLB migration support for PPC64

Changes from V1:
* Added Reviewed-by:
* Drop follow_huge_addr from powerpc

Aneesh Kumar K.V (8):
  mm/hugetlb/migration: Use set_huge_pte_at instead of set_pte_at
  mm/follow_page_mask: Split follow_page_mask to smaller functions.
  mm/hugetlb: export hugetlb_entry_migration helper
  mm/hugetlb: Move default definition of hugepd_t earlier in the header
  mm/follow_page_mask: Add support for hugepage directory entry
  powerpc/hugetlb: Add follow_huge_pd implementation for ppc64.
  powerpc/mm/hugetlb: Remove follow_huge_addr for powerpc
  powerpc/hugetlb: Enable hugetlb migration for ppc64

Anshuman Khandual (1):
  mm/follow_page_mask: Add support for hugetlb pgd entries.

 arch/powerpc/mm/hugetlbpage.c          |  81 ++++++--------
 arch/powerpc/platforms/Kconfig.cputype |   5 +
 include/linux/hugetlb.h                |  56 ++++++----
 mm/gup.c                               | 186 +++++++++++++++++++++++----------
 mm/hugetlb.c                           |  25 ++++-
 mm/migrate.c                           |  21 ++--
 6 files changed, 230 insertions(+), 144 deletions(-)

-- 
2.7.4
