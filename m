Return-Path: <cody@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8E3B92C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Feb 2014 09:02:32 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 14 Feb 2014 17:02:29 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D6A586E804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:02:21 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1EM2Q1F6291742
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 22:02:26 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1EM2PUm026664
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Feb 2014 17:02:26 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH v2 01/11] perf: add PMU_RANGE_ATTR() helper for use by sw-like
 pmus
Date: Fri, 14 Feb 2014 14:02:05 -0800
Message-Id: <1392415338-16288-2-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1392415338-16288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>
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
index e56b07f..2702e91 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -871,4 +871,21 @@ _name##_show(struct device *dev,					\
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
1.8.5.4
