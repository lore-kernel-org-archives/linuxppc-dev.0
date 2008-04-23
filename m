Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 23 Apr 2008 15:17:14 +1000
Subject: [PATCH] ibm_newemac: Increase MDIO timeouts
Message-Id: <20080423051832.63BF7DDF65@ozlabs.org>
Cc: super.firetwister@googlemail.com, netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch doubles the MDIO timeouts in EMAC as there are field
cases where they are two short to communicate with some PHYs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/net/ibm_newemac/core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-work.orig/drivers/net/ibm_newemac/core.c	2008-04-23 15:11:16.000000000 +1000
+++ linux-work/drivers/net/ibm_newemac/core.c	2008-04-23 15:14:20.000000000 +1000
@@ -738,7 +738,7 @@ static int __emac_mdio_read(struct emac_
 		rgmii_get_mdio(dev->rgmii_dev, dev->rgmii_port);
 
 	/* Wait for management interface to become idle */
-	n = 10;
+	n = 20;
 	while (!emac_phy_done(dev, in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n) {
@@ -763,7 +763,7 @@ static int __emac_mdio_read(struct emac_
 	out_be32(&p->stacr, r);
 
 	/* Wait for read to complete */
-	n = 100;
+	n = 200;
 	while (!emac_phy_done(dev, (r = in_be32(&p->stacr)))) {
 		udelay(1);
 		if (!--n) {
@@ -810,7 +810,7 @@ static void __emac_mdio_write(struct ema
 		rgmii_get_mdio(dev->rgmii_dev, dev->rgmii_port);
 
 	/* Wait for management interface to be idle */
-	n = 10;
+	n = 20;
 	while (!emac_phy_done(dev, in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n) {
@@ -836,7 +836,7 @@ static void __emac_mdio_write(struct ema
 	out_be32(&p->stacr, r);
 
 	/* Wait for write to complete */
-	n = 100;
+	n = 200;
 	while (!emac_phy_done(dev, in_be32(&p->stacr))) {
 		udelay(1);
 		if (!--n) {
