Return-Path: <srs0=0zbl=kv=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kqNS5nYZzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 06:43:04 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41kqNS4phWz8w0T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 06:43:04 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41kqNS0g5pz9ryt
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2018 06:43:03 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w76Kd1ff035252
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2018 16:43:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kpw5jrwfe-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 06 Aug 2018 16:43:01 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Mon, 6 Aug 2018 21:43:00 +0100
Subject: [PATCH v2 2/2] powerpc/fadump: merge adjacent memory ranges to
 reduce PT_LOAD segements
From: Hari Bathini <hbathini@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Date: Tue, 07 Aug 2018 02:12:54 +0530
In-Reply-To: <153358813908.15150.18359359970445648733.stgit@hbathini.in.ibm.com>
References: <153358813908.15150.18359359970445648733.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153358817264.15150.1450644377959627061.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With dynamic memory allocation support for crash memory ranges array,
there is no hard limit on the no. of crash memory ranges kernel could
export, but program headers count could overflow in the /proc/vmcore
ELF file while exporting each memory range as PT_LOAD segment. Reduce
the likelihood of a such scenario, by folding adjacent crash memory
ranges which minimizes the total number of PT_LOAD segments.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   45 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 2ec5704..cd0c555 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -908,22 +908,41 @@ static int allocate_crash_memory_ranges(void)
 static inline int fadump_add_crash_memory(unsigned long long base,
 					  unsigned long long end)
 {
+	u64  start, size;
+	bool is_adjacent = false;
+
 	if (base == end)
 		return 0;
 
-	if (crash_mem_ranges == max_crash_mem_ranges) {
-		int ret;
+	/*
+	 * Fold adjacent memory ranges to bring down the memory ranges/
+	 * PT_LOAD segments count.
+	 */
+	if (crash_mem_ranges) {
+		start = crash_memory_ranges[crash_mem_ranges-1].base;
+		size = crash_memory_ranges[crash_mem_ranges-1].size;
 
-		ret = allocate_crash_memory_ranges();
-		if (ret)
-			return ret;
+		if ((start + size) == base)
+			is_adjacent = true;
+	}
+	if (!is_adjacent) {
+		/* resize the array on reaching the limit */
+		if (crash_mem_ranges == max_crash_mem_ranges) {
+			int ret;
+
+			ret = allocate_crash_memory_ranges();
+			if (ret)
+				return ret;
+		}
+
+		start = base;
+		crash_memory_ranges[crash_mem_ranges].base = start;
+		crash_mem_ranges++;
 	}
 
+	crash_memory_ranges[crash_mem_ranges-1].size = (end - start);
 	pr_debug("crash_memory_range[%d] [%#016llx-%#016llx], %#llx bytes\n",
-		crash_mem_ranges, base, end - 1, (end - base));
-	crash_memory_ranges[crash_mem_ranges].base = base;
-	crash_memory_ranges[crash_mem_ranges].size = end - base;
-	crash_mem_ranges++;
+		(crash_mem_ranges - 1), start, end - 1, (end - start));
 	return 0;
 }
 
@@ -999,6 +1018,14 @@ static int fadump_setup_crash_memory_ranges(void)
 
 	pr_debug("Setup crash memory ranges.\n");
 	crash_mem_ranges = 0;
+
+	/* allocate memory for crash memory ranges for the first time */
+	if (!max_crash_mem_ranges) {
+		ret = allocate_crash_memory_ranges();
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * add the first memory chunk (RMA_START through boot_memory_size) as
 	 * a separate memory chunk. The reason is, at the time crash firmware
