Return-Path: <n.eicker@fz-juelich.de>
Received: from zam837.fz-juelich.de (zam837.fz-juelich.de [134.94.100.69])
	by ozlabs.org (Postfix) with SMTP id AB552DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 01:43:15 +1100 (EST)
From: Norbert Eicker <n.eicker@fz-juelich.de>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Subject: [PATCH] spidernet: Fix problem sending IP fragments
Date: Wed, 28 Feb 2007 15:21:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702281521.34277.n.eicker@fz-juelich.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I found out that the spidernet-driver is unable to send fragmented IP 
frames.

Let me just recall the basic structure of "normal" UDP/IP/Ethernet 
frames (that actually work):
 - It starts with the Ethernet header (dest MAC, src MAC, etc.)
 - The next part is occupied by the IP header (version info, length of 
packet, id=0, fragment offset=0, checksum, from / to address, etc.)
 - Then comes the UDP header (src / dest port, length, checksum)
 - Actual payload
 - Ethernet checksum

Now what's different for IP fragment:
 - The IP header has id set to some value (same for all fragments), 
offset is set appropriately (i.e. 0 for first fragment, following 
according to size of other fragments), size is the length of the frame.
 - UDP header is unchanged. I.e. length is according to full UDP 
datagram, not just the part within the actual frame! But this is only 
true within the first frame: all following frames don't have a valid 
UDP-header at all.

The spidernet silicon seems to be quite intelligent: It's able to 
compute (IP / UDP / Ethernet) checksums on the fly and tests if frames 
are conforming to RFC -- at least conforming to RFC on complete frames.

But IP fragments are different as explained above:
I.e. for IP fragments containing part of a UDP datagram it sees 
incompatible length in the headers for IP and UDP in the first frame 
and, thus, skips this frame. But the content *is* correct for IP 
fragments. For all following frames it finds (most probably) no valid 
UDP header at all. But this *is* also correct for IP fragments.

The Linux IP-stack seems to be clever in this point. It expects the 
spidernet to calculate the checksum (since the module claims to be able 
to do so) and marks the skb's for "normal" frames accordingly 
(ip_summed set to CHECKSUM_HW).
But for the IP fragments it does not expect the driver to be capable to 
handle the frames appropriately. Thus all checksums are allready 
computed. This is also flaged within the skb (ip_summed set to 
CHECKSUM_NONE).

Unfortunately the spidernet driver ignores that hints. It tries to send 
the IP fragments of UDP datagrams as normal UDP/IP frames. Since they 
have different structure the silicon detects them the be not 
"well-formed" and skips them.

The following one-liner against 2.6.21-rc2 changes this behavior. If the 
IP-stack claims to have done the checksumming, the driver should not 
try to checksum (and analyze) the frame but send it as is.

Signed-off-by: Norbert Eicker <n.eicker@fz-juelich.de>
---
diff --git a/drivers/net/spider_net.c b/drivers/net/spider_net.c
index 3b91af8..31507ac 100644
--- a/drivers/net/spider_net.c
+++ b/drivers/net/spider_net.c
@@ -719,7 +719,7 @@ spider_net_prepare_tx_descr(struct spide
                        SPIDER_NET_DESCR_CARDOWNED | 
SPIDER_NET_DMAC_NOCS;
        spin_unlock_irqrestore(&chain->lock, flags);

-       if (skb->protocol == htons(ETH_P_IP))
+       if (skb->protocol == htons(ETH_P_IP) && skb->ip_summed == 
CHECKSUM_HW)
                switch (skb->nh.iph->protocol) {
                case IPPROTO_TCP:
                        hwdescr->dmac_cmd_status |= SPIDER_NET_DMAC_TCP;
