Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ0P639yjzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 04:56:26 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v22HlEEt136291
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 12:56:23 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28xpbpwxbv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 12:56:23 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 3 Mar 2017 03:56:20 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1E6A52CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 04:56:18 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v22HuA8W51576956
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 04:56:18 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v22HtjSj007320
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 04:55:45 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 1/3] perf: probe: factor out the ftrace README scanning
Date: Thu,  2 Mar 2017 23:25:05 +0530
In-Reply-To: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170224201103.GO3595@kernel.org>
 <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e4ea4dcc09ac167cc47026e6db73ac67ca001772.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify and separate out the ftrace README scanning logic into a
separate helper. This is used subsequently to scan for all patterns of
interest and to cache the result.

Since we are only interested in availability of probe argument type x,
we will only scan for that.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
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
2.11.1
