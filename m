Return-Path: <srs0=85op=45=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wX79L5Q02zDqZp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 17:55:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wX79L4myNz8wSY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 17:55:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wX79L0qfZz9sP0
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 17:55:01 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4N7Sk9t002939
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 03:55:00 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2am9y6gdmy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 03:54:59 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 23 May 2017 17:54:56 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4N7sjLd4063536
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 17:54:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4N7sEOX012522
 for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2017 17:54:14 +1000
Subject: [PATCH] powerpc/fadump: add reschedule point while releasing memory
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 23 May 2017 13:24:03 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149552604332.732.5139791860101612990.stgit@hbathini.in.ibm.com>
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

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   60 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 466569e..0babefc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1046,28 +1046,66 @@ void fadump_cleanup(void)
 	}
 }
 
+/* Time to wait before a reschedule point */
+#define RELEASE_TIME_LIMIT			500	/* in milliseconds */
+
+/* Release memory in batches of 'N' pages each */
+#define RELEASE_PAGES_BATCH			(1 << 22)
+
+static void fadump_free_reserved_memory(unsigned long start, unsigned long end)
+{
+	unsigned long pfn, start_pfn, end_pfn;
+	unsigned int remaining = end > start ? (end - start) >> PAGE_SHIFT : 0;
+	unsigned long time_limit = jiffies +
+					msecs_to_jiffies(RELEASE_TIME_LIMIT);
+
+	while (remaining) {
+		/* A reschedule point for every 'X' milliseconds */
+		if (time_after_eq(jiffies, time_limit)) {
+			cond_resched();
+			time_limit = jiffies +
+					msecs_to_jiffies(RELEASE_TIME_LIMIT);
+		}
+
+		/* release memory in batches of 'N' pages */
+		start_pfn = start >> PAGE_SHIFT;
+		if (remaining > RELEASE_PAGES_BATCH) {
+			end_pfn = start_pfn + RELEASE_PAGES_BATCH;
+			remaining -= RELEASE_PAGES_BATCH;
+		} else {
+			end_pfn = end >> PAGE_SHIFT;
+			remaining = 0;
+		}
+
+		for (pfn = start_pfn; pfn < end_pfn; pfn++)
+			free_reserved_page(pfn_to_page(pfn));
+
+		start = end_pfn << PAGE_SHIFT;
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
+			fadump_free_reserved_memory(begin, ra_start);
+		if (end > ra_end)
+			fadump_free_reserved_memory(ra_end, end);
+	} else
+		fadump_free_reserved_memory(begin, end);
 }
 
 static void fadump_invalidate_release_mem(void)
