Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNBlj5wqBzDrgY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:08:01 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7TD4SfE005860
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 09:08:00 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2537cwx18h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 09:07:59 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 23:07:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7CBEE3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:07:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7TD7sbE7078296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:07:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7TD7rYT013194
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 23:07:54 +1000
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Dave Hansen <dave.hansen@intel.com>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 2/3] mm/memblock: Expose total reserved memory
Date: Mon, 29 Aug 2016 18:36:49 +0530
In-Reply-To: <1472476010-4709-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1472476010-4709-1-git-send-email-srikar@linux.vnet.ibm.com>
Message-Id: <1472476010-4709-3-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The total reserved memory in a system is accounted but not available for
use use outside mm/memblock.c. By exposing the total reserved memory,
systems can better calculate the size of large hashes.

Cc: linux-mm@kvack.org
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 include/linux/memblock.h | 1 +
 mm/memblock.c            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 2925da2..5b759c9 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -328,6 +328,7 @@ phys_addr_t memblock_alloc_base(phys_addr_t size, phys_addr_t align,
 phys_addr_t __memblock_alloc_base(phys_addr_t size, phys_addr_t align,
 				  phys_addr_t max_addr);
 phys_addr_t memblock_phys_mem_size(void);
+phys_addr_t memblock_reserved_size(void);
 phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 483197e..c8dfa43 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1438,6 +1438,11 @@ phys_addr_t __init_memblock memblock_phys_mem_size(void)
 	return memblock.memory.total_size;
 }
 
+phys_addr_t __init_memblock memblock_reserved_size(void)
+{
+	return memblock.reserved.total_size;
+}
+
 phys_addr_t __init memblock_mem_size(unsigned long limit_pfn)
 {
 	unsigned long pages = 0;
-- 
1.8.5.6
