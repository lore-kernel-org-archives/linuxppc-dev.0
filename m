Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSzPF6TVZzDqH5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 00:54:09 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MDnB6A137925
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:08 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28s9xgdxpx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 08:54:07 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 19:24:03 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8D6A7394005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:24:01 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MDs1m046202906
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:24:01 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MDs0WO024656
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:24:01 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/5] perf: kretprobes: offset from reloc_sym if kernel
 supports it
Date: Wed, 22 Feb 2017 19:23:40 +0530
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <75bafc91e9d381636f68ab9923ce3d52f9157a09.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
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
 tools/perf/util/probe-event.c | 47 ++++++++++++++++++++++++++++++++++++-------
 tools/perf/util/probe-event.h |  2 ++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 35f5b7b7715c..f6bc61c47271 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -737,6 +737,41 @@ post_process_module_probe_trace_events(struct probe_trace_event *tevs,
 	return ret;
 }
 
+bool is_kretprobe_offset_supported(void)
+{
+	FILE *fp;
+	char *buf = NULL;
+	size_t len = 0;
+	bool target_line = false;
+	static int supported = -1;
+
+	if (supported >= 0)
+		return !!supported;
+
+	if (asprintf(&buf, "%s/README", tracing_path) < 0)
+		return false;
+
+	fp = fopen(buf, "r");
+	if (!fp)
+		goto end;
+
+	zfree(&buf);
+	while (getline(&buf, &len, fp) > 0) {
+		target_line = !!strstr(buf, "place (kretprobe): ");
+		if (!target_line)
+			continue;
+		supported = 1;
+	}
+	if (supported == -1)
+		supported = 0;
+
+	fclose(fp);
+end:
+	free(buf);
+
+	return !!supported;
+}
+
 static int
 post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
 				       int ntevs)
@@ -757,7 +792,9 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
 	}
 
 	for (i = 0; i < ntevs; i++) {
-		if (!tevs[i].point.address || tevs[i].point.retprobe)
+		if (!tevs[i].point.address)
+			continue;
+		if (tevs[i].point.retprobe && !is_kretprobe_offset_supported())
 			continue;
 		/* If we found a wrong one, mark it by NULL symbol */
 		if (kprobe_warn_out_range(tevs[i].point.symbol,
@@ -1528,11 +1565,6 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
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
@@ -2841,7 +2873,8 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	}
 
 	/* Note that the symbols in the kmodule are not relocated */
-	if (!pev->uprobes && !pp->retprobe && !pev->target) {
+	if (!pev->uprobes && !pev->target &&
+			(!pp->retprobe || is_kretprobe_offset_supported())) {
 		reloc_sym = kernel_get_ref_reloc_sym();
 		if (!reloc_sym) {
 			pr_warning("Relocated base symbol is not found!\n");
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 5d4e94061402..449d4f311355 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -135,6 +135,8 @@ bool perf_probe_with_var(struct perf_probe_event *pev);
 /* Check the perf_probe_event needs debuginfo */
 bool perf_probe_event_need_dwarf(struct perf_probe_event *pev);
 
+bool is_kretprobe_offset_supported(void);
+
 /* Release event contents */
 void clear_perf_probe_event(struct perf_probe_event *pev);
 void clear_probe_trace_event(struct probe_trace_event *tev);
-- 
2.11.0
