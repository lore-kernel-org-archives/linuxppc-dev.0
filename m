Return-Path: <BATV+578e219acb784a2ea3b2+4271+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D63BE1A11A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:38:24 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 03/21] perf probe ppc: Enable matching against dot symbols
 automatically
Date: Mon,  4 May 2015 18:36:12 -0300
Message-Id: <1430775390-22523-4-git-send-email-acme@kernel.org>
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

Allow perf probe to work on ppc ABIv1 without the need to specify the
leading dot '.' for functions. 'perf probe do_fork' works with this
patch.

We do this by changing how symbol name comparison works on ppc ABIv1 -
we simply ignore and skip over the initial dot, if one exists, during
symbol name comparison.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/652a8f3bfa919bd02a1836a128370eaed59b4a34.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 13 +++++++++++++
 tools/perf/util/map.c                       |  5 +++++
 tools/perf/util/map.h                       |  3 ++-
 tools/perf/util/symbol.c                    |  4 ++--
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 5522a40..2de2cc4 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -8,6 +8,7 @@
 
 #include "debug.h"
 #include "symbol.h"
+#include "map.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
@@ -36,4 +37,16 @@ int arch__choose_best_symbol(struct symbol *syma,
 
 	return SYMBOL_A;
 }
+
+/* Allow matching against dot variants */
+int arch__compare_symbol_names(const char *namea, const char *nameb)
+{
+	/* Skip over initial dot */
+	if (*namea == '.')
+		namea++;
+	if (*nameb == '.')
+		nameb++;
+
+	return strcmp(namea, nameb);
+}
 #endif
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a14f08f..cd0e335 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -292,6 +292,11 @@ int map__load(struct map *map, symbol_filter_t filter)
 	return 0;
 }
 
+int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
+{
+	return strcmp(namea, nameb);
+}
+
 struct symbol *map__find_symbol(struct map *map, u64 addr,
 				symbol_filter_t filter)
 {
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index ec19c59..4e0c729 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -124,7 +124,7 @@ struct thread;
  */
 #define __map__for_each_symbol_by_name(map, sym_name, pos, filter)	\
 	for (pos = map__find_symbol_by_name(map, sym_name, filter);	\
-	     pos && strcmp(pos->name, sym_name) == 0;		\
+	     pos && arch__compare_symbol_names(pos->name, sym_name) == 0;	\
 	     pos = symbol__next_by_name(pos))
 
 #define map__for_each_symbol_by_name(map, sym_name, pos)		\
@@ -132,6 +132,7 @@ struct thread;
 
 typedef int (*symbol_filter_t)(struct map *map, struct symbol *sym);
 
+int arch__compare_symbol_names(const char *namea, const char *nameb);
 void map__init(struct map *map, enum map_type type,
 	       u64 start, u64 end, u64 pgoff, struct dso *dso);
 struct map *map__new(struct machine *machine, u64 start, u64 len,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f805757..45ba48a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -411,7 +411,7 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
 		int cmp;
 
 		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
-		cmp = strcmp(name, s->sym.name);
+		cmp = arch__compare_symbol_names(name, s->sym.name);
 
 		if (cmp < 0)
 			n = n->rb_left;
@@ -429,7 +429,7 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
 		struct symbol_name_rb_node *tmp;
 
 		tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
-		if (strcmp(tmp->sym.name, s->sym.name))
+		if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
 			break;
 
 		s = tmp;
-- 
2.1.0
