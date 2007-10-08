Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 2F182DDFA3
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 01:12:59 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPL00KE6M9KT810@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 09:12:56 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPL008KTM9KPW30@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 09:12:57 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPL00563M9JCCS2@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 09:12:55 -0600 (MDT)
Date: Mon, 08 Oct 2007 09:12:54 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Eval boards should not need to mess with ROOT_DEV
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Message-id: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

I can't see a good reason for eval board platform code to mess with the
ROOT_DEV value instead of using the default behaviour (so I'm writing
this patch to see if anyone will clue me in).

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/efika.c          |    9 ---------
 arch/powerpc/platforms/52xx/lite5200.c       |   12 ------------
 arch/powerpc/platforms/82xx/mpc82xx_ads.c    |    6 ------
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 --
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    2 --
 arch/powerpc/platforms/chrp/setup.c          |   10 ----------
 6 files changed, 0 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 4263158..0b1e60a 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -197,15 +197,6 @@ static void __init efika_setup_arch(void)
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
index e11d27f..48fc662 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -136,18 +136,6 @@ static void __init lite5200_setup_arch(void)
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
 
 static void lite5200_show_cpuinfo(struct seq_file *m)
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index 4008795..a1af287 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -575,12 +575,6 @@ static void __init mpc82xx_ads_setup_arch(void)
 	of_node_put(np);
 #endif
 
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc82xx_ads_setup_arch(), finish", 0);
 }
diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index 8f64f48..c712ce0 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -256,8 +256,6 @@ static void __init mpc86xads_setup_arch(void)
 	cpm_reset();
 
 	mpc86xads_board_setup();
-
-	ROOT_DEV = Root_NFS;
 }
 
 static int __init mpc86xads_probe(void)
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index a1dab4c..4c67cf6 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -408,8 +408,6 @@ static void __init mpc885ads_setup_arch(void)
 	cpm_reset();
 
 	mpc885ads_board_setup();
-
-	ROOT_DEV = Root_NFS;
 }
 
 static int __init mpc885ads_probe(void)
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
 
