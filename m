Return-Path: <srs0=tmo9=2z=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkgx00byJzDqYL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 08:05:40 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vkgx001p2z8t4P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 08:05:40 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vkgwz3ynpz9ryQ
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 08:05:39 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GL47uk127506
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 17:05:34 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297x6a35jn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 17:05:33 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 17 Mar 2017 02:35:30 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2GL5SuV16580828
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 02:35:28 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2GL5ROj030749
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 02:35:28 +0530
Subject: [PATCH v2 1/2] powerpc/fadump: reserve memory at an offset closer
 to bottom of RAM
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 17 Mar 2017 02:35:26 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148969794004.4130.14805754334064000704.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the area to preserve boot memory is reserved at the top of
RAM. This leaves fadump vulnerable to memory hot-remove operations. As
memory for fadump has to be reserved early in the boot process, fadump
can't be registered after a memory hot-remove operation. Though this
problem can't be eleminated completely, the impact can be minimized by
reserving memory at an offset closer to bottom of the RAM. The offset
for fadump memory reservation can be any value greater than fadump boot
memory size.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes from v1:
* Finding the offset based on memory holes/availability
* Improved error checking


 arch/powerpc/kernel/fadump.c |   33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8ff0dd4..33b2da3 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -319,15 +319,34 @@ int __init fadump_reserve_mem(void)
 		pr_debug("fadumphdr_addr = %p\n",
 				(void *) fw_dump.fadumphdr_addr);
 	} else {
-		/* Reserve the memory at the top of memory. */
 		size = get_fadump_area_size();
-		base = memory_boundary - size;
-		memblock_reserve(base, size);
-		printk(KERN_INFO "Reserved %ldMB of memory at %ldMB "
-				"for firmware-assisted dump\n",
-				(unsigned long)(size >> 20),
-				(unsigned long)(base >> 20));
+
+		/*
+		 * Reserve memory at an offset closer to bottom of the RAM to
+		 * minimize the impact of memory hot-remove operation. We can't
+		 * use memblock_find_in_range() here since it doesn't allocate
+		 * from bottom to top.
+		 */
+		for (base = fw_dump.boot_memory_size;
+		     base <= (memory_boundary - size);
+		     base += size) {
+			if (memblock_is_region_memory(base, size) &&
+			    !memblock_is_region_reserved(base, size))
+				break;
+		}
+		if ((base > (memory_boundary - size)) ||
+		    memblock_reserve(base, size)) {
+			pr_err("Failed to reserve memory\n");
+			return 0;
+		}
+
+		pr_info("Reserved %ldMB of memory at %ldMB for firmware-"
+			"assisted dump (System RAM: %ldMB)\n",
+			(unsigned long)(size >> 20),
+			(unsigned long)(base >> 20),
+			(unsigned long)(memblock_phys_mem_size() >> 20));
 	}
+
 	fw_dump.reserve_dump_area_start = base;
 	fw_dump.reserve_dump_area_size = size;
 	return 1;
