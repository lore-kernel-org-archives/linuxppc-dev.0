Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 122171A0F67
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 12:14:38 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Jan 2015 18:14:36 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1B6B53E40040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 18:14:35 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t081EoaI32899180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 18:14:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t081EYW1006424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 18:14:34 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v7 2/4] tools/perf: extend format_alias() to include event
 parameters
Date: Wed,  7 Jan 2015 17:13:51 -0800
Message-Id: <1420679633-28856-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1420679633-28856-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1420679633-28856-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

This causes `perf list pmu` to show parameters for parameterized events
like:

  pmu/event_name,param1=?,param2=?/ [Kernel PMU event]

An example:

  hv_24x7/HPM_TLBIE__PHYS_CORE,core=?/ [Kernel PMU event]

CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v7]
	[Jiri Olsa] Nit: Add braces for clarity.

Changelog[v6]
	[Jiri Olsa, Sukadev Bhattiprolu] Drop the '$' sign and go back to
	just printing whatevever sysfs provides (which is '=?') to identify
	required parameters. sysfs also now uses parameters like 'core'
	and 'vcpu' rather than 'starting_index'.

Changelog[v5]
	[Jiri Olsa, Peter Zijlstra] Use '$' to prefix parameterized events.

Changelog[v4]
	[Jiri Olsa] If the parameter for an event in sysfs is 'param=val',
	have perf-list show the event as 'param=?' rather than 'val=?'.

 tools/perf/util/pmu.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bfbecf7..4841167 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -819,10 +819,36 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
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
+	list_for_each_entry(term, &alias->terms, list) {
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
+			used += snprintf(buf + used, sub_non_neg(len, used),
+					",%s=%s", term->config,
+					term->val.str);
+	}
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
+
 	return buf;
 }
 
-- 
1.8.3.1
