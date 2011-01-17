Return-Path: <timur@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 27696B7144
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 08:29:50 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog: booke_wdt: clean up status messages
Date: Mon, 17 Jan 2011 15:29:40 -0600
Message-ID: <1295299780-27338-1-git-send-email-timur@freescale.com>
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

Improve the status messages that are displayed during some operations of the
PowerPC watchdog timer driver.  When the watchdog is enabled, the timeout is
displayed as a number of seconds, instead of an obscure "period".  The "period"
is the position of a bit in a 64-bit timer register.  The higher the value,
the quicker the watchdog timeout occurs.  Some people chose a high "period"
value for the timer and get confused as to why the board resets within a
few seconds.

Messages displayed during open and close are now debug messages, so that they
don't clutter the console by default.  Finally, printk() is replaced with the
pr_xxx() equivalent.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/watchdog/booke_wdt.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 7e7ec9c..935d0dd 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -221,9 +221,8 @@ static int booke_wdt_open(struct inode *inode, struct file *file)
 	if (booke_wdt_enabled == 0) {
 		booke_wdt_enabled = 1;
 		on_each_cpu(__booke_wdt_enable, NULL, 0);
-		printk(KERN_INFO
-		      "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
-				booke_wdt_period);
+		pr_debug("booke_wdt: watchdog enabled (timeout = %llu sec)\n",
+			period_to_sec(booke_wdt_period));
 	}
 	spin_unlock(&booke_wdt_lock);
 
@@ -240,6 +239,7 @@ static int booke_wdt_release(struct inode *inode, struct file *file)
 	 */
 	on_each_cpu(__booke_wdt_disable, NULL, 0);
 	booke_wdt_enabled = 0;
+	pr_debug("booke_wdt: watchdog disabled\n",
 #endif
 
 	clear_bit(0, &wdt_is_active);
@@ -271,21 +271,20 @@ static int __init booke_wdt_init(void)
 {
 	int ret = 0;
 
-	printk(KERN_INFO "PowerPC Book-E Watchdog Timer Loaded\n");
+	pr_info("PowerPC Book-E Watchdog Timer Loaded\n");
 	ident.firmware_version = cur_cpu_spec->pvr_value;
 
 	ret = misc_register(&booke_wdt_miscdev);
 	if (ret) {
-		printk(KERN_CRIT "Cannot register miscdev on minor=%d: %d\n",
-				WATCHDOG_MINOR, ret);
+		pr_err("booke_wdt: cannot register device (minor=%u, ret=%i)\n",
+		       WATCHDOG_MINOR, ret);
 		return ret;
 	}
 
 	spin_lock(&booke_wdt_lock);
 	if (booke_wdt_enabled == 1) {
-		printk(KERN_INFO
-		      "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
-				booke_wdt_period);
+		pr_info("booke_wdt: watchdog enabled (timeout = %llu sec)\n",
+			period_to_sec(booke_wdt_period));
 		on_each_cpu(__booke_wdt_enable, NULL, 0);
 	}
 	spin_unlock(&booke_wdt_lock);
-- 
1.7.3.4
