Return-Path: <vooon341@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04A7EB70FC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 10:46:21 +1100 (EST)
Received: by bwz10 with SMTP id 10so1883161bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 16:46:17 -0700 (PDT)
Subject: [PATCH 3/4] fs_enet: Add initial support for TWR-MPC5125
From: Vladimir Ermakov <vooon341@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 02:37:23 +0300
Message-ID: <1300318643.12970.73.camel@desinto>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PHY interface selection.
    
On TWR-MPC5125 PHY2 connected through RMII.

Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
---

diff --git a/drivers/net/fs_enet/Kconfig b/drivers/net/fs_enet/Kconfig
index fc073b5..132966b 100644
--- a/drivers/net/fs_enet/Kconfig
+++ b/drivers/net/fs_enet/Kconfig
@@ -32,3 +32,16 @@ config FS_ENET_MDIO_FCC
 	tristate "MDIO driver for FCC"
 	depends on FS_ENET && CPM2
 	select MDIO_BITBANG
+
+choice FS_ENET_RCNTRL
+	prompt "PHY connection interface"
+	default FS_ENET_MII
+	depends on FS_ENET_MPC5121_FEC
+
+config FS_ENET_RCNTRL_MII
+	bool "MII"
+
+config FS_ENET_RCNTRL_RMII
+	bool "RMII"
+
+endchoice
diff --git a/drivers/net/fs_enet/fec.h b/drivers/net/fs_enet/fec.h
index e980527..468be6e 100644
--- a/drivers/net/fs_enet/fec.h
+++ b/drivers/net/fs_enet/fec.h
@@ -26,6 +26,7 @@
 #define FEC_RCNTRL_BC_REJ	0x00000010
 #define FEC_RCNTRL_PROM		0x00000008
 #define FEC_RCNTRL_MII_MODE	0x00000004
+#define FEC_RCNTRL_RMII_MODE	0x00000124
 #define FEC_RCNTRL_DRT		0x00000002
 #define FEC_RCNTRL_LOOP		0x00000001
 
@@ -33,6 +34,11 @@
 #define FEC_TCNTRL_HBC		0x00000002
 #define FEC_TCNTRL_GTS		0x00000001
 
+#ifdef CONFIG_FS_ENET_RCNTRL_MII
+#define FEC_RCNTRL_PHY_MODE FEC_RCNTRL_MII_MODE
+#else /* CONFIG_FS_ENET_RCNTRL_RMII */
+#define FEC_RCNTRL_PHY_MODE FEC_RCNTRL_RMII_MODE
+#endif
 
 
 /*
diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 61035fc..d43e56d 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -319,13 +319,13 @@ static void restart(struct net_device *dev)
 #ifndef CONFIG_FS_ENET_MPC5121_FEC
 	FW(fecp, ivec, (virq_to_hw(fep->interrupt) / 2) << 29);
 
-	FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+	FW(fecp, r_cntrl, FEC_RCNTRL_PHY_MODE);	/* MII/RMII enable */
 #else
 	/*
-	 * Only set MII mode - do not touch maximum frame length
+	 * Only set MII/RMII mode - do not touch maximum frame length
 	 * configured before.
 	 */
-	FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);
+	FS(fecp, r_cntrl, FEC_RCNTRL_PHY_MODE);
 #endif
 	/*
 	 * adjust to duplex mode
@@ -381,7 +381,7 @@ static void stop(struct net_device *dev)
 
 	/* shut down FEC1? that's where the mii bus is */
 	if (fpi->has_phy) {
-		FS(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
+		FS(fecp, r_cntrl, FEC_RCNTRL_PHY_MODE);	/* MII/RMII enable */
 		FS(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
 		FW(fecp, ievent, FEC_ENET_MII);
 		FW(fecp, mii_speed, feci->mii_speed);
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index 7e840d3..bb61ff6 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -161,7 +161,7 @@ static int __devinit fs_enet_mdio_probe(struct platform_device *ofdev)
 
 	fec->mii_speed = speed << 1;
 
-	setbits32(&fec->fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
+	setbits32(&fec->fecp->fec_r_cntrl, FEC_RCNTRL_PHY_MODE);
 	setbits32(&fec->fecp->fec_ecntrl, FEC_ECNTRL_PINMUX |
 	                                  FEC_ECNTRL_ETHER_EN);
 	out_be32(&fec->fecp->fec_ievent, FEC_ENET_MII);
