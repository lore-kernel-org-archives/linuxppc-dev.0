Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdRTx2TdhzDqZN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 19:27:33 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2889Dhv017593
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 03:27:23 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292duh9c6d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 03:27:23 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 18:27:20 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v288RAbV47775974
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:27:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v288Qjsq008034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:26:46 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 3/5] perf: probe: factor out the ftrace README scanning
Date: Wed,  8 Mar 2017 13:56:08 +0530
In-Reply-To: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <6dc30edc747ba82a236593be6cf3a046fa9453b5.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
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

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
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
