Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B98C92C03CB
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2013 11:20:40 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 9 Jan 2013 19:20:38 -0500
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B9644C90026
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2013 19:20:35 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0A0KZRl291630
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 19:20:35 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0A0KT4G018944
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 22:20:34 -0200
From: sukadev@linux.vnet.ibm.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 5/6][v3] perf: Create a sysfs entry for Power event format
Date: Wed,  9 Jan 2013 16:20:31 -0800
Message-Id: <1357777232-32037-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1357777232-32037-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1357777232-32037-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
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

Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
which describes the format of a POWER cpu.

The format of the event is the same for all POWER cpus at least in
(Power6, Power7), so bulk of this change is common in the code common
to POWER cpus.

This code is based on corresponding code in x86.

Changelog[v2]: [Jiri Olsa] Use PMU_FORMAT_ATTR() rather than duplicating it.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |    6 ++++++
 arch/powerpc/perf/core-book3s.c              |   12 ++++++++++++
 arch/powerpc/perf/power7-pmu.c               |    1 +
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index b29fcc6..ee63205 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -135,3 +135,9 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
 
 #define	POWER_EVENT_ATTR(_name, _id)	EVENT_ATTR(PM_##_name, _id, _p)
 #define	POWER_EVENT_PTR(_id)		EVENT_PTR(_id, _p)
+
+/*
+ * Format of a perf event is the same on all POWER cpus. Declare a
+ * common sysfs attribute group that individual POWER cpus can share.
+ */
+extern struct attribute_group power_pmu_format_group;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index fa476d5..4ae044b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1315,6 +1315,18 @@ ssize_t power_events_sysfs_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+PMU_FORMAT_ATTR(event, "config:0-20");
+
+static struct attribute *power_pmu_format_attr[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+struct attribute_group power_pmu_format_group = {
+	.name = "format",
+	.attrs = power_pmu_format_attr,
+};
+
 struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 5627940..5fb3c9b 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -410,6 +410,7 @@ static struct attribute_group power7_pmu_events_group = {
 };
 
 static const struct attribute_group *power7_pmu_attr_groups[] = {
+	&power_pmu_format_group,
 	&power7_pmu_events_group,
 	NULL,
 };
-- 
1.7.1
