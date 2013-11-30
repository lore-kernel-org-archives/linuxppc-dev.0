Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 738162C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 02:33:51 +1100 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Wim Van Sebroeck <wim@iguana.be>, <scottwood@freescale.com>
Subject: [PATCH] watchdog: mpc8xxx_wdt convert to watchdog core
Message-Id: <20131130153345.3070443E15@localhost.localdomain>
Date: Sat, 30 Nov 2013 16:33:45 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert mpc8xxx_wdt.c to the new watchdog API.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

diff -ur a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
--- a/drivers/watchdog/mpc8xxx_wdt.c	2013-05-11 22:57:46.000000000 +0200
+++ b/drivers/watchdog/mpc8xxx_wdt.c	2013-11-30 16:14:53.803495472 +0100
@@ -72,28 +72,31 @@
  * to 0
  */
 static int prescale =3D 1;
-static unsigned int timeout_sec;
 
-static unsigned long wdt_is_open;
 static DEFINE_SPINLOCK(wdt_spinlock);
 
-static void mpc8xxx_wdt_keepalive(void)
+static int mpc8xxx_wdt_ping(struct watchdog_device *w)
 {
 	/* Ping the WDT */
 	spin_lock(&wdt_spinlock);
 	out_be16(&wd_base->swsrr, 0x556c);
 	out_be16(&wd_base->swsrr, 0xaa39);
 	spin_unlock(&wdt_spinlock);
+	return 0;
 }
 
+static struct watchdog_device mpc8xxx_wdt_dev;
 static void mpc8xxx_wdt_timer_ping(unsigned long arg);
-static DEFINE_TIMER(wdt_timer, mpc8xxx_wdt_timer_ping, 0, 0);
+static DEFINE_TIMER(wdt_timer, mpc8xxx_wdt_timer_ping, 0,
+		(unsigned long)&mpc8xxx_wdt_dev);
 
 static void mpc8xxx_wdt_timer_ping(unsigned long arg)
 {
-	mpc8xxx_wdt_keepalive();
+	struct watchdog_device *w =3D (struct watchdog_device *)arg;
+
+	mpc8xxx_wdt_ping(w);
 	/* We're pinging it twice faster than needed, just to be sure. */
-	mod_timer(&wdt_timer, jiffies + HZ * timeout_sec / 2);
+	mod_timer(&wdt_timer, jiffies + HZ * w->timeout / 2);
 }
 
 static void mpc8xxx_wdt_pr_warn(const char *msg)
@@ -102,19 +105,9 @@
 		reset ? "reset" : "machine check exception");
 }
 
-static ssize_t mpc8xxx_wdt_write(struct file *file, const char __user *buf=
,
-				 size_t count, loff_t *ppos)
-{
-	if (count)
-		mpc8xxx_wdt_keepalive();
-	return count;
-}
-
-static int mpc8xxx_wdt_open(struct inode *inode, struct file *file)
+static int mpc8xxx_wdt_start(struct watchdog_device *w)
 {
 	u32 tmp =3D SWCRR_SWEN;
-	if (test_and_set_bit(0, &wdt_is_open))
-		return -EBUSY;
 
 	/* Once we start the watchdog we can't stop it */
 	if (nowayout)
@@ -132,59 +125,30 @@
 
 	del_timer_sync(&wdt_timer);
 
-	return nonseekable_open(inode, file);
+	return 0;
 }
 
-static int mpc8xxx_wdt_release(struct inode *inode, struct file *file)
+static int mpc8xxx_wdt_stop(struct watchdog_device *w)
 {
-	if (!nowayout)
-		mpc8xxx_wdt_timer_ping(0);
-	else
-		mpc8xxx_wdt_pr_warn("watchdog closed");
-	clear_bit(0, &wdt_is_open);
+	mpc8xxx_wdt_timer_ping((unsigned long)w);
 	return 0;
 }
 
