Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 73DE2DDF33
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:49 +1000 (EST)
Message-Id: <20070705170236.976353000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:46 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 13/35] Cleanup marvell phy driver init
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simplify the marvell driver init a bit: Make the supported devices an
array instead of explicitly registering each structure. This makes it
considerably easier to add new devices down the road.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: mainline/drivers/net/phy/marvell.c
===================================================================
--- mainline.orig/drivers/net/phy/marvell.c
+++ mainline/drivers/net/phy/marvell.c
@@ -238,77 +238,71 @@ static int m88e1145_config_init(struct p
 	return 0;
 }
 
-static struct phy_driver m88e1101_driver = {
-	.phy_id = 0x01410c60,
-	.phy_id_mask = 0xfffffff0,
-	.name = "Marvell 88E1101",
-	.features = PHY_GBIT_FEATURES,
-	.flags = PHY_HAS_INTERRUPT,
-	.config_aneg = &marvell_config_aneg,
-	.read_status = &genphy_read_status,
-	.ack_interrupt = &marvell_ack_interrupt,
-	.config_intr = &marvell_config_intr,
-	.driver = {.owner = THIS_MODULE,},
-};
-
-static struct phy_driver m88e1111_driver = {
-	.phy_id = 0x01410cc0,
-	.phy_id_mask = 0xfffffff0,
-	.name = "Marvell 88E1111",
-	.features = PHY_GBIT_FEATURES,
-	.flags = PHY_HAS_INTERRUPT,
-	.config_aneg = &marvell_config_aneg,
-	.read_status = &genphy_read_status,
-	.ack_interrupt = &marvell_ack_interrupt,
-	.config_intr = &marvell_config_intr,
-	.config_init = &m88e1111_config_init,
-	.driver = {.owner = THIS_MODULE,},
-};
-
-static struct phy_driver m88e1145_driver = {
-	.phy_id = 0x01410cd0,
-	.phy_id_mask = 0xfffffff0,
-	.name = "Marvell 88E1145",
-	.features = PHY_GBIT_FEATURES,
-	.flags = PHY_HAS_INTERRUPT,
-	.config_init = &m88e1145_config_init,
-	.config_aneg = &marvell_config_aneg,
-	.read_status = &genphy_read_status,
-	.ack_interrupt = &marvell_ack_interrupt,
-	.config_intr = &marvell_config_intr,
-	.driver = {.owner = THIS_MODULE,},
+static struct phy_driver marvell_drivers[] = {
+	{
+		.phy_id = 0x01410c60,
+		.phy_id_mask = 0xfffffff0,
+		.name = "Marvell 88E1101",
+		.features = PHY_GBIT_FEATURES,
+		.flags = PHY_HAS_INTERRUPT,
+		.config_aneg = &marvell_config_aneg,
+		.read_status = &genphy_read_status,
+		.ack_interrupt = &marvell_ack_interrupt,
+		.config_intr = &marvell_config_intr,
+		.driver = {.owner = THIS_MODULE,},
+	},
+	{
+		.phy_id = 0x01410cc0,
+		.phy_id_mask = 0xfffffff0,
+		.name = "Marvell 88E1111",
+		.features = PHY_GBIT_FEATURES,
+		.flags = PHY_HAS_INTERRUPT,
+		.config_init = &m88e1111_config_init,
+		.config_aneg = &marvell_config_aneg,
+		.read_status = &genphy_read_status,
+		.ack_interrupt = &marvell_ack_interrupt,
+		.config_intr = &marvell_config_intr,
+		.driver = {.owner = THIS_MODULE,},
+	},
+	{
+		.phy_id = 0x01410cd0,
+		.phy_id_mask = 0xfffffff0,
+		.name = "Marvell 88E1145",
+		.features = PHY_GBIT_FEATURES,
+		.flags = PHY_HAS_INTERRUPT,
+		.config_init = &m88e1145_config_init,
+		.config_aneg = &marvell_config_aneg,
+		.read_status = &genphy_read_status,
+		.ack_interrupt = &marvell_ack_interrupt,
+		.config_intr = &marvell_config_intr,
+		.driver = {.owner = THIS_MODULE,},
+	}
 };
 
 static int __init marvell_init(void)
 {
 	int ret;
+	int i;
 
-	ret = phy_driver_register(&m88e1101_driver);
-	if (ret)
-		return ret;
-
-	ret = phy_driver_register(&m88e1111_driver);
-	if (ret)
-		goto err1111;
-
-	ret = phy_driver_register(&m88e1145_driver);
-	if (ret)
-		goto err1145;
+	for (i = 0; i < ARRAY_SIZE(marvell_drivers); i++) {
+		ret = phy_driver_register(&marvell_drivers[i]);
 
-	return 0;
+		if (ret) {
+			while (i-- > 0)
+				phy_driver_unregister(&marvell_drivers[i]);
+			return ret;
+		}
+	}
 
-err1145:
-	phy_driver_unregister(&m88e1111_driver);
-err1111:
-	phy_driver_unregister(&m88e1101_driver);
-	return ret;
+	return 0;
 }
 
 static void __exit marvell_exit(void)
 {
-	phy_driver_unregister(&m88e1101_driver);
-	phy_driver_unregister(&m88e1111_driver);
-	phy_driver_unregister(&m88e1145_driver);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(marvell_drivers); i++)
+		phy_driver_unregister(&marvell_drivers[i]);
 }
 
 module_init(marvell_init);

--
