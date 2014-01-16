Return-Path: <cody@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 933FF2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 10:54:09 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 16 Jan 2014 16:54:06 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6AB161FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 16:53:32 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0GNrp0T7537028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 00:53:51 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0GNs2IT015420
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 16:54:03 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/8] perf: add PMU_RANGE_ATTR() helper for use by sw-like pmus
Date: Thu, 16 Jan 2014 15:53:47 -0800
Message-Id: <1389916434-2288-2-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PMU_RANGE_ATTR() and PMU_RANGE_RESV() (for reserved areas) which
generate functions to extract the relevent bits from
event->attr.config{,1,2} for use by sw-like pmus where the
'config{,1,2}' values don't map directly to hardware registers.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 include/linux/perf_event.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2e069d1..8646e33 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -870,4 +870,21 @@ _name##_show(struct device *dev,					\
 									\
 static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 
+#define PMU_RANGE_ATTR(name, attr_var, bit_start, bit_end)		\
+PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end);		\
+PMU_RANGE_RESV(name, attr_var, bit_start, bit_end)
+
+#define PMU_RANGE_RESV(name, attr_var, bit_start, bit_end)		\
+static u64 event_get_##name##_max(void)					\
+{									\
+	int bits = (bit_end) - (bit_start) + 1;				\
+	return ((0x1ULL << (bits - 1ULL)) - 1ULL) |			\
+		(0xFULL << (bits - 4ULL));				\
+}									\
+static u64 event_get_##name(struct perf_event *event)			\
+{									\
+	return (event->attr.attr_var >> (bit_start)) &			\
+		event_get_##name##_max();				\
+}
+
 #endif /* _LINUX_PERF_EVENT_H */
-- 
1.8.5.2
