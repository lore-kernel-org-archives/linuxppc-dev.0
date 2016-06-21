Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxv1Qd4zDql8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:04:03 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xm5V095821
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:04:01 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23pe0312pr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:04:01 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:03:58 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 10/20] perf, tools,
 jevents: Add support for long descriptions
Date: Mon, 20 Jun 2016 21:02:40 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-11-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement support in jevents to parse long descriptions for events
that may have them in the JSON files. A follow on patch will make this
long description available to user through the 'perf list' command.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v14]
	- [Jiri Olsa] Break up independent parts of the patch into
	  separate patches.
---
 tools/perf/pmu-events/jevents.c    | 32 ++++++++++++++++++++++++--------
 tools/perf/pmu-events/jevents.h    |  3 ++-
 tools/perf/pmu-events/pmu-events.h |  1 +
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index aeafa82..51b864a 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -203,7 +203,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 }
 
 static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc)
+				    char *desc, char *long_desc)
 {
 	FILE *outfp = data;
 	/*
@@ -215,6 +215,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	fprintf(outfp, "\t.name = \"%s\",\n", name);
 	fprintf(outfp, "\t.event = \"%s\",\n", event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
+	if (long_desc && long_desc[0])
+		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
 
 	fprintf(outfp, "},\n");
 
@@ -235,7 +237,8 @@ static void print_events_table_suffix(FILE *outfp)
 
 /* Call func with each event in the json file */
 int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc),
+	  int (*func)(void *data, char *name, char *event, char *desc,
+		      char *long_desc),
 	  void *data)
 {
 	int err = -EIO;
@@ -254,6 +257,8 @@ int json_events(const char *fn,
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
 		char *event = NULL, *desc = NULL, *name = NULL;
+		char *long_desc = NULL;
+		char *extra_desc = NULL;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
@@ -279,6 +284,10 @@ int json_events(const char *fn,
 			} else if (json_streq(map, field, "BriefDescription")) {
 				addfield(map, &desc, "", "", val);
 				fixdesc(desc);
+			} else if (json_streq(map, field,
+					     "PublicDescription")) {
+				addfield(map, &long_desc, "", "", val);
+				fixdesc(long_desc);
 			} else if (json_streq(map, field, "PEBS") && nz) {
 				precise = val;
 			} else if (json_streq(map, field, "MSRIndex") && nz) {
@@ -287,10 +296,10 @@ int json_events(const char *fn,
 				msrval = val;
 			} else if (json_streq(map, field, "Errata") &&
 				   !json_streq(map, val, "null")) {
-				addfield(map, &desc, ". ",
+				addfield(map, &extra_desc, ". ",
 					" Spec update: ", val);
 			} else if (json_streq(map, field, "Data_LA") && nz) {
-				addfield(map, &desc, ". ",
+				addfield(map, &extra_desc, ". ",
 					" Supports address when precise",
 					NULL);
 			}
@@ -298,19 +307,26 @@ int json_events(const char *fn,
 		}
 		if (precise && !strstr(desc, "(Precise Event)")) {
 			if (json_streq(map, precise, "2"))
-				addfield(map, &desc, " ", "(Must be precise)",
-						NULL);
+				addfield(map, &extra_desc, " ",
+						"(Must be precise)", NULL);
 			else
-				addfield(map, &desc, " ",
+				addfield(map, &extra_desc, " ",
 						"(Precise event)", NULL);
 		}
+		if (desc && extra_desc)
+			addfield(map, &desc, " ", extra_desc, NULL);
+		if (long_desc && extra_desc)
+			addfield(map, &long_desc, " ", extra_desc, NULL);
 		if (msr != NULL)
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
-		err = func(data, name, event, desc);
+
+		err = func(data, name, event, desc, long_desc);
 		free(event);
 		free(desc);
 		free(name);
+		free(long_desc);
+		free(extra_desc);
 		if (err)
 			break;
 		tok += j;
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 996601f..b0eb274 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -2,7 +2,8 @@
 #define JEVENTS_H 1
 
 int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc),
+		int (*func)(void *data, char *name, char *event, char *desc,
+				char *long_desc),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 39fec04..711f049 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -8,6 +8,7 @@ struct pmu_event {
 	const char *name;
 	const char *event;
 	const char *desc;
+	const char *long_desc;
 };
 
 /*
-- 
2.5.3
