Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxm5bp7zDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:03:56 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xnKd038112
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:54 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23mywwnsv5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:54 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:03:54 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 13/20] perf, tools, jevents: Add support for event topics
Date: Mon, 20 Jun 2016 21:02:43 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-14-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow assigning categories "Topics" field to the PMU events  i.e.
process the topic field from the JSON file and add a corresponding
topic field to the generated C events tables.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v14]
	[Jiri Olsa] Move this independent code off into a separate patch.
---
 tools/perf/pmu-events/jevents.c    | 12 +++++++++---
 tools/perf/pmu-events/jevents.h    |  2 +-
 tools/perf/pmu-events/pmu-events.h |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 51b864a..a4f117c 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -203,7 +203,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 }
 
 static int print_events_table_entry(void *data, char *name, char *event,
-				    char *desc, char *long_desc)
+				    char *desc, char *long_desc, char *topic)
 {
 	FILE *outfp = data;
 	/*
@@ -217,6 +217,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
 	if (long_desc && long_desc[0])
 		fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
+	if (topic)
+		fprintf(outfp, "\t.topic = \"%s\",\n", topic);
 
 	fprintf(outfp, "},\n");
 
@@ -238,7 +240,7 @@ static void print_events_table_suffix(FILE *outfp)
 /* Call func with each event in the json file */
 int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
-		      char *long_desc),
+		      char *long_desc, char *topic),
 	  void *data)
 {
 	int err = -EIO;
@@ -259,6 +261,7 @@ int json_events(const char *fn,
 		char *event = NULL, *desc = NULL, *name = NULL;
 		char *long_desc = NULL;
 		char *extra_desc = NULL;
+		char *topic = NULL;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
@@ -298,6 +301,8 @@ int json_events(const char *fn,
 				   !json_streq(map, val, "null")) {
 				addfield(map, &extra_desc, ". ",
 					" Spec update: ", val);
+			} else if (json_streq(map, field, "Topic")) {
+				addfield(map, &topic, "", "", val);
 			} else if (json_streq(map, field, "Data_LA") && nz) {
 				addfield(map, &extra_desc, ". ",
 					" Supports address when precise",
@@ -321,12 +326,13 @@ int json_events(const char *fn,
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
 
-		err = func(data, name, event, desc, long_desc);
+		err = func(data, name, event, desc, long_desc, topic);
 		free(event);
 		free(desc);
 		free(name);
 		free(long_desc);
 		free(extra_desc);
+		free(topic);
 		if (err)
 			break;
 		tok += j;
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index b0eb274..9ffcb89 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -3,7 +3,7 @@
 
 int json_events(const char *fn,
 		int (*func)(void *data, char *name, char *event, char *desc,
-				char *long_desc),
+				char *long_desc, char *topic),
 		void *data);
 char *get_cpu_str(void);
 
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 711f049..6b69f4b 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -9,6 +9,7 @@ struct pmu_event {
 	const char *event;
 	const char *desc;
 	const char *long_desc;
+	const char *topic;
 };
 
 /*
-- 
2.5.3
