Return-Path: <hekuang@huawei.com>
Received: from szxga04-in.huawei.com (unknown [119.145.14.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVgKN6KG8zDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 20:55:50 +1000 (AEST)
From: He Kuang <hekuang@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <alexander.shishkin@linux.intel.com>, <hekuang@huawei.com>,
 <wangnan0@huawei.com>, <adrian.hunter@intel.com>, <ak@linux.intel.com>,
 <maddy@linux.vnet.ibm.com>, <bp@suse.de>, <dsahern@gmail.com>,
 <linux@horizon.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
 <linux@rasmusvillemoes.dk>, <yury.norov@gmail.com>, <mpe@ellerman.id.au>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 2/2] tools include: Fix wrong macro definitions for
 cpu_to_le* for big endian
Date: Thu, 16 Jun 2016 10:41:32 +0000
Message-ID: <1466073692-88702-2-git-send-email-hekuang@huawei.com>
In-Reply-To: <1466073692-88702-1-git-send-email-hekuang@huawei.com>
References: <1466073692-88702-1-git-send-email-hekuang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Nan <wangnan0@huawei.com>

The cpu_to_le* macros in kernel.h are defined without considering
endianese. This patch includes "byteoder/generic.h" instead to fix the
bug, and removes redundant definitions of those macros in intel-bts.c
and intel-pt-pkt-decoder.c.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: He Kuang <hekuang@huawei.com>
---
 tools/include/linux/kernel.h                            | 7 +------
 tools/perf/util/intel-bts.c                             | 5 -----
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 7 +------
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 76df535..ccf8daf 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -63,12 +63,7 @@
 #endif
 #endif
 
-/*
- * Both need more care to handle endianness
- * (Don't use bitmap_copy_le() for now)
- */
-#define cpu_to_le64(x)	(x)
-#define cpu_to_le32(x)	(x)
+#include <linux/byteorder/generic.h>
 
 static inline int
 vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 9df9960..0e632c4 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -40,11 +40,6 @@
 #define INTEL_BTS_ERR_NOINSN  5
 #define INTEL_BTS_ERR_LOST    9
 
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define le64_to_cpu bswap_64
-#else
-#define le64_to_cpu
-#endif
 
 struct intel_bts {
 	struct auxtrace			auxtrace;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index b1257c8..9a428f7 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <linux/byteorder/generic.h>
 
 #include "intel-pt-pkt-decoder.h"
 
@@ -27,17 +28,11 @@
 #define NR_FLAG		BIT63
 
 #if __BYTE_ORDER == __BIG_ENDIAN
-#define le16_to_cpu bswap_16
-#define le32_to_cpu bswap_32
-#define le64_to_cpu bswap_64
 #define memcpy_le64(d, s, n) do { \
 	memcpy((d), (s), (n));    \
 	*(d) = le64_to_cpu(*(d)); \
 } while (0)
 #else
-#define le16_to_cpu
-#define le32_to_cpu
-#define le64_to_cpu
 #define memcpy_le64 memcpy
 #endif
 
-- 
1.8.5.2
