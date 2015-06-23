Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB1621A0F9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:22 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 23 Jun 2015 20:28:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F28933578048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:19 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5NASB3947317104
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5NARkPY027505
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:27:47 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: powerkvm@lists.linux.ibm.com, pmac@au1.ibm.com
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [BACKPORT PATCH 4/5] perf probe ppc64le: Fixup function entry if
 using kallsyms lookup
Date: Tue, 23 Jun 2015 15:56:52 +0530
Message-Id: <d221b53a26ffca343c979088715252970901511a.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
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

On powerpc ABIv2, if no debug-info is found and we use kallsyms, we need
to fixup the function entry to point to the local entry point. Use
offset of 8 since current toolchains always generate 2 instructions (8
bytes).

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/92253021e77a104b23b615c8c23bf9501dfe60bf.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 16 ++++++++++++++++
 tools/perf/util/probe-event.c               |  5 +++++
 tools/perf/util/probe-event.h               |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index e8f95e5..b28b5ec 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -8,6 +8,7 @@
 
 #include "debug.h"
 #include "symbol.h"
+#include "map.h"
 #include "probe-event.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
@@ -31,4 +32,19 @@ bool arch__prefers_symtab(void)
 {
 	return true;
 }
+
+#define PPC64LE_LEP_OFFSET	8
+
+void arch__fix_tev_from_maps(struct perf_probe_event *pev,
+			     struct probe_trace_event *tev, struct map *map)
+{
+	/*
+	 * ppc64 ABIv2 local entry point is currently always 2 instructions
+	 * (8 bytes) after the global entry point.
+	 */
+	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS) {
+		tev->point.address += PPC64LE_LEP_OFFSET;
+		tev->point.offset += PPC64LE_LEP_OFFSET;
+	}
+}
 #endif
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 7cc4e47..963efb0 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2206,6 +2206,10 @@ static int probe_function_filter(struct map *map __maybe_unused,
 #define strdup_or_goto(str, label)	\
 	({ char *__p = strdup(str); if (!__p) goto label; __p; })
 
+void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
+				struct probe_trace_event *tev __maybe_unused,
+				struct map *map __maybe_unused) { }
+
 /*
  * Find probe function addresses from map.
  * Return an error or the number of found probe_trace_event
@@ -2319,6 +2323,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 					strdup_or_goto(pev->args[i].type,
 							nomem_out);
 		}
+		arch__fix_tev_from_maps(pev, tev, map);
 	}
 
 out:
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index bb65a7b..006adba 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -136,6 +136,8 @@ extern int show_available_vars(struct perf_probe_event *pevs, int npevs,
 extern int show_available_funcs(const char *module, struct strfilter *filter,
 				bool user);
 bool arch__prefers_symtab(void);
+void arch__fix_tev_from_maps(struct perf_probe_event *pev,
+			     struct probe_trace_event *tev, struct map *map);
 
 /* Maximum index number of event-name postfix */
 #define MAX_EVENT_INDEX	1024
-- 
2.4.0
