Return-Path: <BATV+578e219acb784a2ea3b2+4271+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5ED2A1A09F1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:36:59 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 04/21] perf probe ppc64le: Fix ppc64 ABIv2 symbol decoding
Date: Mon,  4 May 2015 18:36:13 -0300
Message-Id: <1430775390-22523-5-git-send-email-acme@kernel.org>
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
index 2de2cc4..012a0f8 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -17,6 +17,13 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
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
 
 #if !defined(_CALL_ELF) || _CALL_ELF != 2
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 54347ba..d99b442 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -775,6 +775,8 @@ static bool want_demangle(bool is_kernel_sym)
 	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
 }
 
+void __weak arch__elf_sym_adjust(GElf_Sym *sym __maybe_unused) { }
+
 int dso__load_sym(struct dso *dso, struct map *map,
 		  struct symsrc *syms_ss, struct symsrc *runtime_ss,
 		  symbol_filter_t filter, int kmodule)
@@ -939,6 +941,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
 		    (sym.st_value & 1))
 			--sym.st_value;
 
+		arch__elf_sym_adjust(&sym);
+
 		if (dso->kernel || kmodule) {
 			char dso_name[PATH_MAX];
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index bd50ba0..9096529 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -305,6 +305,7 @@ int setup_intlist(struct intlist **list, const char *list_str,
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
+void arch__elf_sym_adjust(GElf_Sym *sym);
 #endif
 
 #define SYMBOL_A 0
-- 
2.1.0
