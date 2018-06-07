Return-Path: <madalin.bucur@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0075.outbound.protection.outlook.com [104.47.0.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411dqj4TJLzF32G
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 18:24:08 +1000 (AEST)
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: "Y.b. Lu" <yangbo.lu@nxp.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "David S .
 Miller" <davem@davemloft.net>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Y.b. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v2, 09/10] dpaa_eth: add support for hardware timestamping
Date: Thu, 7 Jun 2018 08:24:01 +0000
Message-ID: <AM6PR04MB40080865F823C7C57716818FEC640@AM6PR04MB4008.eurprd04.prod.outlook.com>
References: <20180607032256.39802-1-yangbo.lu@nxp.com>
 <20180607032256.39802-10-yangbo.lu@nxp.com>
In-Reply-To: <20180607032256.39802-10-yangbo.lu@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> Sent: Thursday, June 7, 2018 6:23 AM
> Subject: [v2, 09/10] dpaa_eth: add support for hardware timestamping
>=20
> This patch is to add hardware timestamping support
> for dpaa_eth. On Rx, timestamping is enabled for
> all frames. On Tx, we only instruct the hardware
> to timestamp the frames marked accordingly by the
> stack.
>=20
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Removed ifdef for timestamp code.
> 	- Minor fixes for code style.
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  101
> ++++++++++++++++++++++-
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.h |    3 +
>  2 files changed, 99 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index fd43f98..bd589ac 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -1168,7 +1168,7 @@ static int dpaa_eth_init_tx_port(struct fman_port
> *port, struct dpaa_fq *errq,
>  	buf_prefix_content.priv_data_size =3D buf_layout->priv_data_size;
>  	buf_prefix_content.pass_prs_result =3D true;
>  	buf_prefix_content.pass_hash_result =3D true;
> -	buf_prefix_content.pass_time_stamp =3D false;
> +	buf_prefix_content.pass_time_stamp =3D true;
>  	buf_prefix_content.data_align =3D DPAA_FD_DATA_ALIGNMENT;
>=20
>  	params.specific_params.non_rx_params.err_fqid =3D errq->fqid;
> @@ -1210,7 +1210,7 @@ static int dpaa_eth_init_rx_port(struct fman_port
> *port, struct dpaa_bp **bps,
>  	buf_prefix_content.priv_data_size =3D buf_layout->priv_data_size;
>  	buf_prefix_content.pass_prs_result =3D true;
>  	buf_prefix_content.pass_hash_result =3D true;
> -	buf_prefix_content.pass_time_stamp =3D false;
> +	buf_prefix_content.pass_time_stamp =3D true;
>  	buf_prefix_content.data_align =3D DPAA_FD_DATA_ALIGNMENT;
>=20
>  	rx_p =3D &params.specific_params.rx_params;
> @@ -1592,6 +1592,16 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv
> *priv)
>  	return 0;
>  }
>=20
> +static int dpaa_get_tstamp_ns(struct net_device *net_dev, u64 *ns,
> +			      struct fman_port *port, const void *data)
> +{
> +	if (!fman_port_get_tstamp_field(port, data, ns)) {
> +		be64_to_cpus(ns);

Please move this endianness conversion in the fman API.

> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  /* Cleanup function for outgoing frame descriptors that were built on Tx
> path,
>   * either contiguous frames or scatter/gather ones.
>   * Skb freeing is not handled here.
> @@ -1607,14 +1617,29 @@ static int dpaa_eth_refill_bpools(struct dpaa_pri=
v
> *priv)
>  {
>  	const enum dma_data_direction dma_dir =3D DMA_TO_DEVICE;
>  	struct device *dev =3D priv->net_dev->dev.parent;
> +	struct skb_shared_hwtstamps shhwtstamps;
>  	dma_addr_t addr =3D qm_fd_addr(fd);
>  	const struct qm_sg_entry *sgt;
>  	struct sk_buff **skbh, *skb;
>  	int nr_frags, i;
> +	u64 ns;
>=20
>  	skbh =3D (struct sk_buff **)phys_to_virt(addr);
>  	skb =3D *skbh;
>=20
> +	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags &
> SKBTX_HW_TSTAMP) {
> +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> +
> +		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
> +					priv->mac_dev->port[TX],
> +					(void *)skbh)) {
> +			shhwtstamps.hwtstamp =3D ns_to_ktime(ns);
> +			skb_tstamp_tx(skb, &shhwtstamps);
> +		} else {
> +			dev_warn(dev, "dpaa_get_tstamp_ns failed!\n");
> +		}
> +	}
> +
>  	if (unlikely(qm_fd_get_format(fd) =3D=3D qm_fd_sg)) {
>  		nr_frags =3D skb_shinfo(skb)->nr_frags;
>  		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) +
> @@ -2086,6 +2111,11 @@ static int dpaa_start_xmit(struct sk_buff *skb,
> struct net_device *net_dev)
>  	if (unlikely(err < 0))
>  		goto skb_to_fd_failed;
>=20
> +	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags &
> SKBTX_HW_TSTAMP) {
> +		fd.cmd |=3D FM_FD_CMD_UPD;

The fd.cmd field is big endian, please use this:

+		fd.cmd |=3D cpu_to_be32(FM_FD_CMD_UPD);

> +		skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> +	}
> +
>  	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) =3D=3D 0))
>  		return NETDEV_TX_OK;
>=20
> @@ -2227,6 +2257,7 @@ static enum qman_cb_dqrr_result
> rx_default_dqrr(struct qman_portal *portal,
>  						struct qman_fq *fq,
>  						const struct qm_dqrr_entry
> *dq)
>  {
> +	struct skb_shared_hwtstamps *shhwtstamps;
>  	struct rtnl_link_stats64 *percpu_stats;
>  	struct dpaa_percpu_priv *percpu_priv;
>  	const struct qm_fd *fd =3D &dq->fd;
> @@ -2240,6 +2271,7 @@ static enum qman_cb_dqrr_result
> rx_default_dqrr(struct qman_portal *portal,
>  	struct sk_buff *skb;
>  	int *count_ptr;
>  	void *vaddr;
> +	u64 ns;
>=20
>  	fd_status =3D be32_to_cpu(fd->status);
>  	fd_format =3D qm_fd_get_format(fd);
> @@ -2304,6 +2336,18 @@ static enum qman_cb_dqrr_result
> rx_default_dqrr(struct qman_portal *portal,
>  	if (!skb)
>  		return qman_cb_dqrr_consume;
>=20
> +	if (priv->rx_tstamp) {
> +		shhwtstamps =3D skb_hwtstamps(skb);
> +		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
> +
> +		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
> +					priv->mac_dev->port[RX],
> +					vaddr))
> +			shhwtstamps->hwtstamp =3D ns_to_ktime(ns);
> +		else
> +			dev_warn(net_dev->dev.parent,
> "dpaa_get_tstamp_ns failed!\n");
> +	}
> +
>  	skb->protocol =3D eth_type_trans(skb, net_dev);
>=20
>  	if (net_dev->features & NETIF_F_RXHASH && priv->keygen_in_use
> &&
> @@ -2523,11 +2567,58 @@ static int dpaa_eth_stop(struct net_device
> *net_dev)
>  	return err;
>  }
>=20
> +static int dpaa_ts_ioctl(struct net_device *dev, struct ifreq *rq, int c=
md)
> +{
> +	struct dpaa_priv *priv =3D netdev_priv(dev);
> +	struct hwtstamp_config config;
> +
> +	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
> +		return -EFAULT;
> +
> +	switch (config.tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		/* Couldn't disable rx/tx timestamping separately.
> +		 * Do nothing here.
> +		 */
> +		priv->tx_tstamp =3D false;
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		priv->mac_dev->set_tstamp(priv->mac_dev->fman_mac,
> true);
> +		priv->tx_tstamp =3D true;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	if (config.rx_filter =3D=3D HWTSTAMP_FILTER_NONE) {
> +		/* Couldn't disable rx/tx timestamping separately.
> +		 * Do nothing here.
> +		 */
> +		priv->rx_tstamp =3D false;
> +	} else {
> +		priv->mac_dev->set_tstamp(priv->mac_dev->fman_mac,
> true);
> +		priv->rx_tstamp =3D true;
> +		/* TS is set for all frame types, not only those requested */
> +		config.rx_filter =3D HWTSTAMP_FILTER_ALL;
> +	}
> +
> +	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
> +			-EFAULT : 0;
> +}
> +
>  static int dpaa_ioctl(struct net_device *net_dev, struct ifreq *rq, int =
cmd)
>  {
> -	if (!net_dev->phydev)
> -		return -EINVAL;
> -	return phy_mii_ioctl(net_dev->phydev, rq, cmd);
> +	int ret =3D -EINVAL;
> +
> +	if (cmd =3D=3D SIOCGMIIREG) {
> +		if (net_dev->phydev)
> +			return phy_mii_ioctl(net_dev->phydev, rq, cmd);
> +	}
> +
> +	if (cmd =3D=3D SIOCSHWTSTAMP)
> +		return dpaa_ts_ioctl(net_dev, rq, cmd);
> +
> +	return ret;
>  }
>=20
>  static const struct net_device_ops dpaa_ops =3D {
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> index bd94220..af320f8 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> @@ -182,6 +182,9 @@ struct dpaa_priv {
>=20
>  	struct dpaa_buffer_layout buf_layout[2];
>  	u16 rx_headroom;
> +
> +	bool tx_tstamp; /* Tx timestamping enabled */
> +	bool rx_tstamp; /* Rx timestamping enabled */
>  };
>=20
>  /* from dpaa_ethtool.c */
> --
> 1.7.1
