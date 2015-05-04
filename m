Return-Path: <BATV+578e219acb784a2ea3b2+4271+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6667F1A0B6C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:36:59 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 02/21] perf probe ppc: Use the right prefix when ignoring SyS
 symbols on ppc
Date: Mon,  4 May 2015 18:36:11 -0300
Message-Id: <1430775390-22523-3-git-send-email-acme@kernel.org>
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

Use the proper prefix when ignoring SyS symbols on ppc ABIv1. While at
it, generalize symbol selection so architectures can implement their own
logic.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/adf1f98b121ecaf292777fe5cc69fe1038feabce.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 20 ++++++++++++++++++++
 tools/perf/util/symbol.c                    | 21 ++++++++++++---------
 tools/perf/util/symbol.h                    |  5 +++++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index c9de001..5522a40 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -17,3 +17,23 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 	       ehdr.e_type == ET_DYN;
 }
 #endif
+
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
+int arch__choose_best_symbol(struct symbol *syma,
+			     struct symbol *symb __maybe_unused)
+{
+	char *sym = syma->name;
+
+	/* Skip over any initial dot */
+	if (*sym == '.')
+		sym++;
+
+	/* Avoid "SyS" kernel syscall aliases */
+	if (strlen(sym) >= 3 && !strncmp(sym, "SyS", 3))
+		return SYMBOL_B;
+	if (strlen(sym) >= 10 && !strncmp(sym, "compat_SyS", 10))
+		return SYMBOL_B;
+
+	return SYMBOL_A;
+}
+#endif
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 201f6c4c..f805757 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -85,8 +85,17 @@ static int prefix_underscores_count(const char *str)
 	return tail - str;
 }
 
-#define SYMBOL_A 0
-#define SYMBOL_B 1
+int __weak arch__choose_best_symbol(struct symbol *syma,
+				    struct symbol *symb __maybe_unused)
+{
+	/* Avoid "SyS" kernel syscall aliases */
+	if (strlen(syma->name) >= 3 && !strncmp(syma->name, "SyS", 3))
+		return SYMBOL_B;
+	if (strlen(syma->name) >= 10 && !strncmp(syma->name, "compat_SyS", 10))
+		return SYMBOL_B;
+
+	return SYMBOL_A;
+}
 
 static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 {
@@ -134,13 +143,7 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	else if (na < nb)
 		return SYMBOL_B;
 
-	/* Avoid "SyS" kernel syscall aliases */
-	if (na >= 3 && !strncmp(syma->name, "SyS", 3))
-		return SYMBOL_B;
-	if (na >= 10 && !strncmp(syma->name, "compat_SyS", 10))
-		return SYMBOL_B;
-
-	return SYMBOL_A;
+	return arch__choose_best_symbol(syma, symb);
 }
 
 void symbols__fixup_duplicate(struct rb_root *symbols)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 8cb0af4..bd50ba0 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -307,4 +307,9 @@ int setup_intlist(struct intlist **list, const char *list_str,
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr);
 #endif
 
+#define SYMBOL_A 0
+#define SYMBOL_B 1
+
+int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
+
 #endif /* __PERF_SYMBOL */
-- 
2.1.0
