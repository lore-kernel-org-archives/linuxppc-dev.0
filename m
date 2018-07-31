Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fyy15x9pzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 00:10:17 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6VE8u0X101204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:10:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kjs50rmbq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 10:10:14 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Tue, 31 Jul 2018 10:10:14 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/selftests: Avoid backgroud process/threads
Date: Tue, 31 Jul 2018 11:10:08 -0300
Message-Id: <1533046208-8757-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current tm-unavailable test runs for a long period (>120 seconds), and if it is
interrupted, as pressing CRTL-C (SIGINT), the foreground process (harness) dies
but the child process and threads continue to execute (with PPID = 1 now).

In this case, you'd think the test is gone, but there are two threads being
executed in background, one of the thread ('pong') consumes 100% of the CPU and
the other one ('ping') dumps output message, from time to time, in the STDOUT,
which is annoying.

This patch simply gets the child process to be SIGTERMed when the parent dies.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/tm/tm-unavailable.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/powerpc/tm/tm-unavailable.c b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
index 156c8e750259..c42f8b60063c 100644
--- a/tools/testing/selftests/powerpc/tm/tm-unavailable.c
+++ b/tools/testing/selftests/powerpc/tm/tm-unavailable.c
@@ -23,6 +23,8 @@
 #include <stdbool.h>
 #include <pthread.h>
 #include <sched.h>
+#include <signal.h>
+#include <sys/prctl.h>
 
 #include "tm.h"
 
@@ -342,6 +344,9 @@ int tm_unavailable_test(void)
 
 	SKIP_IF(!have_htm());
 
+	/* Send me SIGTERM if PPID is dead (as SIGINTed) */
+	prctl(PR_SET_PDEATHSIG, SIGTERM);
+
 	/* Set only CPU 0 in the mask. Both threads will be bound to CPU 0. */
 	CPU_ZERO(&cpuset);
 	CPU_SET(0, &cpuset);
-- 
2.16.3
