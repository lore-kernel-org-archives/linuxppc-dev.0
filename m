Return-Path: <anton@ozlabs.org>
Date: Sat, 25 Mar 2006 17:30:00 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] HVC init race
Message-ID: <20060325063000.GU30422@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Michael Neuling <mikey@neuling.org>

I've been hitting a crash on boot where tty_open is being called before the
hvc console driver setup is complete.  Below patch fixes this problem.

Thanks to benh for his help on this.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Anton Blanchard <anton@samba.org>
---

Index: build/drivers/char/hvc_console.c
===================================================================
--- build.orig/drivers/char/hvc_console.c	2006-03-25 16:49:20.000000000 +1100
+++ build/drivers/char/hvc_console.c	2006-03-25 16:49:44.000000000 +1100
@@ -823,34 +823,38 @@ EXPORT_SYMBOL(hvc_remove);
  * interfaces start to become available. */
 int __init hvc_init(void)
 {
+	struct tty_driver *drv;
+
 	/* We need more than hvc_count adapters due to hotplug additions. */
-	hvc_driver = alloc_tty_driver(HVC_ALLOC_TTY_ADAPTERS);
-	if (!hvc_driver)
+	drv = alloc_tty_driver(HVC_ALLOC_TTY_ADAPTERS);
+	if (!drv)
 		return -ENOMEM;
 
-	hvc_driver->owner = THIS_MODULE;
-	hvc_driver->devfs_name = "hvc/";
-	hvc_driver->driver_name = "hvc";
-	hvc_driver->name = "hvc";
-	hvc_driver->major = HVC_MAJOR;
-	hvc_driver->minor_start = HVC_MINOR;
-	hvc_driver->type = TTY_DRIVER_TYPE_SYSTEM;
-	hvc_driver->init_termios = tty_std_termios;
-	hvc_driver->flags = TTY_DRIVER_REAL_RAW;
-	tty_set_operations(hvc_driver, &hvc_ops);
+	drv->owner = THIS_MODULE;
+	drv->devfs_name = "hvc/";
+	drv->driver_name = "hvc";
+	drv->name = "hvc";
+	drv->major = HVC_MAJOR;
+	drv->minor_start = HVC_MINOR;
+	drv->type = TTY_DRIVER_TYPE_SYSTEM;
+	drv->init_termios = tty_std_termios;
+	drv->flags = TTY_DRIVER_REAL_RAW;
+	tty_set_operations(drv, &hvc_ops);
 
 	/* Always start the kthread because there can be hotplug vty adapters
 	 * added later. */
 	hvc_task = kthread_run(khvcd, NULL, "khvcd");
 	if (IS_ERR(hvc_task)) {
 		panic("Couldn't create kthread for console.\n");
-		put_tty_driver(hvc_driver);
+		put_tty_driver(drv);
 		return -EIO;
 	}
 
-	if (tty_register_driver(hvc_driver))
+	if (tty_register_driver(drv))
 		panic("Couldn't register hvc console driver\n");
 
+	mb();
+	hvc_driver = drv;
 	return 0;
 }
 module_init(hvc_init);
