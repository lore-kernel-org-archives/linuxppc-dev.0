Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A6BD67BAB
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 10:13:16 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7M0DC9E003908
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 20:13:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7M0DCMB335350
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 18:13:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7M0DBP9012295
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 18:13:12 -0600
Date: Mon, 21 Aug 2006 19:13:11 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060822001311.GK5427@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com>
	<20060818.142513.29571851.davem@davemloft.net>
	<20060818224618.GN26889@austin.ibm.com>
	<20060818.155116.112621100.davem@davemloft.net>
	<20060818232942.GO26889@austin.ibm.com>
	<20060818234532.GA8644@austin.ibm.com>
	<1155962022.5803.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155962022.5803.68.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Jens.Osterkamp@de.ibm.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Aug 19, 2006 at 02:33:42PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-08-18 at 18:45 -0500, Linas Vepstas wrote:
> > On Fri, Aug 18, 2006 at 06:29:42PM -0500, linas wrote:
> > > 
> > > I don't understand what you are saying. If I call the transmit 
> > > queue cleanup code from the poll() routine, nothing hapens, 
> > > because the kernel does not call the poll() routine often 
> > > enough. I've stated this several times.  
> > 
> > OK, Arnd gave me a clue stick. I need to call the (misnamed)
> > netif_rx_schedule() from the tx interrupt in order to get 
> > this to work. That makes sense, and its easy, I'll send the 
> > revised patch.. well, not tonight, but shortly.
> 
> You might not want to call it all the time though... You need some
> interrupt mitigation and thus a timer that calls netif_rx_schedule()
> might be of some use still...

Well, again, the whole point of a low-watermark interrupt is to 
get zero of them when the system is working correctly; they're
self-mitigating by design.

-------------
Anyway, I tried the suggestion, but am getting less-than-ideal
results. 

To recap: my original patch did this:

   spider_interrupt_handler(struct whatever *) {
      ...
      if (tx_interrupt) 
         schedule_work (tx_cleanup_handler)
   }

which David Miller objected to. Once I understood the why 
(sorry for not getting it right away), I then replaced the 
above with the below, which is what I think everyone wanted:


   spider_interrupt_handler(struct whatever *) {
      ...
      if (tx_interrupt) 
         netif_rx_schedule(netdev);
   }

   spidernet_poll(stuct whatever *) {
      tx_cleanup_handler(txring);
      // rx_stuff too ...
   }

I was expecting this to be a no-op from the performance
point of view. Instead, I get a fairly dramatic (11%) slowdown:
the first patch runs in the 785-805 Mbits/sec range, while
the second patch runs in the 705-715 Mbits/sec range. 
I am surprised, ad don't understand why this would be so.

For the record, the alternate patch is below.

----

Index: linux-2.6.18-rc2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/net/spider_net.c	2006-08-21 16:59:33.000000000 -0500
+++ linux-2.6.18-rc2/drivers/net/spider_net.c	2006-08-21 17:15:28.000000000 -0500
@@ -1087,6 +1090,8 @@ spider_net_poll(struct net_device *netde
 	int packets_to_do, packets_done = 0;
 	int no_more_packets = 0;
 
+	spider_net_cleanup_tx_ring(card);
+
 	packets_to_do = min(*budget, netdev->quota);
 
 	while (packets_to_do) {
@@ -1495,16 +1500,16 @@ spider_net_interrupt(int irq, void *ptr,
 	if (!status_reg)
 		return IRQ_NONE;
 
-	if (status_reg & SPIDER_NET_RXINT ) {
+	if (status_reg & SPIDER_NET_RXINT) {
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
-	if (status_reg & SPIDER_NET_TXINT ) {
-		spider_net_cleanup_tx_ring(card);
-		netif_wake_queue(netdev);
-	}
 
-	if (status_reg & SPIDER_NET_ERRINT )
+	/* Call rx_schedule from the tx interrupt, so that NAPI poll runs. */
+	if (status_reg & SPIDER_NET_TXINT)
+		netif_rx_schedule(netdev);
+
+	if (status_reg & SPIDER_NET_ERRINT)
 		spider_net_handle_error_irq(card, status_reg);
 
 	/* clear interrupt sources */
