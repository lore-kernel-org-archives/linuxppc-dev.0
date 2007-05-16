Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B40B5DDF23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 May 2007 05:07:48 +1000 (EST)
Date: Wed, 16 May 2007 12:01:05 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: netdev@vger.kernel.org
Subject: [PATCH 3/3] ibm_emac: fix link speed detection change
Message-ID: <20070516190105.GC14704@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Roese <sr@denx.de>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix link speed detection change.
Thanks to Stefan Roese <sr@denx.de> for finding this bug.

CC: Stefan Roese <sr@denx.de>
Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

---
 drivers/net/ibm_emac/ibm_emac_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
index 50035eb..f752e5f 100644
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -926,7 +926,7 @@ static int emac_link_differs(struct ocp_enet_private *dev)
 	int duplex = r & EMAC_MR1_FDE ? DUPLEX_FULL : DUPLEX_HALF;
 	int speed, pause, asym_pause;
 
-	if (r & (EMAC_MR1_MF_1000 | EMAC_MR1_MF_1000GPCS))
+	if (r & EMAC_MR1_MF_1000)
 		speed = SPEED_1000;
 	else if (r & EMAC_MR1_MF_100)
 		speed = SPEED_100;
