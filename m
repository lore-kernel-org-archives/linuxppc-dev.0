Return-Path: <ragner.magalhaes@indt.org.br>
Received: from mgw-ext13.nokia.com (smtp.nokia.com [131.228.20.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B376DDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:56:21 +1000 (EST)
Message-ID: <469F8C80.7070302@indt.org.br>
Date: Thu, 19 Jul 2007 12:08:32 -0400
From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
MIME-Version: 1.0
To: ext Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] ibmveth: Implement ethtool hooks to enable/disable
	checksum offload
References: <1184860086366-patch-mail.ibm.com>
	<200707191548.l6JFmEYM020387@d03av04.boulder.ibm.com>
In-Reply-To: <200707191548.l6JFmEYM020387@d03av04.boulder.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	santil@linux.vnet.ibm.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ext Brian King wrote:

> +
> +static int ibmveth_set_rx_csum(struct net_device *dev, u32 data)
> +{
> +	struct ibmveth_adapter *adapter = dev->priv;
> +

Why do not to do

	if ((data && adapter->rx_csum) || (!data && !adapter->rx_csum))
		return 0;
less two lines.

> +	if (data && adapter->rx_csum)
> +		return 0;
> +	if (!data && !adapter->rx_csum)
> +		return 0;
> +
> +	return ibmveth_set_csum_offload(dev, data, ibmveth_set_rx_csum_flags);
> +}
> +
> +static int ibmveth_set_tx_csum(struct net_device *dev, u32 data)
> +{
> +	struct ibmveth_adapter *adapter = dev->priv;
> +	int rc = 0;
> +

here also, as above ...
> +	if (data && (dev->features & NETIF_F_IP_CSUM))
> +		return 0;
> +	if (!data && !(dev->features & NETIF_F_IP_CSUM))
> +		return 0;
> +
> +	if (data && !adapter->rx_csum)
> +		rc = ibmveth_set_csum_offload(dev, data, ibmveth_set_tx_csum_flags);
> +	else
> +		ibmveth_set_tx_csum_flags(dev, data);
> +
> +	return rc;
> +}
> +
Best regards,
Ragner
