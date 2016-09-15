Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZtKZ2G0tzDsZm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:25:54 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FMOaX5127944
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:52 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fr9hv5ua-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:25:52 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 16:25:51 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v21 10/19] perf, tools,
 jevents: Add support for long descriptions
Date: Thu, 15 Sep 2016 15:24:47 -0700
In-Reply-To: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1473978296-20712-11-git-send-email-sukadev@linux.vnet.ibm.com>
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
Acked-by: Ingo Molnar <mingo@kernel.org>
---

Changelog[v14]
	- [Jiri Olsa] Break up independent parts of the patch into
	  separate patches.

Changelog[v21]
	- Fix minor conflicts in tools/perf/pmu-events/jevents.c and
	  tools/perf/pmu-events/pmu-events.h
---
 tools/perf/pmu-events/jevents.c    | 32 ++++++++++++++++++++++++--------
 tools/perf/pmu-events/jevents.h    |  3 ++-
 tools/perf/pmu-events/pmu-events.h |  1 +
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index a9ca86d..f550cad 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -268,7 +268,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 }
 
 static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc)
+				    char *desc, char *long_desc)
 {
 	struct perf_entry_data *pd = data;
 	FILE *outfp = pd->outfp;
@@ -284,6 +284,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	fprintf(outfp, "\t.event = \"%s\",\n", event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
 	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
+	if (long_desc && long_desc[0])
+		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
 
 	fprintf(outfp, "},\n");
 
@@ -305,7 +307,8 @@ static void print_events_table_suffix(FILE *outfp)
 
 /* Call func with each event in the json file */
 int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc),
+	  int (*func)(void *data, char *name, char *event, char *desc,
+		      char *long_desc),
 	  void *data)
 {
 	int err = -EIO;
@@ -324,6 +327,8 @@ int json_events(const char *fn,
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
 		char *event = NULL, *desc = NULL, *name = NULL;
+		char *long_desc = NULL;
+		char *extra_desc = NULL;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
@@ -349,6 +354,10 @@ int json_events(const char *fn,
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
@@ -357,10 +366,10 @@ int json_events(const char *fn,
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
@@ -368,19 +377,26 @@ int json_events(const char *fn,
 		}
 		if (precise && desc && !strstr(desc, "(Precise Event)")) {
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
index 70d5479..2eaef59 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -9,6 +9,7 @@ struct pmu_event {
 	const char *event;
 	const char *desc;
 	const char *topic;
+	const char *long_desc;
 };
 
 /*
-- 
1.8.3.1
