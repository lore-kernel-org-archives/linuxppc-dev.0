Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B96F51A0F92
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:21 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 23 Jun 2015 20:28:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 846842CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:17 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5NAS7Vv37158950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:28:15 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5NARinK027443
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 20:27:44 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: powerkvm@lists.linux.ibm.com, pmac@au1.ibm.com
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [BACKPORT PATCH 3/5] perf probe ppc64le: Prefer symbol table lookup
 over DWARF
Date: Tue, 23 Jun 2015 15:56:51 +0530
Message-Id: <789192189498d479b0968845e262b2168e9f5022.1435051955.git.naveen.n.rao@linux.vnet.ibm.com>
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
index fd11157..e8f95e5 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -8,6 +8,7 @@
 
 #include "debug.h"
 #include "symbol.h"
+#include "probe-event.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
@@ -24,3 +25,10 @@ void arch__elf_sym_adjust(GElf_Sym *sym)
 }
 #endif
 #endif
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+bool arch__prefers_symtab(void)
+{
+	return true;
+}
+#endif
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index c150ca4..7cc4e47 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2337,6 +2337,8 @@ err_out:
 	goto out;
 }
 
+bool __weak arch__prefers_symtab(void) { return false; }
+
 static int convert_to_probe_trace_events(struct perf_probe_event *pev,
 					  struct probe_trace_event **tevs,
 					  int max_tevs, const char *target)
@@ -2352,6 +2354,12 @@ static int convert_to_probe_trace_events(struct perf_probe_event *pev,
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
index e01e994..bb65a7b 100644
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
2.4.0
