Return-Path: <B25806@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA0E22C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 20:23:24 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 10 Aug 2012 18:25:13 -0400
Message-ID: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move mmc_delay() from drivers/mmc/core/core.h to
include/linux/mmc/core.h. So when other functions
call it with include syntax using <linux/mmc/core.h>
of absolute path rather than "../core/core.h" of
relative path.

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.h  |   12 ------------
 include/linux/mmc/core.h |   11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3bdafbc..5f63d00 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -11,8 +11,6 @@
 #ifndef _MMC_CORE_CORE_H
 #define _MMC_CORE_CORE_H
 
-#include <linux/delay.h>
-
 #define MMC_CMD_RETRIES        3
 
 struct mmc_bus_ops {
@@ -46,16 +44,6 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_off(struct mmc_host *host);
 
-static inline void mmc_delay(unsigned int ms)
-{
-	if (ms < 1000 / HZ) {
-		cond_resched();
-		mdelay(ms);
-	} else {
-		msleep(ms);
-	}
-}
-
 void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 1b431c7..7021658 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/delay.h>
 
 struct request;
 struct mmc_data;
@@ -192,6 +193,16 @@ static inline void mmc_claim_host(struct mmc_host *host)
 	__mmc_claim_host(host, NULL);
 }
 
+static inline void mmc_delay(unsigned int ms)
+{
+	if (ms < 1000 / HZ) {
+		cond_resched();
+		mdelay(ms);
+	} else {
+		msleep(ms);
+	}
+}
+
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
1.7.6.5
