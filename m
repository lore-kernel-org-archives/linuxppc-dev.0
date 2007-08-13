Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 9D3F7DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 17:21:38 +1000 (EST)
Date: Mon, 13 Aug 2007 09:21:31 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Message-ID: <20070813072131.GD13994@moe.telargo.com>
References: <20070810095153.GC13994@moe.telargo.com>
	<20070810130225.GE3375@ghostprotocols.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070810130225.GE3375@ghostprotocols.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/08/07 10:02 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 10, 2007 at 11:51:53AM +0200, Domen Puncer escreveu:
> > +static u8 null_mac[6];
> 
> const

OK.

...
> > +static void fec_set_paddr(struct net_device *dev, u8 *mac)
> > +{
> > +	struct fec_priv *priv = netdev_priv(dev);
> > +	struct mpc52xx_fec __iomem *fec = priv->fec;
> > +
> > +	out_be32(&fec->paddr1, *(u32*)(&mac[0]));
> > +	out_be32(&fec->paddr2, (*(u16*)(&mac[4]) << 16) | FEC_PADDR2_TYPE);
> 
> spaces after the types on casts to pointers

I assume you mean: out_be32(&fec->paddr1, *(u32 *)(&mac[0]));

> 
> > +}
> > +
> > +static void fec_get_paddr(struct net_device *dev, u8 *mac)
> > +{
> > +	struct fec_priv *priv = netdev_priv(dev);
> > +	struct mpc52xx_fec __iomem *fec = priv->fec;
> > +
> > +	*(u32*)(&mac[0]) = in_be32(&fec->paddr1);
> > +	*(u16*)(&mac[4]) = in_be32(&fec->paddr2) >> 16;
> 
> ditto

OK.

> 
> > +}
> > +
> > +static int fec_set_mac_address(struct net_device *dev, void *addr)
> > +{
> > +	struct sockaddr *sock = (struct sockaddr *)addr;
> 
> no need for a cast, addr is a void pointer

Right, missed this one.

> 
> > +
> > +	memcpy(dev->dev_addr, sock->sa_data, dev->addr_len);
> > +
> > +	fec_set_paddr(dev, sock->sa_data);
> > +	return 0;
> 
> Why always return 0? make it void

Because struct net_device->set_mac_address's prototype is like that.

> 
> > +}
> > +
> > +static void fec_free_rx_buffers(struct bcom_task *s)
> > +{
> > +	struct sk_buff *skb;
> > +
> > +	while (!bcom_queue_empty(s)) {
> > +		skb = bcom_retrieve_buffer(s, NULL, NULL);
> > +		kfree_skb(skb);
> > +	}
> > +}
> > +
> > +static int fec_alloc_rx_buffers(struct bcom_task *rxtsk)
> > +{
> > +	while (!bcom_queue_full(rxtsk)) {
> > +		struct sk_buff *skb;
> > +		struct bcom_fec_bd *bd;
> > +
> > +		skb = dev_alloc_skb(FEC_RX_BUFFER_SIZE);
> > +		if (skb == 0)
> 
> Test against NULL

Right. I also fixed other stuff sparse reports.

> 
> > +			return -EAGAIN;
> > +

...
> > +
> > +	if (new_state && netif_msg_link(priv)) {
> > +		phy_print_status(phydev);
> > +	}
> 
> No need for {}, this if has only one statement

OK.

...
> > +static int __init
> > +mpc52xx_fec_init(void)
> > +{
> > +	int ret;
> > +	if ((ret = fec_mdio_init())) {
> 
> Why not:
> 
> 	int ret = fec_mdio_init();
> 	if (ret) {
> 
> Less parenthesis, looks more clear

I prefer it like that too.


Thanks Arnaldo!


Any other comments on code functionality, design?


	Domen
