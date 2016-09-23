Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgNVB1RrRzDsmm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:57 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N6HZ3s073634
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:55 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25mqb79a2y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 02:18:54 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 23 Sep 2016 16:18:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 69225357805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8N6ImCp66977832
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8N6Imf6007753
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:18:48 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 11/20] selftests/powerpc: Allow tests to extend their kill
 timeout
Date: Fri, 23 Sep 2016 16:18:17 +1000
In-Reply-To: <20160923061826.30790-1-cyrilbur@gmail.com>
References: <20160923061826.30790-1-cyrilbur@gmail.com>
Message-Id: <20160923061826.30790-12-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 tools/testing/selftests/powerpc/harness.c | 9 +++++++--
 tools/testing/selftests/powerpc/utils.h   | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index 52f9be7..248a820 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -19,9 +19,9 @@
 #include "subunit.h"
 #include "utils.h"
 
-#define TIMEOUT		120
 #define KILL_TIMEOUT	5
 
+static uint64_t timeout = 120;
 
 int run_test(int (test_function)(void), char *name)
 {
@@ -44,7 +44,7 @@ int run_test(int (test_function)(void), char *name)
 	setpgid(pid, pid);
 
 	/* Wake us up in timeout seconds */
-	alarm(TIMEOUT);
+	alarm(timeout);
 	terminated = false;
 
 wait:
@@ -94,6 +94,11 @@ static struct sigaction alarm_action = {
 	.sa_handler = alarm_handler,
 };
 
+void test_harness_set_timeout(uint64_t time)
+{
+	timeout = time;
+}
+
 int test_harness(int (test_function)(void), char *name)
 {
 	int rc;
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index ecd11b5..53405e8 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -22,7 +22,7 @@ typedef uint32_t u32;
 typedef uint16_t u16;
 typedef uint8_t u8;
 
-
+void test_harness_set_timeout(uint64_t time);
 int test_harness(int (test_function)(void), char *name);
 extern void *get_auxv_entry(int type);
 int pick_online_cpu(void);
-- 
2.10.0
