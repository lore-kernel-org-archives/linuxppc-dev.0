Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23A3A1A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 12:49:37 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <acme@kernel.org>, <naveen.n.rao@linux.vnet.ibm.com>, <jolsa@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <wangnan0@huawei.com>, <sukadev@linux.vnet.ibm.com>
Subject: [RESEND PATCH v4 2/3] tools: Move Makefile.arch from perf/config to
 tools/scripts
Date: Thu, 17 Dec 2015 01:43:51 +0000
Message-ID: <1450316632-152513-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1450316632-152513-1-git-send-email-wangnan0@huawei.com>
References: <1450316632-152513-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After this patch other directories can use this architecture detector
without directly including it from perf's directory. Libbpf would
utilize it to get proper $(ARCH) so it can receive correct uapi include
directory.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/config/Makefile      |  2 +-
 tools/perf/config/Makefile.arch | 18 ------------------
 tools/perf/tests/make           |  2 +-
 tools/scripts/Makefile.arch     | 18 ++++++++++++++++++
 4 files changed, 20 insertions(+), 20 deletions(-)
 delete mode 100644 tools/perf/config/Makefile.arch
 create mode 100644 tools/scripts/Makefile.arch

diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index a552417..34717e4 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -17,7 +17,7 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(EXTRA_WARNINGS)
 
-include $(src-perf)/config/Makefile.arch
+include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,ARCH)
 
diff --git a/tools/perf/config/Makefile.arch b/tools/perf/config/Makefile.arch
deleted file mode 100644
index e11fbd6..0000000
--- a/tools/perf/config/Makefile.arch
+++ /dev/null
@@ -1,18 +0,0 @@
-ifndef ARCH
-ARCH := $(shell uname -m 2>/dev/null || echo not)
-endif
-
-ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
-                                  -e s/sun4u/sparc/ -e s/sparc64/sparc/ \
-                                  -e /arm64/!s/arm.*/arm/ -e s/sa110/arm/ \
-                                  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-                                  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
-                                  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
-                                  -e s/tile.*/tile/ )
-
-LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
-ifeq ($(LP64), 1)
-  IS_64_BIT := 1
-else
-  IS_64_BIT := 0
-endif
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c1fbb8e..a8ede37 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -12,7 +12,7 @@ endif
 else
 PERF := .
 
-include config/Makefile.arch
+include $(srctree)/scripts/Makefile.arch
 
 # FIXME looks like x86 is the only arch running tests ;-)
 # we need some IS_(32/64) flag to make this generic
diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
new file mode 100644
index 0000000..e11fbd6
--- /dev/null
+++ b/tools/scripts/Makefile.arch
@@ -0,0 +1,18 @@
+ifndef ARCH
+ARCH := $(shell uname -m 2>/dev/null || echo not)
+endif
+
+ARCH := $(shell echo $(ARCH) | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
+                                  -e s/sun4u/sparc/ -e s/sparc64/sparc/ \
+                                  -e /arm64/!s/arm.*/arm/ -e s/sa110/arm/ \
+                                  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+                                  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
+                                  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
+                                  -e s/tile.*/tile/ )
+
+LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
+ifeq ($(LP64), 1)
+  IS_64_BIT := 1
+else
+  IS_64_BIT := 0
+endif
-- 
1.8.3.4
