Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8F121A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:15 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:12 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4EC313940061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC69Lw47251496
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC67vt004037
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 3/7] perf probe/ppc: Use the right prefix when ignoring SyS
 symbols on ppc
Date: Tue, 28 Apr 2015 17:35:36 +0530
Message-Id: <adf1f98b121ecaf292777fe5cc69fe1038feabce.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
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

Use the proper prefix when ignoring SyS symbols on ppc ABIv1. While at
it, generalize symbol selection so architectures can implement their
own logic.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changes:
- Move logic to arch helper.

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
2.3.5
