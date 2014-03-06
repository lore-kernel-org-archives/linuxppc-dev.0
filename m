Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C06702C0236
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 11:01:50 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 17:01:47 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3209938C8067
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 19:01:45 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2601jaO3867090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 00:01:45 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2601huP030389
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 19:01:44 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH v4 02/11] perf: add PMU_FORMAT_RANGE() helper for use by
 sw-like pmus
Date: Wed,  5 Mar 2014 16:01:01 -0800
Message-Id: <1394064082-6242-3-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, scottwood@freescale.com,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PMU_FORMAT_RANGE() and PMU_FORMAT_RANGE_RESERVED() (for reserved
areas) which generate functions to extract the relevent bits from
event->attr.config{,1,2} for use by sw-like pmus where the
'config{,1,2}' values don't map directly to hardware registers.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 include/linux/perf_event.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e56b07f..5c12009 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -871,4 +871,27 @@ _name##_show(struct device *dev,					\
 									\
 static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 
+#define format_max(name) FORMAT_MAX_(name)()
+#define FORMAT_MAX_(name) format_##name##_max
+
+#define format_get(name, event) FORMAT_GET_(name)(event)
+#define FORMAT_GET_(name) format_get_##name
+
+#define PMU_FORMAT_RANGE(name, attr_var, bit_start, bit_end)		\
+PMU_FORMAT_RANGE_RESERVED(name, attr_var, bit_start, bit_end)		\
+PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end)
+
+#define PMU_FORMAT_RANGE_RESERVED(name, attr_var, bit_start, bit_end)	\
+static u64 FORMAT_MAX_(name)(void)					\
+{									\
+	BUILD_BUG_ON((bit_start > bit_end)				\
+		    || (bit_end >= (sizeof(1ull) * 8)));		\
+	return (((1ull << (bit_end - bit_start)) - 1) << 1) + 1;	\
+}									\
+static u64 FORMAT_GET_(name)(struct perf_event *event)			\
+{									\
+	return (event->attr.attr_var >> (bit_start)) &			\
+		format_max(name);					\
+}
+
 #endif /* _LINUX_PERF_EVENT_H */
-- 
1.9.0
