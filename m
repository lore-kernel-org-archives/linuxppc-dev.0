Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sypS60QDXzDt39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 19:40:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 1/3] cxl: Split _CXL_LOOP_HCALL9 out into a separate macro
Date: Tue, 18 Oct 2016 19:40:30 +1100
Message-Id: <1476780032-21643-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a subsequent patch we want to change the type of retbuf between
plpar_hcall() and plpar_hcall9(), but we can't because _CXL_LOOP_HCALL
expects the same type for retbuf regardless of the hcall type.

So duplicate the logic in a separate macro for plpar_hcall9().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/misc/cxl/hcalls.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
index d6d11f4056d7..01a8d917631c 100644
--- a/drivers/misc/cxl/hcalls.c
+++ b/drivers/misc/cxl/hcalls.c
@@ -77,8 +77,37 @@
 			msleep(delay);					\
 		}							\
 	}
+
+#define _CXL_LOOP_HCALL9(call, rc, retbuf, fn, ...)			\
+	{								\
+		unsigned int delay, total_delay = 0;			\
+		u64 token = 0;						\
+									\
+		memset(retbuf, 0, sizeof(retbuf));			\
+		while (1) {						\
+			rc = call(fn, retbuf, __VA_ARGS__, token);	\
+			token = retbuf[0];				\
+			if (rc != H_BUSY && !H_IS_LONG_BUSY(rc))	\
+				break;					\
+									\
+			if (rc == H_BUSY)				\
+				delay = 10;				\
+			else						\
+				delay = get_longbusy_msecs(rc);		\
+									\
+			total_delay += delay;				\
+			if (total_delay > CXL_HCALL_TIMEOUT) {		\
+				WARN(1, "Warning: Giving up waiting for CXL hcall " \
+				     "%#x after %u msec\n", fn, total_delay); \
+				rc = H_BUSY;				\
+				break;					\
+			}						\
+			msleep(delay);					\
+		}							\
+	}
+
 #define CXL_H_WAIT_UNTIL_DONE(...)  _CXL_LOOP_HCALL(plpar_hcall, __VA_ARGS__)
-#define CXL_H9_WAIT_UNTIL_DONE(...) _CXL_LOOP_HCALL(plpar_hcall9, __VA_ARGS__)
+#define CXL_H9_WAIT_UNTIL_DONE(...) _CXL_LOOP_HCALL9(plpar_hcall9, __VA_ARGS__)
 
 #define _PRINT_MSG(rc, format, ...)					\
 	{								\
-- 
2.7.4
