Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 6A992DE09D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 21:46:29 +1000 (EST)
Date: Fri, 16 May 2008 15:46:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH 6/8] [WATCHDOG] mpc8xxx_wdt: add support for MPC8xx
	watchdogs
Message-ID: <20080516114627.GA29928@polina.dev.rtsoft.ru>
References: <20080515165250.GA30738@polina.dev.rtsoft.ru>
	<20080515165401.GF3887@polina.dev.rtsoft.ru>
	<482D5129.6050402@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <482D5129.6050402@scram.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Chen Gong <G.Chen@freescale.com>,
	Scott Wood <scottwood@freescale.com>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 11:17:29AM +0200, Jochen Friedrich wrote:
> Hi Anton,
> 
> > The mpc8xxx_wdt driver is using two registers: SWSRR to push magic
> > numbers, and SWCRR to control the watchdog. Both registers are available
> > on the MPC8xx, and seem to have the same offsets and semantics as in
> > MPC83xx/MPC86xx watchdogs. The only difference is prescale value. So this
> > driver should simply work on the MPC8xx CPUs.
> > 
> > MPC823 seem to be the first CPU in MPC8xx line, so we use fsl,mpc823-wdt
> > compatible matching.
> > 
> > Though, this patch was only build-tested and okay to drop from this
> > series until tested or corrected to work on the actual hardware.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Tested-by: Jochen Friedrich <jochen@scram.de>

Thanks!

> The driver works OK on MPC823.
> 
> One nit however ist the late initialisation of the wdt timer. I had to add
> two hardcoded wdt resets in the board setup, one in setup_arch and one in
> arch_initcall, to prevent a reset until mpc8xxx_wdt kicks in. However, IMHO
> this is acceptable as it only hits the 8xx series with the small prescale.

Hm... This is strange because subsys initcalls should be called quite
early... what type of initcall you're using in the board file to probe the
OF bus? I guess this was machine_device_initcall, can you try the
machine_subsys_initcall(), i.e. the same as we use in the driver?

If this still doesn't not work... You can try the patch attached here,
and try using machine_arch_initcall to do of_platform_bus_probe().
This way wdt should be called even earlier...

Also, if u-boot enables the watchdog, it should support the keepalive
too, because it might spend precious time not pinging the wdt...

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index c7e28f0..0f7e165 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -207,13 +207,6 @@ static int __devinit mpc8xxx_wdt_probe(struct of_device *ofdev,
 		goto err_unmap;
 	}
 
-	ret = misc_register(&mpc8xxx_wdt_miscdev);
-	if (ret) {
-		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
-			WATCHDOG_MINOR, ret);
-		goto err_unmap;
-	}
-
 	/* Calculate the timeout in seconds */
 	if (prescale)
 		timeout_sec = (timeout * wdt_type->prescaler) / freq;
@@ -234,6 +227,7 @@ static int __devinit mpc8xxx_wdt_probe(struct of_device *ofdev,
 	return 0;
 err_unmap:
 	iounmap(wd_base);
+	wd_base = NULL;
 	return ret;
 }
 
@@ -281,17 +275,38 @@ static struct of_platform_driver mpc8xxx_wdt_driver = {
 	},
 };
 
+/*
+ * We do wdt initialization in two steps: arch_initcall probes the wdt
+ * very early to start pinging the watchdog (misc devices are not yet
+ * available), and later module_init() just registers the misc device.
+ */
+static int __init mpc8xxx_wdt_init_late(void)
+{
+	int ret;
+
+	if (!wd_base)
+		return -ENODEV;
+
+	ret = misc_register(&mpc8xxx_wdt_miscdev);
+	if (ret) {
+		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		return ret;
+	}
+	return 0;
+}
+module_init(mpc8xxx_wdt_init_late);
+
 static int __init mpc8xxx_wdt_init(void)
 {
 	return of_register_platform_driver(&mpc8xxx_wdt_driver);
 }
+arch_initcall(mpc8xxx_wdt_init);
 
 static void __exit mpc8xxx_wdt_exit(void)
 {
 	of_unregister_platform_driver(&mpc8xxx_wdt_driver);
 }
-
-subsys_initcall(mpc8xxx_wdt_init);
 module_exit(mpc8xxx_wdt_exit);
 
 MODULE_AUTHOR("Dave Updegraff, Kumar Gala");
