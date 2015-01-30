Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 769961A0E33
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 08:47:23 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 30 Jan 2015 14:47:21 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5A68C3E40048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:47:18 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0ULl9QU50200726
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:47:17 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0ULki6i031964
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:46:45 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH v7 1/7] perf: provide sysfs_show for struct
 perf_pmu_events_attr
Date: Fri, 30 Jan 2015 13:45:57 -0800
Message-Id: <1422654363-2035-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1422654363-2035-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1422654363-2035-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <cody@linux.vnet.ibm.com>

(struct perf_pmu_events_attr) is defined in include/linux/perf_event.h,
but the only "show" for it is in x86 and contains x86 specific stuff.

Make a generic one for those of us who are just using the event_str.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
Changelog[v7]: [Jiri Olsa] Add a check pmu_events->str for similarity
		the RAPL use of sysfs_show().

 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 486e84c..58f59bd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -897,6 +897,9 @@ struct perf_pmu_events_attr {
 	const char *event_str;
 };
 
+ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
+			      char *page);
+
 #define PMU_EVENT_ATTR(_name, _var, _id, _show)				\
 static struct perf_pmu_events_attr _var = {				\
 	.attr = __ATTR(_name, 0444, _show, NULL),			\
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c1ee7f..934687f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8276,6 +8276,18 @@ void __init perf_event_init(void)
 		     != 1024);
 }
 
+ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
+			      char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	if (pmu_attr->event_str)
+		return sprintf(page, "%s\n", pmu_attr->event_str);
+
+	return 0;
+}
+
 static int __init perf_event_sysfs_init(void)
 {
 	struct pmu *pmu;
-- 
1.8.3.1
