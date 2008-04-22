Return-Path: <benh@ozlabs.org>
To: <jgarzik@pobox.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 22 Apr 2008 10:46:42 +1000
Subject: [PATCH 2/6] ibm_newemac: Add support for 460EX/GT-type MAL rx-channel
	handling
Message-Id: <20080422004758.DB022DE1C0@ozlabs.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stefan Roese <sr@denx.de>

On some 4xx PPC's (e.g. 460EX/GT), the rx channel number is a multiple
of 8 (e.g. 8 for EMAC1, 16 for EMAC2), but enabling in MAL_RXCASR needs
the divided by 8 value for the bitmask.

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 drivers/net/ibm_newemac/mal.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ibm_newemac/mal.c b/drivers/net/ibm_newemac/mal.c
index 6869f08..fb9c9eb 100644
--- a/drivers/net/ibm_newemac/mal.c
+++ b/drivers/net/ibm_newemac/mal.c
@@ -136,6 +136,14 @@ void mal_enable_rx_channel(struct mal_instance *mal, int channel)
 {
 	unsigned long flags;
 
+	/*
+	 * On some 4xx PPC's (e.g. 460EX/GT), the rx channel is a multiple
+	 * of 8, but enabling in MAL_RXCASR needs the divided by 8 value
+	 * for the bitmask
+	 */
+	if (!(channel % 8))
+		channel >>= 3;
+
 	spin_lock_irqsave(&mal->lock, flags);
 
 	MAL_DBG(mal, "enable_rx(%d)" NL, channel);
@@ -148,6 +156,14 @@ void mal_enable_rx_channel(struct mal_instance *mal, int channel)
 
 void mal_disable_rx_channel(struct mal_instance *mal, int channel)
 {
+	/*
+	 * On some 4xx PPC's (e.g. 460EX/GT), the rx channel is a multiple
+	 * of 8, but enabling in MAL_RXCASR needs the divided by 8 value
+	 * for the bitmask
+	 */
+	if (!(channel % 8))
+		channel >>= 3;
+
 	set_mal_dcrn(mal, MAL_RXCARR, MAL_CHAN_MASK(channel));
 
 	MAL_DBG(mal, "disable_rx(%d)" NL, channel);
