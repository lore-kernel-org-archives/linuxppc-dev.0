Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14E521A01E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:42 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 01/10] selftests/powerpc: Don't ignore errors from sub
 Makefiles
Date: Wed, 23 Jul 2014 17:31:31 +1000
Message-Id: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we ignore errors from our sub Makefiles. We inherited that
from the top-level selftests Makefile which aims to build and run as
many tests as possible and damn the torpedoes.

For the powerpc tests we'd instead like any errors to fail the build, so
we can automatically catch build failures.

We can achieve the best of both worlds by using -k, which tells make to
keep building when it hits an error, but still reports the error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/Makefile     | 10 +++++-----
 tools/testing/selftests/powerpc/pmu/Makefile | 15 ++++++---------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 54833a791a44..74a78cedce37 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -17,10 +17,10 @@ TARGETS = pmu copyloops mm tm
 
 endif
 
-all:
-	@for TARGET in $(TARGETS); do \
-		$(MAKE) -C $$TARGET all; \
-	done;
+all: $(TARGETS)
+
+$(TARGETS):
+	$(MAKE) -k -C $@ all
 
 run_tests: all
 	@for TARGET in $(TARGETS); do \
@@ -36,4 +36,4 @@ clean:
 tags:
 	find . -name '*.c' -o -name '*.h' | xargs ctags
 
-.PHONY: all run_tests clean tags
+.PHONY: all run_tests clean tags $(TARGETS)
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index b9ff0db42c79..cd256277c24e 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -4,7 +4,9 @@ noarg:
 PROGS := count_instructions
 EXTRA_SOURCES := ../harness.c event.c
 
-all: $(PROGS) sub_all
+SUB_TARGETS = ebb
+
+all: $(PROGS) $(SUB_TARGETS)
 
 $(PROGS): $(EXTRA_SOURCES)
 
@@ -20,13 +22,8 @@ run_tests: all sub_run_tests
 clean: sub_clean
 	rm -f $(PROGS) loop.o
 
-
-SUB_TARGETS = ebb
-
-sub_all:
-	@for TARGET in $(SUB_TARGETS); do \
-		$(MAKE) -C $$TARGET all; \
-	done;
+$(SUB_TARGETS):
+	$(MAKE) -k -C $@ all
 
 sub_run_tests: all
 	@for TARGET in $(SUB_TARGETS); do \
@@ -38,4 +35,4 @@ sub_clean:
 		$(MAKE) -C $$TARGET clean; \
 	done;
 
-.PHONY: all run_tests clean sub_all sub_run_tests sub_clean
+.PHONY: all run_tests clean sub_run_tests sub_clean $(SUB_TARGETS)
-- 
1.9.1
