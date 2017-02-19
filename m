Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2WK26QPzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:07:41 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA3dAx100501
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:07:38 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28pk9p45qj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:07:38 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 03:07:37 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 00/10] powerpc/mm/ppc64: Add 128TB support
Date: Sun, 19 Feb 2017 15:37:07 +0530
Message-Id: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series increase the effective virtual address range of
applications from 64TB to 128TB. We do that by supporting a 
68 bit virtual address. On platforms that can only do 65 bit virtual
address we limit the max contexts to a 16bit value instead of 19.

The patch series also switch the page table layout such that we can
do 512TB effective address. But we still limit the TASK_SIZE to
128TB. This was done to make sure we don't break applications
that make assumption regarding the max address returned by the
OS. We can switch to 128TB without a linux personality value because
other architectures do 128TB as max address.

Changes from V2:
* Handle hugepage size correctly.

Aneesh Kumar K.V (10):
  powerpc/mm/slice: Convert slice_mask high slice to a bitmap
  powerpc/mm/slice: Update the function prototype
  powerpc/mm/hash: Move kernel context to the starting of context range
  powerpc/mm/hash: Support 68 bit VA
  powerpc/mm: Move copy_mm_to_paca to paca.c
  powerpc/mm: Remove redundant TASK_SIZE_USER64 checks
  powerpc/mm/slice: Use mm task_size as max value of slice index
  powerpc/mm/hash: Increase VA range to 128TB
  powerpc/mm/slice: Move slice_mask struct definition to slice.c
  powerpc/mm/slice: Update slice mask printing to use bitmap printing.

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   2 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 160 ++++++++++++---------
 arch/powerpc/include/asm/mmu.h                |  19 ++-
 arch/powerpc/include/asm/mmu_context.h        |   2 +-
 arch/powerpc/include/asm/paca.h               |  18 +--
 arch/powerpc/include/asm/page_64.h            |  14 --
 arch/powerpc/include/asm/processor.h          |  22 ++-
 arch/powerpc/kernel/paca.c                    |  26 ++++
 arch/powerpc/kvm/book3s_64_mmu_host.c         |  10 +-
 arch/powerpc/mm/hash_utils_64.c               |   9 +-
 arch/powerpc/mm/init_64.c                     |   4 -
 arch/powerpc/mm/mmu_context_book3s64.c        |  96 +++++++++----
 arch/powerpc/mm/pgtable_64.c                  |   5 -
 arch/powerpc/mm/slb.c                         |   2 +-
 arch/powerpc/mm/slb_low.S                     |  74 ++++++----
 arch/powerpc/mm/slice.c                       | 195 +++++++++++++++-----------
 17 files changed, 394 insertions(+), 266 deletions(-)

-- 
2.7.4
