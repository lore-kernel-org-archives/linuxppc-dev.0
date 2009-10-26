Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id CA1E4B7BCC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 02:38:48 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 26 Oct 2009 09:38:39 -0600
Subject: Jumbo Frame bug in ibm_newemac driver (was Jumbo Frames, sil24 SATA
	driver, and kswapd0 page allocation failures)
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB08E@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F01FE4C90D0@midas.usurf.usu.edu>
	<4A83442B.6080305@nortel.com>
	<BB99A6BA28709744BF22A68E6D7EB51F02271D9CF7@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F02271D9CF7@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Okay, I need to revisit this issue.  I have had my time taken away for othe=
r things the past couple of months, but I am now back at this network issue=
.

Here is what I have done:

1. I modified the ibm_newemac driver to follow scatter-gather chains on the=
 RX path.  The idea was to setup the driver to only ever deal with single p=
ages.  The MAL in the PPC only supports data transfers of up to 4080 bytes =
(less than a single page), so it appears that the hardware should support s=
ingle page chains.  I set this up just like the e1000 driver.  For whatever=
 reason, this did not work.  It is probably because I do not fully understa=
nd the Linux network stack yet (as is apparent in the next iteration).

2. I reverted to the original driver and found that, contrary to what I had=
 thought earlier, the driver does allocate a ring of skbs for use in the dr=
iver.  However, when a jumbo packet is received (larger than 4080 bytes) it=
 uses the skb that was pre-allocated for the jumbo packet and allocates a n=
ew skb to replace the one in the ring.  This is where the problem is - in t=
hat new allocation to replace the one in the stack.  So, to remedy this, I =
pre-allocated the same number of jumbo skbs for the sole purpose of being u=
sed as new skbs for the rx ring.  Here is some code that shows the idea:

Statuc int emaC_open(struct net_device *ndev)
{
	...

        /* Allocate RX ring */
        for (i =3D 0; i < NUM_RX_BUFF; ++i)
        {
                if (emac_alloc_rx_skb(dev, i, GFP_KERNEL)) {
                        printk(KERN_ERR "%s: failed to allocate RX ring\n",
                               ndev->name);
                        goto oom;
                }

        }

	...
}

