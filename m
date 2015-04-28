Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03C671A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:15 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7A1B9125805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:38:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC6A9n49021178
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:11 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC67Kq004054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 5/7] perf probe/ppc64le: Fix ppc64 ABIv2 symbol decoding
Date: Tue, 28 Apr 2015 17:35:38 +0530
Message-Id: <ab9cc5e2b9de4cbaaf50f6ef2346a6a81100bad1.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
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

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

ppc64 ELF ABIv2 has a Global Entry Point (GEP) and a Local Entry Point
(LEP). For purposes of probing, we need the LEP - the offset to which is
encoded in st_other.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changes:
- No changes other than move to use __weak functions

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
index 7f5d237..9d526a5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -776,6 +776,8 @@ static bool want_demangle(bool is_kernel_sym)
 	return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
 }
 
+void __weak arch__elf_sym_adjust(GElf_Sym *sym __maybe_unused) { }
+
 int dso__load_sym(struct dso *dso, struct map *map,
 		  struct symsrc *syms_ss, struct symsrc *runtime_ss,
 		  symbol_filter_t filter, int kmodule)
@@ -940,6 +942,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
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
2.3.5