-static long mpc8xxx_wdt_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
-{
-	void __user *argp =3D (void __user *)arg;
-	int __user *p =3D argp;
-	static const struct watchdog_info ident =3D {
-		.options =3D WDIOF_KEEPALIVEPING,
-		.firmware_version =3D 1,
-		.identity =3D "MPC8xxx",
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-	case WDIOC_KEEPALIVE:
-		mpc8xxx_wdt_keepalive();
-		return 0;
-	case WDIOC_GETTIMEOUT:
-		return put_user(timeout_sec, p);
-	default:
-		return -ENOTTY;
-	}
-}
+static struct watchdog_info mpc8xxx_wdt_info =3D {
+	.options =3D WDIOF_KEEPALIVEPING,
+	.firmware_version =3D 1,
+	.identity =3D "MPC8xxx",
+};
 
-static const struct file_operations mpc8xxx_wdt_fops =3D {
-	.owner		=3D THIS_MODULE,
-	.llseek		=3D no_llseek,
-	.write		=3D mpc8xxx_wdt_write,
-	.unlocked_ioctl	=3D mpc8xxx_wdt_ioctl,
-	.open		=3D mpc8xxx_wdt_open,
-	.release	=3D mpc8xxx_wdt_release,
+static struct watchdog_ops mpc8xxx_wdt_ops =3D {
+	.owner =3D THIS_MODULE,
+	.start =3D mpc8xxx_wdt_start,
+	.stop =3D mpc8xxx_wdt_stop,
 };
 
-static struct miscdevice mpc8xxx_wdt_miscdev =3D {
-	.minor	=3D WATCHDOG_MINOR,
-	.name	=3D "watchdog",
-	.fops	=3D &mpc8xxx_wdt_fops,
+static struct watchdog_device mpc8xxx_wdt_dev =3D {
+	.info =3D &mpc8xxx_wdt_info,
+	.ops =3D &mpc8xxx_wdt_ops,
 };
 
 static const struct of_device_id mpc8xxx_wdt_match[];
@@ -196,6 +160,7 @@
 	const struct mpc8xxx_wdt_type *wdt_type;
 	u32 freq =3D fsl_get_sys_freq();
 	bool enabled;
+	unsigned int timeout_sec;
 
 	match =3D of_match_device(mpc8xxx_wdt_match, &ofdev->dev);
 	if (!match)
@@ -222,6 +187,7 @@
 	else
 		timeout_sec =3D timeout / freq;
 
+	mpc8xxx_wdt_dev.timeout =3D timeout_sec;
 #ifdef MODULE
 	ret =3D mpc8xxx_wdt_init_late();
 	if (ret)
@@ -237,7 +203,7 @@
 	 * userspace handles it.
 	 */
 	if (enabled)
-		mpc8xxx_wdt_timer_ping(0);
+		mpc8xxx_wdt_timer_ping((unsigned long)&mpc8xxx_wdt_dev);
 	return 0;
 err_unmap:
 	iounmap(wd_base);
@@ -249,7 +215,7 @@
 {
 	mpc8xxx_wdt_pr_warn("watchdog removed");
 	del_timer_sync(&wdt_timer);
-	misc_deregister(&mpc8xxx_wdt_miscdev);
+	watchdog_unregister_device(&mpc8xxx_wdt_dev);
 	iounmap(wd_base);
 
 	return 0;
@@ -301,10 +267,11 @@
 	if (!wd_base)
 		return -ENODEV;
 
-	ret =3D misc_register(&mpc8xxx_wdt_miscdev);
+	watchdog_set_nowayout(&mpc8xxx_wdt_dev, nowayout);
+
+	ret =3D watchdog_register_device(&mpc8xxx_wdt_dev);
 	if (ret) {
-		pr_err("cannot register miscdev on minor=3D%d (err=3D%d)\n",
-		       WATCHDOG_MINOR, ret);
+		pr_err("cannot register watchdog device (err=3D%d)\n", ret);
 		return ret;
 	}
 	return 0;
diff -ur a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1146,6 +1146,7 @@
 config 8xxx_WDT
 	tristate "MPC8xxx Platform Watchdog Timer"
 	depends on PPC_8xx || PPC_83xx || PPC_86xx
+	select WATCHDOG_CORE
 	help
 	  This driver is for a SoC level watchdog that exists on some
 	  Freescale PowerPC processors. So far this driver supports:

---
Ce courrier =C3=A9lectronique ne contient aucun virus ou logiciel malveilla=
nt parce que la protection avast! Antivirus est active.
http://www.avast.com
