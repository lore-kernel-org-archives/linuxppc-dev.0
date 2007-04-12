Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6CD89DDF7D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 03:10:45 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3CG9ui2005786
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 12:09:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CHAfvn292392
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:10:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CHAe52013689
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:10:41 -0400
Date: Thu, 12 Apr 2007 12:10:39 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH for 2.6.21] spidernet: Fix problem sending IP fragments
Message-ID: <20070412171039.GO4747@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linux-kernel@vger.kernel.org, etdev@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Norbert Eicker <n.eicker@fz-juelich.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Resending a previously submitted patch.  I would really like to 
see this patch go into 2.6.21.

Its a one-line patch to the spidernet device driver; it fixes 
the operation of NFS for this device.  This device is not 
available on x86 platforms; accepting this patch will not 
break x86. The device is integrated into the southbridge
for cell-based systems, and so is only available on those
systems. It is *not* used on the ps3, since the ps3 hides 
this function under a hypervisor layer. Thus, the impact
ito the big wide world of applying this patch is small. 
By contrast, the hurt to the small collection of affected 
systems is high.

The rest of this email is a long description of the nature 
of the bug.

--linas



The basic structure of "normal" UDP/IP/Ethernet 
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

Index: linux-2.6.21-rc4-git4/drivers/net/spider_net.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/net/spider_net.c	2007-03-19 12:51:21.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/net/spider_net.c	2007-03-19 13:13:47.000000000 -0500
@@ -719,7 +719,7 @@ spider_net_prepare_tx_descr(struct spide
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
 	spin_unlock_irqrestore(&chain->lock, flags);
 
-	if (skb->protocol == htons(ETH_P_IP))
+	if (skb->protocol == htons(ETH_P_IP) && skb->ip_summed == CHECKSUM_PARTIAL)
 		switch (skb->nh.iph->protocol) {
 		case IPPROTO_TCP:
 			hwdescr->dmac_cmd_status |= SPIDER_NET_DMAC_TCP;
