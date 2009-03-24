Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3B10FDDF55
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 08:22:22 +1100 (EST)
Date: Tue, 24 Mar 2009 14:22:09 -0700 (PDT)
Message-Id: <20090324.142209.234280606.davem@davemloft.net>
To: Joakim.Tjernlund@transmode.se
Subject: Re: [PATCH] ucc_geth: Convert to net_device_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <OFA0B803BB.DEC93B9A-ONC1257583.0039CF3E-C1257583.003A55BA@transmode.se>
References: <OF2EE08546.DF677136-ONC1257582.0037C87E-C1257582.00388BCE@transmode.se>
	<20090323.114928.01832203.davem@davemloft.net>
	<OFA0B803BB.DEC93B9A-ONC1257583.0039CF3E-C1257583.003A55BA@transmode.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 24 Mar 2009 11:37:11 +0100

> David Miller <davem@davemloft.net> wrote on 23/03/2009 19:49:28:
> > 
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Mon, 23 Mar 2009 11:17:39 +0100
> > 
> > > Sorry for the WS damaged patch, but my current company mailer cannot
> > > handle inline patches. Due to this we are setting up a new mail system
> > > but it will be a few days before this is ready.
> > > Therefore I am attaching this patch as well, use that one
> > > to apply instaed of the inline variant.
> > 
> > This patch has other problems, anyways.
> > 
> > > +#if 0
> > > +/* not yet */
> > > +       .ndo_set_mac_address    = ucc_geth_set_mac_address,
> > > +       .ndo_change_mtu         = ucc_geth_change_mtu,
> > > +       .ndo_do_ioctl           = ucc_geth_do_ioctl,
> > > +#endif
> > 
> > Don't do stuff like this, please.  Even the code you are
> > copying from doesn't have the set_mac_address method
> > assignment proceted by #if 0 stuff.
> > 
> > Just get rid of all the unused stuff completely.
> 
> OK, here is a new version. The #if 0 ..#endif has been removed.

Missing ".ndo_set_mac_address = eth_set_mac_address," and
also ".ndo_change_mtu = eth_change_mtu".

Also please inline your patches so that people can quote them in
replies.
