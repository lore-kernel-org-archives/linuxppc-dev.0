Return-Path: <cminyard@comcast.net>
Received: from rwcrmhc12.comcast.net (rwcrmhc12.comcast.net [216.148.227.85])
	by ozlabs.org (Postfix) with ESMTP id D69FF680F7
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2005 04:37:31 +1000 (EST)
Date: Thu, 29 Sep 2005 13:32:21 -0500
From: Corey Minyard <minyard@acm.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050929183221.GA17292@i2.minyard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: MV64x60 watchdog timer driver updates
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

James looked at an earlier version and said it was ok, and suggested
a few changes.  This has been tested against 2.6.14-rc2 on a Katana.

Note that the bus_clk value from the platform information seems to
be in MHZ, but the actual frequency is generally 133,333,333, not
133,000,000.  I don't think the inaccuracy matters here, but it seems
a little odd.

-Corey

----

The mv64x60 watchdog timer driver didn't allow dynamically setting
the timeout value.  The hardware is settable, and setting the value
is rather important (especially with such a small default).  So
this patch adds that function.

It also does the following:
  * Modifies the returned timeout to be seconds, not jiffies,
    as seconds is the standard.
  * Adds a semaphore around the various critical data structures
    and access to the device registers.  The former operations
    could be racy.
  * Adds enable and disable operations.

Signed-off-by: Corey Minyard <cminyard@mvista.com>

Index: linux-2.6.14-rc2/drivers/char/watchdog/mv64x60_wdt.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/watchdog/mv64x60_wdt.c
+++ linux-2.6.14-rc2/drivers/char/watchdog/mv64x60_wdt.c
@@ -25,12 +25,14 @@
 #include <asm/mv64x60.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/semaphore.h>
 
 /* MV64x60 WDC (config) register access definitions */
 #define MV64x60_WDC_CTL1_MASK	(3 << 24)
 #define MV64x60_WDC_CTL1(val)	((val & 3) << 24)
 #define MV64x60_WDC_CTL2_MASK	(3 << 26)
 #define MV64x60_WDC_CTL2(val)	((val & 3) << 26)
+#define MV64x60_WDC_ENABLE	(1 << 31)
 
 /* Flags bits */
 #define MV64x60_WDOG_FLAG_OPENED	0
@@ -39,44 +41,77 @@
 static unsigned long wdt_flags;
 static int wdt_status;
 static void __iomem *mv64x60_regs;
+static int mv64x60_bus_clk = 133000000;
 static int mv64x60_wdt_timeout;
+static u32 mv64x60_wdt_control_val;
+
+static DECLARE_MUTEX(mv64x60_sem);
+
+static u32 mv64x60_wdt_read_reg(void)
+{
+	return readl(mv64x60_regs + MV64x60_WDT_WDC);
+}
 
 static void mv64x60_wdt_reg_write(u32 val)
 {
 	/* Allow write only to CTL1 / CTL2 fields, retaining values in
 	 * other fields.
 	 */
-	u32 data = readl(mv64x60_regs + MV64x60_WDT_WDC);
-	data &= ~(MV64x60_WDC_CTL1_MASK | MV64x60_WDC_CTL2_MASK);
-	data |= val;
+	u32 data = mv64x60_wdt_control_val | val;
 	writel(data, mv64x60_regs + MV64x60_WDT_WDC);
 }
 
 static void mv64x60_wdt_service(void)
 {
 	/* Write 01 followed by 10 to CTL2 */
+	down(&mv64x60_sem);
 	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x01));
 	mv64x60_wdt_reg_write(MV64x60_WDC_CTL2(0x02));
