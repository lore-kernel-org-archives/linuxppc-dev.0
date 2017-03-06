Return-Path: <BATV+cde3ad3f600696023d18+4943+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcVTS60P7zDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 06:38:52 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/35] perf probe: Generalize probe event file open routine
Date: Mon,  6 Mar 2017 16:38:17 -0300
Message-Id: <20170306193825.24011-28-acme@kernel.org>
In-Reply-To: <20170306193825.24011-1-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Generalize probe event file open routine into a generic function for opening
trace files.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/b580465c7a4dcd5d3b40fdf8568e6be45d0a6333.1487849577.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c | 20 +++++++++++---------
 tools/perf/util/probe-file.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 436b64731f65..1a62daceb028 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -70,7 +70,7 @@ static void print_both_open_warning(int kerr, int uerr)
 	}
 }
 
-static int open_probe_events(const char *trace_file, bool readwrite)
+int open_trace_file(const char *trace_file, bool readwrite)
 {
 	char buf[PATH_MAX];
 	int ret;
@@ -92,12 +92,12 @@ static int open_probe_events(const char *trace_file, bool readwrite)
 
 static int open_kprobe_events(bool readwrite)
 {
-	return open_probe_events("kprobe_events", readwrite);
+	return open_trace_file("kprobe_events", readwrite);
 }
 
 static int open_uprobe_events(bool readwrite)
 {
-	return open_probe_events("uprobe_events", readwrite);
+	return open_trace_file("uprobe_events", readwrite);
 }
 
 int probe_file__open(int flag)
@@ -899,6 +899,7 @@ bool probe_type_is_available(enum probe_type type)
 	size_t len = 0;
 	bool target_line = false;
 	bool ret = probe_type_table[type].avail;
+	int fd;
 
 	if (type >= PROBE_TYPE_END)
 		return false;
@@ -906,14 +907,16 @@ bool probe_type_is_available(enum probe_type type)
 	if (ret || probe_type_table[type].checked)
 		return ret;
 
-	if (asprintf(&buf, "%s/README", tracing_path) < 0)
+	fd = open_trace_file("README", false);
+	if (fd < 0)
 		return ret;
 
-	fp = fopen(buf, "r");
-	if (!fp)
-		goto end;
+	fp = fdopen(fd, "r");
+	if (!fp) {
+		close(fd);
+		return ret;
+	}
 
-	zfree(&buf);
 	while (getline(&buf, &len, fp) > 0 && !ret) {
 		if (!target_line) {
 			target_line = !!strstr(buf, " type: ");
@@ -928,7 +931,6 @@ bool probe_type_is_available(enum probe_type type)
 	probe_type_table[type].avail = ret;
 
 	fclose(fp);
-end:
 	free(buf);
 
 	return ret;
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index eba44c3e9dca..a17a82eff8a0 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -35,6 +35,7 @@ enum probe_type {
 
 /* probe-file.c depends on libelf */
 #ifdef HAVE_LIBELF_SUPPORT
+int open_trace_file(const char *trace_file, bool readwrite);
 int probe_file__open(int flag);
 int probe_file__open_both(int *kfd, int *ufd, int flag);
 struct strlist *probe_file__get_namelist(int fd);
-- 
2.9.3
