Return-Path: <vbarshak@ru.mvista.com>
Received: from localhost.localdomain (unknown [93.100.123.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE37FB7BBB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 00:31:25 +1100 (EST)
Date: Mon, 5 Oct 2009 17:31:24 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: Olof Johansson <olof@lixom.net>
Subject: [PATCH] pasemi_mac: ethtool set settings support
Message-ID: <20091005133124.GA11717@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AC9ED9B.5040400@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add ethtool set settings to pasemi_mac_ethtool.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/net/pasemi_mac_ethtool.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff -pruN linux-2.6.orig/drivers/net/pasemi_mac_ethtool.c linux-2.6/drivers/net/pasemi_mac_ethtool.c
--- linux-2.6.orig/drivers/net/pasemi_mac_ethtool.c	2009-10-05 16:24:14.000000000 +0400
+++ linux-2.6./drivers/net/pasemi_mac_ethtool.c	2009-10-05 16:27:08.000000000 +0400
@@ -77,6 +77,19 @@ pasemi_mac_ethtool_get_settings(struct n
 	return phy_ethtool_gset(phydev, cmd);
 }
 
+static int
+pasemi_mac_ethtool_set_settings(struct net_device *netdev,
+			       struct ethtool_cmd *cmd)
+{
+	struct pasemi_mac *mac = netdev_priv(netdev);
+	struct phy_device *phydev = mac->phydev;
+
+	if (!phydev)
+		return -EOPNOTSUPP;
+
+	return phy_ethtool_sset(phydev, cmd);
+}
+
 static void
 pasemi_mac_ethtool_get_drvinfo(struct net_device *netdev,
 			       struct ethtool_drvinfo *drvinfo)
@@ -150,6 +163,7 @@ static void pasemi_mac_get_strings(struc
 
 const struct ethtool_ops pasemi_mac_ethtool_ops = {
 	.get_settings		= pasemi_mac_ethtool_get_settings,
+	.set_settings		= pasemi_mac_ethtool_set_settings,
 	.get_drvinfo		= pasemi_mac_ethtool_get_drvinfo,
 	.get_msglevel		= pasemi_mac_ethtool_get_msglevel,
 	.set_msglevel		= pasemi_mac_ethtool_set_msglevel,
