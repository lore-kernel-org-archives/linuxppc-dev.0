Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 66E07DE01D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:50:07 +1000 (EST)
Received: from pd3mr1so.prod.shaw.ca
	(pd3mr1so-qfe3.prod.shaw.ca [10.0.141.177]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPP00M0CLKQ9N10@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:48:26 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd3mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP00FILLKOXVB0@pd3mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 12:48:26 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP00265LKNRZX0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:48:24 -0600 (MDT)
Date: Wed, 10 Oct 2007 12:48:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] Platforms shouldn't mess with ROOT_DEV
In-reply-to: <20071010184542.13609.70984.stgit@trillian.cg.shawcable.net>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	arnd@arndb.de, linas@austin.ibm.com, benh@kernel.crashing.org,
	geoffrey.levand@am.sony.com
Message-id: <20071010184828.13609.76505.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071010184542.13609.70984.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

There is no good reason for board platform code to mess with the ROOT_DEV.
Remove it from all in-tree platforms except powermac

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/efika.c    |    9 ---------
 arch/powerpc/platforms/52xx/lite5200.c |   12 ------------
 arch/powerpc/platforms/cell/setup.c    |    5 -----
 arch/powerpc/platforms/celleb/setup.c  |    5 -----
 arch/powerpc/platforms/chrp/setup.c    |   10 ----------
 arch/powerpc/platforms/pseries/setup.c |    5 -----
 6 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 6fc17fa..a0da70c 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -180,15 +180,6 @@ static void __init efika_setup_arch(void)
 {
 	rtas_initialize();
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	initrd_below_start_ok = 1;
-
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-		ROOT_DEV = Root_SDA2;	/* sda2 (sda1 is for the kernel) */
-
 	efika_pcisetup();
 
 #ifdef CONFIG_PM
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 0caa3d9..a0b4934 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -156,18 +156,6 @@ static void __init lite5200_setup_arch(void)
 		of_node_put(np);
 	}
 #endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-#ifdef  CONFIG_ROOT_NFS
-		ROOT_DEV = Root_NFS;
-#else
-		ROOT_DEV = Root_HDA1;
-#endif
-
 }
 
 /*
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index db66542..3d679b1 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -161,11 +161,6 @@ static void __init cell_setup_arch(void)
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;
 
-	if (ROOT_DEV == 0) {
-		printk("No ramdisk, default root is /dev/hda2\n");
-		ROOT_DEV = Root_HDA2;
-	}
-
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
 	find_and_init_phbs();
diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
index 0f1dddb..1769d75 100644
--- a/arch/powerpc/platforms/celleb/setup.c
+++ b/arch/powerpc/platforms/celleb/setup.c
@@ -101,11 +101,6 @@ static void __init celleb_setup_arch(void)
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;
 
-	if (ROOT_DEV == 0) {
-		printk("No ramdisk, default root is /dev/hda2\n");
-		ROOT_DEV = Root_HDA2;
-	}
-
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 96498ad..5930626 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -290,16 +290,6 @@ void __init chrp_setup_arch(void)
 		ppc_md.set_rtc_time	= rtas_set_rtc_time;
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	/* this is fine for chrp */
-	initrd_below_start_ok = 1;
-
-	if (initrd_start)
-		ROOT_DEV = Root_RAM0;
-	else
-#endif
-		ROOT_DEV = Root_SDA2; /* sda2 (sda1 is for the kernel) */
-
 	/* On pegasos, enable the L2 cache if not already done by OF */
 	pegasos_set_l2cr();
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f0b7146..fdb9b1c 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -257,11 +257,6 @@ static void __init pSeries_setup_arch(void)
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000;
 
-	if (ROOT_DEV == 0) {
-		printk("No ramdisk, default root is /dev/sda2\n");
-		ROOT_DEV = Root_SDA2;
-	}
-
 	fwnmi_init();
 
 	/* Find and initialize PCI host bridges */
