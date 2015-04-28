Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CA2F1A0BE4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:26 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5A8A7125805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:38:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC69ZT37028034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:10 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC6790004029
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 2/7] perf probe/ppc: Fix symbol fixup issues due to ELF type
Date: Tue, 28 Apr 2015 17:35:35 +0530
Message-Id: <41392bb856ef62d929995e0b61967689b7915207.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, masami.hiramatsu.pt@hitachi.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com
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
---
Changes:
- Introduce arch helper to limit change to ppc.

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
index ac09c60..7f5d237 100644
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
@@ -712,8 +717,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
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
2.3.5
