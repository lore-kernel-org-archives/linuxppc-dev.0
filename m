Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxx64cRzDqhv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:04:05 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xqS8051926
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:04:04 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23n0mepfw9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:04:04 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:04:02 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 18/20] perf, tools, pmu-events: Fix fixed counters on Intel
Date: Mon, 20 Jun 2016 21:02:48 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-19-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

The JSON event lists use a different encoding for fixed counters
than perf for instructions and cycles (ref-cycles is ok)

This lead to some common events like inst_retired.any
or cpu_clk_unhalted.thread not counting, when specified with their
JSON name.

Special case these events in the jevents conversion process.
I prefer to not touch the JSON files for this, as it's intended
that standard JSON files can be just dropped into the perf
build without changes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
[Fix minor compile error]
---
 tools/perf/pmu-events/jevents.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b701d77..c8d8e4a 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -237,6 +237,29 @@ static void print_events_table_suffix(FILE *outfp)
 	fprintf(outfp, "};\n");
 }
 
+static struct fixed {
+	const char *name;
+	const char *event;
+} fixed[] = {
+	{ "inst_retired.any", "event=0xc0" },
+	{ "cpu_clk_unhalted.thread", "event=0x3c" },
+	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
+	{ NULL, NULL},
+};
+
+/*
+ * Handle different fixed counter encodings between JSON and perf.
+ */
+static char *real_event(const char *name, char *event)
+{
+	int i;
+
+	for (i = 0; fixed[i].name; i++)
+		if (!strcasecmp(name, fixed[i].name))
+			return (char *)fixed[i].event;
+	return event;
+}
+
 /* Call func with each event in the json file */
 int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
@@ -325,8 +348,8 @@ int json_events(const char *fn,
 		if (msr != NULL)
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
-
-		err = func(data, name, event, desc, long_desc, topic);
+		err = func(data, name, real_event(name, event), desc,
+			   long_desc, topic);
 		free(event);
 		free(desc);
 		free(name);
-- 
2.5.3
