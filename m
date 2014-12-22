Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB55C1A0C29
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 18:50:02 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 00:50:00 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1045F6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 02:41:52 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBM7nwCp27000936
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 07:49:58 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBM7nvF3024052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 02:49:58 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v6 1/4] tools/perf: support parsing parameterized events
Date: Sun, 21 Dec 2014 23:49:24 -0800
Message-Id: <1419234567-22784-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, dev@codyps.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <cody@linux.vnet.ibm.com>

Enable event specification like:

	pmu/event_name,param1=0x1,param2=0x4/

Assuming that

	/sys/bus/event_source/devices/pmu/events/event_name

Contains something like

	param2=?,bar=1,param1=?

Changelog[v4]:
	[Jiri Olsa] Merge to recent perf-core and fix a small conflict.

Changelog[v3]:
	[Jiri Olsa] If the sysfs event file specifies 'param=val', make the
	usage 'hv_24x7/event,param=123/' rather than 'hv_24x7/event,val=123/'.

CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/pmu.c          | 65 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index db2cf78..ca226ce 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -71,6 +71,7 @@ struct parse_events_term {
 	int type_val;
 	int type_term;
 	struct list_head list;
+	bool used;
 };
 
 struct parse_events_evlist {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5c9c494..cb516dd 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -551,31 +551,68 @@ static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
 }
 
 /*
+ * Term is a string term, and might be a param-term. Try to look up it's value
+ * in the remaining terms.
+ * - We have a term like "base-or-format-term=param-term",
+ * - We need to find the value supplied for "param-term" (with param-term named
+ *   in a config string) later on in the term list.
+ */
+static int pmu_resolve_param_term(struct parse_events_term *term,
+				  struct list_head *head_terms,
+				  __u64 *value)
+{
+	struct parse_events_term *t;
+
+	list_for_each_entry(t, head_terms, list) {
+		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
+			if (!strcmp(t->config, term->config)) {
+				t->used = true;
+				*value = t->val.num;
+				return 0;
+			}
+		}
+	}
+
+	if (verbose)
+		printf("Required parameter '%s' not specified\n", term->config);
+
+	return -1;
+}
+
+/*
  * Setup one of config[12] attr members based on the
  * user input data - term parameter.
  */
 static int pmu_config_term(struct list_head *formats,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
+			   struct list_head *head_terms,
 			   bool zero)
 {
 	struct perf_pmu_format *format;
 	__u64 *vp;
+	__u64 val;
+
+	/*
+	 * If this is a parameter we've already used for parameterized-eval,
+	 * skip it in normal eval.
+	 */
+	if (term->used)
+		return 0;
 
 	/*
-	 * Support only for hardcoded and numnerial terms.
 	 * Hardcoded terms should be already in, so nothing
 	 * to be done for them.
 	 */
 	if (parse_events__is_hardcoded_term(term))
 		return 0;
 
-	if (term->type_val != PARSE_EVENTS__TERM_TYPE_NUM)
-		return -EINVAL;
-
 	format = pmu_find_format(formats, term->config);
-	if (!format)
+	if (!format) {
+		if (verbose)
+			printf("Invalid event/parameter '%s'\n", term->config);
 		return -EINVAL;
+	}
 
 	switch (format->value) {
 	case PERF_PMU_FORMAT_VALUE_CONFIG:
@@ -592,11 +629,16 @@ static int pmu_config_term(struct list_head *formats,
 	}
 
 	/*
-	 * XXX If we ever decide to go with string values for
-	 * non-hardcoded terms, here's the place to translate
-	 * them into value.
+	 * Either directly use a numeric term, or try to translate string terms
+	 * using event parameters.
 	 */
-	pmu_format_value(format->bits, term->val.num, vp, zero);
+	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+		val = term->val.num;
+	else
+		if (pmu_resolve_param_term(term, head_terms, &val))
+			return -EINVAL;
+
+	pmu_format_value(format->bits, val, vp, zero);
 	return 0;
 }
 
@@ -607,9 +649,10 @@ int perf_pmu__config_terms(struct list_head *formats,
 {
 	struct parse_events_term *term;
 
-	list_for_each_entry(term, head_terms, list)
-		if (pmu_config_term(formats, attr, term, zero))
+	list_for_each_entry(term, head_terms, list) {
+		if (pmu_config_term(formats, attr, term, head_terms, zero))
 			return -EINVAL;
+	}
 
 	return 0;
 }
-- 
1.8.3.1
