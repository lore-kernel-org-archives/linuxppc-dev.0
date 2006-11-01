Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF7F967B6F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 16:45:23 +1100 (EST)
Subject: [PATCH] powerpc: windfarm requests missing modules
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 15:55:26 +1100
Message-Id: <1162356927.25682.409.camel@localhost.localdomain>
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

The windfarm code, in it's current incarnation, uses request_module() to
load the various submodules it needs for a given platform so that only
the main platform control module needs to be modprobed. However, it was
missing various bits. This fixes it. In the future, we'll use some
hotplug mecanisms to try to get all of this auto-loaded on the platforms
where it matters but that isn't ready yet.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I consider this a bug fix, could go in 2.6.19

Index: linux-work/drivers/macintosh/windfarm_pm112.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm112.c	2006-10-13 17:23:48.000000000 +1000
+++ linux-work/drivers/macintosh/windfarm_pm112.c	2006-11-01 13:52:27.000000000 +1100
@@ -685,6 +685,17 @@ static int __init wf_pm112_init(void)
 		++nr_cores;
 
 	printk(KERN_INFO "windfarm: initializing for dual-core desktop G5\n");
+
+#ifdef MODULE
+	request_module("windfarm_smu_controls");
+	request_module("windfarm_smu_sensors");
+	request_module("windfarm_smu_sat");
+	request_module("windfarm_lm75_sensor");
+	request_module("windfarm_max6690_sensor");
+	request_module("windfarm_cpufreq_clamp");
+
+#endif /* MODULE */
+
 	platform_driver_register(&wf_pm112_driver);
 	return 0;
 }
Index: linux-work/drivers/macintosh/windfarm_pm81.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm81.c	2006-11-01 13:48:52.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_pm81.c	2006-11-01 13:49:24.000000000 +1100
@@ -788,6 +788,7 @@ static int __init wf_smu_init(void)
 		request_module("windfarm_smu_controls");
 		request_module("windfarm_smu_sensors");
 		request_module("windfarm_lm75_sensor");
+		request_module("windfarm_cpufreq_clamp");
 
 #endif /* MODULE */
 		platform_driver_register(&wf_smu_driver);
Index: linux-work/drivers/macintosh/windfarm_pm91.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_pm91.c	2006-10-13 17:23:48.000000000 +1000
+++ linux-work/drivers/macintosh/windfarm_pm91.c	2006-11-01 13:50:03.000000000 +1100
@@ -719,6 +719,7 @@ static int __init wf_smu_init(void)
 		request_module("windfarm_smu_controls");
 		request_module("windfarm_smu_sensors");
 		request_module("windfarm_lm75_sensor");
+		request_module("windfarm_cpufreq_clamp");
 
 #endif /* MODULE */
 		platform_driver_register(&wf_smu_driver);
