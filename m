Return-Path: <B06378@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EDC4AB6F9A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 19:17:21 +1000 (EST)
From: Jiajun Wu <b06378@freescale.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: [PATCH] gianfar:don't add FCB length to hard_header_len
Date: Tue, 22 May 2012 17:00:48 +0800
Message-ID: <1337677248-27792-1-git-send-email-b06378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jiajun Wu <b06378@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FCB(Frame Control Block) isn't the part of netdev hard header.
Add FCB to hard_header_len will make GRO fail at MAC comparision stage.

Signed-off-by: Jiajun Wu <b06378@freescale.com>
---
 drivers/net/ethernet/freescale/gianfar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 1adb024..0741ade 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -1082,7 +1082,7 @@ static int gfar_probe(struct platform_device *ofdev)
 
 	if (dev->features & NETIF_F_IP_CSUM ||
 			priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER)
-		dev->hard_header_len += GMAC_FCB_LEN;
+		dev->needed_headroom = GMAC_FCB_LEN;
 
 	/* Program the isrg regs only if number of grps > 1 */
 	if (priv->num_grps > 1) {
-- 
1.5.6.5
