Return-Path: <srs0=hqgh=la=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sZq70chyzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2018 06:41:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41sZq66xfBz8t83
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2018 06:41:06 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41sZq61S38z9s3Z
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2018 06:41:05 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7HKcuGq000637
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 16:41:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kx30k5fa2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2018 16:41:02 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Fri, 17 Aug 2018 21:41:01 +0100
Subject: [PATCH] powerpc/fadump: cleanup crash memory ranges support
From: Hari Bathini <hbathini@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Date: Sat, 18 Aug 2018 02:10:56 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153453843169.1010.11894303551198228940.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 1bd6a1c4b80a ("powerpc/fadump: handle crash memory ranges array
index overflow") changed crash memory ranges to a dynamic array that
is reallocated on-demand with krealloc(). The relevant header for this
call was not included. The kernel compiles though. But be cautious and
add the header anyway.

Also, memory allocation logic in fadump_add_crash_memory() takes care
of memory allocation for crash memory ranges in all scenarios. Drop
unnecessary memory allocation in fadump_setup_crash_memory_ranges().

Fixes: 1bd6a1c4b80a ("powerpc/fadump: handle crash memory ranges array index overflow")
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

* Actually posted a V3 with this changes but V2 made it!
    - https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=59839


 arch/powerpc/kernel/fadump.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 986ec47..a711d22 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -34,6 +34,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/slab.h>
 
 #include <asm/debugfs.h>
 #include <asm/page.h>
@@ -1019,13 +1020,6 @@ static int fadump_setup_crash_memory_ranges(void)
 	pr_debug("Setup crash memory ranges.\n");
 	crash_mem_ranges = 0;
 
-	/* allocate memory for crash memory ranges for the first time */
-	if (!max_crash_mem_ranges) {
-		ret = allocate_crash_memory_ranges();
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * add the first memory chunk (RMA_START through boot_memory_size) as
 	 * a separate memory chunk. The reason is, at the time crash firmware