+	up(&mv64x60_sem);
+}
+
+static int mv64x60_set_timeout(int timeout)
+{
+	u32 cnt;
+
+	if (timeout > (0xffffffff / mv64x60_bus_clk))
+		return -EINVAL;
+
+	down(&mv64x60_sem);
+	mv64x60_wdt_timeout = timeout;
+
+	/* Put into u32 first so shift will be unsigned. */
+	cnt = timeout * mv64x60_bus_clk;
+	mv64x60_wdt_control_val = cnt >> 8;
+	up(&mv64x60_sem);
+
+	if (test_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags))
+		mv64x60_wdt_service();
+	return 0;
 }
 
 static void mv64x60_wdt_handler_disable(void)
 {
+	down(&mv64x60_sem);
 	if (test_and_clear_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
 		/* Write 01 followed by 10 to CTL1 */
 		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
 		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
 		printk(KERN_NOTICE "mv64x60_wdt: watchdog deactivated\n");
 	}
+	up(&mv64x60_sem);
 }
 
 static void mv64x60_wdt_handler_enable(void)
 {
+	down(&mv64x60_sem);
 	if (!test_and_set_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags)) {
 		/* Write 01 followed by 10 to CTL1 */
 		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x01));
 		mv64x60_wdt_reg_write(MV64x60_WDC_CTL1(0x02));
 		printk(KERN_NOTICE "mv64x60_wdt: watchdog activated\n");
 	}
+	up(&mv64x60_sem);
 }
 
 static int mv64x60_wdt_open(struct inode *inode, struct file *file)
@@ -119,6 +154,7 @@ static int mv64x60_wdt_ioctl(struct inod
 			     unsigned int cmd, unsigned long arg)
 {
 	int timeout;
+	int val;
 	static struct watchdog_info info = {
 		.options = WDIOF_KEEPALIVEPING,
 		.firmware_version = 0,
@@ -142,7 +178,14 @@ static int mv64x60_wdt_ioctl(struct inod
 		return -EOPNOTSUPP;
 
 	case WDIOC_SETOPTIONS:
-		return -EOPNOTSUPP;
+		if (copy_from_user(&val, (int *) arg, sizeof(int)))
+			return -EFAULT;
+		if (val & WDIOS_DISABLECARD)
+			mv64x60_wdt_handler_disable();
+
+		if (val & WDIOS_ENABLECARD)
+			mv64x60_wdt_handler_enable();
+		return 0;
 
 	case WDIOC_KEEPALIVE:
 		mv64x60_wdt_service();
@@ -150,13 +193,15 @@ static int mv64x60_wdt_ioctl(struct inod
 		break;
 
 	case WDIOC_SETTIMEOUT:
-		return -EOPNOTSUPP;
+  		if (get_user(timeout, (int *)arg))
+  			return -EFAULT;
+		return mv64x60_set_timeout(timeout);
 
 	case WDIOC_GETTIMEOUT:
-		timeout = mv64x60_wdt_timeout * HZ;
-		if (put_user(timeout, (int *)arg))
-			return -EFAULT;
-		break;
+		timeout = mv64x60_wdt_timeout;
+  		if (put_user(timeout, (int *)arg))
+  			return -EFAULT;
+  		break;
 
 	default:
 		return -ENOIOCTLCMD;
@@ -184,18 +229,25 @@ static int __devinit mv64x60_wdt_probe(s
 {
 	struct platform_device *pd = to_platform_device(dev);
 	struct mv64x60_wdt_pdata *pdata = pd->dev.platform_data;
-	int bus_clk = 133;
+	int timeout = 10;
 
-	mv64x60_wdt_timeout = 10;
 	if (pdata) {
-		mv64x60_wdt_timeout = pdata->timeout;
-		bus_clk = pdata->bus_clk;
+		timeout = pdata->timeout;
+		mv64x60_bus_clk = pdata->bus_clk * 1000000;
+	}
+	if (mv64x60_set_timeout(timeout)) {
+		printk("mv64x60_wdt: Default timeout too large, setting to"
+		       " maximum value\n");
+		mv64x60_set_timeout(0xffffffff / mv64x60_bus_clk);
 	}
 
 	mv64x60_regs = mv64x60_get_bridge_vbase();
 
-	writel((mv64x60_wdt_timeout * (bus_clk * 1000000)) >> 8,
-	       mv64x60_regs + MV64x60_WDT_WDC);
+	if (mv64x60_wdt_read_reg() & MV64x60_WDC_ENABLE) {
+		/* Watchdog was already running, disable it */
+		set_bit(MV64x60_WDOG_FLAG_ENABLED, &wdt_flags);
+		mv64x60_wdt_handler_disable();
+	}
 
 	return misc_register(&mv64x60_wdt_miscdev);
 }
