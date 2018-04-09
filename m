Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJgB6b3HzDrZf
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:25:58 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id y12-v6so4375485plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:25:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 9/9] powerpc/powernv: opal-kmsg standardise OPAL_BUSY
 handling
Date: Mon,  9 Apr 2018 15:24:31 +1000
Message-Id: <20180409052431.26405-10-npiggin@gmail.com>
In-Reply-To: <20180409052431.26405-1-npiggin@gmail.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OPAL_CONSOLE_FLUSH is documented as being able to return OPAL_BUSY,
so implement the standard OPAL_BUSY handling for it.

Cc: Russell Currey <ruscur@russell.cc>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-kmsg.c | 24 ++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index 6f1214d4de92..f8f41ccce75f 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/kmsg_dump.h>
+#include <linux/delay.h>
 
 #include <asm/opal.h>
 #include <asm/opal-api.h>
@@ -26,8 +27,7 @@
 static void force_opal_console_flush(struct kmsg_dumper *dumper,
 				     enum kmsg_dump_reason reason)
 {
-	int i;
-	int64_t ret;
+	s64 rc;
 
 	/*
 	 * Outside of a panic context the pollers will continue to run,
@@ -37,14 +37,22 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 		return;
 
 	if (opal_check_token(OPAL_CONSOLE_FLUSH)) {
-		ret = opal_console_flush(0);
+		do  {
+			rc = OPAL_BUSY;
+			while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
+				rc = opal_console_flush(0);
+				if (rc == OPAL_BUSY_EVENT) {
+					mdelay(OPAL_BUSY_DELAY_MS);
+					opal_poll_events(NULL);
+				} else if (rc == OPAL_BUSY) {
+					mdelay(OPAL_BUSY_DELAY_MS);
+				}
+			}
+		} while (rc == OPAL_PARTIAL); /* More to flush */
 
-		if (ret == OPAL_UNSUPPORTED || ret == OPAL_PARAMETER)
-			return;
-
-		/* Incrementally flush until there's nothing left */
-		while (opal_console_flush(0) != OPAL_SUCCESS);
 	} else {
+		int i;
+
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
-- 
2.17.0
