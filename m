Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAB051A070B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 13:57:47 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Nov 2015 21:57:45 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0F02838C8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:57:43 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB12vhH819923000
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 02:57:43 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB12vgsq007376
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:57:42 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 18/19] perf, tools, pmu-events: Fix fixed counters on Intel
Date: Mon, 30 Nov 2015 18:57:13 -0800
Message-Id: <1448938635-29176-19-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
index b4e3f01..5a28baf 100644
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
1.8.3.1
