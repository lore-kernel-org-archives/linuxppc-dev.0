Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3 1/3] selftests: Add infrastructure for powerpc selftests
Date: Tue,  6 Aug 2013 17:42:35 +1000
Message-Id: <1375774957-30052-1-git-send-email-michael@ellerman.id.au>
Cc: Jeremy Kerr <jk@ozlabs.org>, Andrew Morton <akpm@osdl.org>,
 Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit adds a powerpc subdirectory to tools/testing/selftests,
for tests that are powerpc specific.

On other architectures nothing is built. The makefile supports cross
compilation if the user sets ARCH and CROSS_COMPILE.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
v3: Add tags
v2: No change

 tools/testing/selftests/Makefile         |  1 +
 tools/testing/selftests/powerpc/Makefile | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/Makefile

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4cb14ca..9f3eae2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -8,6 +8,7 @@ TARGETS += net
 TARGETS += ptrace
 TARGETS += timers
 TARGETS += vm
+TARGETS += powerpc
 
 all:
 	for TARGET in $(TARGETS); do \
diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
new file mode 100644
index 0000000..b315740
--- /dev/null
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -0,0 +1,39 @@
+# Makefile for powerpc selftests
+
+# ARCH can be overridden by the user for cross compiling
+ARCH ?= $(shell uname -m)
+ARCH := $(shell echo $(ARCH) | sed -e s/ppc.*/powerpc/)
+
+ifeq ($(ARCH),powerpc)
+
+GIT_VERSION = $(shell git describe --always --long --dirty || echo "unknown")
+
+CC := $(CROSS_COMPILE)$(CC)
+CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CURDIR) $(CFLAGS)
+
+export CC CFLAGS
+
+TARGETS =
+
+endif
+
+all:
+	@for TARGET in $(TARGETS); do \
+		$(MAKE) -C $$TARGET all; \
+	done;
+
+run_tests: all
+	@for TARGET in $(TARGETS); do \
+		$(MAKE) -C $$TARGET run_tests; \
+	done;
+
+clean:
+	@for TARGET in $(TARGETS); do \
+		$(MAKE) -C $$TARGET clean; \
+	done;
+	rm -f tags
+
+tags:
+	find . -name '*.c' -o -name '*.h' | xargs ctags
+
+.PHONY: all run_tests clean tags
-- 
1.8.1.2
