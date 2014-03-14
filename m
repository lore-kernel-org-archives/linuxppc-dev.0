Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 15/20] powerpc/perf: Add macros for defining event fields &
 formats
Date: Fri, 14 Mar 2014 16:00:40 +1100
Message-Id: <1394773245-18328-16-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
References: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <cody@linux.vnet.ibm.com>

Add two macros which generate functions to extract the relevent bits
from event->attr.config{,1,2}.

EVENT_DEFINE_RANGE() defines an accessor for a range of bits in the
event, as well as a "max" function that gives the maximum value of the
field based on the bit width.

EVENT_DEFINE_RANGE_FORMAT() defines the accessor & max routine and also
a format attribute for use in the PMU's attr_groups.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
[mpe: move to powerpc, ugly but descriptive macro names]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/hv-common.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/perf/hv-common.h b/arch/powerpc/perf/hv-common.h
index 7e615bd..5d79cec 100644
--- a/arch/powerpc/perf/hv-common.h
+++ b/arch/powerpc/perf/hv-common.h
@@ -1,6 +1,7 @@
 #ifndef LINUX_POWERPC_PERF_HV_COMMON_H_
 #define LINUX_POWERPC_PERF_HV_COMMON_H_
 
+#include <linux/perf_event.h>
 #include <linux/types.h>
 
 struct hv_perf_caps {
@@ -14,4 +15,22 @@ struct hv_perf_caps {
 
 unsigned long hv_perf_caps_get(struct hv_perf_caps *caps);
 
+
+#define EVENT_DEFINE_RANGE_FORMAT(name, attr_var, bit_start, bit_end)	\
+PMU_FORMAT_ATTR(name, #attr_var ":" #bit_start "-" #bit_end);		\
+EVENT_DEFINE_RANGE(name, attr_var, bit_start, bit_end)
+
+#define EVENT_DEFINE_RANGE(name, attr_var, bit_start, bit_end)	\
+static u64 event_get_##name##_max(void)					\
+{									\
+	BUILD_BUG_ON((bit_start > bit_end)				\
+		    || (bit_end >= (sizeof(1ull) * 8)));		\
+	return (((1ull << (bit_end - bit_start)) - 1) << 1) + 1;	\
+}									\
+static u64 event_get_##name(struct perf_event *event)			\
+{									\
+	return (event->attr.attr_var >> (bit_start)) &			\
+		event_get_##name##_max();				\
+}
+
 #endif
-- 
1.8.3.2
