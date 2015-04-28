Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7219A1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:16 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:14 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5B9363940067
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:10 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC69kN60489926
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC67xV004044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 4/7] perf probe/ppc: Enable matching against dot symbols
 automatically
Date: Tue, 28 Apr 2015 17:35:37 +0530
Message-Id: <652a8f3bfa919bd02a1836a128370eaed59b4a34.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
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

Allow perf probe to work on ppc ABIv1 without the need to specify the
leading dot '.' for functions. 'perf probe do_fork' works with this
patch.

We do this by changing how symbol name comparison works on ppc ABIv1 -
we simply ignore and skip over the initial dot, if one exists, during
symbol name comparison.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changes:
This patch has been redone since upstream changed quite a bit. We now implement
arch-specific helper during symbol name comparison to ignore leading dot on ppc
symbols.

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
2.3.5
