Date: Fri, 8 Mar 2002 11:39:12 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200203081939.g28JdCP28936@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Bugfix in arch/ppc/8260_io/fcc_enet.c linux-2.4.17
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found a bug which was manifest when linux boots and lots of ethernet
packets are coming in. I think the problem is because the fcc_enet.c
adds the network device in very early during the boot, and the driver is
happily calling netif_rx() on the received packets even though the interface
isn't officially "up". Linux appears not to like this, and would crash
sporadically, or predictibly if I have a program on another computer running
just blasting packets at the first one.

The fix is to just put an if around this section in fcc_enet_rx:
		skb = dev_alloc_skb(pkt_len-4);

		if (skb == NULL) {
			printk("%s: Memory squeeze, dropping packet.\n", dev->name);
			cep->stats.rx_dropped++;
		}
		else {
			skb->dev = dev;
			skb_put(skb,pkt_len-4);	/* Make room */
			eth_copy_and_sum(skb,
				(unsigned char *)__va(bdp->cbd_bufaddr),
				pkt_len-4, 0);
			skb->protocol=eth_type_trans(skb,dev);
			netif_rx(skb);
		}

So it becomes:
		if(dev->flags & IFF_UP) { /* only do if iface is up */
	                skb = dev_alloc_skb(pkt_len-4);

	                if (skb == NULL) {
	                        printk("%s: Memory squeeze, dropping packet.\n", dev->name);
	                        cep->stats.rx_dropped++;
	                }
	                else {
	                        skb->dev = dev;
	                        skb_put(skb,pkt_len-4); /* Make room */
	                        eth_copy_and_sum(skb,
	                                (unsigned char *)__va(bdp->cbd_bufaddr),
	                                pkt_len-4, 0);
	                        skb->protocol=eth_type_trans(skb,dev);
	                        netif_rx(skb);
	                }
		}

This fixes the crash bug.

-Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
