Return-Path: <dev@codyps.com>
Received: from mail-yk0-x22d.google.com (mail-yk0-x22d.google.com
 [IPv6:2607:f8b0:4002:c07::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 038C51A0590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 10:27:27 +1000 (EST)
Received: by mail-yk0-f173.google.com with SMTP id 142so7744455ykq.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 17:27:25 -0700 (PDT)
From: Cody P Schafer <dev@codyps.com>
To: LKML <linux-kernel@vger.kernel.org>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Cody P Schafer <dev@codyps.com>, Peter Zijlstra <peterz@infradead.org>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH 08/16] tools/perf: extend format_alias() to include event
 parameters
Date: Tue, 27 May 2014 17:22:03 -0700
Message-Id: <1401236684-10579-9-git-send-email-dev@codyps.com>
In-Reply-To: <1401236684-10579-1-git-send-email-dev@codyps.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This causes `perf list pmu` to show parameters for parameterized events
like follows:

  pmu/event_name,param1=?,param2=?/ [Kernel PMU event]

An example:

  hv_gpci/dispatch_timebase_by_processor_processor_time_in_timebase_cycles,phys_processor_idx=?/ [Kernel PMU event]

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Cody P Schafer <dev@codyps.com>
---
 tools/perf/util/pmu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index db53fac..7b8d067 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -741,10 +741,33 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
 		set_bit(b, bits);
 }
 
+static int sub_non_neg(int a, int b)
+{
+	if (b > a)
+		return 0;
+	return a - b;
+}
+
 static char *format_alias(char *buf, int len, struct perf_pmu *pmu,
 			  struct perf_pmu_alias *alias)
 {
-	snprintf(buf, len, "%s/%s/", pmu->name, alias->name);
+	struct parse_events_term *term;
+	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
+
+	list_for_each_entry(term, &alias->terms, list)
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
+			used += snprintf(buf + used, sub_non_neg(len, used),
+					",%s=?", term->val.str);
+
+	if (sub_non_neg(len, used) > 0) {
+		buf[used] = '/';
+		used++;
+	}
+	if (sub_non_neg(len, used) > 0) {
+		buf[used] = '\0';
+		used++;
+	} else
+		buf[len - 1] = '\0';
 	return buf;
 }
 
@@ -795,6 +818,7 @@ void print_pmu_events(const char *event_glob, bool name_only)
 			if (is_cpu && !name_only)
 				aliases[j] = format_alias_or(buf, sizeof(buf),
 							      pmu, alias);
+
 			aliases[j] = strdup(aliases[j]);
 			j++;
 		}
-- 
1.9.3
