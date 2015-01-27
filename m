Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FF4D1A05B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 12:43:33 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 26 Jan 2015 20:43:29 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 56DAE38C8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 20:43:26 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0R1hQqw28246030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 01:43:26 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0R1hPxd011562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jan 2015 20:43:26 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v7 1/7] perf: provide sysfs_show for struct
 perf_pmu_events_attr
Date: Mon, 26 Jan 2015 17:43:04 -0800
Message-Id: <1422322990-9030-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1422322990-9030-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1422322990-9030-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

(struct perf_pmu_events_attr) is defined in include/linux/perf_event.h,
but the only "show" for it is in x86 and contains x86 specific stuff.

Make a generic one for those of us who are just using the event_str.

Changelog[v7]: [Jiri Olsa] Add a check pmu_events->str for similarity
		the RAPL use of sysfs_show().

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
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
