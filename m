Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D3ED1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 03:35:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BD0212CE8067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:01 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9HZ1Sw7143540
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:01 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9HZ0wI012134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 04:35:01 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [RFC PATCH 6/8] perf tools powerpc: Fix PPC64 ELF ABIv2 symbol
 decoding
Date: Tue,  9 Dec 2014 23:04:04 +0530
Message-Id: <fc380ddad57d90d338ea79f319c5f5d1dd6639b9.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC64 ELF ABIv2 has a Global Entry Point (GEP) and a Local Entry Point
(LEP). For purposes of probing, we need the LEP. Offset to the LEP is
encoded in st_other.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/Makefile              |  1 +
 tools/perf/arch/powerpc/util/elf-sym-decode.c | 27 +++++++++++++++++++++++++++
 tools/perf/config/Makefile                    |  1 +
 tools/perf/util/elf_sym.h                     | 13 +++++++++++++
 tools/perf/util/symbol-elf.c                  |  8 ++++++++
 5 files changed, 50 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/util/elf-sym-decode.c
 create mode 100644 tools/perf/util/elf_sym.h

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 6f7782b..8621439 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -3,4 +3,5 @@ PERF_HAVE_DWARF_REGS := 1
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/skip-callchain-idx.o
 endif
+LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/elf-sym-decode.o
 LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/header.o
diff --git a/tools/perf/arch/powerpc/util/elf-sym-decode.c b/tools/perf/arch/powerpc/util/elf-sym-decode.c
new file mode 100644
index 0000000..7434656
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/elf-sym-decode.c
@@ -0,0 +1,27 @@
+/*
+ * Decode offset from Global Entry Point to Local Entry Point on PPC64
+ * ELF ABIv2.
+ *
+ * Derived from definitions in arch/powerpc/kernel/module_64.c
+ *
+ * Copyright (C) 2014 Ananth N Mavinakayanahalli, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <gelf.h>
+#include "elf_sym.h"
+
+/* PowerPC64 ABIv2 specific values for the ELF64_Sym st_other field. */
+#define STO_PPC64_LOCAL_BIT	5
+#define STO_PPC64_LOCAL_MASK	(7 << STO_PPC64_LOCAL_BIT)
+#define PPC64_LOCAL_ENTRY_OFFSET(other)					\
+ (((1 << (((other) & STO_PPC64_LOCAL_MASK) >> STO_PPC64_LOCAL_BIT)) >> 2) << 2)
+
+unsigned int arch_elf_sym_decode_offset(GElf_Sym *sym)
+{
+	return PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
+}
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index 58f6091..8f64557 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -378,6 +378,7 @@ ifeq ($(ARCH),powerpc)
   ifndef NO_DWARF
     CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
   endif
+  CFLAGS += -DHAVE_ELF_SYM_DECODE
 endif
 
 ifndef NO_LIBUNWIND
diff --git a/tools/perf/util/elf_sym.h b/tools/perf/util/elf_sym.h
new file mode 100644
index 0000000..0176f21
--- /dev/null
+++ b/tools/perf/util/elf_sym.h
@@ -0,0 +1,13 @@
+#ifndef __PERF_ELF_SYM_H
+#define __PERF_ELF_SYM_H
+
+#ifdef HAVE_ELF_SYM_DECODE
+extern unsigned int arch_elf_sym_decode_offset(GElf_Sym *sym);
+#else
+static inline unsigned int arch_elf_sym_decode_offset(GElf_Sym *sym __maybe_unused)
+{
+	return 0;
+}
+#endif
+
+#endif	/* __PERF_ELF_SYM_H */
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 67e4392..92a424e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -10,6 +10,7 @@
 #include "vdso.h"
 #include <symbol/kallsyms.h>
 #include "debug.h"
+#include "elf_sym.h"
 
 #ifndef HAVE_ELF_GETPHDRNUM_SUPPORT
 static int elf_getphdrnum(Elf *elf, size_t *dst)
@@ -848,6 +849,13 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
+		/*
+		 * PPC64 ELF ABIv2 encodes Local Entry Point offset in
+		 * the st_other field
+		 */
+		if ((map->type == MAP__FUNCTION) && sym.st_other)
+			sym.st_value += arch_elf_sym_decode_offset(&sym);
+
 		if (dso->kernel || kmodule) {
 			char dso_name[PATH_MAX];
 
-- 
2.1.3
