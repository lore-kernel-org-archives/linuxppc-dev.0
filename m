Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 614701A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 07:17:33 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 14:17:31 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1CF841FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:05:31 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QKDx6V39387206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 13:13:59 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QKHHkS017134
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 14:17:19 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 18/19] perf, tools, pmu-events: Fix fixed counters on Intel
Date: Mon, 26 Oct 2015 13:14:32 -0700
Message-Id: <1445890473-22877-19-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1445890473-22877-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
 tools/perf/pmu-events/jevents.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 7347cca..247d777e 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -237,6 +237,28 @@ static void print_events_table_suffix(FILE *outfp)
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
+	for (i = 0; fixed[i].name; i++)
+		if (!strcasecmp(name, fixed[i].name))
+			return (char *)fixed[i].event;
+	return event;
+}
+
 /* Call func with each event in the json file */
 int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
@@ -324,8 +346,7 @@ int json_events(const char *fn,
 		if (msr != NULL)
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
-
-		err = func(data, name, event, desc, long_desc, topic);
+		err = func(data, name, real_event(name, event), desc, long_desc, topic);
 		free(event);
 		free(desc);
 		free(name);
-- 
2.5.3
