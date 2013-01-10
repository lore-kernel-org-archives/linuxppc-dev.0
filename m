Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 466EF2C079E
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2013 12:06:44 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 9 Jan 2013 18:06:41 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2C9A019D806A
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2013 18:06:31 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0A16R6r276934
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 18:06:28 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0A16P5N017411
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 18:06:26 -0700
Date: Wed, 9 Jan 2013 17:06:34 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 5/6][v3] perf: Create a sysfs entry for Power event format
Message-ID: <20130110010633.GE32590@us.ibm.com>
References: <20130110010347.GA32590@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130110010347.GA32590@us.ibm.com>
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

[PATCH 5/6][v3] perf: Create a sysfs entry for Power event format

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
