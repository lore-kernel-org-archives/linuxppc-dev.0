Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZtKn1yVbzDsYx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 08:26:05 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FMN2qY028018
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:26:03 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25f8udm197-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:26:03 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 18:26:02 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v21 17/19] perf, tools, pmu-events: Fix fixed counters on Intel
Date: Thu, 15 Sep 2016 15:24:54 -0700
In-Reply-To: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1473978296-20712-18-git-send-email-sukadev@linux.vnet.ibm.com>
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
Acked-by: Ingo Molnar <mingo@kernel.org>
---
Changelog[v21]:
	Fix minor conflict in tools/perf/pmu-events/jevents.c
---
 tools/perf/pmu-events/jevents.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9cdfbaa..e8e2a87 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -305,6 +305,29 @@ static void print_events_table_suffix(FILE *outfp)
 	close_table = 0;
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
@@ -391,7 +414,7 @@ int json_events(const char *fn,
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
 
-		err = func(data, name, event, desc, long_desc);
+		err = func(data, name, real_event(name, event), desc, long_desc);
 		free(event);
 		free(desc);
 		free(name);
-- 
1.8.3.1
