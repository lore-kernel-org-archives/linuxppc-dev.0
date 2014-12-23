Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07AE51A0D0B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Dec 2014 06:59:26 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 23 Dec 2014 12:59:24 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BBD776E803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 14:51:15 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBNJxLOl27721816
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 19:59:21 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBNJxLZD009816
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 14:59:21 -0500
Date: Tue, 23 Dec 2014 11:58:50 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 1/4] tools/perf: support parsing parameterized events
Message-ID: <20141223195850.GA26952@us.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141222143710.GA29096@krava.brq.redhat.com>
 <20141222193045.GA19784@us.ibm.com>
 <20141223095506.GB22265@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141223095506.GB22265@krava.brq.redhat.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From a24b480ff54381a7e092597864cf615162afdd60 Mon Sep 17 00:00:00 2001
From: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Wed, 24 Sep 2014 12:27:15 -0700
Subject: [PATCH 1/4] tools/perf: support parsing parameterized events

Enable event specification like:

	pmu/event_name,param1=0x1,param2=0x4/

Assuming that

	/sys/bus/event_source/devices/pmu/events/event_name

Contains something like

	param2=?,bar=1,param1=?

Changelog[v6]:
	[Jiri Olsa] Add a check to make sure that sysfs entries with
	parameters exactly match '=?'.

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
 tools/perf/util/pmu.c          | 74 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 64 insertions(+), 11 deletions(-)

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
index 5c9c494..bfbecf7 100644
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
@@ -592,11 +629,25 @@ static int pmu_config_term(struct list_head *formats,
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
+	else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR) {
+		if (strcmp(term->val.str, "?")) {
+			if (verbose)
+				pr_info("Invalid sysfs entry %s=%s\n",
+						term->config, term->val.str);
+			return -EINVAL;
+		}
+
+		if (pmu_resolve_param_term(term, head_terms, &val))
+			return -EINVAL;
+	} else
+		return -EINVAL;
+
+	pmu_format_value(format->bits, val, vp, zero);
 	return 0;
 }
 
@@ -607,9 +658,10 @@ int perf_pmu__config_terms(struct list_head *formats,
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
