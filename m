Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF851DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 10:16:02 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l28NFvQJ004995
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 18:15:57 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l28NFviI295422
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 18:15:57 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l28NFveO017011
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 18:15:57 -0500
Date: Thu, 8 Mar 2007 17:15:56 -0600
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] spidernet: Fix problem sending IP fragments
Message-ID: <20070308231556.GE30703@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Norbert Eicker <n.eicker@fz-juelich.de>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Jeff, 

Please apply. The rather long patch description is from the submitter,
Norbert Eicker, I don't know if that's alright, or if I should ask to 
have it trimmed.

Thanks, 
--linas

From: Norbert Eicker <n.eicker@fz-juelich.de>

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
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
diff --git a/drivers/net/spider_net.c b/drivers/net/spider_net.c
index 3b91af8..31507ac 100644
 drivers/net/spider_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.20-git16/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-git16.orig/drivers/net/spider_net.c	2007-03-01 13:39:14.000000000 -0600
+++ linux-2.6.20-git16/drivers/net/spider_net.c	2007-03-01 18:14:51.000000000 -0600
@@ -719,7 +719,7 @@ spider_net_prepare_tx_descr(struct spide
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
 	spin_unlock_irqrestore(&chain->lock, flags);
 
-	if (skb->protocol == htons(ETH_P_IP))
+	if (skb->protocol == htons(ETH_P_IP) && skb->ip_summed == CHECKSUM_PARTIAL)
 		switch (skb->nh.iph->protocol) {
 		case IPPROTO_TCP:
 			hwdescr->dmac_cmd_status |= SPIDER_NET_DMAC_TCP;
