Return-Path: <bhutchings@solarflare.com>
Received: from exchange.solarflare.com (mail.solarflare.com [216.237.3.220])
	by ozlabs.org (Postfix) with ESMTP id 4CC25B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 01:23:35 +1000 (EST)
Subject: Re: [PATCH] ucc_geth: fix ethtool set ring param bug
From: Ben Hutchings <bhutchings@solarflare.com>
To: Liang Li <liang.li@windriver.com>
In-Reply-To: <20100831151629.GA21442@localhost>
References: <1283179677-21262-1-git-send-email-liang.li@windriver.com>
	<1283265682.2244.0.camel@achroite.uk.solarflarecom.com>
	<20100831151629.GA21442@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 16:23:30 +0100
Message-ID: <1283268210.2244.2.camel@achroite.uk.solarflarecom.com>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, avorontsov@ru.mvista.com,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-08-31 at 23:16 +0800, Liang Li wrote:
> On Tue, Aug 31, 2010 at 03:41:22PM +0100, Ben Hutchings wrote:
> > On Mon, 2010-08-30 at 22:47 +0800, Liang Li wrote:
> > > It's common sense that when we should do change to driver ring
> > > desc/buffer etc only after 'stop/shutdown' the device. When we
> > > do change while devices/driver is running, kernel oops occur:
> > [...]
> > > diff --git a/drivers/net/ucc_geth_ethtool.c b/drivers/net/ucc_geth_ethtool.c
> > > index 6f92e48..1b37aaa 100644
> > > --- a/drivers/net/ucc_geth_ethtool.c
> > > +++ b/drivers/net/ucc_geth_ethtool.c
> > > @@ -255,13 +255,18 @@ uec_set_ringparam(struct net_device *netdev,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	ug_info->bdRingLenRx[queue] = ring->rx_pending;
> > > -	ug_info->bdRingLenTx[queue] = ring->tx_pending;
> > > -
> > >  	if (netif_running(netdev)) {
> > > -		/* FIXME: restart automatically */
> > > -		printk(KERN_INFO
> > > -			"Please re-open the interface.\n");
> > > +		printk(KERN_INFO "Stopping interface %s.\n", netdev->name);
> > > +		ucc_geth_close(netdev);
> > > +
> > > +		ug_info->bdRingLenRx[queue] = ring->rx_pending;
> > > +		ug_info->bdRingLenTx[queue] = ring->tx_pending;
> > > +
> > > +		printk(KERN_INFO "Reactivating interface %s.\n", netdev->name);
> > > +		ucc_geth_open(netdev);
> > 
> > What if ucc_geth_open() fails?
> 
> I did some runtime tests but did not witness the ucc_geth_open fail.
> Assume it may fail for some reason, then I tend to think give out
> warnings for request user to open/enable it mannually?  Or we may need
> to keep the 'FIXME' line?

The easy way out is to allow changing the ring size only while the
interface is down.  The hard way is to make the change in such a way
that you can roll back in case of failure.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
