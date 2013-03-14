Return-Path: <BATV+18920339ee8181c42cca+3490+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 65CF92C0079
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Mar 2013 23:23:45 +1100 (EST)
From: Arnaldo Carvalho de Melo <acme@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 7/8] perf/POWER7: Create a sysfs format entry for Power7 events
Date: Thu, 14 Mar 2013 09:23:14 -0300
Message-Id: <1363263795-31485-8-git-send-email-acme@infradead.org>
In-Reply-To: <1363263795-31485-1-git-send-email-acme@infradead.org>
References: <1363263795-31485-1-git-send-email-acme@infradead.org>
Content-Type: text/plain; charset="utf-8"
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Robert Richter <robert.richter@amd.com>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
which describes the format of the POWER7 PMU events.

This code is based on corresponding code in x86.

Changelog[v4]:  [Michael Ellerman, Paul Mckerras] The event format is different
		for other POWER cpus. So move the code to POWER7-specific,
		power7-pmu.c Also, the POWER7 format uses bits 0-19 not 0-20.

Changelog[v2]: [Jiri Osla] Use PMU_FORMAT_ATTR rather than duplicating code.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
Tested-by: Michael Ellerman <michael@ellerman.id.au>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anton Blanchard <anton@au1.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
Link: http://lkml.kernel.org/r/20130306054826.GA14627@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/powerpc/perf/power7-pmu.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index b554879..3c475d6 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -420,7 +420,20 @@ static struct attribute_group power7_pmu_events_group = {
 	.attrs = power7_events_attr,
 };
 
+PMU_FORMAT_ATTR(event, "config:0-19");
+
+static struct attribute *power7_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+struct attribute_group power7_pmu_format_group = {
+	.name = "format",
+	.attrs = power7_pmu_format_attr,
+};
+
 static const struct attribute_group *power7_pmu_attr_groups[] = {
+	&power7_pmu_format_group,
 	&power7_pmu_events_group,
 	NULL,
 };
-- 
1.7.1
