Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3cHP3ZJBzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 23:19:29 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u72DEov6136026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 09:19:27 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grry0p6w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 09:19:27 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 23:19:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C36C63578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 23:19:19 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u72DJJpr25493536
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 23:19:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u72DJJnh023145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 23:19:19 +1000
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux--foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH 0/0] Disable deferred struct page initialisation on Fadump
Date: Tue,  2 Aug 2016 18:49:05 +0530
Message-Id: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fadump kernel reserves large chunks of memory even before the pages are
initialised. This could mean memory that corresponds to several nodes might
fall in memblock reserved regions.

Kernels compiled with CONFIG_DEFERRED_STRUCT_PAGE_INIT will initialise
only certain size memory per node. The certain size takes into account
the dentry and inode cache sizes. However such a kernel when booting a
secondary kernel will not be able to allocate the required amount of
memory to suffice for the dentry and inode caches. This results in
crashes like the below on large systems such as 32 TB systems.

Dentry cache hash table entries: 536870912 (order: 16, 4294967296 bytes)
vmalloc: allocation failure, allocated 4097114112 of 17179934720 bytes
swapper/0: page allocation failure: order:0, mode:0x2080020(GFP_ATOMIC)
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6-master+ #3
Call Trace:
[c00000000108fb10] [c0000000007fac88] dump_stack+0xb0/0xf0 (unreliable)
[c00000000108fb50] [c000000000235264] warn_alloc_failed+0x114/0x160
[c00000000108fbf0] [c000000000281484] __vmalloc_node_range+0x304/0x340
[c00000000108fca0] [c00000000028152c] __vmalloc+0x6c/0x90
[c00000000108fd40] [c000000000aecfb0]
alloc_large_system_hash+0x1b8/0x2c0
[c00000000108fe00] [c000000000af7240] inode_init+0x94/0xe4
[c00000000108fe80] [c000000000af6fec] vfs_caches_init+0x8c/0x13c
[c00000000108ff00] [c000000000ac4014] start_kernel+0x50c/0x578
[c00000000108ff90] [c000000000008c6c] start_here_common+0x20/0xa8

This can be solved by two approaches.
1. Disable deferred struct page initialisation on fadump.

2. Detect reserved nodes and allocate accordingly.
 - Detecting nodes whose memblocks are mostly reserved.
 - Allocating extra memory in other nodes in lieu of the nodes whose
   memory is reserved.

This patchset takes the first approach.

Srikar Dronamraju (2):
  mm: Allow disabling deferred struct page initialisation
  fadump: Disable deferred page struct initialisation

 arch/powerpc/kernel/fadump.c |  1 +
 include/linux/mmzone.h       |  2 +-
 mm/page_alloc.c              | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
1.8.5.6
