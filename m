Return-Path: <BATV+578e219acb784a2ea3b2+4271+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 193E91A1834
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:41:55 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 01/21] perf probe ppc: Fix symbol fixup issues due to ELF type
Date: Mon,  4 May 2015 18:36:10 -0300
Message-Id: <1430775390-22523-2-git-send-email-acme@kernel.org>
In-Reply-To: <1430775390-22523-1-git-send-email-acme@kernel.org>
References: <1430775390-22523-1-git-send-email-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

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
 tools/perf/arch/powerpc/util/Build          |  1 +
 tools/perf/arch/powerpc/util/sym-handling.c | 19 +++++++++++++++++++
 tools/perf/util/symbol-elf.c                |  8 ++++++--
 tools/perf/util/symbol.h                    |  4 ++++
 4 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/sym-handling.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 0af6e9b..7b8b0d1 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,4 +1,5 @@
 libperf-y += header.o
+libperf-y += sym-handling.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
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
index a7ab606..54347ba 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -630,6 +630,11 @@ void symsrc__destroy(struct symsrc *ss)
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
@@ -711,8 +716,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 						     ".gnu.prelink_undo",
 						     NULL) != NULL);
 	} else {
-		ss->adjust_symbols = ehdr.e_type == ET_EXEC ||
-				     ehdr.e_type == ET_REL;
+		ss->adjust_symbols = elf__needs_adjust_symbols(ehdr);
 	}
 
 	ss->name   = strdup(name);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0956150..8cb0af4 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -303,4 +303,8 @@ int setup_list(struct strlist **list, const char *list_str,
 int setup_intlist(struct intlist **list, const char *list_str,
 		  const char *list_name);
 
+#ifdef HAVE_LIBELF_SUPPORT
+bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
+#endif
+
 #endif /* __PERF_SYMBOL */
-- 
2.1.0
