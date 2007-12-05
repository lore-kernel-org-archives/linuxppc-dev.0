Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 05 Dec 2007 11:14:27 +1100
Subject: [PATCH 3/11] ibm_newemac: Fix ZMII refcounting bug
Message-Id: <20071205001536.59F81DDF62@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When using ZMII for MDIO only (such as 440GX with RGMII for data and ZMII for
MDIO), the ZMII code would fail to properly refcount, thus triggering a
BUG_ON().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Stefan Roese <sr@denx.de>
---

 drivers/net/ibm_newemac/zmii.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-work/drivers/net/ibm_newemac/zmii.c
===================================================================
--- linux-work.orig/drivers/net/ibm_newemac/zmii.c	2007-11-08 15:45:32.000000000 +1100
+++ linux-work/drivers/net/ibm_newemac/zmii.c	2007-11-08 15:46:21.000000000 +1100
@@ -83,12 +83,14 @@ int __devinit zmii_attach(struct of_devi
 
 	ZMII_DBG(dev, "init(%d, %d)" NL, input, *mode);
 
-	if (!zmii_valid_mode(*mode))
+	if (!zmii_valid_mode(*mode)) {
 		/* Probably an EMAC connected to RGMII,
 		 * but it still may need ZMII for MDIO so
 		 * we don't fail here.
 		 */
+		dev->users++;
 		return 0;
+	}
 
 	mutex_lock(&dev->lock);
 
