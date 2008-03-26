Return-Path: <olof@lixom.net>
Date: Tue, 25 Mar 2008 20:57:10 -0500
From: Olof Johansson <olof@lixom.net>
To: jgarzik@pobox.com
Subject: [PATCH 1/2] pasemi_mac: Jumbo frame bugfixes
Message-ID: <20080326015710.GB23103@lixom.net>
References: <20080326015625.GA23103@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080326015625.GA23103@lixom.net>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a couple of corner cases around interface up/down when jumbo frames are
configured. Resources weren't always freed and reallocated properly.
    
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index c50f0f4..abb1dc4 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -404,6 +404,7 @@ static void pasemi_mac_free_csring(struct pasemi_mac_csring *csring)
 	pasemi_dma_free_flag(csring->events[1]);
 	pasemi_dma_free_ring(&csring->chan);
 	pasemi_dma_free_chan(&csring->chan);
+	pasemi_dma_free_fun(csring->fun);
 }
 
 static int pasemi_mac_setup_rx_resources(const struct net_device *dev)
@@ -1150,7 +1151,10 @@ static int pasemi_mac_open(struct net_device *dev)
 	if (!mac->tx)
 		goto out_tx_ring;
 
-	if (dev->mtu > 1500) {
+	/* We might already have allocated rings in case mtu was changed
+	 * before interface was brought up.
+	 */
+	if (dev->mtu > 1500 && !mac->num_cs) {
 		pasemi_mac_setup_csrings(mac);
 		if (!mac->num_cs)
 			goto out_tx_ring;
@@ -1388,8 +1392,12 @@ static int pasemi_mac_close(struct net_device *dev)
 	free_irq(mac->tx->chan.irq, mac->tx);
 	free_irq(mac->rx->chan.irq, mac->rx);
 
-	for (i = 0; i < mac->num_cs; i++)
+	for (i = 0; i < mac->num_cs; i++) {
 		pasemi_mac_free_csring(mac->cs[i]);
+		mac->cs[i] = NULL;
+	}
+
+	mac->num_cs = 0;
 
 	/* Free resources */
 	pasemi_mac_free_rx_resources(mac);
