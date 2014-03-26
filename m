Return-Path: <qiang.zhao@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C1CD14009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 17:47:40 +1100 (EST)
Received: from mail47-tx2 (localhost [127.0.0.1])	by mail47-tx2-R.bigfish.com
 (Postfix) with ESMTP id 7196A120226	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 26 Mar 2014 06:47:35 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH] phy/at8031: enable at8031 to work on interrupt mode
Date: Wed, 26 Mar 2014 14:45:38 +0800
Message-ID: <1395816338-3090-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R63061@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The at8031 can work on polling mode and interrupt mode.
Add ack_interrupt and config intr funcs to enable
interrupt mode for it.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index bc71947..d034ef5 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -27,6 +27,9 @@
 #define AT803X_MMD_ACCESS_CONTROL		0x0D
 #define AT803X_MMD_ACCESS_CONTROL_DATA		0x0E
 #define AT803X_FUNC_DATA			0x4003
+#define AT803X_INER				0x0012
+#define AT803X_INER_INIT			0xec00
+#define AT803X_INSR				0x0013
 #define AT803X_DEBUG_ADDR			0x1D
 #define AT803X_DEBUG_DATA			0x1E
 #define AT803X_DEBUG_SYSTEM_MODE_CTRL		0x05
@@ -191,6 +194,31 @@ static int at803x_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int at803x_ack_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read(phydev, AT803X_INSR);
+
+	return (err < 0) ? err : 0;
+}
+
+static int at803x_config_intr(struct phy_device *phydev)
+{
+	int err;
+	int value;
+
+	value = phy_read(phydev, AT803X_INER);
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		err = phy_write(phydev, AT803X_INER,
+				(value | AT803X_INER_INIT));
+	else
+		err = phy_write(phydev, AT803X_INER, value);
+
+	return err;
+}
+
 static struct phy_driver at803x_driver[] = {
 {
 	/* ATHEROS 8035 */
@@ -240,6 +268,8 @@ static struct phy_driver at803x_driver[] = {
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_aneg	= genphy_config_aneg,
 	.read_status	= genphy_read_status,
+	.ack_interrupt  = &at803x_ack_interrupt,
+	.config_intr    = &at803x_config_intr,
 	.driver		= {
 		.owner = THIS_MODULE,
 	},
-- 
1.8.5
