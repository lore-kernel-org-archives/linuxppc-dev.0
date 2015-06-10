Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA7491A0E83
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 17:26:31 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 03:26:29 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 45A01C9006F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:17:34 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A7QR6i58589326
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 07:26:27 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A7QQCf015425
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:27 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 16/19] perf, tools, jevents: Add support for event topics
Date: Wed, 10 Jun 2015 00:25:20 -0700
Message-Id: <1433921123-25327-17-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
index a8507c9..ea3474b 100644
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
@@ -297,6 +300,8 @@ int json_events(const char *fn,
 				   !json_streq(map, val, "null")) {
 				addfield(map, &extra_desc, ". ",
 					" Spec update: ", val);
+			} else if (json_streq(map, field, "Topic")) {
+				addfield(map, &topic, "", "", val);
 			} else if (json_streq(map, field, "Data_LA") && nz) {
 				addfield(map, &extra_desc, ". ",
 					" Supports address when precise",
@@ -320,12 +325,13 @@ int json_events(const char *fn,
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
1.8.3.1
