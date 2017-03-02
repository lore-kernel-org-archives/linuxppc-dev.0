Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ0P83d3rzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 04:56:28 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v22HhbxP144319
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:56:26 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xpbpnxg5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 12:56:26 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 3 Mar 2017 03:56:23 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F11052CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 04:56:21 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v22HuDdC32833758
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 04:56:21 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v22HtnHO007367
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 04:55:49 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 2/3] perf: kretprobes: offset from reloc_sym if kernel
 supports it
Date: Thu,  2 Mar 2017 23:25:06 +0530
In-Reply-To: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170224201103.GO3595@kernel.org>
 <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <fd619418f5967ca7a77e5c1b49e632862040703b.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We indicate support for accepting sym+offset with kretprobes through a
line in ftrace README. Parse the same to identify support and choose the
appropriate format for kprobe_events.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 12 +++++-------
 tools/perf/util/probe-file.c  |  7 +++++++
 tools/perf/util/probe-file.h  |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 35f5b7b7715c..faf5789902f5 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -757,7 +757,9 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
 	}
 
 	for (i = 0; i < ntevs; i++) {
-		if (!tevs[i].point.address || tevs[i].point.retprobe)
+		if (!tevs[i].point.address)
+			continue;
+		if (tevs[i].point.retprobe && !kretprobe_offset_is_supported())
 			continue;
 		/* If we found a wrong one, mark it by NULL symbol */
 		if (kprobe_warn_out_range(tevs[i].point.symbol,
@@ -1528,11 +1530,6 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 		return -EINVAL;
 	}
 
-	if (pp->retprobe && !pp->function) {
-		semantic_error("Return probe requires an entry function.\n");
-		return -EINVAL;
-	}
-
 	if ((pp->offset || pp->line || pp->lazy_line) && pp->retprobe) {
 		semantic_error("Offset/Line/Lazy pattern can't be used with "
 			       "return probe.\n");
@@ -2841,7 +2838,8 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	}
 
 	/* Note that the symbols in the kmodule are not relocated */
-	if (!pev->uprobes && !pp->retprobe && !pev->target) {
+	if (!pev->uprobes && !pev->target &&
+			(!pp->retprobe || kretprobe_offset_is_supported())) {
 		reloc_sym = kernel_get_ref_reloc_sym();
 		if (!reloc_sym) {
 			pr_warning("Relocated base symbol is not found!\n");
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 8a219cd831b7..1542cd0d6799 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -879,6 +879,7 @@ int probe_cache__show_all_caches(struct strfilter *filter)
 
 enum ftrace_readme {
 	FTRACE_README_PROBE_TYPE_X = 0,
+	FTRACE_README_KRETPROBE_OFFSET,
 	FTRACE_README_END,
 };
 
@@ -889,6 +890,7 @@ static struct {
 #define DEFINE_TYPE(idx, pat)			\
 	[idx] = {.pattern = pat, .avail = false}
 	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
+	DEFINE_TYPE(FTRACE_README_KRETPROBE_OFFSET, "*place (kretprobe): *"),
 };
 
 static bool scan_ftrace_readme(enum ftrace_readme type)
@@ -939,3 +941,8 @@ bool probe_type_is_available(enum probe_type type)
 
 	return true;
 }
+
+bool kretprobe_offset_is_supported(void)
+{
+	return scan_ftrace_readme(FTRACE_README_KRETPROBE_OFFSET);
+}
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index a17a82eff8a0..dbf95a00864a 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -65,6 +65,7 @@ struct probe_cache_entry *probe_cache__find_by_name(struct probe_cache *pcache,
 					const char *group, const char *event);
 int probe_cache__show_all_caches(struct strfilter *filter);
 bool probe_type_is_available(enum probe_type type);
+bool kretprobe_offset_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
 static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused)
 {
-- 
2.11.1
