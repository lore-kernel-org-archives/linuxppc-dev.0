Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93F891A0510
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 21:16:09 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] selftests/powerpc: Use the test harness for the TM DSCR test
Date: Fri, 13 Jun 2014 21:16:04 +1000
Message-Id: <1402658164-29839-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This gives us standardised success/failure output and also handles
killing the test if it runs forever (2 minutes).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/Makefile          |  2 +-
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 51267f4..2cede23 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -2,7 +2,7 @@ PROGS := tm-resched-dscr
 
 all: $(PROGS)
 
-$(PROGS):
+$(PROGS): ../harness.c
 
 run_tests: all
 	@-for PROG in $(PROGS); do \
diff --git a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
index ee98e38..42d4c8c 100644
--- a/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-resched-dscr.c
@@ -28,6 +28,8 @@
 #include <assert.h>
 #include <asm/tm.h>
 
+#include "utils.h"
+
 #define TBEGIN          ".long 0x7C00051D ;"
 #define TEND            ".long 0x7C00055D ;"
 #define TCHECK          ".long 0x7C00059C ;"
@@ -36,7 +38,8 @@
 #define SPRN_TEXASR     0x82
 #define SPRN_DSCR       0x03
 
-int main(void) {
+int test_body(void)
+{
 	uint64_t rv, dscr1 = 1, dscr2, texasr;
 
 	printf("Check DSCR TM context switch: ");
@@ -81,10 +84,15 @@ int main(void) {
 		}
 		if (dscr2 != dscr1) {
 			printf(" FAIL\n");
-			exit(EXIT_FAILURE);
+			return 1;
 		} else {
 			printf(" OK\n");
-			exit(EXIT_SUCCESS);
+			return 0;
 		}
 	}
 }
+
+int main(void)
+{
+	return test_harness(test_body, "tm_resched_dscr");
+}
-- 
1.9.1
