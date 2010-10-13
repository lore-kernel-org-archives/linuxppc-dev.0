Return-Path: <timur@freescale.com>
Received: from TX2EHSOBE002.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 823F3B6F10
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 06:19:47 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <kumar.gala@freescale.com>,
	<linux-watchdog@vger.kernel.org>
Subject: [PATCH] powerpc: change the Book-E watchdog driver default timeout
	into a Kconfig option
Date: Wed, 13 Oct 2010 14:19:36 -0500
Message-ID: <1286997576-4988-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PowerPC Book-E watchdog driver (booke_wdt.c) defines a default timeout
value in the code based on whether it's a Freescale Book-E part of not.
Instead of having hard-coded values in the driver, make it a Kconfig option.

As newer chips gets faster, the current default values become less appropriate,
since the timeout sometimes occurs before the kernel finishes booting.  Making
the value a Kconfig option allows BSPs to configure a new value with requiring
the wdt_period command-line parameter to be set.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/watchdog/Kconfig     |   17 +++++++++++++++++
 drivers/watchdog/booke_wdt.c |    8 +-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3684144..2fdb45c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -966,6 +966,23 @@ config BOOKE_WDT
 	  Please see Documentation/watchdog/watchdog-api.txt for
 	  more information.
 
+config BOOKE_WDT_DEFAULT_TIMEOUT
+	int "PowerPC Book-E Watchdog Timer Default Timeout"
+	depends on BOOKE_WDT
+	default 38 if FSL_BOOKE
+	range 0 63 if FSL_BOOKE
+	default 3 if !FSL_BOOKE
+	range 0 3 if !FSL_BOOKE
+	help
+	  Select the default watchdog timer period to be used by the PowerPC
+	  Book-E watchdog driver.  A watchdog "event" occurs when the bit
+	  position represented by this number transitions from zero to one.
+
+	  For Freescale Book-E processors, this is a number between 0 and 63.
+	  For other Book-E processors, this is a number between 0 and 3.
+
+	  The value can be overidden by the wdt_period command-line parameter.
+
 # PPC64 Architecture
 
 config WATCHDOG_RTAS
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index a989998..d11ffb0 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -33,14 +33,8 @@
  * occur, and the final time the board will reset.
  */
 
-#ifdef	CONFIG_FSL_BOOKE
-#define WDT_PERIOD_DEFAULT 38	/* Ex. wdt_period=28 bus=333Mhz,reset=~40sec */
-#else
-#define WDT_PERIOD_DEFAULT 3	/* Refer to the PPC40x and PPC4xx manuals */
-#endif				/* for timing information */
-
 u32 booke_wdt_enabled;
-u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
+u32 booke_wdt_period = CONFIG_BOOKE_WDT_DEFAULT_TIMEOUT;
 
 #ifdef	CONFIG_FSL_BOOKE
 #define WDTP(x)		((((x)&0x3)<<30)|(((x)&0x3c)<<15))
-- 
1.7.2.3
