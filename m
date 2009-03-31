Return-Path: <shemminger@vyatta.com>
Received: from mail.vyatta.com (mail.vyatta.com [76.74.103.46])
	by ozlabs.org (Postfix) with ESMTP id CA23FDDEE9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 01:56:33 +1100 (EST)
Date: Tue, 31 Mar 2009 07:48:06 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
To: Henk Stegeman <henk.stegeman@gmail.com>
Subject: Re: Patch: Fix fec_mpc52xx driver to use net_device_ops
Message-ID: <20090331074806.432a882a@nehalam>
In-Reply-To: <ae4f76fd0903310344s2d46edf2l505a1d21a4778d54@mail.gmail.com>
References: <ae4f76fd0903310344s2d46edf2l505a1d21a4778d54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 31 Mar 2009 12:44:15 +0200
Henk Stegeman <henk.stegeman@gmail.com> wrote:

> Fix fec_mpc52xx driver to use net_device_ops and to be careful not to
> dereference phy_device if a phy has not yet been connected.
> 
> Signed-off-by: Henk Stegeman <henk.stegeman@gmail.com>
> 
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index cd8e98b..ca76b95 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -847,24 +847,40 @@ static void mpc52xx_fec_get_drvinfo(struct
> net_device *dev,
>  static int mpc52xx_fec_get_settings(struct net_device *dev, struct
> ethtool_cmd *cmd)
>  {
>  	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
> +
> +	if (!priv->phydev)
> +			return -ENODEV;
> +
>  	return phy_ethtool_gset(priv->phydev, cmd);
>  }
> 
>  static int mpc52xx_fec_set_settings(struct net_device *dev, struct
> ethtool_cmd *cmd)
>  {
>  	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
> +
> +	if (!priv->phydev)
> +			return -ENODEV;
> +
>  	return phy_ethtool_sset(priv->phydev, cmd);
>  }
> 
>  static u32 mpc52xx_fec_get_msglevel(struct net_device *dev)
>  {
>  	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
> +
> +	if (!priv->phydev)
> +		return 0;
> +
>  	return priv->msg_enable;
>  }
> 
>  static void mpc52xx_fec_set_msglevel(struct net_device *dev, u32 level)
>  {
>  	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
> +
> +	if (!priv->phydev)
> +			return;
> +
>  	priv->msg_enable = level;
>  }
> 
> @@ -882,12 +898,31 @@ static int mpc52xx_fec_ioctl(struct net_device
> *dev, struct ifreq *rq, int cmd)
>  {
>  	struct mpc52xx_fec_priv *priv = netdev_priv(dev);
> 
> +	if (!priv->phydev)
> +			return -ENODEV;
> +
>  	return mpc52xx_fec_phy_mii_ioctl(priv, if_mii(rq), cmd);
>  }
> 
>  /* ======================================================================== */
>  /* OF Driver                                                                */
>  /* ======================================================================== */
> +static const struct net_device_ops mpc52xx_fec_netdev_ops = {
> +       .ndo_open               = mpc52xx_fec_open,
> +       .ndo_stop               = mpc52xx_fec_close,
> +       .ndo_start_xmit         = mpc52xx_fec_hard_start_xmit,
> +       .ndo_tx_timeout         = mpc52xx_fec_tx_timeout,
> +       .ndo_get_stats          = mpc52xx_fec_get_stats,
> +       .ndo_set_multicast_list = mpc52xx_fec_set_multicast_list,
> +       .ndo_validate_addr      = eth_validate_addr,
> +       .ndo_set_mac_address    = mpc52xx_fec_set_mac_address,
> +       .ndo_do_ioctl           = mpc52xx_fec_ioctl,
> 
What about change_mtu? Don't you want:
          .ndo_change_mtu         = eth_change_mtu,
