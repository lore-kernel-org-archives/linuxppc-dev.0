Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrhdB3wwwzF1Vt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 14:58:53 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1S3sx2P097448
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 22:58:51 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gdj0j5dck-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 22:58:50 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Feb 2018 20:58:49 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] selftests/vm: Update max va test to check for high address
 return.
Date: Wed, 28 Feb 2018 09:28:30 +0530
Message-Id: <20180228035830.10089-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mmap(-1,..) is expected to search from max supported VA top down. It should find
an address above ADDR_SWITCH_HINT. Explicitly check for this.

Also derefer the address even if we failed the addr check.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 tools/testing/selftests/vm/va_128TBswitch.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/va_128TBswitch.c b/tools/testing/selftests/vm/va_128TBswitch.c
index e7fe734c374f..f68fa4bd8179 100644
--- a/tools/testing/selftests/vm/va_128TBswitch.c
+++ b/tools/testing/selftests/vm/va_128TBswitch.c
@@ -44,6 +44,7 @@ struct testcase {
 	unsigned long flags;
 	const char *msg;
 	unsigned int low_addr_required:1;
+	unsigned int high_addr_required:1;
 	unsigned int keep_mapped:1;
 };
 
@@ -108,6 +109,7 @@ static struct testcase testcases[] = {
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
@@ -115,12 +117,14 @@ static struct testcase testcases[] = {
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR) again",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
 		.size = 2 * PAGE_SIZE,
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
 		.msg = "mmap(HIGH_ADDR, MAP_FIXED)",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
@@ -128,12 +132,14 @@ static struct testcase testcases[] = {
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
 		.size = 2 * PAGE_SIZE,
 		.flags = MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1) again",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = ((void *)(ADDR_SWITCH_HINT - PAGE_SIZE)),
@@ -193,6 +199,7 @@ static struct testcase hugetlb_testcases[] = {
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR, MAP_HUGETLB)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
@@ -200,12 +207,14 @@ static struct testcase hugetlb_testcases[] = {
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(HIGH_ADDR, MAP_HUGETLB) again",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = HIGH_ADDR,
 		.size = HUGETLB_SIZE,
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
 		.msg = "mmap(HIGH_ADDR, MAP_FIXED | MAP_HUGETLB)",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
@@ -213,12 +222,14 @@ static struct testcase hugetlb_testcases[] = {
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1, MAP_HUGETLB)",
 		.keep_mapped = 1,
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *) -1,
 		.size = HUGETLB_SIZE,
 		.flags = MAP_HUGETLB | MAP_PRIVATE | MAP_ANONYMOUS,
 		.msg = "mmap(-1, MAP_HUGETLB) again",
+		.high_addr_required = 1,
 	},
 	{
 		.addr = (void *)(ADDR_SWITCH_HINT - PAGE_SIZE),
@@ -257,14 +268,16 @@ static int run_test(struct testcase *test, int count)
 		if (t->low_addr_required && p >= (void *)(ADDR_SWITCH_HINT)) {
 			printf("FAILED\n");
 			ret = 1;
-		} else {
-			/*
-			 * Do a dereference of the address returned so that we catch
-			 * bugs in page fault handling
-			 */
-			memset(p, 0, t->size);
+		} else if (t->high_addr_required && p < (void *)(ADDR_SWITCH_HINT)) {
+			printf("FAILED\n");
+			ret = 1;
+		} else
 			printf("OK\n");
-		}
+		/*
+		 * Do a dereference of the address returned so that we catch
+		 * bugs in page fault handling
+		 */
+		memset(p, 0, t->size);
 		if (!t->keep_mapped)
 			munmap(p, t->size);
 	}
-- 
2.14.3
