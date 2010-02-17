Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 13376B7DDA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 08:31:29 +1100 (EST)
Date: Wed, 17 Feb 2010 22:31:04 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [net-next-2.6 PATCH v2 3/3] fs_enet: add FEC TX buffer
	alignment workaround for MPC5121
Message-ID: <20100217223104.41d91a83@wker>
In-Reply-To: <1266419836.3075.12.camel@edumazet-laptop>
References: <1266418530-2727-1-git-send-email-agust@denx.de>
	<1266418530-2727-2-git-send-email-agust@denx.de>
	<1266418530-2727-3-git-send-email-agust@denx.de>
	<1266418530-2727-4-git-send-email-agust@denx.de>
	<1266419836.3075.12.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	"David S. Miller" <davem@davemloft.net>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Feb 2010 16:17:16 +0100
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Le mercredi 17 f=C3=A9vrier 2010 =C3=A0 15:55 +0100, Anatolij Gustschin a=
 =C3=A9crit :
...
> > +static struct sk_buff *tx_skb_align_workaround(struct net_device *dev,
> > +					       struct sk_buff *skb)
> > +{
> > +	struct sk_buff *new_skb;
> > +	struct fs_enet_private *fep =3D netdev_priv(dev);
> > +
> > +	/* Alloc new skb */
> > +	new_skb =3D dev_alloc_skb(ENET_RX_FRSIZE + 4);
>=20
>=20
> ENET_RX_FRSIZE looks strange in TX path
>=20
> Why not using skb->len + 4 instead of ENET_RX_FRSIZE + 4 ?

I will fix it.

> > +	if (!new_skb) {
> > +		dev_warn(fep->dev, "Memory squeeze, dropping tx packet.\n");
>=20
> I am just wondering if this is ratelimited ?

Right, it should be ratelimited, will fix it, too.

...
> >  static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *=
dev)
> >  {
> >  	struct fs_enet_private *fep =3D netdev_priv(dev);
> > @@ -588,6 +619,19 @@ static int fs_enet_start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
> >  	u16 sc;
> >  	unsigned long flags;
> > =20
> > +#ifdef CONFIG_FS_ENET_MPC5121_FEC
> > +	if (((unsigned long)skb->data) & 0x3) {
> > +		skb =3D tx_skb_align_workaround(dev, skb);
> > +		if (!skb) {
> > +			/*
> > +			 * We have lost packet due to memory allocation error
> > +			 * in tx_skb_align_workaround(). Hopefully original
> > +			 * skb is still valid, so try transmit it later.
> > +			 */
>=20
> Could you define 'try to transmit later' ?
> Who is responsible to trigger this event ?

The function returns NETDEV_TX_BUSY here, skb is not
consumed and will be requeued by sch_direct_xmit(), so
it is scheduled for resending later.

Thanks,
Anatolij
