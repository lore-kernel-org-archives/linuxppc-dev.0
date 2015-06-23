Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA4641A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 23 Jun 2015 20:28:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C4EFC2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5NAS1WC60358676
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5NARZkh027236
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:27:36 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: powerkvm@lists.linux.ibm.com, pmac@au1.ibm.com
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [BACKPORT PATCH 1/5] perf probe ppc: Fix symbol fixup issues due to
 ELF type
Date: Tue, 23 Jun 2015 15:56:49 +0530
Message-Id: <1e62b8db1e6b7d7fe2cafbdd3d6bb82cb3781b0d.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If using the symbol table, symbol addresses are not being fixed up
properly, resulting in probes being placed at wrong addresses:

  # perf probe do_fork
  Added new event:
    probe:do_fork        (on do_fork)

  You can now use it in all perf tools, such as:

	  perf record -e probe:do_fork -aR sleep 1

  # cat /sys/kernel/debug/tracing/kprobe_events
  p:probe/do_fork _text+635952
  # printf "%x" 635952
  9b430
  # grep do_fork /boot/System.map
  c0000000000ab430 T .do_fork

Fix by checking for ELF type ET_DYN used by ppc64 kernels.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/41392bb856ef62d929995e0b61967689b7915207.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/Makefile            |  1 +
 tools/perf/arch/powerpc/util/sym-handling.c | 19 +++++++++++++++++++
 tools/perf/util/symbol-elf.c                |  8 ++++++--
 tools/perf/util/symbol.h                    |  4 ++++
 4 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/sym-handling.c

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 6f7782b..85d2306 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -4,3 +4,4 @@ LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/skip-callchain-idx.o
 endif
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/header.o
+LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/sym-handling.o
diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
new file mode 100644
index 0000000..c9de001
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -0,0 +1,19 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
+ */
+
+#include "debug.h"
+#include "symbol.h"
+
+#ifdef HAVE_LIBELF_SUPPORT
+bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
+{
+	return ehdr.e_type == ET_EXEC ||
+	       ehdr.e_type == ET_REL ||
+	       ehdr.e_type == ET_DYN;
+}
+#endif
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1e23a5b..ddb300b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -563,6 +563,11 @@ void symsrc__destroy(struct symsrc *ss)
 	close(ss->fd);
 }
 
+bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
+{
+	return ehdr.e_type == ET_EXEC || ehdr.e_type == ET_REL;
+}
+
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		 enum dso_binary_type type)
 {
@@ -628,8 +633,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 						     ".gnu.prelink_undo",
 						     NULL) != NULL);
 	} else {
-		ss->adjust_symbols = ehdr.e_type == ET_EXEC ||
-				     ehdr.e_type == ET_REL;
+		ss->adjust_symbols = elf__needs_adjust_symbols(ehdr);
 	}
 
 	ss->name   = strdup(name);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index eb2c19b..7335790 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -313,4 +313,8 @@ int compare_proc_modules(const char *from, const char *to);
 int setup_list(struct strlist **list, const char *list_str,
 	       const char *list_name);
 
+#ifdef HAVE_LIBELF_SUPPORT
+bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
+#endif
+
 #endif /* __PERF_SYMBOL */
-- 
2.4.0
