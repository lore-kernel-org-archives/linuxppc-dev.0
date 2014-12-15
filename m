Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97BD11A0267
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Dec 2014 00:51:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4B75C3578063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:09 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBFEp9Jd37879834
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:09 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBFEp8BW004724
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:09 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [PATCHv2 6/8] perf tools powerpc: Fix PPC64 ELF ABIv2 symbol decoding
Date: Mon, 15 Dec 2014 20:20:36 +0530
Message-Id: <c81364f6bd46c9ab9074fcb107fccf7de63cc56e.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
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
Changes from previous patchset:
Simplified logic by adding dependancy on HAVE_ARCH_SYMBOL_HANDLING. Also
generalized arch_elf_sym_decode() to be suitable for other architectures in
future.

 tools/perf/arch/powerpc/util/sym-handling.c | 10 ++++++++++
 tools/perf/util/symbol-elf.c                |  2 ++
 tools/perf/util/symbol.h                    |  6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 0a77825..a27bfaf 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -1,8 +1,10 @@
 /*
  * Special symbol handling for PowerPC:
  * - Handle dot symbols on ABIv1
+ * - Decode offset from Global entry point to Local entry point on ABIv2
  *
  * Copyright (C) 2014 Naveen N Rao, IBM Corporation.
+ * Copyright (C) 2014 Ananth N Mavinakayanahalli, IBM Corporation.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -26,3 +28,11 @@ int probe_function_filter(struct map *map __maybe_unused, struct symbol *sym)
 	}
 	return 1;
 }
+
+inline void arch_elf_sym_decode(GElf_Sym *sym __maybe_unused)
+{
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	if (sym && sym->st_other)
+		sym->st_value += PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
+#endif
+}
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7ac4e4c..557b63b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -902,6 +902,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
+		arch_elf_sym_decode(&sym);
+
 		if (dso->kernel || kmodule) {
 			char dso_name[PATH_MAX];
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 9d602e9..9e03cdf 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -294,4 +294,10 @@ int compare_proc_modules(const char *from, const char *to);
 int setup_list(struct strlist **list, const char *list_str,
 	       const char *list_name);
 
+#ifdef HAVE_ARCH_SYMBOL_HANDLING
+extern void arch_elf_sym_decode(GElf_Sym *sym __maybe_unused);
+#else
+static inline void arch_elf_sym_decode(GElf_Sym *sym __maybe_unused) { }
+#endif
+
 #endif /* __PERF_SYMBOL */
-- 
2.1.3
