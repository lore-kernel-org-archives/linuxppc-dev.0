Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D50721A031C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:15 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4B139125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:38:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC6BCH19267730
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:11 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC6831004120
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 6/7] perf probe/ppc64le: Prefer symbol table lookup over
 DWARF
Date: Tue, 28 Apr 2015 17:35:39 +0530
Message-Id: <88a10e22f4aaba2aef812824ca4b10d7beeea012.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
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
---
Changes:
- No changes other than move to use __weak functions

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
index a8c19d5..5e62a07 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2587,6 +2587,8 @@ err_out:
 	goto out;
 }
 
+bool __weak arch__prefers_symtab(void) { return false; }
+
 static int convert_to_probe_trace_events(struct perf_probe_event *pev,
 					  struct probe_trace_event **tevs,
 					  int max_tevs, const char *target)
@@ -2602,6 +2604,12 @@ static int convert_to_probe_trace_events(struct perf_probe_event *pev,
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
2.3.5
