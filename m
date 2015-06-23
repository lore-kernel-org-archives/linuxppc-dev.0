Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9019E1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 23 Jun 2015 20:28:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 276802CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5NAS3ZD62062646
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5NARcLg027350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:27:39 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: powerkvm@lists.linux.ibm.com, pmac@au1.ibm.com
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [BACKPORT PATCH 2/5] perf probe ppc64le: Fix ppc64 ABIv2 symbol
 decoding
Date: Tue, 23 Jun 2015 15:56:50 +0530
Message-Id: <6dfebbb8b9cf5b0f002599d8b72bad7d857d7789.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
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

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

ppc64 ELF ABIv2 has a Global Entry Point (GEP) and a Local Entry Point
(LEP). For purposes of probing, we need the LEP - the offset to which is
encoded in st_other.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/ab9cc5e2b9de4cbaaf50f6ef2346a6a81100bad1.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 7 +++++++
 tools/perf/util/symbol-elf.c                | 4 ++++
 tools/perf/util/symbol.h                    | 1 +
 3 files changed, 12 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index c9de001..fd11157 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -16,4 +16,11 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 	       ehdr.e_type == ET_REL ||
 	       ehdr.e_type == ET_DYN;
 }
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+void arch__elf_sym_adjust(GElf_Sym *sym)
+{
+	sym->st_value += PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
+}
+#endif
 #endif
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index ddb300b..1ffd44f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -690,6 +690,8 @@ static bool want_demangle(bool is_kernel_sym)
 	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
 }
 
+void __weak arch__elf_sym_adjust(GElf_Sym *sym __maybe_unused) { }
+
 int dso__load_sym(struct dso *dso, struct map *map,
 		  struct symsrc *syms_ss, struct symsrc *runtime_ss,
 		  symbol_filter_t filter, int kmodule)
@@ -851,6 +853,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
+		arch__elf_sym_adjust(&sym);
+
 		if (dso->kernel || kmodule) {
 			char dso_name[PATH_MAX];
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 7335790..2ef8119 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -315,6 +315,7 @@ int setup_list(struct strlist **list, const char *list_str,
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
+void arch__elf_sym_adjust(GElf_Sym *sym);
 #endif
 
 #endif /* __PERF_SYMBOL */
-- 
2.4.0
