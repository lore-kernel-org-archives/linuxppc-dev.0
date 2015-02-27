Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 646AF1A0052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 09:22:09 +1100 (AEDT)
Date: Fri, 27 Feb 2015 17:22:06 -0500 (EST)
Message-Id: <20150227.172206.206607639934597507.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Subject: Re: [PATCH] ibmveth: Add function to enable live MAC address changes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1424910864-32266-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1424910864-32266-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Wed, 25 Feb 2015 18:34:24 -0600

> Add a function that will enable changing the MAC address
> of an ibmveth interface while it is still running.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 21978cc..6e44357 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1327,6 +1327,24 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>  	return ret;
>  }
>  
> +static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
> +{
> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
> +	struct sockaddr *addr = p;
> +	u64 mac_address;
> +	int rc;
> +
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	ether_addr_copy(dev->dev_addr, addr->sa_data);
> +
> +	mac_address = ibmveth_encode_mac_addr(dev->dev_addr);
> +	rc = h_change_logical_lan_mac(adapter->vdev->unit_address, mac_address);

As others have said, if this hypervisor call fails you must not change
dev->dev_addr.  It must always be in sync with "the hardware."
