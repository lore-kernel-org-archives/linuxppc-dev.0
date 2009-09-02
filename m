Return-Path: <John.Linn@xilinx.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 46773B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 23:33:26 +1000 (EST)
Received: from SG2EHSOBE002.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by ozlabs.org (Postfix) with ESMTP id F26EFDDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 23:33:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [V3] net: add Xilinx emac lite device driver
Date: Wed, 2 Sep 2009 07:33:18 -0600
In-Reply-To: <20090820094914.46f1db9c@nehalam>
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
	<20090820094914.46f1db9c@nehalam>
From: John Linn <John.Linn@xilinx.com>
To: "Stephen Hemminger" <shemminger@vyatta.com>
Message-ID: <20090902133245.5128E26804D@mail202-sin.bigfish.com>
Cc: Michal Simek <michal.simek@petalogix.com>, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, davem@davemloft.net,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@vyatta.com]
> Sent: Thursday, August 20, 2009 5:49 PM
> To: John Linn
> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
davem@davemloft.net; jgarzik@pobox.com; John
> Linn; grant.likely@secretlab.ca; Josh Boyer; John Williams; Michal
Simek; Sadanand Mutyala
> Subject: Re: [PATCH] [V3] net: add Xilinx emac lite device driver
> =

> On Thu, 20 Aug 2009 03:49:51 -0600
> John Linn <john.linn@xilinx.com> wrote:
> =

> > +/**
> > + * xemaclite_ioctl - Perform IO Control operations on the network
device
> > + * @dev:	Pointer to the network device
> > + * @rq:		Pointer to the interface request structure
> > + * @cmd:	IOCTL command
> > + *
> > + * The only IOCTL operation supported by this function is setting
the MAC
> > + * address. An error is reported if any other operations are
requested.
> > + *
> > + * Return:	0 to indicate success, or a negative error for failure.
> > + */
> > +static int xemaclite_ioctl(struct net_device *dev, struct ifreq
*rq, int cmd)
> > +{
> > +	struct net_local *lp =3D (struct net_local *) netdev_priv(dev);
> > +	struct hw_addr_data *hw_addr =3D (struct hw_addr_data *)
&rq->ifr_hwaddr;
> > +
> > +	switch (cmd) {
> > +	case SIOCETHTOOL:
> > +		return -EIO;
> > +
> > +	case SIOCSIFHWADDR:
> > +		dev_err(&lp->ndev->dev, "SIOCSIFHWADDR\n");
> > +
> > +		/* Copy MAC address in from user space */
> > +		copy_from_user((void __force *) dev->dev_addr,
> > +			       (void __user __force *) hw_addr,
> > +			       IFHWADDRLEN);
> > +		xemaclite_set_mac_address(lp, dev->dev_addr);
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> =

> Do you really need this? I doubt the SIOCSIFHWADDR even reaches
driver!
> =

> The normal call path for setting hardware address is:
>   dev_ifsioc
>          dev_set_mac_address
>              ops->ndo_set_mac_address -->
> =

> The driver should be:
>    1. defining new code to do ndo_set_mac_address
>    2. remove existing xmaclite_ioctl - all ioctl's handled by upper
layers
> =

> FYI - the only ioctl's that make it to network device ndo_ioctl
>  are listed in dev_ifsioc
>    SIOCDEVPRIVATE ... SIOCDEVPRIVATE + 15
>    SIOCBOND*
>    SIOCMII*
>    SIOCBR*
>    SIOCHWTSTAMP
>    SIOCWANDEV
> =

> =


We agree and will be updating the driver for this change. Sorry about
the delay as I was on vacation.

Thanks,
John


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
