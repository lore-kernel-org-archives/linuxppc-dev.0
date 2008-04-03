Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 3E826DE018
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 22:45:30 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] ibm_newemac: Add support for 460EX/GT-type MAL rx-channel
	handling
Date: Thu,  3 Apr 2008 13:45:10 +0200
Message-Id: <1207223110-27281-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On some 4xx PPC's (e.g. 460EX/GT), the rx channel number is a multiple
of 8 (e.g. 8 for EMAC1, 16 for EMAC2), but enabling in MAL_RXCASR needs
the divided by 8 value for the bitmask.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/mal.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

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
-- 
1.5.4.5
