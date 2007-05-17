Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB3CBDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 09:53:04 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4HNqqiA018884
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 19:52:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4HNqqZg254154
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 17:52:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4HNqpsq001679
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 17:52:52 -0600
Date: Thu, 17 May 2007 18:52:47 -0500
To: David Miller <davem@davemloft.net>
Subject: Re: RT patches expose netdev race [was Re: [RFC] [patch 2/2] powerpc
	2.6.21-rt1: fix kernel hang and/or panic
Message-ID: <20070517235247.GJ4325@austin.ibm.com>
References: <yyiirau5v8g.wl@toshiba.co.jp>
	<1179223742.32247.184.camel@localhost.localdomain>
	<20070517001801.GB4325@austin.ibm.com>
	<20070516.174101.45179259.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070516.174101.45179259.davem@davemloft.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, mingo@elte.hu,
	tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 05:41:01PM -0700, David Miller wrote:
> From: linas@austin.ibm.com (Linas Vepstas)
> Date: Wed, 16 May 2007 19:18:02 -0500
> 
> > Since this is a long email; let me put a summary up front:
> > I think the RT/premption patches are exposing some sort
> > of race in the ip header handling code. The rest of the 
> > note is forensics pointing to this.
> 
> skb->head should never ever be NULL.

The stack trace from Owa-san showed a null pointer deref at 
ip_hdr(skb)->protocol for an skb passed in via hard_start_xmit()

I dunno, memory corruption?

Tsutomu, can you reproduce this with something similr to the following
patch?

--linas

 drivers/net/spider_net.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6.22-rc1/drivers/net/spider_net.c
===================================================================
--- linux-2.6.22-rc1.orig/drivers/net/spider_net.c	2007-05-17 18:31:40.000000000 -0500
+++ linux-2.6.22-rc1/drivers/net/spider_net.c	2007-05-17 18:51:49.000000000 -0500
@@ -720,7 +720,19 @@ spider_net_prepare_tx_descr(struct spide
 			SPIDER_NET_DESCR_CARDOWNED | SPIDER_NET_DMAC_NOCS;
 	spin_unlock_irqrestore(&chain->lock, flags);
 
-	if (skb->protocol == htons(ETH_P_IP) && skb->ip_summed == CHECKSUM_PARTIAL)
+	if (skb->protocol == htons(ETH_P_IP) && skb->ip_summed == CHECKSUM_PARTIAL) {
+		struct iphdr *hp=ip_hdr(skb);
+		if (((unsigned long) hp < 0x100000) || 
+		    ((unsigned long)hp > 0xffff000000000000UL)) {
+			printk(KERN_ERROR "spidernet: bad ip header! "
+				"skb=%p ip_hdr=%p head=%p data=%p net=%x\n", skb, hp,
+				skb->head, skb->data, skb->network_header);
+			int i;
+			unsinged long *s=(unsigned long*) skb;
+			for (i=0; i<20; i++) {
+				printk("%d %lx %lx\n", i, s[2*i],s[2*i+1]);
+			}
+		} else {
 		switch (ip_hdr(skb)->protocol) {
 		case IPPROTO_TCP:
 			hwdescr->dmac_cmd_status |= SPIDER_NET_DMAC_TCP;
@@ -728,6 +740,8 @@ spider_net_prepare_tx_descr(struct spide
 		case IPPROTO_UDP:
 			hwdescr->dmac_cmd_status |= SPIDER_NET_DMAC_UDP;
 			break;
+		}
+		}
 	}
 
 	/* Chain the bus address, so that the DMA engine finds this descr. */
