Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id D7EFE67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Apr 2005 14:28:12 +1000 (EST)
Message-ID: <424CCD9E.2010907@jp.fujitsu.com>
Date: Fri, 01 Apr 2005 13:27:10 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, galak@freescale.com,
	mporter@kernel.crashing.org
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] WDT Driver for Book-E [3/3] get rid of PVR. access.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I fixed the device driver codes for BOOK-E Architecture which I posted before.
This patch get rid of PVR register access in the driver according to
recent fashion.

This patch is written to apply after applying two patches I sent before.

Please apply.

P.S. Kumar, have you tested this driver?
Please notify if there are some problems with the driver.

Regards,

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>

diff -Naur linux-2.6.11.6.orig/drivers/char/watchdog/booke_wdt.c linux-2.6.11.6/drivers/char/watchdog/booke_wdt.c
--- linux-2.6.11.6.orig/drivers/char/watchdog/booke_wdt.c	2005-04-01 02:55:48.000000000 +0900
+++ linux-2.6.11.6/drivers/char/watchdog/booke_wdt.c	2005-04-01 02:35:00.000000000 +0900
@@ -37,6 +37,7 @@
 #include <asm/reg.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include <asm/cputable.h>
 #include "booke_wdt.h"

 /* micro seconds per one milli-second(used to calculatewatchdog
@@ -345,7 +346,7 @@
     /* Hardware WDT provided by the processor.
      * So, we set firmware version as processor version number.
      */
-    ident.firmware_version=mfspr(PVR);
+    ident.firmware_version=cpu_specs[0].pvr_value;
     __booke_wdt_setup_val(WDT_WP,WRC_NONE);
 }
 /**
