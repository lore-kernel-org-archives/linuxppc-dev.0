Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQLTC53gNzDvx0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 03:03:11 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAPFwhkm116848
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:09 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26xj5gu02c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:08 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 09:03:07 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v6 0/7] Radix pte update tlbflush optimizations.
Date: Fri, 25 Nov 2016 21:32:50 +0530
Message-Id: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes from V5:
Switch to use pte bits to track page size.

Aneesh Kumar K.V (7):
  powerpc/mm: Rename hugetlb-radix.h to hugetlb.h
  powerpc/mm/hugetlb: Handle hugepage size supported by hash config
  powerpc/mm: Introduce _PAGE_GIGANTIC and _PAGE_LARGE software pte bits
  powerpc/mm: Add radix__tlb_flush_pte
  powerpc/mm: update radix__ptep_set_access_flag to not do full mm tlb
    flush
  powerpc/mm: update radix__pte_update to not do full mm tlb flush
  powerpc/mm: Batch tlb flush when invalidating pte entries

 arch/powerpc/include/asm/book3s/32/pgtable.h       |  3 ++-
 .../asm/book3s/64/{hugetlb-radix.h => hugetlb.h}   | 21 ++++++++++++++--
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 15 ++++++++++--
 arch/powerpc/include/asm/book3s/64/radix.h         | 28 ++++++++++------------
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 ++
 arch/powerpc/include/asm/hugetlb.h                 |  2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  3 ++-
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  3 ++-
 arch/powerpc/mm/pgtable-book3s64.c                 |  3 ++-
 arch/powerpc/mm/pgtable.c                          |  2 +-
 arch/powerpc/mm/tlb-radix.c                        | 11 +++++++++
 11 files changed, 67 insertions(+), 26 deletions(-)
 rename arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} (55%)

-- 
2.10.2