static inline int emac_alloc_rx_skb2(struct emac_instance *dev, int slot,
                                    gfp_t flags)
{
        struct sk_buff *skb =3D dev->rx_skb_pool[slot];
        if (unlikely(!skb))
                return -ENOMEM;

        if(skb_recycle_check(skb, emac_rx_skb_size(dev->rx_skb_size)))
        {
        dev->rx_skb[slot] =3D skb;
        dev->rx_desc[slot].data_len =3D 0;

        skb_reserve(skb, EMAC_RX_SKB_HEADROOM + 2);
        dev->rx_desc[slot].data_ptr =3D
            dma_map_single(&dev->ofdev->dev, skb->data - 2, dev->rx_sync_si=
ze,
                           DMA_FROM_DEVICE) + 2;
        wmb();
        dev->rx_desc[slot].ctrl =3D MAL_RX_CTRL_EMPTY |
            (slot =3D=3D (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);

        return 0;
        }
        else
        {
                printk(KERN_NOTICE "EMAC: SKB not recycleable\n");
                return -ENOMEM;
        }
}

Static int emac_poll_rx(void *param, int budget)
{
	...
	      sg:
                if (ctrl & MAL_RX_CTRL_FIRST) {
                        BUG_ON(dev->rx_sg_skb);
                        if (unlikely(emac_alloc_rx_skb2(dev, slot, GFP_ATOM=
IC))) {
                                DBG(dev, "rx OOM %d" NL, slot);
                                ++dev->estats.rx_dropped_oom;
                                emac_recycle_rx_skb(dev, slot, 0);
                        } else {
                                dev->rx_sg_skb =3D skb;
					  emac_recycle_rx_skb(dev,slot,len);
                                skb_put(skb, len);
                        }
                } else if (!emac_rx_sg_append(dev, slot) &&
                           (ctrl & MAL_RX_CTRL_LAST)) {

                        skb =3D dev->rx_sg_skb;
                        dev->rx_sg_skb =3D NULL;

                        ctrl &=3D EMAC_BAD_RX_MASK;
                        if (unlikely(ctrl && ctrl !=3D EMAC_RX_TAH_BAD_CSUM=
)) {
                                emac_parse_rx_error(dev, ctrl);
                                ++dev->estats.rx_dropped_error;
                                dev_kfree_skb(skb);
                                len =3D 0;
                        } else {
                        /*      printk(KERN_NOTICE "EMAC: pushing sg packet=
\n");*/
                                goto push_packet;
                        }
                }
                goto skip;
	...
}

The changes are the allocation of the rx_skb_pool in emac_open(), the funct=
ion call emac_alloc_rx_skb2() in emac_poll_rx(), and the modifications to e=
mac_alloc_skb to create emac_alloc_rx_skb2.  Also, corresponding allocation=
s for rx_skb_pool are found in emac_resize_rx_ring() for when we need to re=
size the pool.

Now the problem that I am having is this - the first time through the ring,=
 things work just fine.  But the second time through the loop, the buffers =
are not cleaned out - they still think they contain data.  I have tried cal=
ling skb_recycle_check() to restore the skb to a new state, however that ca=
ll fails because apparently the skb cannot be reused for receive.  Why is t=
hat the case?  What am I missing?  It seems like I am missing something tha=
t allows the skb to be reused?

I will admit, I am not a Linux network driver expert, though I am learning.=
  If anyone can lend any advice or can see a problem in my logic, then plea=
se let me know.

Thanks!

Jonathan

> > If the hardware supports it, the best way to deal with it is to
> set
> > up
> > the driver so that it only ever deals in single pages.
>=20
> I am working on fixing the driver to support NETIF_F_SG and have
> changed how it receives packets to follow how the e1000 driver does
> it.
>=20
> Here is where I am at:
>=20
> When I get the first part of the frame, I allocate an skb for the
> packet.  I call dev->page =3D alloc_page(GFP_ATOMIC) to allocate a
> page for the 4080 bytes coming from the MAL.
>=20
> I then setup a DMA mapping for that page to get the data out of the
> MAL (the original code simply used dma_map_single, but I need a
> page).
>=20
> Once the DMA map has been setup and data transferred, I call
> skb_fill_page_desc() to put the data into the skb.  I then wrote a
> function called emac_consume_page, which unmaps the DMA mapping,
> frees the page, and updates the lengths in the skb.
>=20
> The relevant source code is at the end of this email.
>=20
> My problem is this:
>=20
> When I run this code, it appears to create the fragmented packet
> just fine, but when it passes it up the stack, the kernel spits out
> these bugs, one after another:
>=20
> BUG: Bad page state in process swapper  pfn:0ee9b
> page:c051f360 flags:(null) count:-3 mapcount:0 mapping:(null)
> index:766
> Call Trace:
> [c032bc30] [c0006ef0] show_stack+0x44/0x16c (unreliable)
> [c032bc70] [c006c438] bad_page+0x94/0x130
> [c032bc90] [c006d4a0] get_page_from_freelist+0x458/0x4d4
> [c032bd20] [c006d5f4] __alloc_pages_nodemask+0xd8/0x4f8
> [c032bda0] [c01a1174] emac_poll_rx+0x300/0x9c8
> [c032bdf0] [c019cb64] mal_poll+0xa8/0x1ec
> [c032be20] [c01cf218] net_rx_action+0x9c/0x1b4
> [c032be50] [c0039678] __do_softirq+0xc4/0x148
> [c032be90] [c0004d18] do_softirq+0x78/0x80
> [c032bea0] [c0039264] irq_exit+0x64/0x7c
> [c032beb0] [c0005210] do_IRQ+0x9c/0xb4
> [c032bed0] [c000fa7c] ret_from_except+0x0/0x18
> [c032bf90] [c000808c] cpu_idle+0xdc/0xec
> [c032bfb0] [c00028fc] rest_init+0x70/0x84
> [c032bfc0] [c02e0864] start_kernel+0x240/0x2c4
> [c032bff0] [c0002254] start_here+0x44/0xb0
> BUG: Bad page state in process swapper  pfn:0ee8c
> page:c051f180 flags:(null) count:-3 mapcount:0 mapping:(null)
> index:757
> Call Trace:
> [c032bc30] [c0006ef0] show_stack+0x44/0x16c (unreliable)
> [c032bc70] [c006c438] bad_page+0x94/0x130
> [c032bc90] [c006d4a0] get_page_from_freelist+0x458/0x4d4
> [c032bd20] [c006d5f4] __alloc_pages_nodemask+0xd8/0x4f8
> [c032bda0] [c01a1174] emac_poll_rx+0x300/0x9c8
> [c032bdf0] [c019cb64] mal_poll+0xa8/0x1ec
> [c032be20] [c01cf218] net_rx_action+0x9c/0x1b4
> [c032be50] [c0039678] __do_softirq+0xc4/0x148
> [c032be90] [c0004d18] do_softirq+0x78/0x80
> [c032bea0] [c0039264] irq_exit+0x64/0x7c
> [c032beb0] [c0005210] do_IRQ+0x9c/0xb4
> [c032bed0] [c000fa7c] ret_from_except+0x0/0x18
> [c032bf90] [c000808c] cpu_idle+0xdc/0xec
> [c032bfb0] [c00028fc] rest_init+0x70/0x84
> [c032bfc0] [c02e0864] start_kernel+0x240/0x2c4
> [c032bff0] [c0002254] start_here+0x44/0xb0
>=20
> I know that I am missing something when it comes to allocating the
> pages for the fragments, but when I compare my methodology to the
> e1000 driver, they appear to be functionally the same?
>=20
> Any ideas?  I can send the entire source file for the driver if
> needs be.
>=20
> Thanks!
>=20
> Jonathan
>=20
>=20
> Here is the source:
>=20
> static int emac_poll_rx(void *param, int budget)
> {
>=20
> ... /* Other code is here */
>=20
> push_packet:
> 	skb->dev =3D dev->ndev;
> 	skb->protocol =3D eth_type_trans(skb, dev->ndev);
> 	emac_rx_csum(dev, skb, ctrl);
>=20
> 	if (unlikely(netif_receive_skb(skb) =3D=3D NET_RX_DROP))
> 		++dev->estats.rx_dropped_stack;
> next:
> 	++dev->stats.rx_packets;
> skip:
> 	dev->stats.rx_bytes +=3D len;
> 	slot =3D (slot + 1) % NUM_RX_BUFF;
> 	--budget;
> 	++received;
> 	continue;
> sg:
> if (ctrl & MAL_RX_CTRL_FIRST) {
> 	BUG_ON(dev->rx_sg_skb);
> 	if (unlikely(emac_alloc_rx_skb2(dev, slot, GFP_ATOMIC))) {
> 		DBG(dev, "rx OOM %d (%d) (%d)" NL, slot, dev-
> >rx_skb_size, len);
> 		++dev->estats.rx_dropped_oom;
> 		emac_recycle_rx_skb(dev, slot, 0);
> 	} else {
> 		dev->rx_sg_skb =3D skb;
> 		skb_fill_page_desc(dev->rx_sg_skb, 0, dev->page, 0,
> len);
> 		emac_consume_page(dev, len, slot);
> 		dev->rx_sg_skb->len +=3D ETH_HLEN;
> 	}
> } else if (!emac_rx_sg_append(dev, slot) && (ctrl &
> MAL_RX_CTRL_LAST)) {
> 	skb =3D dev->rx_sg_skb;
> 	dev->rx_sg_skb =3D NULL;
>=20
> 	ctrl &=3D EMAC_BAD_RX_MASK;
> 	if (unlikely(ctrl && ctrl !=3D EMAC_RX_TAH_BAD_CSUM)) {
> 		emac_parse_rx_error(dev, ctrl);
> 		++dev->estats.rx_dropped_error;
> 		dev_kfree_skb(skb);
> 		len =3D 0;
> 	} else
> 		goto push_packet;
> }
>=20
> ... /* Other code is here */
> } /* end of emac_poll_rx */
>=20
> static inline int emac_alloc_rx_skb2(struct emac_instance *dev, int
> slot,
> 				    gfp_t flags)
> {
> 	struct sk_buff *skb =3D alloc_skb(242, flags);
> 	if (unlikely(!skb))
> 		return -ENOMEM;
>=20
>=20
> 	dev->rx_skb[slot] =3D skb;
> 	dev->rx_desc[slot].data_len =3D 0;
>=20
> 	dev->page =3D alloc_page(flags);
> 	DBG(dev, "emac_alloc_skb2: page %x" NL, dev->page);
> 	if(unlikely(!dev->page))
> 	{
> 		return -1;
> 	}
> 	dev->rx_desc[slot].data_ptr =3D dma_map_page(&dev->ofdev->dev,
> dev->page, 0, 4096, DMA_FROM_DEVICE);
>=20
> 	wmb();
> 	dev->rx_desc[slot].ctrl =3D MAL_RX_CTRL_EMPTY |
> 	    (slot =3D=3D (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
>=20
> 	return 0;
> } /* end of emac_alloc_rx_skb2 */
>=20
> static inline void emac_consume_page(struct emac_instance* dev, int
> length, int slot)
> {
> 	dma_unmap_page(&dev->ofdev->dev, dev->rx_desc[slot].data_ptr,
> 4096, DMA_FROM_DEVICE);
> 	wmb();
> 	__free_page(dev->page);
> 	dev->page =3D NULL;
> 	dev->rx_sg_skb->len +=3D length;
> 	dev->rx_sg_skb->data_len +=3D length;
> 	dev->rx_sg_skb->truesize +=3D length;
> }
>=20
> static inline int emac_rx_sg_append(struct emac_instance *dev, int
> slot)
> {
> 	if (likely(dev->rx_sg_skb !=3D NULL)) {
> 		int len =3D dev->rx_desc[slot].data_len;
> 		int tot_len =3D dev->rx_sg_skb->len + len;
>=20
> 		if (unlikely(tot_len + 2 > dev->max_mtu)) {
> 			++dev->estats.rx_dropped_mtu;
> 			dev_kfree_skb(dev->rx_sg_skb);
> 			dev->rx_sg_skb =3D NULL;
> 		} else {
> 			dev->page =3D alloc_page(GFP_ATOMIC);
> 			if(unlikely(!dev->page))
> 			{
> 				return -ENOMEM;
> 			}
> 			dev->rx_desc[slot].data_ptr =3D dma_map_page(&dev-
> >ofdev->dev, dev->page, 0, 4096, DMA_FROM_DEVICE);
> 			dev->rx_desc[slot].data_len =3D 0;
> 			wmb();
> 			dev->rx_desc[slot].ctrl =3D MAL_RX_CTRL_EMPTY |
> (slot =3D=3D (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);
> 			skb_fill_page_desc(dev->rx_sg_skb, skb_shinfo(dev-
> >rx_sg_skb)->nr_frags, dev->page, 0, len);
> 			emac_consume_page(dev, len, slot);
> 			return 0;
> 		}
> 	}
> 	emac_recycle_rx_skb(dev, slot, 0);
> 	return -1;
> } /* end of emac_rx_sg_append */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
