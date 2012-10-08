Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Eric Dumazet <edumazet@google.com>
Subject: net: fix typo in freescale/ucc_geth.c
In-reply-to: <20121008173653.1d17895964980c98af59c8ea@canb.auug.org.au>
References: <20121008173653.1d17895964980c98af59c8ea@canb.auug.org.au>
Date: Tue, 09 Oct 2012 10:52:25 +1100
Message-ID: <23452.1349740345@neuling.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
 linux-next@vger.kernel.org, Maxime Bizon <mbizon@freebox.fr>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch: 
  acb600d net: remove skb recycling
added dev_free_skb() to drivers/net/ethernet/freescale/ucc_geth.c

This is a typo and should be dev_kfree_skb().  This fixes this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
This hit as a compile error in next-20121008 with mpc85xx_defconfig.

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index dfa0aaa..0a70bb5 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3268,7 +3268,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 			if (netif_msg_rx_err(ugeth))
 				ugeth_err("%s, %d: ERROR!!! skb - 0x%08x",
 					   __func__, __LINE__, (u32) skb);
-			dev_free_skb(skb);
+			dev_kfree_skb(skb);
 
 			ugeth->rx_skbuff[rxQ][ugeth->skb_currx[rxQ]] = NULL;
 			dev->stats.rx_dropped++;
