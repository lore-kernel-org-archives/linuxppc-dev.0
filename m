Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lGlB2gk7zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:15:49 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77EF4Mq110976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2018 10:15:47 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kqannxvk0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 10:15:46 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 7 Aug 2018 08:15:45 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [PATCH v3] selftests/powerpc: Kill child processes on SIGINT
Date: Tue,  7 Aug 2018 11:15:39 -0300
In-Reply-To: <a4f9f03b-51dd-55d4-cfec-9ae48fbbd9d6@debian.org>
References: <a4f9f03b-51dd-55d4-cfec-9ae48fbbd9d6@debian.org>
Message-Id: <1533651339-12816-1-git-send-email-leitao@debian.org>
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
zombies processes are doing annoying things, as consuming the whole CPU or
dumping things to STDOUT.

This patch fixes this problem by attaching an empty signal handler to
SIGINT in the harness process. This handler will interrupt (EINTR) the
parent process waitpid() call, letting the code to follow through the
normal flow, which will kill all the processes in the child process group.

This patch also fixes a typo.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/harness.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index 66d31de60b9a..9d7166dfad1e 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -85,13 +85,13 @@ int run_test(int (test_function)(void), char *name)
 	return status;
 }
 
-static void alarm_handler(int signum)
+static void sig_handler(int signum)
 {
-	/* Jut wake us up from waitpid */
+	/* Just wake us up from waitpid */
 }
 
-static struct sigaction alarm_action = {
-	.sa_handler = alarm_handler,
+static struct sigaction sig_action = {
+	.sa_handler = sig_handler,
 };
 
 void test_harness_set_timeout(uint64_t time)
@@ -106,8 +106,14 @@ int test_harness(int (test_function)(void), char *name)
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
