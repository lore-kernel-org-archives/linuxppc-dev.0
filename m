Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PNs44cMzDrBT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:17 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSfPS085369
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:15 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24s2v78cn5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:15 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8DA123578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:11 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNTBlR30474390
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNTBcZ023231
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:11 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 11/20] selftests/powerpc: Allow tests to extend their kill
 timeout
Date: Fri, 12 Aug 2016 09:28:10 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-12-cyrilbur@gmail.com>
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
2.9.2
