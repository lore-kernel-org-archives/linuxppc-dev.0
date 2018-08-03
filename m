Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hqQ1496ZzF1mh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2018 00:37:28 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w73EZmEL098974
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Aug 2018 10:37:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmrxtg1ts-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2018 10:37:25 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Fri, 3 Aug 2018 08:37:24 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [PATCH v2] selftests/powerpc: Avoid remaining process/threads
Date: Fri,  3 Aug 2018 11:37:19 -0300
In-Reply-To: <87bmajhh40.fsf@concordia.ellerman.id.au>
References: <87bmajhh40.fsf@concordia.ellerman.id.au>
Message-Id: <1533307039-13744-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are some powerpc selftests, as tm/tm-unavailable, that run for a long
period (>120 seconds), and if it is interrupted, as pressing CRTL-C
(SIGINT), the foreground process (harness) dies but the child process and
threads continue to execute (with PPID = 1 now) in background.

In this case, you'd think the whole test exited, but there are remaining
threads and processes being executed in background. Sometimes these
zoombies processes are doing annoying things, as consuming the whole CPU or
dumping things to STDOUT.

This patch fixes this problem by creating a SIGINT handler in the harness
process, which will kill the child process group once a SIGINT is caught.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/harness.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index 66d31de60b9a..06c51e8d8ccb 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -22,12 +22,12 @@
 #define KILL_TIMEOUT	5
 
 static uint64_t timeout = 120;
+pid_t pid;
 
 int run_test(int (test_function)(void), char *name)
 {
 	bool terminated;
 	int rc, status;
-	pid_t pid;
 
 	/* Make sure output is flushed before forking */
 	fflush(stdout);
@@ -85,13 +85,16 @@ int run_test(int (test_function)(void), char *name)
 	return status;
 }
 
-static void alarm_handler(int signum)
+static void sig_handler(int signum)
 {
-	/* Jut wake us up from waitpid */
+	if (signum == SIGINT)
+		kill(-pid, SIGTERM);
+
+	/* if SIGALRM, just wake us up from waitpid */
 }
 
-static struct sigaction alarm_action = {
-	.sa_handler = alarm_handler,
+static struct sigaction sig_action = {
+	.sa_handler = sig_handler,
 };
 
 void test_harness_set_timeout(uint64_t time)
@@ -106,8 +109,14 @@ int test_harness(int (test_function)(void), char *name)
 	test_start(name);
 	test_set_git_version(GIT_VERSION);
 
-	if (sigaction(SIGALRM, &alarm_action, NULL)) {
-		perror("sigaction");
+	if (sigaction(SIGINT, &sig_action, NULL)) {
+		perror("sigaction (sigint)");
+		test_error(name);
+		return 1;
+	}
+
+	if (sigaction(SIGALRM, &sig_action, NULL)) {
+		perror("sigaction (sigalrm)");
 		test_error(name);
 		return 1;
 	}
-- 
2.16.3
