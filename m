Return-Path: <BATV+1d99f8073f34f075460d+4951+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjP2B0m6xzDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 05:50:42 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/19] perf probe: Factor out the ftrace README scanning
Date: Tue, 14 Mar 2017 15:50:19 -0300
Message-Id: <20170314185023.31303-16-acme@kernel.org>
In-Reply-To: <20170314185023.31303-1-acme@kernel.org>
References: <20170314185023.31303-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Simplify and separate out the ftrace README scanning logic into a
separate helper. This is used subsequently to scan for all patterns of
interest and to cache the result.

Since we are only interested in availability of probe argument type x,
we will only scan for that.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/6dc30edc747ba82a236593be6cf3a046fa9453b5.1488961018.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c | 70 +++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 1a62daceb028..8a219cd831b7 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -877,35 +877,31 @@ int probe_cache__show_all_caches(struct strfilter *filter)
 	return 0;
 }
 
+enum ftrace_readme {
+	FTRACE_README_PROBE_TYPE_X = 0,
+	FTRACE_README_END,
+};
+
 static struct {
 	const char *pattern;
-	bool	avail;
-	bool	checked;
-} probe_type_table[] = {
-#define DEFINE_TYPE(idx, pat, def_avail)	\
-	[idx] = {.pattern = pat, .avail = (def_avail)}
-	DEFINE_TYPE(PROBE_TYPE_U, "* u8/16/32/64,*", true),
-	DEFINE_TYPE(PROBE_TYPE_S, "* s8/16/32/64,*", true),
-	DEFINE_TYPE(PROBE_TYPE_X, "* x8/16/32/64,*", false),
-	DEFINE_TYPE(PROBE_TYPE_STRING, "* string,*", true),
-	DEFINE_TYPE(PROBE_TYPE_BITFIELD,
-		    "* b<bit-width>@<bit-offset>/<container-size>", true),
+	bool avail;
+} ftrace_readme_table[] = {
+#define DEFINE_TYPE(idx, pat)			\
+	[idx] = {.pattern = pat, .avail = false}
+	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
 };
 
-bool probe_type_is_available(enum probe_type type)
+static bool scan_ftrace_readme(enum ftrace_readme type)
 {
+	int fd;
 	FILE *fp;
 	char *buf = NULL;
 	size_t len = 0;
-	bool target_line = false;
-	bool ret = probe_type_table[type].avail;
-	int fd;
+	bool ret = false;
+	static bool scanned = false;
 
-	if (type >= PROBE_TYPE_END)
-		return false;
-	/* We don't have to check the type which supported by default */
-	if (ret || probe_type_table[type].checked)
-		return ret;
+	if (scanned)
+		goto result;
 
 	fd = open_trace_file("README", false);
 	if (fd < 0)
@@ -917,21 +913,29 @@ bool probe_type_is_available(enum probe_type type)
 		return ret;
 	}
 
-	while (getline(&buf, &len, fp) > 0 && !ret) {
-		if (!target_line) {
-			target_line = !!strstr(buf, " type: ");
-			if (!target_line)
-				continue;
-		} else if (strstr(buf, "\t          ") != buf)
-			break;
-		ret = strglobmatch(buf, probe_type_table[type].pattern);
-	}
-	/* Cache the result */
-	probe_type_table[type].checked = true;
-	probe_type_table[type].avail = ret;
+	while (getline(&buf, &len, fp) > 0)
+		for (enum ftrace_readme i = 0; i < FTRACE_README_END; i++)
+			if (!ftrace_readme_table[i].avail)
+				ftrace_readme_table[i].avail =
+					strglobmatch(buf, ftrace_readme_table[i].pattern);
+	scanned = true;
 
 	fclose(fp);
 	free(buf);
 
-	return ret;
+result:
+	if (type >= FTRACE_README_END)
+		return false;
+
+	return ftrace_readme_table[type].avail;
+}
+
+bool probe_type_is_available(enum probe_type type)
+{
+	if (type >= PROBE_TYPE_END)
+		return false;
+	else if (type == PROBE_TYPE_X)
+		return scan_ftrace_readme(FTRACE_README_PROBE_TYPE_X);
+
+	return true;
 }
-- 
2.9.3
