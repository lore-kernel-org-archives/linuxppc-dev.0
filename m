Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id BF5FCDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 01:36:17 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so1638029rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 08:36:16 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] net: Fix ucc_geth.c handling of phy 'interface' property.
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
	Andy Fleming <afleming@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Date: Mon, 27 Apr 2009 09:36:13 -0600
Message-ID: <20090427153612.5108.10877.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Previous rework to ucc_geth.c to add of_mdio support (net: Rework
ucc_geth driver to use of_mdio infrastructure) added a block of
code which broke older openfirmware device trees which use an
'interface' property in the phy node to describe the connection
between the MAC and the PHY.  This patch removes the offending blurb.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/net/ucc_geth.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)


diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 195b490..d805d60 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3639,9 +3639,6 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	prop = of_get_property(np, "phy-connection-type", NULL);
 	if (!prop) {
 		/* handle interface property present in old trees */
-		if (!phy)
-			return -ENODEV;
-
 		prop = of_get_property(phy, "interface", NULL);
 		if (prop != NULL) {
 			phy_interface = enet_to_phy_interface[*prop];
