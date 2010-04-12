Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF5F9B7D1D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 12 Apr 2010 16:45:05 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o3C6ff3Q004512
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2010 16:41:41 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3C6cf1W1270004
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2010 16:38:41 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o3C6j451025895
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2010 16:45:05 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] perf: Move arch specific code into separate arch directory
Date: Mon, 12 Apr 2010 16:43:15 +1000
Message-Id: <1271054596-26561-2-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1271054596-26561-1-git-send-email-imunsie@au.ibm.com>
References: <1271054596-26561-1-git-send-email-imunsie@au.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au.ibm.com>

The perf userspace tool included some architecture specific code to map
registers from the DWARF register number into the names used by the regs
and stack access API.

This patch moves the architecture specific code out into a seperate
arch/x86 directory along with the infrastructure required to use it.

Signed-off-by: Ian Munsie <imunsie@au.ibm.com>
---
 tools/perf/Makefile                           |   18 ++++++-
 tools/perf/arch/x86/Makefile                  |    1 +
 tools/perf/arch/x86/include/arch_dwarf-regs.h |    6 ++
 tools/perf/arch/x86/util/dwarf-regs.c         |   75 +++++++++++++++++++++++++
 tools/perf/util/include/dwarf-regs.h          |    8 +++
 tools/perf/util/probe-finder.c                |   55 ++----------------
 6 files changed, 113 insertions(+), 50 deletions(-)
 create mode 100644 tools/perf/arch/x86/Makefile
 create mode 100644 tools/perf/arch/x86/include/arch_dwarf-regs.h
 create mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
 create mode 100644 tools/perf/util/include/dwarf-regs.h

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index f578b05..07a6ee2 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -172,6 +172,20 @@ uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
+				  -e s/arm.*/arm/ -e s/sa110/arm/ \
+				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
+				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
+				  -e s/sh[234].*/sh/ )
+
+# Additional ARCH settings for x86
+ifeq ($(ARCH),i386)
+        ARCH := x86
+endif
+ifeq ($(ARCH),x86_64)
+        ARCH := x86
+endif
+
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 #
@@ -284,7 +298,7 @@ endif
 # Those must not be GNU-specific; they are shared with perl/ which may
 # be built by a different compiler. (Note that this is an artifact now
 # but it still might be nice to keep that distinction.)
-BASIC_CFLAGS = -Iutil/include
+BASIC_CFLAGS = -Iutil/include -Iarch/$(ARCH)/include
 BASIC_LDFLAGS =
 
 # Guard against environment variables
@@ -366,6 +380,7 @@ LIB_H += util/include/asm/byteorder.h
 LIB_H += util/include/asm/swab.h
 LIB_H += util/include/asm/system.h
 LIB_H += util/include/asm/uaccess.h
+LIB_H += util/include/dwarf-regs.h
 LIB_H += perf.h
 LIB_H += util/cache.h
 LIB_H += util/callchain.h
@@ -484,6 +499,7 @@ PERFLIBS = $(LIB_FILE)
 
 -include config.mak.autogen
 -include config.mak
