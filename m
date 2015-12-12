Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 72A1D1A1053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Dec 2015 11:54:05 +1100 (AEDT)
Date: Fri, 11 Dec 2015 19:53:58 -0500 (EST)
Message-Id: <20151211.195358.1764064794354600517.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, brking@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, nguyendo@us.ibm.com, formosa@us.ibm.com,
 linuxppc-dev@lists.ozlabs.org, jallen@linux.vnet.ibm.com
Subject: Re: [PATCH net-next v2] Driver for IBM System i/p VNIC protocol
From: David Miller <davem@davemloft.net>
In-Reply-To: <1449597139-8338-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1449597139-8338-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Tue,  8 Dec 2015 11:52:19 -0600

> +static long h_reg_sub_crq(unsigned long unit_address, unsigned long token,
> +			  unsigned long length, unsigned long *number,
> +			  unsigned long *irq)
> +{
> +	long rc;
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];

Please declare local variables from longest to shortest line, otherwise
known as "reverse christmas tree" order.

Audit this in your entire driver.

> +	pool->rx_buff = kcalloc(pool->size, sizeof(struct ibmvnic_rx_buff),
> +				GFP_KERNEL);

Allocation failures not checked until much later in this function, where
several other resources have been allocated meanwhile.  That doesn't
make any sense at all.

> +	adapter->closing = 1;

Please use type 'bool' and values 'true' and 'false' for boolean
values.

Audit this in your entire driver.

> +	if (ip_hdr(skb)->version == 4)
> +		tx_crq.v1.flags1 |= IBMVNIC_TX_PROT_IPV4;
> +	else if (ip_hdr(skb)->version == 6)
> +		tx_crq.v1.flags1 |= IBMVNIC_TX_PROT_IPV6;
> +

You cannot dereference the protocol header of the SKB without
first checking the skb->protocol value, otherwise you're looking
at garbage.

> +static int ibmvnic_set_mac(struct net_device *netdev, void *p)
> +{
> +	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
> +	struct sockaddr *addr = p;
> +	union ibmvnic_crq crq;
> +
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
> +	memset(&crq, 0, sizeof(crq));
> +	crq.change_mac_addr.first = IBMVNIC_CRQ_CMD;
> +	crq.change_mac_addr.cmd = CHANGE_MAC_ADDR;
> +	ether_addr_copy(&crq.change_mac_addr.mac_addr[0], addr->sa_data);
> +	ibmvnic_send_crq(adapter, &crq);
> +
> +	return 0;
> +}

You are responsible for copying the new MAC address into dev->dev_addr
on success.

> +static int ibmvnic_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
> +			     int cmd)
> +{
 ...
> +	return 0;
> +}
> +
> +static int ibmvnic_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +{
> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +	case SIOCGMIIREG:
> +	case SIOCSMIIREG:
> +		return ibmvnic_mii_ioctl(netdev, ifr, cmd);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

This really doesn't make any sense.  Please just delete this.  You
don't support MII reads or writes because they logically don't make
sense on this device.

> +static struct net_device_stats *ibmvnic_get_stats(struct net_device *dev)
> +{
> +	struct ibmvnic_adapter *adapter = netdev_priv(dev);
> +
> +	/* only return the current stats */
> +	return &adapter->net_stats;
> +}

The default method does this for you as long as you properly use
net_device's embedded stats, therefore you don't need to provide this
at all.

That's all I have any energy for, and as you can see nobody else wants
to even try to review this driver.

It's going to take a lot of respins and time before this driver is
ready for upstream inclusion.
