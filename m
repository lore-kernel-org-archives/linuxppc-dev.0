Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1CF0F1A02A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:44 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 05/10] selftests/powerpc: Count instructions under scheduler
 pressure
Date: Wed, 23 Jul 2014 17:31:35 +1000
Message-Id: <1406100700-9702-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
References: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Have a task eat some cpu while we are counting instructions to create
some scheduler pressure. The idea being to try and unearth any bugs we
have in counting that only appear when context switching is happening.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/Makefile             | 2 +-
 tools/testing/selftests/powerpc/pmu/count_instructions.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index ebc0e7449cd9..8595cfd7e41b 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -2,7 +2,7 @@ noarg:
 	$(MAKE) -C ../
 
 PROGS := count_instructions l3_bank_test
-EXTRA_SOURCES := ../harness.c event.c
+EXTRA_SOURCES := ../harness.c event.c lib.c
 
 SUB_TARGETS = ebb
 
diff --git a/tools/testing/selftests/powerpc/pmu/count_instructions.c b/tools/testing/selftests/powerpc/pmu/count_instructions.c
index 312b4f0fd27c..5e241e14f204 100644
--- a/tools/testing/selftests/powerpc/pmu/count_instructions.c
+++ b/tools/testing/selftests/powerpc/pmu/count_instructions.c
@@ -12,6 +12,7 @@
 
 #include "event.h"
 #include "utils.h"
+#include "lib.h"
 
 extern void thirty_two_instruction_loop(u64 loops);
 
@@ -90,7 +91,7 @@ static u64 determine_overhead(struct event *events)
 	return overhead;
 }
 
-static int count_instructions(void)
+static int test_body(void)
 {
 	struct event events[2];
 	u64 overhead;
@@ -129,6 +130,11 @@ static int count_instructions(void)
 	return 0;
 }
 
+static int count_instructions(void)
+{
+	return eat_cpu(test_body);
+}
+
 int main(void)
 {
 	return test_harness(count_instructions, "count_instructions");
-- 
1.9.1
