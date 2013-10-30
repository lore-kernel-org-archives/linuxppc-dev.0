Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id B04C92C0365
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 15:25:47 +1100 (EST)
Date: Tue, 29 Oct 2013 21:25:43 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ADB_PMU_LED_IDE selects LEDS_TRIGGER_IDE_DISK which has
 unmet direct dependencies
In-Reply-To: <1383088392.5117.38.camel@pasglop>
Message-ID: <alpine.DEB.2.11.1310292123190.31521@trent.utfs.org>
References: <alpine.DEB.2.11.1310280031020.31521@trent.utfs.org>
 <1383088392.5117.38.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 30 Oct 2013 at 10:13, Benjamin Herrenschmidt wrote:
> You probably want to do that to the ADB_PMU_LED_IDE entry not the
> ADB_PMU_LED one which doesn't have a dependency and isn't the one
> selecting LEDS_TRIGGER_IDE_DISK :-)

Right you are, sorry for the mixup. Let me try again:


  Signed-off-by: Christian Kujau <lists@nerdbynature.de>

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 696238b..d26a312 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -103,6 +103,7 @@ config ADB_PMU_LED_IDE
 	bool "Use front LED as IDE LED by default"
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
+	depends on IDE_GD_ATA
 	select LEDS_TRIGGERS
 	select LEDS_TRIGGER_IDE_DISK
 	help

C.
-- 
BOFH excuse #378:

Operators killed by year 2000 bug bite.
