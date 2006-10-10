Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FCEB679E7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 11:47:40 +1000 (EST)
Subject: [PATCH] powerpc: Fix windfarm platform device usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 11:47:31 +1000
Message-Id: <1160444851.32237.41.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The windfarm code uses a struct device_driver instead of
platform_driver, which can cause crashes if any of the callbacks are
called (like on module removal). This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/macintosh/windfarm_pm112.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm112.c	2006-03-10 15:58:18.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pm112.c	2006-10-10 11:40:20.000000000 +1000
@@ -650,24 +650,26 @@ static struct notifier_block pm112_event
 	.notifier_call = pm112_wf_notify,
 };
 
-static int wf_pm112_probe(struct device *dev)
+static int wf_pm112_probe(struct platform_device *dev)
 {
 	wf_register_client(&pm112_events);
 	return 0;
 }
 
-static int wf_pm112_remove(struct device *dev)
+static int __devexit wf_pm112_remove(struct platform_device *dev)
 {
 	wf_unregister_client(&pm112_events);
 	/* should release all sensors and controls */
 	return 0;
 }
 
-static struct device_driver wf_pm112_driver = {
-	.name = "windfarm",
-	.bus = &platform_bus_type,
+static struct platform_driver wf_pm112_driver = {
 	.probe = wf_pm112_probe,
-	.remove = wf_pm112_remove,
+	.remove = __devexit_p(wf_pm112_remove),
+	.driver = {
+		.name = "windfarm",
+		.bus = &platform_bus_type,
+	},
 };
 
 static int __init wf_pm112_init(void)
@@ -683,13 +685,13 @@ static int __init wf_pm112_init(void)
 		++nr_cores;
 
 	printk(KERN_INFO "windfarm: initializing for dual-core desktop G5\n");
-	driver_register(&wf_pm112_driver);
+	platform_driver_register(&wf_pm112_driver);
 	return 0;
 }
 
 static void __exit wf_pm112_exit(void)
 {
-	driver_unregister(&wf_pm112_driver);
+	platform_driver_unregister(&wf_pm112_driver);
 }
 
 module_init(wf_pm112_init);
Index: linux-work/drivers/macintosh/windfarm_pm81.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm81.c	2006-10-06 13:48:04.000000000 +1000
+++ linux-work/drivers/macintosh/windfarm_pm81.c	2006-10-10 11:42:02.000000000 +1000
@@ -131,8 +131,6 @@
 
 static int wf_smu_mach_model;	/* machine model id */
 
-static struct device *wf_smu_dev;
-
 /* Controls & sensors */
 static struct wf_sensor	*sensor_cpu_power;
 static struct wf_sensor	*sensor_cpu_temp;
@@ -717,16 +715,14 @@ static int wf_init_pm(void)
 	return 0;
 }
 
-static int wf_smu_probe(struct device *ddev)
+static int wf_smu_probe(struct platform_device *ddev)
 {
-	wf_smu_dev = ddev;
-
 	wf_register_client(&wf_smu_events);
 
 	return 0;
 }
 
-static int wf_smu_remove(struct device *ddev)
+static int __devexit wf_smu_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&wf_smu_events);
 
@@ -766,16 +762,16 @@ static int wf_smu_remove(struct device *
 	if (wf_smu_cpu_fans)
 		kfree(wf_smu_cpu_fans);
 
-	wf_smu_dev = NULL;
-
 	return 0;
 }
 
-static struct device_driver wf_smu_driver = {
-        .name = "windfarm",
-        .bus = &platform_bus_type,
+static struct platform_driver wf_smu_driver = {
         .probe = wf_smu_probe,
-        .remove = wf_smu_remove,
+        .remove = __devexit_p(wf_smu_remove),
+	.driver = {
+		.name = "windfarm",
+		.bus = &platform_bus_type,
+	},
 };
 
 
@@ -794,7 +790,7 @@ static int __init wf_smu_init(void)
 		request_module("windfarm_lm75_sensor");
 
 #endif /* MODULE */
-		driver_register(&wf_smu_driver);
+		platform_driver_register(&wf_smu_driver);
 	}
 
 	return rc;
@@ -803,7 +799,7 @@ static int __init wf_smu_init(void)
 static void __exit wf_smu_exit(void)
 {
 
-	driver_unregister(&wf_smu_driver);
+	platform_driver_unregister(&wf_smu_driver);
 }
 
 
Index: linux-work/drivers/macintosh/windfarm_pm91.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm91.c	2006-10-06 13:48:04.000000000 +1000
+++ linux-work/drivers/macintosh/windfarm_pm91.c	2006-10-10 11:41:52.000000000 +1000
@@ -63,8 +63,6 @@
  */
 #undef HACKED_OVERTEMP
 
-static struct device *wf_smu_dev;
-
 /* Controls & sensors */
 static struct wf_sensor	*sensor_cpu_power;
 static struct wf_sensor	*sensor_cpu_temp;
@@ -641,16 +639,14 @@ static int wf_init_pm(void)
 	return 0;
 }
 
-static int wf_smu_probe(struct device *ddev)
+static int wf_smu_probe(struct platform_device *ddev)
 {
-	wf_smu_dev = ddev;
-
 	wf_register_client(&wf_smu_events);
 
 	return 0;
 }
 
-static int wf_smu_remove(struct device *ddev)
+static int __devexit wf_smu_remove(struct platform_device *ddev)
 {
 	wf_unregister_client(&wf_smu_events);
 
@@ -698,16 +694,16 @@ static int wf_smu_remove(struct device *
 	if (wf_smu_cpu_fans)
 		kfree(wf_smu_cpu_fans);
 
-	wf_smu_dev = NULL;
-
 	return 0;
 }
 
-static struct device_driver wf_smu_driver = {
-        .name = "windfarm",
-        .bus = &platform_bus_type,
+static struct platform_driver wf_smu_driver = {
         .probe = wf_smu_probe,
-        .remove = wf_smu_remove,
+        .remove = __devexit_p(wf_smu_remove),
+	.driver = {
+		.name = "windfarm",
+		.bus = &platform_bus_type,
+	},
 };
 
 
@@ -725,7 +721,7 @@ static int __init wf_smu_init(void)
 		request_module("windfarm_lm75_sensor");
 
 #endif /* MODULE */
-		driver_register(&wf_smu_driver);
+		platform_driver_register(&wf_smu_driver);
 	}
 
 	return rc;
@@ -734,7 +730,7 @@ static int __init wf_smu_init(void)
 static void __exit wf_smu_exit(void)
 {
 
-	driver_unregister(&wf_smu_driver);
+	platform_driver_unregister(&wf_smu_driver);
 }
 
 
