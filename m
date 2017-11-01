Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRkgG65K4zDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 21:17:46 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA1AGYhg120499
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Nov 2017 06:17:44 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dycb28763-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 06:17:43 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 1 Nov 2017 10:17:41 -0000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Subject: [RFC 0/2] Enable ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH on POWER
Date: Wed,  1 Nov 2017 15:47:33 +0530
Message-Id: <20171101101735.2318-1-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <Khandual@linux.vnet.ibm.com>

Batched TLB flush during reclaim path has been around for couple of years
now and been enabled on X86 platform. The idea is to batch multiple page
TLB invalidation requests together and flush all those CPUs completely
who might have the TLB cache for any of the unmapped pages instead of just
sending multiple IPIs and flushing out individual pages each time reclaim
unmaps one page. This has the potential to improve performance for certain
types of workloads under memory pressure provided some conditions related
to individual page TLB invalidation, CPU wide TLB invalidation, system
wide TLB invalidation, TLB reload, IPI costs etc are met.

Please refer the commit 72b252aed5 ("mm: send one IPI per CPU to TLB flush
all entries after unmapping pages") from Mel Gorman for more details on
how it can impact the performance for various workloads. This enablement
improves performance for the original test case 'case-lru-file-mmap-read'
from vm-scallability bucket but only from system time perspective.

time ./run case-lru-file-mmap-read

Without the patch:

real    4m20.364s
user    102m52.492s
sys     433m26.190s

With the patch:

real    4m15.942s	(-  1.69%)
user    111m16.662s	(+  7.55%)
sys     382m35.202s	(- 11.73%)

Parallel kernel compilation does not see any performance improvement or
degradation with and with out this patch. It remains within margin of
error.

Without the patch:

real    1m13.850s
user    39m21.803s
sys     2m43.362s

With the patch:

real    1m14.481s	(+ 0.85%)
user    39m27.409s	(+ 0.23%)
sys     2m44.656s	(+ 0.79%)

It batches up multiple struct mm during reclaim and keeps on accumulating
the superset of struct mm's cpu mask who might have a TLB which needs to
be invalidated. Then local struct mm wide invalidation is performance on
the cpu mask for all those batched ones. Please do the review and let me
know if there is any other way to do this better. Thank you.

Anshuman Khandual (2):
  mm/tlbbatch: Introduce arch_tlbbatch_should_defer()
  powerpc/mm: Enable deferred flushing of TLB during reclaim

 arch/powerpc/Kconfig                |  1 +
 arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++
 arch/powerpc/include/asm/tlbflush.h |  3 +++
 arch/powerpc/mm/tlb-radix.c         | 49 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tlbflush.h     | 12 +++++++++
 mm/rmap.c                           |  9 +------
 6 files changed, 96 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/tlbbatch.h

-- 
1.8.3.1
