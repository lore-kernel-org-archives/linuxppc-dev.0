Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23205DDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 09:14:20 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1HIBLL-0005Qg-T5
	for linuxppc-dev@ozlabs.org; Fri, 16 Feb 2007 16:14:17 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Remove obsolete setting of ROOT_DEV for 85xx and 86xx
	platforms.
Date: Fri, 16 Feb 2007 16:14:15 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HIBLL-0005Qg-T5@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Jon Loeliger <jdl@freescale.com>

---
 arch/powerpc/platforms/85xx/mpc8568_mds.c  |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |    7 -------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |    7 -------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7 -------
 4 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc8568_mds.c b/arch/powerpc/platforms/85xx/mpc8568_mds.c
index 0861d11..324138a 100644
--- a/arch/powerpc/platforms/85xx/mpc8568_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc8568_mds.c
@@ -27,7 +27,6 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/root_dev.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index c56fce5..741bcea 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -17,7 +17,6 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/root_dev.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -245,12 +244,6 @@ static void __init mpc85xx_ads_setup_arch(void)
 		add_bridge(np);
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
-
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
 }
 
 static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index abc0aca..bf6c604 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -22,7 +22,6 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/root_dev.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
@@ -263,12 +262,6 @@ static void __init mpc85xx_cds_setup_arch(void)
 	ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
-
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
 }
 
 static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index f4dd5f2..030f9b2 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -18,7 +18,6 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
-#include <linux/root_dev.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -365,12 +364,6 @@ mpc86xx_hpcn_setup_arch(void)
 
 	printk("MPC86xx HPCN board from Freescale Semiconductor\n");
 
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
-
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
 #endif
-- 
1.5.0.rc3.ge4b0e
