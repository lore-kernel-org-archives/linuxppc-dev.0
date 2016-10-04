Return-Path: <BATV+ef2f77d1cbf736fff7a8+4790+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp33x2b8DzDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 13:37:49 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Andi Kleen <ak@linux.intel.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/22] perf pmu-events: Fix fixed counters on Intel
Date: Mon,  3 Oct 2016 23:37:20 -0300
Message-Id: <1475548641-12182-22-git-send-email-acme@kernel.org>
In-Reply-To: <1475548641-12182-1-git-send-email-acme@kernel.org>
References: <1475548641-12182-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

The JSON event lists use a different encoding for fixed counters than
perf for instructions and cycles (ref-cycles is ok)

This lead to some common events like inst_retired.any or
cpu_clk_unhalted.thread not counting, when specified with their JSON
name.

Special case these events in the jevents conversion process.  I prefer
to not touch the JSON files for this, as it's intended that standard
JSON files can be just dropped into the perf build without changes.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
[Fix minor compile error]
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1473978296-20712-18-git-send-email-sukadev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 13f4284721d5..04e106e799ac 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -306,6 +306,29 @@ static void print_events_table_suffix(FILE *outfp)
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
@@ -392,7 +415,7 @@ int json_events(const char *fn,
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
 
-		err = func(data, name, event, desc, long_desc);
+		err = func(data, name, real_event(name, event), desc, long_desc);
 		free(event);
 		free(desc);
 		free(name);
-- 
2.7.4
