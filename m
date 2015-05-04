Return-Path: <BATV+fa775b7f4a918d778493+4271+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D0DC1A057B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:36:48 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 05/21] perf probe ppc64le: Prefer symbol table lookup over
 DWARF
Date: Mon,  4 May 2015 18:36:14 -0300
Message-Id: <1430775390-22523-6-git-send-email-acme@kernel.org>
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

Use symbol table lookups by default if DWARF is not necessary, since
powerpc ABIv2 encodes local entry points in the symbol table and the
function entry address in DWARF may not be appropriate for kprobes, as
described here:

https://sourceware.org/bugzilla/show_bug.cgi?id=17638

"The DWARF address ranges deliberately include the *whole* function,
both global and local entry points."
...
"If you want to set probes on a local entry point, you should look up
the symbol in the main symbol table (not DWARF), and check the st_other
bits; they will indicate whether the function has a local entry point,
and what its offset from the global entry point is.  Note that GDB does
the same when setting a breakpoint on a function entry."

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/88a10e22f4aaba2aef812824ca4b10d7beeea012.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 8 ++++++++
 tools/perf/util/probe-event.c               | 8 ++++++++
 tools/perf/util/probe-event.h               | 1 +
 3 files changed, 17 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 012a0f8..a170060 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -9,6 +9,7 @@
 #include "debug.h"
 #include "symbol.h"
 #include "map.h"
+#include "probe-event.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
@@ -57,3 +58,10 @@ int arch__compare_symbol_names(const char *namea, const char *nameb)
 	return strcmp(namea, nameb);
 }
 #endif
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+bool arch__prefers_symtab(void)
+{
+	return true;
+}
+#endif
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 291bf23..4dfb412 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2567,6 +2567,8 @@ err_out:
 	goto out;
 }
 
+bool __weak arch__prefers_symtab(void) { return false; }
+
 static int convert_to_probe_trace_events(struct perf_probe_event *pev,
 					  struct probe_trace_event **tevs,
 					  int max_tevs, const char *target)
@@ -2582,6 +2584,12 @@ static int convert_to_probe_trace_events(struct perf_probe_event *pev,
 		}
 	}
 
+	if (arch__prefers_symtab() && !perf_probe_event_need_dwarf(pev)) {
+		ret = find_probe_trace_events_from_map(pev, tevs, max_tevs, target);
+		if (ret > 0)
+			return ret; /* Found in symbol table */
+	}
+
 	/* Convert perf_probe_event with debuginfo */
 	ret = try_to_find_probe_trace_events(pev, tevs, max_tevs, target);
 	if (ret != 0)
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index d6b7834..52bca4b 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -135,6 +135,7 @@ extern int show_available_vars(struct perf_probe_event *pevs, int npevs,
 			       struct strfilter *filter, bool externs);
 extern int show_available_funcs(const char *module, struct strfilter *filter,
 				bool user);
+bool arch__prefers_symtab(void);
 
 /* Maximum index number of event-name postfix */
 #define MAX_EVENT_INDEX	1024
-- 
2.1.0
