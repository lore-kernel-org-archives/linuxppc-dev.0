Return-Path: <Lu.Jiang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 209772C02C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 12:44:37 +1000 (EST)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
 by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6D2iYs5009625
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 19:44:35 -0700 (PDT)
From: Jiang Lu <lu.jiang@windriver.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] ppc44x/watchdog: Select WATCHDOG_NOWAYOUT option
Date: Fri, 13 Jul 2012 10:44:33 +0800
Message-ID: <1342147473-20231-1-git-send-email-lu.jiang@windriver.com>
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

On PPC44x core, the WRC(Watchdog-timer Reset Control) field of TCR
of timer can not reset by software after set to a non-zero value.
Which means software can not reset the timeout behaviour of watchdog timer.

This patch selects WATCHDOG_NOWAYOUT option for 44x platforms to
indicate the watchdog timer can not be disabled once fired.

Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
---
 drivers/watchdog/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3709624..41f3dff 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1084,6 +1084,7 @@ config PIKA_WDT
 config BOOKE_WDT
 	tristate "PowerPC Book-E Watchdog Timer"
 	depends on BOOKE || 4xx
+	select WATCHDOG_NOWAYOUT if 44x
 	---help---
 	  Watchdog driver for PowerPC Book-E chips, such as the Freescale
 	  MPC85xx SOCs and the IBM PowerPC 440.
-- 
1.7.7
