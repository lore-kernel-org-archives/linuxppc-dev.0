Return-Path: <pegasos@frokaschwei.de>
Received: from frokaschwei.de (frokaschwei.de [213.203.244.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12FEA681BD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 08:16:29 +1100 (EST)
From: Wolfram Joost <pegasos@frokaschwei.de>
To: "Dale Farnsworth" <dale@farnsworth.org>,
 linuxppc-dev@ozlabs.org
Date: Thu, 12 Jan 2006 22:16:18 +0100
References: <20060112190900.23594.qmail@farnsworth.org>
In-Reply-To: <20060112190900.23594.qmail@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601122216.18481@mail.frokaschwei.de>
Subject: Re: mv643xx_eth.c: Multicast and IPv6 support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

> > currently, the driver mv643xx_eth.c doesn't support receiving of

> Thanks.  On December 28th, I posted a patch to netdev@vger.kernel.org that
> adds multicast support to the mv643xx driver.  I'll ping jgarzik
> about it.

Oh, didn't find that patch yesterday.

> The IPv6 changes look good.  Would you please re-submit these without
> the multicast changes and with a Signed-off-by line?

Here it comes. However, IPv6 uses multicasting for address resolution
(replacement for ARP), so IPv6 doesn't work until the multicast patch is applied, too.

Wolfram.

---
This patch removes the NETIF_F_HW_CSUM flag to be able to use other protocols
than IPv4. Hardware checksums for IPv4 should continue to work.
The sanity-check has been enhanced to check the used protocol and to not
access skb->iph for non-ipv4-packets.

Signed-off-by: Wolfram Joost <pegasos@frokaschwei.de>
---
diff -up linux-2.6.15/drivers/net/mv643xx_eth.c linux-2.6.15.patched/drivers/net/mv643xx_eth.c
--- linux-2.6.15/drivers/net/mv643xx_eth.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.patched/drivers/net/mv643xx_eth.c	2006-01-12 21:52:32.000000000 +0100
@@ -1151,25 +1151,28 @@ linear:
 			pkt_info.l4i_chk = 0;
 		} else {
 
-			pkt_info.cmd_sts = ETH_TX_ENABLE_INTERRUPT |
-					   ETH_TX_FIRST_DESC |
-					   ETH_TX_LAST_DESC |
-					   ETH_GEN_TCP_UDP_CHECKSUM |
-					   ETH_GEN_IP_V_4_CHECKSUM |
-					   skb->nh.iph->ihl << ETH_TX_IHL_SHIFT;
 			/* CPU already calculated pseudo header checksum. */
-			if (skb->nh.iph->protocol == IPPROTO_UDP) {
-				pkt_info.cmd_sts |= ETH_UDP_FRAME;
+			if ( (skb->protocol == ETH_P_IP) &&
+			     (skb->nh.iph->protocol == IPPROTO_UDP) ) {
+				pkt_info.cmd_sts = ETH_UDP_FRAME;
 				pkt_info.l4i_chk = skb->h.uh->check;
-			} else if (skb->nh.iph->protocol == IPPROTO_TCP)
+			} else if ( (skb->protocol == ETH_P_IP) &&
+				    (skb->nh.iph->protocol == IPPROTO_TCP) ) {
+				pkt_info.cmd_sts = 0;
 				pkt_info.l4i_chk = skb->h.th->check;
-			else {
+			} else {
 				printk(KERN_ERR
-					"%s: chksum proto != TCP or UDP\n",
+					"%s: chksum proto != IPv4 TCP or UDP\n",
 					dev->name);
 				spin_unlock_irqrestore(&mp->lock, flags);
 				return 1;
 			}
+			pkt_info.cmd_sts |= ETH_TX_ENABLE_INTERRUPT |
+					    ETH_TX_FIRST_DESC |
+					    ETH_TX_LAST_DESC |
+					    ETH_GEN_TCP_UDP_CHECKSUM |
+					    ETH_GEN_IP_V_4_CHECKSUM |
+					    skb->nh.iph->ihl << ETH_TX_IHL_SHIFT;
 		}
 		pkt_info.byte_cnt = skb->len;
 		pkt_info.buf_ptr = dma_map_single(NULL, skb->data, skb->len,
@@ -1216,23 +1219,26 @@ linear:
 			pkt_info.cmd_sts = ETH_TX_FIRST_DESC |
 					   5 << ETH_TX_IHL_SHIFT;
 		else {
-			pkt_info.cmd_sts = ETH_TX_FIRST_DESC |
-					   ETH_GEN_TCP_UDP_CHECKSUM |
-					   ETH_GEN_IP_V_4_CHECKSUM |
-					   skb->nh.iph->ihl << ETH_TX_IHL_SHIFT;
 			/* CPU already calculated pseudo header checksum. */
-			if (skb->nh.iph->protocol == IPPROTO_UDP) {
-				pkt_info.cmd_sts |= ETH_UDP_FRAME;
+			if ( (skb->protocol == ETH_P_IP) &&
+			     (skb->nh.iph->protocol == IPPROTO_UDP) ) {
+				pkt_info.cmd_sts = ETH_UDP_FRAME;
 				pkt_info.l4i_chk = skb->h.uh->check;
-			} else if (skb->nh.iph->protocol == IPPROTO_TCP)
+			} else if ( (skb->protocol == ETH_P_IP) &&
+				    (skb->nh.iph->protocol == IPPROTO_TCP) ) {
+				pkt_info.cmd_sts = 0;
 				pkt_info.l4i_chk = skb->h.th->check;
-			else {
+			} else {
 				printk(KERN_ERR
-					"%s: chksum proto != TCP or UDP\n",
+					"%s: chksum proto != IPv4 TCP or UDP\n",
 					dev->name);
 				spin_unlock_irqrestore(&mp->lock, flags);
 				return 1;
 			}
+			pkt_info.cmd_sts |= ETH_TX_FIRST_DESC |
+					    ETH_GEN_TCP_UDP_CHECKSUM |
+					    ETH_GEN_IP_V_4_CHECKSUM |
+					    skb->nh.iph->ihl << ETH_TX_IHL_SHIFT;
 		}
 
 		status = eth_port_send(mp, &pkt_info);
@@ -1441,7 +1447,7 @@ static int mv643xx_eth_probe(struct plat
 	 * Zero copy can only work if we use Discovery II memory. Else, we will
 	 * have to map the buffers to ISA memory which is only 16 MB
 	 */
-	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_HW_CSUM;
+	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM;
 #endif
 #endif
 
