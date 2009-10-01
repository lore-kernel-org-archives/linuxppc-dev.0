Return-Path: <vbarshak@ru.mvista.com>
Received: from localhost.localdomain (unknown [93.100.123.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3938B7BDC
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2009 09:30:37 +1000 (EST)
Date: Fri, 2 Oct 2009 02:27:48 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] pasemi_mac: ethtool get settings fix
Message-ID: <20091001222748.GA21276@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not all pasemi mac interfaces can have a phy attached.
For example, XAUI has no phy and phydev is NULL for it.
In this case ethtool get settings causes kernel crash.
Fix it by returning -EOPNOTSUPP if there's no PHY attached.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/net/pasemi_mac_ethtool.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.21.orig/drivers/net/pasemi_mac_ethtool.c	2008-11-06 18:10:38.000000000 +0300
+++ linux-2.6.21/drivers/net/pasemi_mac_ethtool.c	2008-11-19 19:24:28.000000000 +0300
@@ -71,6 +71,8 @@ pasemi_mac_ethtool_get_settings(struct n
 	struct pasemi_mac *mac = netdev_priv(netdev);
 	struct phy_device *phydev = mac->phydev;
 
+	if (!phydev)
+		return -EOPNOTSUPP;
 	return phy_ethtool_gset(phydev, cmd);
 }
 
