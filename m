Return-Path: <srs0=hqze=5g=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdyQ50tpvzDqKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 05:41:17 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wdyQ46pNVz8svH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 05:41:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wdyQ41zw0z9sNM
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2017 05:41:16 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51JcS3p016115
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2017 15:41:13 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ats1a0mhc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Jun 2017 15:41:13 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 2 Jun 2017 05:41:10 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51Jex6X41287752
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2017 05:41:07 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51JeRYN024192
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2017 05:40:27 +1000
Subject: [PATCH v2] powerpc/fadump: add reschedule point while releasing memory
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 02 Jun 2017 01:10:10 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149634598024.11266.1878020879845577140.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Around 95% of memory is reserved by fadump/capture kernel. All this
memory is freed, one page at a time, on writing '1' to the node
/sys/kernel/fadump_release_mem. On systems with large memory, this
can take a long time to complete, leading to soft lockup warning
messages. To avoid this, add reschedule points at regular intervals.

Also, while memblock_reserve() implicitly takes care of holes in the
given memory range while reserving memory, those holes need to be
taken care of while releasing memory as memory is freed one page at
a time. Add support to skip holes while releasing memory.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes since v1:
* Got rid of RELEASE_PAGES_BATCH macro and the corresponding code to
  simplify the implementation.
* Introduced support to skip memory holes while releasing memory.


 arch/powerpc/kernel/fadump.c |   65 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 466569e..23aa674 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1046,28 +1046,71 @@ void fadump_cleanup(void)
 	}
 }
 
+static void fadump_free_reserved_memory(unsigned long start_pfn,
+					unsigned long end_pfn)
+{
+	unsigned long pfn;
+	unsigned long time_limit = jiffies + HZ;
+
+	pr_info("freeing reserved memory (0x%llx - 0x%llx)\n",
+		PFN_PHYS(start_pfn), PFN_PHYS(end_pfn));
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		free_reserved_page(pfn_to_page(pfn));
+
+		if (time_after(jiffies, time_limit)) {
+			cond_resched();
+			time_limit = jiffies + HZ;
+		}
+	}
+}
+
+/*
+ * Skip memory holes and free memory that was actually reserved.
+ */
+static void fadump_release_reserved_area(unsigned long start, unsigned long end)
+{
+	struct memblock_region *reg;
+	unsigned long tstart, tend;
+	unsigned long start_pfn = PHYS_PFN(start);
+	unsigned long end_pfn = PHYS_PFN(end);
+
+	for_each_memblock(memory, reg) {
+		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
+		tend = min(end_pfn, memblock_region_memory_end_pfn(reg));
+		if (tstart < tend) {
+			fadump_free_reserved_memory(tstart, tend);
+
+			if (tend == end_pfn)
+				break;
+
+			start_pfn = tend + 1;
+		}
+	}
+}
+
 /*
  * Release the memory that was reserved in early boot to preserve the memory
  * contents. The released memory will be available for general use.
  */
 static void fadump_release_memory(unsigned long begin, unsigned long end)
 {
-	unsigned long addr;
 	unsigned long ra_start, ra_end;
 
 	ra_start = fw_dump.reserve_dump_area_start;
 	ra_end = ra_start + fw_dump.reserve_dump_area_size;
 
-	for (addr = begin; addr < end; addr += PAGE_SIZE) {
-		/*
-		 * exclude the dump reserve area. Will reuse it for next
-		 * fadump registration.
-		 */
-		if (addr <= ra_end && ((addr + PAGE_SIZE) > ra_start))
-			continue;
-
-		free_reserved_page(pfn_to_page(addr >> PAGE_SHIFT));
-	}
+	/*
+	 * exclude the dump reserve area. Will reuse it for next
+	 * fadump registration.
+	 */
+	if (begin < ra_end && end > ra_start) {
+		if (begin < ra_start)
+			fadump_release_reserved_area(begin, ra_start);
+		if (end > ra_end)
+			fadump_release_reserved_area(ra_end, end);
+	} else
+		fadump_release_reserved_area(begin, end);
 }
 
 static void fadump_invalidate_release_mem(void)
