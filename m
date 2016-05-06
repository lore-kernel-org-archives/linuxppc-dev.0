Return-Path: <BATV+855daf51ec5a7c0bcd54+4639+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1CN163LfzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:29:53 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Mark Wielaard <mjw@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/17] perf symbols: Fix kallsyms perf test on ppc64le
Date: Thu,  5 May 2016 21:29:38 -0300
Message-Id: <1462494580-27164-16-git-send-email-acme@kernel.org>
In-Reply-To: <1462494580-27164-1-git-send-email-acme@kernel.org>
References: <1462494580-27164-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

ppc64le functions have a Global Entry Point (GEP) and a Local Entry
Point (LEP). While placing a probe, we always prefer the LEP since it
catches function calls through both the GEP and the LEP. In order to do
this, we fixup the function entry points during elf symbol table lookup
to point to the LEPs. This works, but breaks 'perf test kallsyms' since
the symbols loaded from the symbol table (pointing to the LEP) do not
match the symbols in kallsyms.

To fix this, we do not adjust all the symbols during symbol table load.
Instead, we note down st_other in a newly introduced arch-specific
member of perf symbol structure, and later use this to adjust the probe
trace point.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: Mark Wielaard <mjw@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/6be7c2b17e370100c2f79dd444509df7929bdd3e.1460451721.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 28 ++++++++++++++++++++--------
 tools/perf/util/probe-event.c               |  5 +++--
 tools/perf/util/probe-event.h               |  3 ++-
 tools/perf/util/symbol-elf.c                |  7 ++++---
 tools/perf/util/symbol.h                    |  3 ++-
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 6974ba0fa065..c6d0f91731a1 100644
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
@@ -65,11 +59,21 @@ bool arch__prefers_symtab(void)
 	return true;
 }
 
+#ifdef HAVE_LIBELF_SUPPORT
+void arch__sym_update(struct symbol *s, GElf_Sym *sym)
+{
+	s->arch_sym = sym->st_other;
+}
+#endif
+
 #define PPC64LE_LEP_OFFSET	8
 
 void arch__fix_tev_from_maps(struct perf_probe_event *pev,
-			     struct probe_trace_event *tev, struct map *map)
+			     struct probe_trace_event *tev, struct map *map,
+			     struct symbol *sym)
 {
+	int lep_offset;
+
 	/*
 	 * When probing at a function entry point, we normally always want the
 	 * LEP since that catches calls to the function through both the GEP and
@@ -82,10 +86,18 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 	 *
 	 * In addition, we shouldn't specify an offset for kretprobes.
 	 */
-	if (pev->point.offset || pev->point.retprobe || !map)
+	if (pev->point.offset || pev->point.retprobe || !map || !sym)
 		return;
 
+	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
+
 	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
 		tev->point.offset += PPC64LE_LEP_OFFSET;
+	else if (lep_offset) {
+		if (pev->uprobes)
+			tev->point.address += lep_offset;
+		else
+			tev->point.offset += lep_offset;
+	}
 }
 #endif
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 85d82f4dc5e9..c82c625395ab 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2477,7 +2477,8 @@ static int find_probe_functions(struct map *map, char *name,
 
 void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
 				struct probe_trace_event *tev __maybe_unused,
-				struct map *map __maybe_unused) { }
+				struct map *map __maybe_unused,
+				struct symbol *sym __maybe_unused) { }
 
 /*
  * Find probe function addresses from map.
@@ -2614,7 +2615,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 					strdup_or_goto(pev->args[i].type,
 							nomem_out);
 		}
-		arch__fix_tev_from_maps(pev, tev, map);
+		arch__fix_tev_from_maps(pev, tev, map, sym);
 	}
 	if (ret == skipped) {
 		ret = -ENOENT;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index e2209623f981..5a27eb4fad05 100644
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
index 3f9d6798bd18..87a297dd8901 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -770,7 +770,8 @@ static bool want_demangle(bool is_kernel_sym)
 	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
 }
 
-void __weak arch__elf_sym_adjust(GElf_Sym *sym __maybe_unused) { }
+void __weak arch__sym_update(struct symbol *s __maybe_unused,
+		GElf_Sym *sym __maybe_unused) { }
 
 int dso__load_sym(struct dso *dso, struct map *map,
 		  struct symsrc *syms_ss, struct symsrc *runtime_ss,
@@ -947,8 +948,6 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
-		arch__elf_sym_adjust(&sym);
-
 		if (dso->kernel || kmodule) {
 			char dso_name[PATH_MAX];
 
@@ -1082,6 +1081,8 @@ new_symbol:
 		if (!f)
 			goto out_elf_end;
 
+		arch__sym_update(f, &sym);
+
 		if (filter && filter(curr_map, f))
 			symbol__delete(f);
 		else {
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c8e43979ed5c..07211c2f8456 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -55,6 +55,7 @@ struct symbol {
 	u16		namelen;
 	u8		binding;
 	bool		ignore;
+	u8		arch_sym;
 	char		name[0];
 };
 
@@ -323,7 +324,7 @@ int setup_intlist(struct intlist **list, const char *list_str,
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
-void arch__elf_sym_adjust(GElf_Sym *sym);
+void arch__sym_update(struct symbol *s, GElf_Sym *sym);
 #endif
 
 #define SYMBOL_A 0
-- 
2.5.5
