Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdRTz5rKGzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 19:27:35 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v288LFZd091579
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 03:27:27 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292ec805n0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 03:27:27 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 18:27:24 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v288REIK33816668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:27:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v288Qnw0008113
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:26:49 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 4/5] perf: kretprobes: offset from reloc_sym if kernel
 supports it
Date: Wed,  8 Mar 2017 13:56:09 +0530
In-Reply-To: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <496ef9f33c1ab16286ece9dd62aa672807aef91c.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
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

As an example, without this perf patch, but with the ftrace changes:

  naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/tracing/README | grep kretprobe
  place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>
  naveen@ubuntu:~/linux/tools/perf$
  naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -v do_open%return
  probe-definition(0): do_open%return
  symbol:do_open file:(null) line:0 offset:0 return:1 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /boot/vmlinux for symbols
  Open Debuginfo file: /boot/vmlinux
  Try to find probe point from debuginfo.
  Matched function: do_open [2d0c7d8]
  Probe point found: do_open+0
  Matched function: do_open [35d76b5]
  found inline addr: 0xc0000000004ba984
  Failed to find "do_open%return",
   because do_open is an inlined function and has no return point.
  An error occurred in debuginfo analysis (-22).
  Trying to use symbols.
  Opening /sys/kernel/debug/tracing//kprobe_events write=1
  Writing event: r:probe/do_open do_open+0
  Writing event: r:probe/do_open_1 do_open+0
  Added new events:
    probe:do_open        (on do_open%return)
    probe:do_open_1      (on do_open%return)

  You can now use it in all perf tools, such as:

	  perf record -e probe:do_open_1 -aR sleep 1

  naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/list
  c000000000041370  k  kretprobe_trampoline+0x0    [OPTIMIZED]
  c0000000004433d0  r  do_open+0x0    [DISABLED]
  c0000000004433d0  r  do_open+0x0    [DISABLED]

And after this patch (and the subsequent powerpc patch):

  naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -v do_open%return
  probe-definition(0): do_open%return
  symbol:do_open file:(null) line:0 offset:0 return:1 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /boot/vmlinux for symbols
  Open Debuginfo file: /boot/vmlinux
  Try to find probe point from debuginfo.
  Matched function: do_open [2d0c7d8]
  Probe point found: do_open+0
  Matched function: do_open [35d76b5]
  found inline addr: 0xc0000000004ba984
  Failed to find "do_open%return",
   because do_open is an inlined function and has no return point.
  An error occurred in debuginfo analysis (-22).
  Trying to use symbols.
  Opening /sys/kernel/debug/tracing//README write=0
  Opening /sys/kernel/debug/tracing//kprobe_events write=1
  Writing event: r:probe/do_open _text+4469712
  Writing event: r:probe/do_open_1 _text+4956248
  Added new events:
    probe:do_open        (on do_open%return)
    probe:do_open_1      (on do_open%return)

  You can now use it in all perf tools, such as:

	  perf record -e probe:do_open_1 -aR sleep 1

  naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/list
  c000000000041370  k  kretprobe_trampoline+0x0    [OPTIMIZED]
  c0000000004433d0  r  do_open+0x0    [DISABLED]
  c0000000004ba058  r  do_open+0x8    [DISABLED]

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 12 +++++-------
 tools/perf/util/probe-file.c  |  7 +++++++
 tools/perf/util/probe-file.h  |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 28fb62c32678..c9bdc9ded0c3 100644
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
