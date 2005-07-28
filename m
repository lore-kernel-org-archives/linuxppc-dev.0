Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BD3167DCD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 07:57:01 +1000 (EST)
Date: Thu, 28 Jul 2005 06:13:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Message-ID: <20050728091306.GB6101@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 8xx: convert fec driver to use work_struct
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

8xx: convert fec driver to use work_struct

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@conectiva.com.br>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Index: 2.6-8xx/arch/ppc/8xx_io/fec.c
===================================================================
--- 2.6-8xx.orig/arch/ppc/8xx_io/fec.c	2005-07-04 11:40:54.000000000 -0300
+++ 2.6-8xx/arch/ppc/8xx_io/fec.c	2005-07-04 11:45:57.000000000 -0300
@@ -173,7 +173,7 @@
 	uint	phy_status;
 	uint	phy_speed;
 	phy_info_t	*phy;
-	struct tq_struct phy_task;
+	struct work_struct phy_task;
 
 	uint	sequence_done;
 
@@ -1263,8 +1263,9 @@
 	printk(".\n");
 }
 
-static void mii_display_config(struct net_device *dev)
+static void mii_display_config(void *priv)
 {
+	struct net_device *dev = (struct net_device *)priv;
 	struct fec_enet_private *fep = dev->priv;
 	volatile uint *s = &(fep->phy_status);
 
@@ -1294,8 +1295,9 @@
 	fep->sequence_done = 1;
 }
 
-static void mii_relink(struct net_device *dev)
+static void mii_relink(void *priv)
 {
+	struct net_device *dev = (struct net_device *)priv;
 	struct fec_enet_private *fep = dev->priv;
 	int duplex;
 
@@ -1323,18 +1325,16 @@
 {
 	struct fec_enet_private *fep = dev->priv;
 
-	fep->phy_task.routine = (void *)mii_relink;
-	fep->phy_task.data = dev;
-	schedule_task(&fep->phy_task);
+	INIT_WORK(&fep->phy_task, mii_relink, (void *)dev);
+	schedule_work(&fep->phy_task);
 }
 
 static void mii_queue_config(uint mii_reg, struct net_device *dev)
 {
 	struct fec_enet_private *fep = dev->priv;
 
-	fep->phy_task.routine = (void *)mii_display_config;
-	fep->phy_task.data = dev;
-	schedule_task(&fep->phy_task);
+	INIT_WORK(&fep->phy_task, mii_display_config, (void *)dev);
+	schedule_work(&fep->phy_task);
 }
 
 
