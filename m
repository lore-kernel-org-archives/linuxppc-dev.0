Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JdZM1N4JzF13T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 19:04:58 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O91SOR075584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 05:04:56 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mpumg37sh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 05:04:56 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 24 Sep 2018 03:04:55 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 0/5] NestMMU pte upgrade workaround for mprotect and
 autonuma
Date: Mon, 24 Sep 2018 14:34:13 +0530
Message-Id: <20180924090418.31282-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can upgrade pte access (R -> RW transition) via mprotect or autonuma. We need
to make sure we follow the recommended pte update sequence as outlined in
commit: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
for such updates. This patch series do that.

-aneesh


Aneesh Kumar K.V (5):
  mm: Update ptep_modify_prot_start/commit to take vm_area_struct as arg
  mm: update ptep_modify_prot_commit to take old pte value as arg
  arch/powerpc/mm: Nest MMU workaround for mprotect/autonuma RW upgrade.
  mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
  arch/powerpc/mm/hugetlb: NestMMU workaround for hugetlb mprotect RW
    upgrade

 arch/powerpc/include/asm/book3s/64/hugetlb.h |  8 +++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++
 arch/powerpc/include/asm/hugetlb.h           |  2 +-
 arch/powerpc/mm/hugetlbpage.c                | 35 ++++++++++++++++++++
 arch/powerpc/mm/pgtable-book3s64.c           | 34 +++++++++++++++++++
 arch/s390/include/asm/pgtable.h              |  5 +--
 arch/s390/mm/pgtable.c                       |  8 +++--
 arch/x86/include/asm/paravirt.h              |  9 +++--
 fs/proc/task_mmu.c                           |  8 +++--
 include/asm-generic/pgtable.h                | 10 +++---
 include/linux/hugetlb.h                      | 18 ++++++++++
 mm/hugetlb.c                                 |  8 +++--
 mm/memory.c                                  |  8 ++---
 mm/mprotect.c                                |  6 ++--
 14 files changed, 150 insertions(+), 27 deletions(-)

-- 
2.17.1
