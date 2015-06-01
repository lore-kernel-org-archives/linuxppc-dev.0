Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A674D1A016E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 19:44:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] selftests/powerpc: Add install support to more powerpc tests
Date: Mon,  1 Jun 2015 19:44:17 +1000
Message-Id: <1433151857-23896-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These tests were merged in parallel to the install support, update them
now to use it.

This also adds cross compile support for the VPHN test which was missing
it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/switch_endian/Makefile | 14 ++++----------
 tools/testing/selftests/powerpc/vphn/Makefile          | 13 +++++--------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/powerpc/switch_endian/Makefile b/tools/testing/selftests/powerpc/switch_endian/Makefile
index 081473db22b7..e21d10674e54 100644
--- a/tools/testing/selftests/powerpc/switch_endian/Makefile
+++ b/tools/testing/selftests/powerpc/switch_endian/Makefile
@@ -1,9 +1,8 @@
-CC := $(CROSS_COMPILE)gcc
-PROGS := switch_endian_test
+TEST_PROGS := switch_endian_test
 
 ASFLAGS += -O2 -Wall -g -nostdlib -m64
 
-all: $(PROGS)
+all: $(TEST_PROGS)
 
 switch_endian_test: check-reversed.S
 
@@ -13,12 +12,7 @@ check-reversed.o: check.o
 check-reversed.S: check-reversed.o
 	hexdump -v -e '/1 ".byte 0x%02X\n"' $< > $@
 
-run_tests: all
-	@-for PROG in $(PROGS); do \
-		./$$PROG; \
-	done;
+include ../../lib.mk
 
 clean:
-	rm -f $(PROGS) *.o check-reversed.S
-
-.PHONY: all run_tests clean
+	rm -f $(TEST_PROGS) *.o check-reversed.S
diff --git a/tools/testing/selftests/powerpc/vphn/Makefile b/tools/testing/selftests/powerpc/vphn/Makefile
index e539f775fd8f..a485f2e286ae 100644
--- a/tools/testing/selftests/powerpc/vphn/Makefile
+++ b/tools/testing/selftests/powerpc/vphn/Makefile
@@ -1,15 +1,12 @@
-PROG := test-vphn
+TEST_PROGS := test-vphn
 
 CFLAGS += -m64
 
-all: $(PROG)
+all: $(TEST_PROGS)
 
-$(PROG): ../harness.c
+$(TEST_PROGS): ../harness.c
 
-run_tests: all
-	./$(PROG)
+include ../../lib.mk
 
 clean:
-	rm -f $(PROG)
-
-.PHONY: all run_tests clean
+	rm -f $(TEST_PROGS)
-- 
2.1.0
