Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 7E124DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:16:46 +1100 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU1007ER6VWL320@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:16:44 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JU100DHT6SDZGB0@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 12:14:39 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU100EPJ6SDJ030@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:14:37 -0700 (MST)
Date: Wed, 02 Jan 2008 12:14:28 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/5] [POWERPC] powermac: Use machine_*_initcall() hooks in
	platform code
In-reply-to: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	vitb@kernel.crashing.org, galak@kernel.crashing.org, olof@lixom.net
Message-id: <20080102191424.24178.41726.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/powermac/low_i2c.c    |    7 ++-----
 arch/powerpc/platforms/powermac/pfunc_base.c |    3 +--
 arch/powerpc/platforms/powermac/pic.c        |    3 +--
 arch/powerpc/platforms/powermac/setup.c      |   12 ++----------
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da2007e..9c9299c 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1462,9 +1462,6 @@ int __init pmac_i2c_init(void)
 		return 0;
 	i2c_inited = 1;
 
-	if (!machine_is(powermac))
-		return 0;
-
 	/* Probe keywest-i2c busses */
 	kw_i2c_probe();
 
@@ -1483,7 +1480,7 @@ int __init pmac_i2c_init(void)
 
 	return 0;
 }
-arch_initcall(pmac_i2c_init);
+machine_arch_initcall(powermac, pmac_i2c_init);
 
 /* Since pmac_i2c_init can be called too early for the platform device
  * registration, we need to do it at a later time. In our case, subsys
@@ -1515,4 +1512,4 @@ static int __init pmac_i2c_create_platform_devices(void)
 
 	return 0;
 }
-subsys_initcall(pmac_i2c_create_platform_devices);
+machine_subsys_initcall(powermac, pmac_i2c_create_platform_devices);
diff --git a/arch/powerpc/platforms/powermac/pfunc_base.c b/arch/powerpc/platforms/powermac/pfunc_base.c
index 45d54b9..db20de5 100644
--- a/arch/powerpc/platforms/powermac/pfunc_base.c
+++ b/arch/powerpc/platforms/powermac/pfunc_base.c
@@ -363,8 +363,7 @@ int __init pmac_pfunc_base_install(void)
 
 	return 0;
 }
-
-arch_initcall(pmac_pfunc_base_install);
+machine_arch_initcall(powermac, pmac_pfunc_base_install);
 
 #ifdef CONFIG_PM
 
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 999f5e1..cd72164 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -690,6 +690,5 @@ static int __init init_pmacpic_sysfs(void)
 	sysdev_driver_register(&pmacpic_sysclass, &driver_pmacpic);
 	return 0;
 }
-
-subsys_initcall(init_pmacpic_sysfs);
+machine_subsys_initcall(powermac, init_pmacpic_sysfs);
 
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index adad4e9..36ff1b6 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -397,17 +397,13 @@ static int initializing = 1;
 
 static int pmac_late_init(void)
 {
-	if (!machine_is(powermac))
-		return -ENODEV;
-
 	initializing = 0;
 	/* this is udbg (which is __init) and we can later use it during
 	 * cpu hotplug (in smp_core99_kick_cpu) */
 	ppc_md.progress = NULL;
 	return 0;
 }
-
-late_initcall(pmac_late_init);
+machine_late_initcall(powermac, pmac_late_init);
 
 /*
  * This is __init_refok because we check for "initializing" before
@@ -534,9 +530,6 @@ static int __init pmac_declare_of_platform_devices(void)
 	if (machine_is(chrp))
 		return -1;
 
-	if (!machine_is(powermac))
-		return 0;
-
 	np = of_find_node_by_name(NULL, "valkyrie");
 	if (np)
 		of_platform_device_create(np, "valkyrie", NULL);
@@ -551,8 +544,7 @@ static int __init pmac_declare_of_platform_devices(void)
 
 	return 0;
 }
-
-device_initcall(pmac_declare_of_platform_devices);
+machine_device_initcall(powermac, pmac_declare_of_platform_devices);
 
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
