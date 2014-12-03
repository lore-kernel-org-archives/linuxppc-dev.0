Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAD111A0A11
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 13:04:22 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 19:04:18 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9B99F1FF003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 18:52:59 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB324wwo48693436
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 19:04:58 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB324Evn030062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 19:04:15 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <michaele@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v5 2/6] perf: add PMU_EVENT_ATTR_STRING() helper
Date: Tue,  2 Dec 2014 18:03:51 -0800
Message-Id: <1417572235-8197-3-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1417572235-8197-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1417572235-8197-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Helper for constructing static struct perf_pmu_events_attr s.

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 include/linux/perf_event.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 58f59bd..4038299 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -906,6 +906,13 @@ static struct perf_pmu_events_attr _var = {				\
 	.id   =  _id,							\
 };
 
+#define PMU_EVENT_ATTR_STRING(_name, _var, _value)			\
+static struct perf_pmu_events_attr _var = {				\
+	.attr = __ATTR(_name, 0444, perf_event_sysfs_show, NULL),	\
+	.event_str = _value,						\
+};
+
+
 #define PMU_FORMAT_ATTR(_name, _format)					\
 static ssize_t								\
 _name##_show(struct device *dev,					\
-- 
1.8.3.1
