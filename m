Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 956BA2C0209
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2013 11:06:19 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 9 Jan 2013 19:06:16 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EDFEC38C8026
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2013 19:06:12 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0A06CCV330032
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 19:06:12 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0A06BMZ016536
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2013 19:06:12 -0500
From: sukadev@linux.vnet.ibm.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/6][v3] perf: Make EVENT_ATTR global
Date: Wed,  9 Jan 2013 16:06:16 -0800
Message-Id: <1357776380-31712-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1357776380-31712-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1357776380-31712-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: robert.richter@amd.com, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename EVENT_ATTR() to PMU_EVENT_ATTR() and make it global so it is
available to all architectures.

Further to allow architectures flexibility, have PMU_EVENT_ATTR() pass
in the variable name as a parameter.

Changelog[v3]
	- [Jiri Olsa] No need to define PMU_EVENT_PTR()

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/x86/kernel/cpu/perf_event.c |   13 +++----------
 include/linux/perf_event.h       |   11 +++++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 4428fd1..59a1238 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1316,11 +1316,6 @@ static struct attribute_group x86_pmu_format_group = {
 	.attrs = NULL,
 };
 
-struct perf_pmu_events_attr {
-	struct device_attribute attr;
-	u64 id;
-};
-
 /*
  * Remove all undefined events (x86_pmu.event_map(id) == 0)
  * out of events_attr attributes.
@@ -1354,11 +1349,9 @@ static ssize_t events_sysfs_show(struct device *dev, struct device_attribute *at
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
 
-#define EVENT_ATTR(_name, _id)					\
-static struct perf_pmu_events_attr EVENT_VAR(_id) = {		\
-	.attr = __ATTR(_name, 0444, events_sysfs_show, NULL),	\
-	.id   =  PERF_COUNT_HW_##_id,				\
-};
+#define EVENT_ATTR(_name, _id)						\
+	PMU_EVENT_ATTR(_name, EVENT_VAR(_id), PERF_COUNT_HW_##_id,	\
+			events_sysfs_show)
 
 EVENT_ATTR(cpu-cycles,			CPU_CYCLES		);
 EVENT_ATTR(instructions,		INSTRUCTIONS		);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6bfb2fa..42adf01 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -817,6 +817,17 @@ do {									\
 } while (0)
 
 
+struct perf_pmu_events_attr {
+	struct device_attribute attr;
+	u64 id;
+};
+
+#define PMU_EVENT_ATTR(_name, _var, _id, _show)				\
+static struct perf_pmu_events_attr _var = {				\
+	.attr = __ATTR(_name, 0444, _show, NULL),			\
+	.id   =  _id,							\
+};
+
 #define PMU_FORMAT_ATTR(_name, _format)					\
 static ssize_t								\
 _name##_show(struct device *dev,					\
-- 
1.7.1