+-include arch/$(ARCH)/Makefile
 
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
new file mode 100644
index 0000000..1191403
--- /dev/null
+++ b/tools/perf/arch/x86/Makefile
@@ -0,0 +1 @@
+LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
diff --git a/tools/perf/arch/x86/include/arch_dwarf-regs.h b/tools/perf/arch/x86/include/arch_dwarf-regs.h
new file mode 100644
index 0000000..9e8da6a
--- /dev/null
+++ b/tools/perf/arch/x86/include/arch_dwarf-regs.h
@@ -0,0 +1,6 @@
+#ifndef _PREF_ARCH_PPC_DWARF_REGS_H
+#define _PREF_ARCH_PPC_DWARF_REGS_H
+
+#define get_arch_regstr(n) get_arch_regstr(n)
+
+#endif
diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/arch/x86/util/dwarf-regs.c
new file mode 100644
index 0000000..a794d30
--- /dev/null
+++ b/tools/perf/arch/x86/util/dwarf-regs.c
@@ -0,0 +1,75 @@
+/*
+ * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
+ * Extracted from probe-finder.c
+ *
+ * Written by Masami Hiramatsu <mhiramat@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+
+#include <libio.h>
+#include <dwarf-regs.h>
+
+/*
+ * Generic dwarf analysis helpers
+ */
+
+#define X86_32_MAX_REGS 8
+const char *x86_32_regs_table[X86_32_MAX_REGS] = {
+	"%ax",
+	"%cx",
+	"%dx",
+	"%bx",
+	"$stack",	/* Stack address instead of %sp */
+	"%bp",
+	"%si",
+	"%di",
+};
+
+#define X86_64_MAX_REGS 16
+const char *x86_64_regs_table[X86_64_MAX_REGS] = {
+	"%ax",
+	"%dx",
+	"%cx",
+	"%bx",
+	"%si",
+	"%di",
+	"%bp",
+	"%sp",
+	"%r8",
+	"%r9",
+	"%r10",
+	"%r11",
+	"%r12",
+	"%r13",
+	"%r14",
+	"%r15",
+};
+
+/* TODO: switching by dwarf address size */
+#ifdef __x86_64__
+#define ARCH_MAX_REGS X86_64_MAX_REGS
+#define arch_regs_table x86_64_regs_table
+#else
+#define ARCH_MAX_REGS X86_32_MAX_REGS
+#define arch_regs_table x86_32_regs_table
+#endif
+
+/* Return architecture dependent register string (for kprobe-tracer) */
+const char *get_arch_regstr(unsigned int n)
+{
+	return (n <= ARCH_MAX_REGS) ? arch_regs_table[n] : NULL;
+}
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
new file mode 100644
index 0000000..2a1cf6f
--- /dev/null
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -0,0 +1,8 @@
+#ifndef _PERF_DWARF_REGS_H_
+#define _PERF_DWARF_REGS_H_
+
+#include <arch_dwarf-regs.h>
+
+const char *get_arch_regstr(unsigned int n);
+
+#endif
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index a851377..27020fe 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -31,6 +31,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <ctype.h>
+#include <dwarf-regs.h>
 
 #include "string.h"
 #include "event.h"
@@ -38,57 +39,13 @@
 #include "util.h"
 #include "probe-finder.h"
 
-
-/*
- * Generic dwarf analysis helpers
- */
-
-#define X86_32_MAX_REGS 8
-const char *x86_32_regs_table[X86_32_MAX_REGS] = {
-	"%ax",
-	"%cx",
-	"%dx",
-	"%bx",
-	"$stack",	/* Stack address instead of %sp */
-	"%bp",
-	"%si",
-	"%di",
-};
-
-#define X86_64_MAX_REGS 16
-const char *x86_64_regs_table[X86_64_MAX_REGS] = {
-	"%ax",
-	"%dx",
-	"%cx",
-	"%bx",
-	"%si",
-	"%di",
-	"%bp",
-	"%sp",
-	"%r8",
-	"%r9",
-	"%r10",
-	"%r11",
-	"%r12",
-	"%r13",
-	"%r14",
-	"%r15",
-};
-
-/* TODO: switching by dwarf address size */
-#ifdef __x86_64__
-#define ARCH_MAX_REGS X86_64_MAX_REGS
-#define arch_regs_table x86_64_regs_table
-#else
-#define ARCH_MAX_REGS X86_32_MAX_REGS
-#define arch_regs_table x86_32_regs_table
-#endif
-
 /* Return architecture dependent register string (for kprobe-tracer) */
-static const char *get_arch_regstr(unsigned int n)
+#ifndef get_arch_regstr
+const char *get_arch_regstr(unsigned int n __attribute__((unused)))
 {
-	return (n <= ARCH_MAX_REGS) ? arch_regs_table[n] : NULL;
+	return NULL;
 }
+#endif
 
 /*
  * Compare the tail of two strings.
@@ -397,7 +354,7 @@ static void convert_location(Dwarf_Op *op, struct probe_finder *pf)
 
 	regs = get_arch_regstr(regn);
 	if (!regs)
-		die("%u exceeds max register number.", regn);
+		die("Mapping for DWARF register number %u missing on this architecture.", regn);
 
 	tvar->value = xstrdup(regs);
 	if (ref) {
-- 
1.7.0
