Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmND16HYzF1vK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:28:27 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBNEoT061726
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:24 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hcs5unf48-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:28:24 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:28:23 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 11/11] powerpc/book3s64: Enable split pmd ptlock.
Date: Mon, 16 Apr 2018 16:57:24 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-13-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Testing with a threaded version of mmap_bench which allocate 1G chunks and
with large number of threads we find:

without patch

    32.72%  mmap_bench  [kernel.vmlinux]            [k] do_raw_spin_lock
            |
            ---do_raw_spin_lock
               |
                --32.68%--0
                          |
                          |--15.82%--pte_fragment_alloc
                          |          |
                          |           --15.79%--do_huge_pmd_anonymous_page
                          |                     __handle_mm_fault
                          |                     handle_mm_fault
                          |                     __do_page_fault
                          |                     handle_page_fault
                          |                     test_mmap
                          |                     test_mmap
                          |                     start_thread
                          |                     __clone
                          |
                          |--14.95%--do_huge_pmd_anonymous_page
                          |          __handle_mm_fault
                          |          handle_mm_fault
                          |          __do_page_fault
                          |          handle_page_fault
                          |          test_mmap
                          |          test_mmap
                          |          start_thread
                          |          __clone
                          |

with patch

    12.89%  mmap_bench  [kernel.vmlinux]            [k] do_raw_spin_lock
            |
            ---do_raw_spin_lock
               |
                --12.83%--0
                          |
                          |--3.21%--pagevec_lru_move_fn
                          |          __lru_cache_add
                          |          |
                          |           --2.74%--do_huge_pmd_anonymous_page
                          |                     __handle_mm_fault
                          |                     handle_mm_fault
                          |                     __do_page_fault
                          |                     handle_page_fault
                          |                     test_mmap
                          |                     test_mmap
                          |                     start_thread
                          |                     __clone
                          |
                          |--3.11%--do_huge_pmd_anonymous_page
                          |          __handle_mm_fault
                          |          handle_mm_fault
                          |          __do_page_fault
                          |          handle_page_fault
                          |          test_mmap
                          |          test_mmap
                          |          start_thread
                          |          __clone

.....
                          |
                           --0.55%--pte_fragment_alloc
                                     |
                                      --0.55%--do_huge_pmd_anonymous_page
                                                __handle_mm_fault
                                                handle_mm_fault
                                                __do_page_fault
                                                handle_page_fault
                                                test_mmap
                                                test_mmap
                                                start_thread
                                                __clone

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/Kconfig.cputype | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 67d3125d0610..cc892dcfa114 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -292,6 +292,10 @@ config PPC_STD_MMU_32
 	def_bool y
 	depends on PPC_STD_MMU && PPC32
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y
+	depends on PPC_BOOK3S_64
+
 config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
-- 
2.14.3
