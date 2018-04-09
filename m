Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJg1680GzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:25:49 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id x4-v6so4474447pln.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:25:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 6/9] powerpc/powernv: OPAL NVRAM driver standardise
 OPAL_BUSY delays
Date: Mon,  9 Apr 2018 15:24:28 +1000
Message-Id: <20180409052431.26405-7-npiggin@gmail.com>
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

Convert to using the standard delay poll/delay form.

The NVRAM driver:

- Did not previously delay or sleep in its busy loop.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-nvram.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-nvram.c b/arch/powerpc/platforms/powernv/opal-nvram.c
index ba2ff06a2c98..1bceb95f422d 100644
--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -11,6 +11,7 @@
 
 #define DEBUG
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
@@ -56,8 +57,12 @@ static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		}
 	}
 
 	if (rc)
-- 
2.17.0
