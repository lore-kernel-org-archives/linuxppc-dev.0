Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3DFC568635
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Oct 2005 06:47:46 +1100 (EST)
Date: Sat, 29 Oct 2005 12:47:41 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Garzik <jgarzik@pobox.com>
Message-ID: <20051029194741.GD1865@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/3] PPC 4xx EMAC driver: fix VSC8201 PHY initialization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

* MII registers must override strap pins
* disable "echo" mode to make 10/HDX work (Franz Sirl)

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 drivers/net/ibm_emac/ibm_emac_phy.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_emac/ibm_emac_phy.c b/drivers/net/ibm_emac/ibm_emac_phy.c
index a27e49c..67935dd 100644
--- a/drivers/net/ibm_emac/ibm_emac_phy.c
+++ b/drivers/net/ibm_emac/ibm_emac_phy.c
@@ -236,12 +236,16 @@ static struct mii_phy_def genmii_phy_def
 };
 
 /* CIS8201 */
+#define MII_CIS8201_10BTCSR	0x16
+#define  TENBTCSR_ECHO_DISABLE	0x2000
 #define MII_CIS8201_EPCR	0x17
 #define  EPCR_MODE_MASK		0x3000
 #define  EPCR_GMII_MODE		0x0000
 #define  EPCR_RGMII_MODE	0x1000
 #define  EPCR_TBI_MODE		0x2000
 #define  EPCR_RTBI_MODE		0x3000
+#define MII_CIS8201_ACSR	0x1c
+#define  ACSR_PIN_PRIO_SELECT	0x0004
 
 static int cis8201_init(struct mii_phy *phy)
 {
@@ -269,6 +273,14 @@ static int cis8201_init(struct mii_phy *
 	}
 
 	phy_write(phy, MII_CIS8201_EPCR, epcr);
+	
+	/* MII regs override strap pins */
+	phy_write(phy, MII_CIS8201_ACSR, 
+		  phy_read(phy, MII_CIS8201_ACSR) | ACSR_PIN_PRIO_SELECT);
+
+	/* Disable TX_EN -> CRS echo mode, otherwise 10/HDX doesn't work */
+	phy_write(phy, MII_CIS8201_10BTCSR,
+		  phy_read(phy, MII_CIS8201_10BTCSR) | TENBTCSR_ECHO_DISABLE);
 
 	return 0;
 }
