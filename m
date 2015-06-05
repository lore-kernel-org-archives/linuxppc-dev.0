Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8E711A08DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:17 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:15 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BCAE23E40030
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:28:12 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556RuxR48693272
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:27:56 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556SC4I008144
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:12 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 13/19] perf, tools,
 jevents: Add support for long descriptions
Date: Thu,  4 Jun 2015 23:27:21 -0700
Message-Id: <1433485647-9314-14-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Changelog[v14]
	- [Jiri Olsa] Break up independent parts of the patch into
	  separate patches.
---
 tools/perf/pmu-events/jevents.c    |   31 +++++++++++++++++++++++--------
 tools/perf/pmu-events/jevents.h    |    3 ++-
 tools/perf/pmu-events/pmu-events.h |    1 +
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 5f7603b..a8507c9 100644
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
@@ -279,6 +284,9 @@ int json_events(const char *fn,
 			} else if (json_streq(map, field, "BriefDescription")) {
 				addfield(map, &desc, "", "", val);
 				fixdesc(desc);
+			} else if (json_streq(map, field, "PublicDescription")) {
+				addfield(map, &long_desc, "", "", val);
+				fixdesc(long_desc);
 			} else if (json_streq(map, field, "PEBS") && nz) {
 				precise = val;
 			} else if (json_streq(map, field, "MSRIndex") && nz) {
@@ -287,10 +295,10 @@ int json_events(const char *fn,
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
@@ -298,19 +306,26 @@ int json_events(const char *fn,
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
1.7.9.5
