Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZtmW40dVzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 03:45:15 +1100 (AEDT)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 30 Mar 2016 22:15:12 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2UGj9v39896242
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 22:15:09 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2UGj7Wp000579
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 22:15:08 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [RFC PATCH 1/2] tools/perf: Change how ppc64le symbols are fixed up
Date: Wed, 30 Mar 2016 22:13:33 +0530
Message-Id: <55e87f5862086492c1465d70f86b724e5029be6a.1459354581.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reference:
http://thread.gmane.org/gmane.linux.ports.ppc.embedded/93611/focus=93746

ppc64le functions have a Global Entry Point (GEP) and a Local Entry
Point (LEP). While placing a probe, we always prefer the LEP since it
catches function calls through both the GEP and the LEP. In order to do
this, we fixup the function entry points during elf symbol table lookup
to point to the LEPs. This works, but has two side-effects that may not
be desirable:
1. The actual function size does not get reflected accurately since we
consider functions to start from the LEP (this may not have a specific
impact on perf yet).
2. perf test kallsyms fails since the symbols loaded from the symbol
table (pointing to the LEP) do not match the symbols in kallsyms.

This patch is an (early) RFC to see if we can delay fixing up the
symbols on ppc64le. We now store the elf st_other field during symbol
table load and use this to fix up the symbols with the probe event. With
this patch, 'perf test kallsyms' passes for me on ppc64le.

This is early RFC and I have *not* done enough testing yet. I wanted to
get early feedback if this makes sense or if we are just better off
fixing the perf test itself in a different manner.

Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 12 +++++-------
 tools/perf/util/probe-event.c               |  5 +++--
 tools/perf/util/probe-event.h               |  3 ++-
 tools/perf/util/symbol-elf.c                |  6 ++----
 tools/perf/util/symbol.h                    |  1 +
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index bbc1a50..3e98a61 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -19,12 +19,6 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 	       ehdr.e_type == ET_DYN;
 }
 
-#if defined(_CALL_ELF) && _CALL_ELF == 2
-void arch__elf_sym_adjust(GElf_Sym *sym)
-{
-	sym->st_value += PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
-}
-#endif
 #endif
 
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
@@ -68,7 +62,8 @@ bool arch__prefers_symtab(void)
 #define PPC64LE_LEP_OFFSET	8
 
 void arch__fix_tev_from_maps(struct perf_probe_event *pev,
-			     struct probe_trace_event *tev, struct map *map)
+			     struct probe_trace_event *tev, struct map *map,
+			     struct symbol *sym)
 {
 	/*
 	 * ppc64 ABIv2 local entry point is currently always 2 instructions
@@ -77,6 +72,9 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS) {
 		tev->point.address += PPC64LE_LEP_OFFSET;
 		tev->point.offset += PPC64LE_LEP_OFFSET;
+	} else if (PPC64_LOCAL_ENTRY_OFFSET(sym->elf_st_other)) {
+		tev->point.address += PPC64_LOCAL_ENTRY_OFFSET(sym->elf_st_other);
+		tev->point.offset += PPC64_LOCAL_ENTRY_OFFSET(sym->elf_st_other);
 	}
 }
 #endif
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8319fbb..d786a49 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2498,7 +2498,8 @@ static int find_probe_functions(struct map *map, char *name,
 
 void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
 				struct probe_trace_event *tev __maybe_unused,
-				struct map *map __maybe_unused) { }
+				struct map *map __maybe_unused,
+				struct symbol *sym __maybe_unused) { }
 
 /*
  * Find probe function addresses from map.
@@ -2624,7 +2625,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 					strdup_or_goto(pev->args[i].type,
 							nomem_out);
 		}
-		arch__fix_tev_from_maps(pev, tev, map);
+		arch__fix_tev_from_maps(pev, tev, map, sym);
 	}
 	if (ret == skipped) {
 		ret = -ENOENT;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index e54e7b0..9bbc0c1 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -154,7 +154,8 @@ int show_available_vars(struct perf_probe_event *pevs, int npevs,
 int show_available_funcs(const char *module, struct strfilter *filter, bool user);
 bool arch__prefers_symtab(void);
 void arch__fix_tev_from_maps(struct perf_probe_event *pev,
-			     struct probe_trace_event *tev, struct map *map);
+			     struct probe_trace_event *tev, struct map *map,
+			     struct symbol *sym);
 
 /* If there is no space to write, returns -E2BIG. */
 int e_snprintf(char *str, size_t size, const char *format, ...)
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index bc229a7..4fd9651 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -777,8 +777,6 @@ static bool want_demangle(bool is_kernel_sym)
 	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
 }
 
-void __weak arch__elf_sym_adjust(GElf_Sym *sym __maybe_unused) { }
-
 int dso__load_sym(struct dso *dso, struct map *map,
 		  struct symsrc *syms_ss, struct symsrc *runtime_ss,
 		  symbol_filter_t filter, int kmodule)
@@ -954,8 +952,6 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
-		arch__elf_sym_adjust(&sym);
-
 		if (dso->kernel || kmodule) {
 			char dso_name[PATH_MAX];
 
@@ -1089,6 +1085,8 @@ new_symbol:
 		if (!f)
 			goto out_elf_end;
 
+		f->elf_st_other = sym.st_other;
+
 		if (filter && filter(curr_map, f))
 			symbol__delete(f);
 		else {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c8b7544..22e7795 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -55,6 +55,7 @@ struct symbol {
 	u16		namelen;
 	u8		binding;
 	bool		ignore;
+	u8		elf_st_other;
 	char		name[0];
 };
 
-- 
2.7.4
