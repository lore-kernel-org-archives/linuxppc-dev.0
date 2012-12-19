Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C8302C0093
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 18:28:19 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 19 Dec 2012 02:28:16 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A3F2C6E8040
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 02:28:12 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBJ7SDYT63176730
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 02:28:13 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBJ7SCc5014083
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 05:28:12 -0200
Date: Tue, 18 Dec 2012 23:28:02 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 robert.richter@amd.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf: Make EVENT_ATTR and EVENT_PTR global
Message-ID: <20121219072802.GA30790@us.ibm.com>
References: <20121219072646.GA30580@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121219072646.GA30580@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Rename EVENT_ATTR() and EVENT_PTR() PMU_EVENT_ATTR() and PMU_EVENT_PTR().
Make them global so they are available to all architectures.

Further to allow architectures flexibility, have PMU_EVENT_PTR() pass in the
variable name as a parameter.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/x86/kernel/cpu/perf_event.c |   17 +++++------------
 include/linux/perf_event.h       |   13 +++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 4428fd1..24bc505 100644
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
@@ -1351,14 +1346,12 @@ static ssize_t events_sysfs_show(struct device *dev, struct device_attribute *at
 	return x86_pmu.events_sysfs_show(page, config);
 }
 
-#define EVENT_VAR(_id)  event_attr_##_id
-#define EVENT_PTR(_id) &event_attr_##_id.attr.attr
+#define EVENT_VAR(_id)	event_attr_##_id
+#define EVENT_ID(_id)	PERF_COUNT_HW_##_id
+#define EVENT_PTR(_id)	PMU_EVENT_PTR(EVENT_VAR(_id))
 
-#define EVENT_ATTR(_name, _id)					\
-static struct perf_pmu_events_attr EVENT_VAR(_id) = {		\
-	.attr = __ATTR(_name, 0444, events_sysfs_show, NULL),	\
-	.id   =  PERF_COUNT_HW_##_id,				\
-};
+#define EVENT_ATTR(_name, _id)						\
+	PMU_EVENT_ATTR(_name, EVENT_VAR(_id), EVENT_ID(_id), events_sysfs_show)
 
 EVENT_ATTR(cpu-cycles,			CPU_CYCLES		);
 EVENT_ATTR(instructions,		INSTRUCTIONS		);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6bfb2fa..31692cb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -817,6 +817,19 @@ do {									\
 } while (0)
 
 
+struct perf_pmu_events_attr {
+	struct device_attribute attr;
+	u64 id;
+};
+
+#define PMU_EVENT_PTR(_var)	&_var.attr.attr
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
