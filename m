Return-Path: <olof@lixom.net>
Message-Id: <20080221025930.273755000@lixom.net>
References: <20080221025753.903665000@lixom.net>
Date: Wed, 20 Feb 2008 20:57:58 -0600
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [patch 5/6] pasemi_mac: Enable GSO by default
Cc: netdev@vger.kernel.org, pasemi-linux@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ethtool support will handle the runtime toggling, but we do quite a bit
better with it on by default so just leave it on for now.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: k.org/drivers/net/pasemi_mac.c
===================================================================
--- k.org.orig/drivers/net/pasemi_mac.c
+++ k.org/drivers/net/pasemi_mac.c
@@ -1750,7 +1750,7 @@ pasemi_mac_probe(struct pci_dev *pdev, c
 	netif_napi_add(dev, &mac->napi, pasemi_mac_poll, 64);
 
 	dev->features = NETIF_F_IP_CSUM | NETIF_F_LLTX | NETIF_F_SG |
-			NETIF_F_HIGHDMA;
+			NETIF_F_HIGHDMA | NETIF_F_GSO;
 
 	mac->lro_mgr.max_aggr = LRO_MAX_AGGR;
 	mac->lro_mgr.max_desc = MAX_LRO_DESCRIPTORS;

-- 
