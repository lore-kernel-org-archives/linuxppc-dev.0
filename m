Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 324122C037E
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 16:49:24 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 5 Mar 2013 22:49:23 -0700
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DD545C90025
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 00:49:20 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r265nKmN280880
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Mar 2013 00:49:20 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r265nJrw003255
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Mar 2013 00:49:20 -0500
Date: Tue, 5 Mar 2013 21:48:26 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
Message-ID: <20130306054826.GA14627@us.ibm.com>
References: <20130123062201.GA13720@us.ibm.com>
 <20130123062613.GF13720@us.ibm.com>
 <20130226052646.GB21553@concordia>
 <20130226200343.GA21543@us.ibm.com>
 <20130227011725.GA5819@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130227011725.GA5819@concordia>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| I suspect Arnaldo was either waiting for an ACK from Ben, or was
| expecting Ben to take it?

Arnaldo, here is an updated patch. If it is acked by Paul Mackerras,
Michael Ellerman or Ben, will you add it to your tree so the whole
patchset comes from one place ?

Sukadev

---
>From 50c7a46f14083c0ed10d66b7aed66ba76e798550 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 5 Mar 2013 21:20:56 -0800
Subject: [PATCH] [PATCH 5/6][v4]: perf Create a sysfs format entry for Power7 events

Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
which describes the format of the POWER7 PMU events.

This code is based on corresponding code in x86.

Changelog[v4]:  [Michael Ellerman, Paul Mckerras] The event format is different
		for other POWER cpus. So move the code to POWER7-specific,
		power7-pmu.c Also, the POWER7 format uses bits 0-19 not 0-20.

Changelog[v2]: [Jiri Osla] Use PMU_FORMAT_ATTR rather than duplicating code.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
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
