Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTXKP2JghzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 22:37:45 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1NBXw5Y082904
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 06:37:42 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28stpb2kgb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 06:37:42 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 23 Feb 2017 17:07:38 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7C8C5E0063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 17:09:14 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1NBaVSv6488170
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 17:06:31 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1NBbXf0014754
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 17:07:34 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/2] perf: probe: generalize probe event file open routine
Date: Thu, 23 Feb 2017 17:07:23 +0530
In-Reply-To: <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
References: <20170223181022.7d4427714cabbb7ccd6d6673@kernel.org>
Message-Id: <b580465c7a4dcd5d3b40fdf8568e6be45d0a6333.1487849577.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

...into a generic function for opening trace files.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
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
2.11.1
