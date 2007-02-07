Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: Fix booke watchdog initialization
Date: Wed, 7 Feb 2007 09:45:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702070945.56056.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[PATCH] ppc: Fix booke watchdog initialization

Fix two problems in the book-e watchdog driver.

a) The 4xx default period was defined wrong
b) Clear status before enabling the watchdog exception

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit 39f3c85aaf1b18075dcdad200ebe49016451f375
tree cb00cd890052571f5a7b9dad12f156a3a9ce22b4
parent 62d0cfcb27cf755cebdc93ca95dabc83608007cd
author Stefan Roese <sr@denx.de> Wed, 07 Feb 2007 09:41:40 +0100
committer Stefan Roese <sr@denx.de> Wed, 07 Feb 2007 09:41:40 +0100

 drivers/char/watchdog/booke_wdt.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index 4889022..0e23f29 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -35,7 +35,7 @@
 #ifdef	CONFIG_FSL_BOOKE
 #define WDT_PERIOD_DEFAULT 63	/* Ex. wdt_period=28 bus=333Mhz , reset=~40sec */
 #else
-#define WDT_PERIOD_DEFAULT 4	/* Refer to the PPC40x and PPC4xx manuals */
+#define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
 #endif				/* for timing information */
 
 u32 booke_wdt_enabled = 0;
@@ -48,12 +48,22 @@ u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 #endif
 
 /*
+ * booke_wdt_ping:
+ */
+static __inline__ void booke_wdt_ping(void)
+{
+	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
+}
+
+/*
  * booke_wdt_enable:
  */
 static __inline__ void booke_wdt_enable(void)
 {
 	u32 val;
 
+	/* clear status before enabling watchdog */
+	booke_wdt_ping();
 	val = mfspr(SPRN_TCR);
 	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
 
@@ -61,14 +71,6 @@ static __inline__ void booke_wdt_enable(void)
 }
 
 /*
- * booke_wdt_ping:
- */
-static __inline__ void booke_wdt_ping(void)
-{
-	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
-}
-
-/*
  * booke_wdt_write:
  */
 static ssize_t booke_wdt_write (struct file *file, const char __user *buf,
