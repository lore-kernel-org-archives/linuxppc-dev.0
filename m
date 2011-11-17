Return-Path: <wg@grandegger.com>
Message-ID: <4EC506E4.5060806@grandegger.com>
Date: Thu, 17 Nov 2011 14:06:44 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Netdev@vger.kernel.org
Subject: [PATCH net-next] ibm/emac: fix improper cleanup when device is removed
 to allow re-bind
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The re-binding (unbind..bind) of an EMAC device fails because the
static variable "busy_phy_map" is not updated when the device is
removed.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 drivers/net/ethernet/ibm/emac/core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index ed79b2d..2abce96 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2924,6 +2924,9 @@ static int __devexit emac_remove(struct platform_device *ofdev)
 	if (emac_has_feature(dev, EMAC_FTR_HAS_ZMII))
 		zmii_detach(dev->zmii_dev, dev->zmii_port);
 
+	busy_phy_map &= ~(1 << dev->phy.address);
+	DBG(dev, "busy_phy_map now %#x" NL, busy_phy_map);
+
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
 
-- 
1.7.4.1
