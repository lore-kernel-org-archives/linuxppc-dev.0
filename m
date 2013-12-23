Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 920F72C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 21:16:29 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] ibmveth: Fix more little endian issues
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20131223173833.0a9a6705@kryten>
Date: Mon, 23 Dec 2013 11:17:47 +0100
Message-Id: <71EC0FB0-80C9-4133-A384-35D212ACE968@suse.de>
References: <1387762163-39662-1-git-send-email-agraf@suse.de>
 <20131223173833.0a9a6705@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: Dinar Valeev <dvaleev@suse.com>, Santiago Leon <santil@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 23.12.2013, at 07:38, Anton Blanchard <anton@samba.org> wrote:

>=20
> Hi Alex,
>=20
>> The ibmveth driver is memcpy()'ing the mac address between a variable
>> (register) and memory. This assumes a certain endianness of the
>> system, so let's make that implicit assumption work again.
>=20
> Nice catch! I don't like how the driver has two different methods
> for creating these MAC addresses, both without comments. How does
> this look?

Heh - I didn't even realize those two places were doing the same thing.

Obviously your patch is by far nicer.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex

>=20
> Anton
> --
>=20
> The hypervisor expects MAC addresses passed in registers to be big
> endian u64. Create a helper function called ibmveth_encode_mac_addr
> which does the right thing in both big and little endian.
>=20
> We were storing the MAC address in a long in struct ibmveth_adapter.
> It's never used so remove it - we don't need another place in the
> driver where we create endian issues with MAC addresses.
>=20
> Reported-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c =
b/drivers/net/ethernet/ibm/ibmveth.c
> index 952d795..044178b 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -523,6 +523,17 @@ retry:
> 	return rc;
> }
>=20
> +/*
> + * The hypervisor expects MAC addresses passed in registers to be
> + * big endian u64.
> + */
> +static unsigned long ibmveth_encode_mac_addr(char *mac)
> +{
> +	unsigned long encoded =3D 0;
> +	memcpy(((char *)&encoded) + 2, mac, ETH_ALEN);
> +	return cpu_to_be64(encoded);
> +}
> +
> static int ibmveth_open(struct net_device *netdev)
> {
> 	struct ibmveth_adapter *adapter =3D netdev_priv(netdev);
> @@ -580,8 +591,7 @@ static int ibmveth_open(struct net_device *netdev)
> 	adapter->rx_queue.num_slots =3D rxq_entries;
> 	adapter->rx_queue.toggle =3D 1;
>=20
> -	memcpy(&mac_address, netdev->dev_addr, netdev->addr_len);
> -	mac_address =3D mac_address >> 16;
> +	mac_address =3D ibmveth_encode_mac_addr(netdev->dev_addr);
>=20
> 	rxq_desc.fields.flags_len =3D IBMVETH_BUF_VALID |
> 					adapter->rx_queue.queue_len;
> @@ -1184,8 +1194,8 @@ static void ibmveth_set_multicast_list(struct =
net_device *netdev)
> 		/* add the addresses to the filter table */
> 		netdev_for_each_mc_addr(ha, netdev) {
> 			/* add the multicast address to the filter table =
*/
> -			unsigned long mcast_addr =3D 0;
> -			memcpy(((char *)&mcast_addr)+2, ha->addr, =
ETH_ALEN);
> +			unsigned long mcast_addr;
> +			mcast_addr =3D =
ibmveth_encode_mac_addr(ha->addr);
> 			lpar_rc =3D =
h_multicast_ctrl(adapter->vdev->unit_address,
> 						   =
IbmVethMcastAddFilter,
> 						   mcast_addr);
> @@ -1369,9 +1379,6 @@ static int ibmveth_probe(struct vio_dev *dev, =
const struct vio_device_id *id)
>=20
> 	netif_napi_add(netdev, &adapter->napi, ibmveth_poll, 16);
>=20
> -	adapter->mac_addr =3D 0;
> -	memcpy(&adapter->mac_addr, mac_addr_p, ETH_ALEN);
> -
> 	netdev->irq =3D dev->irq;
> 	netdev->netdev_ops =3D &ibmveth_netdev_ops;
> 	netdev->ethtool_ops =3D &netdev_ethtool_ops;
> @@ -1380,7 +1387,7 @@ static int ibmveth_probe(struct vio_dev *dev, =
const struct vio_device_id *id)
> 		NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> 	netdev->features |=3D netdev->hw_features;
>=20
> -	memcpy(netdev->dev_addr, &adapter->mac_addr, netdev->addr_len);
> +	memcpy(netdev->dev_addr, mac_addr_p, ETH_ALEN);
>=20
> 	for (i =3D 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
> 		struct kobject *kobj =3D &adapter->rx_buff_pool[i].kobj;
> diff --git a/drivers/net/ethernet/ibm/ibmveth.h =
b/drivers/net/ethernet/ibm/ibmveth.h
> index 84066ba..2c636cb 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.h
> +++ b/drivers/net/ethernet/ibm/ibmveth.h
> @@ -139,7 +139,6 @@ struct ibmveth_adapter {
>     struct napi_struct napi;
>     struct net_device_stats stats;
>     unsigned int mcastFilterSize;
> -    unsigned long mac_addr;
>     void * buffer_list_addr;
>     void * filter_list_addr;
>     dma_addr_t buffer_list_dma;
