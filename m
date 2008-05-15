Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 5B03CDE660
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:54:02 +1000 (EST)
Date: Thu, 15 May 2008 20:54:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 6/8] [WATCHDOG] mpc8xxx_wdt: add support for MPC8xx watchdogs
Message-ID: <20080515165401.GF3887@polina.dev.rtsoft.ru>
References: <20080515165250.GA30738@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080515165250.GA30738@polina.dev.rtsoft.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Chen Gong <G.Chen@freescale.com>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mpc8xxx_wdt driver is using two registers: SWSRR to push magic
numbers, and SWCRR to control the watchdog. Both registers are available
on the MPC8xx, and seem to have the same offsets and semantics as in
MPC83xx/MPC86xx watchdogs. The only difference is prescale value. So this
driver should simply work on the MPC8xx CPUs.

MPC823 seem to be the first CPU in MPC8xx line, so we use fsl,mpc823-wdt
compatible matching.

Though, this patch was only build-tested and okay to drop from this
series until tested or corrected to work on the actual hardware.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/watchdog/Kconfig       |    3 ++-
 drivers/watchdog/mpc8xxx_wdt.c |   11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 008eaa6..f9e617b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -684,10 +684,11 @@ config 8xx_WDT
 
 config 8xxx_WDT
 	tristate "MPC8xxx Platform Watchdog Timer"
-	depends on PPC_83xx || PPC_86xx
+	depends on PPC_8xx || PPC_83xx || PPC_86xx
 	help
 	  This driver is for a SoC level watchdog that exists on some
 	  Freescale PowerPC processors. So far this driver supports:
+	  - MPC8xx watchdogs
 	  - MPC83xx watchdogs
 	  - MPC86xx watchdogs
 
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 2f0681f..c7e28f0 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -1,5 +1,5 @@
 /*
- * mpc8xxx_wdt.c - MPC83xx/MPC86xx watchdog userspace interface
+ * mpc8xxx_wdt.c - MPC8xx/MPC83xx/MPC86xx watchdog userspace interface
  *
  * Authors: Dave Updegraff <dave@cray.org>
  * 	    Kumar Gala <galak@kernel.crashing.org>
@@ -261,6 +261,12 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 			.hw_enabled = true,
 		},
 	},
+	{
+		.compatible = "fsl,mpc823-wdt",
+		.data = &(struct mpc8xxx_wdt_type) {
+			.prescaler = 0x800,
+		},
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
@@ -289,6 +295,7 @@ subsys_initcall(mpc8xxx_wdt_init);
 module_exit(mpc8xxx_wdt_exit);
 
 MODULE_AUTHOR("Dave Updegraff, Kumar Gala");
-MODULE_DESCRIPTION("Driver for watchdog timer in MPC83xx/MPC86xx uProcessors");
+MODULE_DESCRIPTION("Driver for watchdog timer in MPC8xx/MPC83xx/MPC86xx "
+		   "uProcessors");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
-- 
1.5.5.1
