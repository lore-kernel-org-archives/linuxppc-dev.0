Return-Path: <sachinp@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTPpN5r3tzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 17:43:56 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N6hYZO146776
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 01:43:53 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28sdf5xe2f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 01:43:53 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sachinp@linux.vnet.ibm.com>;
 Thu, 23 Feb 2017 12:13:50 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 82526E005B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 12:15:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1N6hlCo26083374
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 12:13:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1N6hlcB023604
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 12:13:47 +0530
From: Sachin Sant <sachinp@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: michael@ellerman.id.au, Sachin Sant <sachinp@linux.vnet.ibm.com>,
 linux-kselftest@vger.kernel.org
Date: Thu, 23 Feb 2017 12:13:46 +0530
Subject: [PATCH] selftest/powerpc/alignment: Fix false failures for skipped
 tests
Message-Id: <20170223064346.69668.83215.sendpatchset@sachins-mbp.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tests under alignment subdirectory are skipped when executed on previous
generation hardware, but harness still marks them as failed.

test: test_copy_unaligned
tags: git_version:unknown
[SKIP] Test skipped on line 26
skip: test_copy_unaligned
selftests: copy_unaligned [FAIL]

The MAGIC_SKIP_RETURN_VALUE value assigned to rc variable is retained till
the program exit which causes the test to be marked as failed.

This patch resets the value before returning to the main() routine.
With this patch the test o/p is as follows:

test: test_copy_unaligned
tags: git_version:unknown
[SKIP] Test skipped on line 26
skip: test_copy_unaligned
selftests: copy_unaligned [PASS]

Signed-off-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
---

diff -Naurp a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
--- a/tools/testing/selftests/powerpc/harness.c	2017-02-19 16:34:00.000000000 -0600
+++ b/tools/testing/selftests/powerpc/harness.c	2017-02-22 23:53:44.347242893 -0600
@@ -114,9 +114,11 @@ int test_harness(int (test_function)(voi
 
 	rc = run_test(test_function, name);
 
-	if (rc == MAGIC_SKIP_RETURN_VALUE)
+	if (rc == MAGIC_SKIP_RETURN_VALUE) {
 		test_skip(name);
-	else
+		/* so that skipped test is not marked as failed */
+		rc = 0;
+	} else
 		test_finish(name, rc);
 
 	return rc;
