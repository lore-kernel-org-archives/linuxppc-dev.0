Return-Path: <shemminger@vyatta.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4E2E2B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 02:49:22 +1000 (EST)
Received: from mail.vyatta.com (mail.vyatta.com [76.74.103.46])
	by ozlabs.org (Postfix) with ESMTP id DE56FDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 02:49:21 +1000 (EST)
Date: Thu, 20 Aug 2009 09:49:14 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] [V3] net: add Xilinx emac lite device driver
Message-ID: <20090820094914.46f1db9c@nehalam>
In-Reply-To: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
References: <20090820094956.02DFC45004F@mail96-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michal Simek <michal.simek@petalogix.com>, netdev@vger.kernel.org,
	Sadanand M <sadanan@xilinx.com>, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	John Linn <john.linn@xilinx.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 20 Aug 2009 03:49:51 -0600
John Linn <john.linn@xilinx.com> wrote:

> +/**
> + * xemaclite_ioctl - Perform IO Control operations on the network device
> + * @dev:	Pointer to the network device
> + * @rq:		Pointer to the interface request structure
> + * @cmd:	IOCTL command
> + *
> + * The only IOCTL operation supported by this function is setting the MAC
> + * address. An error is reported if any other operations are requested.
> + *
> + * Return:	0 to indicate success, or a negative error for failure.
> + */
> +static int xemaclite_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> +{
> +	struct net_local *lp = (struct net_local *) netdev_priv(dev);
> +	struct hw_addr_data *hw_addr = (struct hw_addr_data *) &rq->ifr_hwaddr;
> +
> +	switch (cmd) {
> +	case SIOCETHTOOL:
> +		return -EIO;
> +
> +	case SIOCSIFHWADDR:
> +		dev_err(&lp->ndev->dev, "SIOCSIFHWADDR\n");
> +
> +		/* Copy MAC address in from user space */
> +		copy_from_user((void __force *) dev->dev_addr,
> +			       (void __user __force *) hw_addr,
> +			       IFHWADDRLEN);
> +		xemaclite_set_mac_address(lp, dev->dev_addr);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

Do you really need this? I doubt the SIOCSIFHWADDR even reaches driver!

The normal call path for setting hardware address is:
  dev_ifsioc
         dev_set_mac_address
             ops->ndo_set_mac_address --> 

The driver should be:
   1. defining new code to do ndo_set_mac_address
   2. remove existing xmaclite_ioctl - all ioctl's handled by upper layers

FYI - the only ioctl's that make it to network device ndo_ioctl
 are listed in dev_ifsioc
   SIOCDEVPRIVATE ... SIOCDEVPRIVATE + 15
   SIOCBOND*
   SIOCMII*
   SIOCBR*
   SIOCHWTSTAMP
   SIOCWANDEV
