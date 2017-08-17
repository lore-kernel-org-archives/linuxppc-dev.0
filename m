Return-Path: <srs0=i6t0=7t=au1.ibm.com=sam.bobroff@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXp2n6GHszDrJF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 11:06:57 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xXp2n5dDHz8t9h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 11:06:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xXp2n2jhwz9t1t
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 11:06:56 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7H1545b123897
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2017 21:06:54 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ccudgymfk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2017 21:06:54 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 17 Aug 2017 11:06:51 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7H16nx820775130
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 11:06:49 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7H16nJe014806
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 11:06:49 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v7H16nZE014801
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 11:06:49 +1000
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C85C5A0105
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2017 11:06:48 +1000 (AEST)
Date: Thu, 17 Aug 2017 11:06:47 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/1] selftests/powerpc: Improve tm-resched-dscr
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <620568b89e995ed57f03da41857fb37584766a69.1502931841.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The tm-resched-dscr self test can, in some situations, run for
several minutes before being successfully interrupted by the context
switch it needs in order to perform the test. This often seems to
occur when the test is being run in a virtual machine.

Improve the test by running it under eat_cpu() to guarantee
contention for the CPU and increase the chance of a context switch.

In practice this seems to reduce the test time, in some cases, from
more than two minutes to under a second.

Also remove the "progress dots" so that if the test does run for a
long time, it doesn't produce large amounts of unnecessary output.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 tools/testing/selftests/powerpc/tm/Makefile          |  1 +
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 958c11c14acd..7bfcd454fb2a 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -15,6 +15,7 @@ $(OUTPUT)/tm-syscall: tm-syscall-asm.S
 $(OUTPUT)/tm-syscall: CFLAGS += -I../../../../../usr/include
 $(OUTPUT)/tm-tmspr: CFLAGS += -pthread
 $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
+$(OUTPUT)/tm-resched-dscr: ../pmu/lib.o
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
index e79ccd6aada1..a7ac2e4c60d9 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -30,6 +30,7 @@
 
 #include "utils.h"
 #include "tm.h"
+#include "../pmu/lib.h"
 
 #define SPRN_DSCR       0x03
 
@@ -75,8 +76,6 @@ int test_body(void)
 		);
 		assert(rv); /* make sure the transaction aborted */
 		if ((texasr >> 56) != TM_CAUSE_RESCHED) {
-			putchar('.');
-			fflush(stdout);
 			continue;
 		}
 		if (dscr2 != dscr1) {
@@ -89,7 +88,12 @@ int test_body(void)
 	}
 }
 
-int main(void)
+static int tm_resched_dscr(void)
 {
-	return test_harness(test_body, "tm_resched_dscr");
+	return eat_cpu(test_body);
+}
+
+int main(int argc, const char *argv[])
+{
+	return test_harness(tm_resched_dscr, "tm_resched_dscr");
 }
-- 
2.14.1.2.g4274c698f
