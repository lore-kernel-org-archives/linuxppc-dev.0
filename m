Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 81ADB2C04E8
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2012 06:18:57 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Nov 2012 12:18:54 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B7A2E1FF001B
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2012 12:18:44 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA7JIguk066632
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 12:18:44 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA7JIbw9021769
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 12:18:40 -0700
Date: Wed, 7 Nov 2012 11:19:52 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anton Blanchard <anton@au1.ibm.com>, robert.richter@amd.com
Subject: [PATCH 4/4] perf: Create a sysfs entry for Power event format
Message-ID: <20121107191951.GD16211@us.ibm.com>
References: <20121107191818.GA16211@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121107191818.GA16211@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From bafc551c31ce23c1cba0b75d23de6c46aba90f26 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 6 Nov 2012 16:30:28 -0800
Subject: [PATCH 4/4] perf: Create a sysfs entry for Power event format

Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
which describes the format of a POWER cpu.

	$ cat /sys/bus/event_source/devices/cpu/format/event
	config:0-20

The format of the event is the same for all POWER cpus, so bulk of this
change is in the code common to POWER cpus.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |    8 ++++++++
 arch/powerpc/perf/core-book3s.c              |   19 +++++++++++++++++++
 arch/powerpc/perf/power7-pmu.c               |    1 +
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index ad84f73..20a49bf 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -130,3 +130,11 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
 		.attr = __ATTR(_name, 0444, power_events_sysfs_show, NULL),\
 		.id   = PM_##_id,                                               \
 	};
+
+/*
+ * Format of a perf event is the same on all POWER cpus. Declare a
+ * common sysfs attribute group that individual POWER cpus can share.
+ */
+extern struct attribute_group power_pmu_format_group;
+
+
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 19b23bd..388e2a1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1315,6 +1315,25 @@ ssize_t power_events_sysfs_show(struct device *dev,
        return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+static ssize_t power_config_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *page)
+{
+	return sprintf(page, "config:0-20\n");
+}
+
+static struct device_attribute config_dev_attr = \
+			__ATTR(event, 0444, power_config_sysfs_show, NULL);
+
+static struct attribute *power_pmu_format_attr[] = {
+	&config_dev_attr.attr,
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
index 31c61ab..aa9f588 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -387,6 +387,7 @@ static struct attribute_group power7_pmu_events_group = {
 };
 
 static const struct attribute_group *power7_pmu_attr_groups[] = {
+	&power_pmu_format_group,
 	&power7_pmu_events_group,
 	NULL,
 };
-- 
1.7.1
