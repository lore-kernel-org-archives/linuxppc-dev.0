Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xZGFK0yKjzDqYg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 20:21:08 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7JAJS4P047024
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 06:21:06 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cee7rstqy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 06:21:06 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Sat, 19 Aug 2017 20:21:04 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7JAJlLx27066622
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 20:19:47 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7JAJkml014463
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 20:19:47 +1000
Subject: [linux-next][bisected c64e09ce] sysctl command hung indefinitely
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@suse.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-next
 <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 sachinp <sachinp@linux.vnet.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Joonsoo Kim <js1304@gmail.com>
Date: Sat, 19 Aug 2017 15:49:31 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1503137971.28497.19.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

'sysctl -a' command never completes on my PowerPC machine with latest
next kernel (As of next-20170811)

Machine Type : Power8 bare-metal
Kernel version : 4.13.0-rc4-next-20170817
gcc version : 4.8.5


command output
--------------
$ sysctl -a
[...
vm.hugetlb_shm_group = 0
vm.laptop_mode = 0
vm.legacy_va_layout = 0
vm.lowmem_reserve_ratio = 256	256	32
vm.max_map_count = 65530
vm.min_free_kbytes = 6637
vm.min_slab_ratio = 5
vm.min_unmapped_ratio = 1
vm.mmap_min_addr = 4096
vm.mmap_rnd_bits = 14
vm.mmap_rnd_compat_bits = 7
vm.nr_hugepages = 0
vm.nr_hugepages_mempolicy = 0
vm.nr_overcommit_hugepages = 0
vm.nr_pdflush_threads = 0
vm.numa_zonelist_order = Node
vm.numa_zonelist_order = e
vm.numa_zonelist_order = ode
vm.numa_zonelist_order = 
vm.numa_zonelist_order = de
vm.numa_zonelist_order = Node
vm.numa_zonelist_order = e
vm.numa_zonelist_order = ode
vm.numa_zonelist_order = 
vm.numa_zonelist_order = de
vm.numa_zonelist_order = Node
vm.numa_zonelist_order = e
vm.numa_zonelist_order = ode
vm.numa_zonelist_order = 
vm.numa_zonelist_order = de
vm.numa_zonelist_order = Node
vm.numa_zonelist_order = e
vm.numa_zonelist_order = ode
....]

The last string 'vm.numa_zonelist_order = ' keeps flooding the stdout
and command never exit.

A bisection resulted commit c64e09ce mm, page_alloc: rip out
ZONELIST_ORDER_ZONE

Command exits cleanly when the above commit is reverted.

from the commit I see some changes to kernel/sysctl.c

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6648fbb..0d51ec1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1574,8 +1574,6 @@ static int sysrq_sysctl_handler(struct ctl_table
*table, int write,
 #ifdef CONFIG_NUMA
        {
                .procname       = "numa_zonelist_order",
-               .data           = &numa_zonelist_order,
-               .maxlen         = NUMA_ZONELIST_ORDER_LEN,
                .mode           = 0644,
                .proc_handler   = numa_zonelist_order_handler,
        },

does the above change has caused the noise ?

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
