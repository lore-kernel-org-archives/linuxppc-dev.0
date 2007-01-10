Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-248.msk.skylink.ru
	[83.217.45.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DFBDDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 12:25:22 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 3/5] [FS_ENET] OF-related update for FEC and SCC MAC's
Date: Wed, 10 Jan 2007 04:11:54 +0300
Message-ID: <20070110011154.20342.12189.stgit@localhost.localdomain>
In-Reply-To: <20070110011124.20342.38130.stgit@localhost.localdomain>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Updated direct resource pass with ioremap call, make it grant proper IRQ
mapping, stuff incompatible with the new approach were respectively put  under
#ifndef CONFIG_PPC_MERGE.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/net/fs_enet/mac-fec.c |   13 +++++++++----
 drivers/net/fs_enet/mac-scc.c |    6 ++++--
 drivers/net/phy/fixed.c       |    2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index c2c5fd4..474d6d7 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -104,9 +104,9 @@ static int do_pd_setup(struct fs_enet_private *fep)
 	fep->interrupt = platform_get_irq_byname(pdev,"interrupt");
 	if (fep->interrupt < 0)
 		return -EINVAL;
-	
+
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	fep->fec.fecp =(void*)r->start;
+	fep->fec.fecp = (void *)ioremap(r->start, r->end - r->start + 1);
 
 	if(fep->fec.fecp == NULL)
 		return -EINVAL;
@@ -319,11 +319,14 @@ static void restart(struct net_device *dev)
 	 * Clear any outstanding interrupt.
 	 */
 	FW(fecp, ievent, 0xffc0);
+#ifndef CONFIG_PPC_MERGE
 	FW(fecp, ivec, (fep->interrupt / 2) << 29);
-	
+#else
+	FW(fecp, ivec, (irq_map[fep->interrupt].hwirq / 2) << 29);
+#endif
 
 	/*
-	 * adjust to speed (only for DUET & RMII) 
+	 * adjust to speed (only for DUET & RMII)
 	 */
 #ifdef CONFIG_DUET
 	if (fpi->use_rmii) {
@@ -418,6 +421,7 @@ static void stop(struct net_device *dev)
 
 static void pre_request_irq(struct net_device *dev, int irq)
 {
+#ifndef CONFIG_PPC_MERGE
 	immap_t *immap = fs_enet_immap;
 	u32 siel;
 
@@ -431,6 +435,7 @@ static void pre_request_irq(struct net_device *dev, int irq)
 			siel &= ~(0x80000000 >> (irq & ~1));
 		out_be32(&immap->im_siu_conf.sc_siel, siel);
 	}
+#endif
 }
 
 static void post_free_irq(struct net_device *dev, int irq)
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 95ec587..62057f4 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -121,13 +121,13 @@ static int do_pd_setup(struct fs_enet_private *fep)
 		return -EINVAL;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	fep->scc.sccp = (void *)r->start;
+	fep->scc.sccp = (void *)ioremap(r->start, r->end - r->start + 1);
 
 	if (fep->scc.sccp == NULL)
 		return -EINVAL;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram");
-	fep->scc.ep = (void *)r->start;
+	fep->scc.ep = (void *)ioremap(r->start, r->end - r->start + 1);
 
 	if (fep->scc.ep == NULL)
 		return -EINVAL;
@@ -397,6 +397,7 @@ static void stop(struct net_device *dev)
 
 static void pre_request_irq(struct net_device *dev, int irq)
 {
+#ifndef CONFIG_PPC_MERGE
 	immap_t *immap = fs_enet_immap;
 	u32 siel;
 
@@ -410,6 +411,7 @@ static void pre_request_irq(struct net_device *dev, int irq)
 			siel &= ~(0x80000000 >> (irq & ~1));
 		out_be32(&immap->im_siu_conf.sc_siel, siel);
 	}
+#endif
 }
 
 static void post_free_irq(struct net_device *dev, int irq)
diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index 096d4a1..8613539 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -349,7 +349,7 @@ static int __init fixed_init(void)
 	fixed_mdio_register_device(0, 100, 1);
 #endif
 
-#ifdef CONFIX_FIXED_MII_10_FDX
+#ifdef CONFIG_FIXED_MII_10_FDX
 	fixed_mdio_register_device(0, 10, 1);
 #endif
 	return 0;
