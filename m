Return-Path: <ragner.magalhaes@indt.org.br>
Received: from mgw-ext12.nokia.com (smtp.nokia.com [131.228.20.171])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.nokia.com",
	Issuer "VeriSign Trust Network" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 403C5DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 04:17:59 +1000 (EST)
Message-ID: <469FAA9F.9010207@indt.org.br>
Date: Thu, 19 Jul 2007 14:17:03 -0400
From: Ragner Magalhaes <ragner.magalhaes@indt.org.br>
MIME-Version: 1.0
To: brking@linux.vnet.ibm.com
Subject: Re: [PATCH 2/4] ibmveth: Implement ethtool hooks to enable/disable
	checksum offload
References: <1184860086366-patch-mail.ibm.com>
	<200707191548.l6JFmEYM020387@d03av04.boulder.ibm.com>
	<469F8C80.7070302@indt.org.br>
	<469FA68F.9070607@linux.vnet.ibm.com>
In-Reply-To: <469FA68F.9070607@linux.vnet.ibm.com>
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
> Ragner Magalhaes wrote:
>> ext Brian King wrote:
>>
>>> +
>>> +static int ibmveth_set_rx_csum(struct net_device *dev, u32 data)
>>> +{
>>> +	struct ibmveth_adapter *adapter = dev->priv;
>>> +
>> Why do not to do
>>
>> 	if ((data && adapter->rx_csum) || (!data && !adapter->rx_csum))
>> 		return 0;
>> less two lines.
> 
> Ok.
> 
>> here also, as above ...
>>> +	if (data && (dev->features & NETIF_F_IP_CSUM))
>>> +		return 0;
>>> +	if (!data && !(dev->features & NETIF_F_IP_CSUM))
>>> +		return 0;
> 
> This change would make the line > 80 columns, which I prefer to avoid.
> Updated patch attached which addresses the first comment.
I think would not be ugly to make.

	if ((data && (dev->features & NETIF_F_IP_CSUM)) ||
		(!data && !(dev->features & NETIF_F_IP_CSUM)))
		return 0;

> 
> Thanks,
> 
> Brian
> 
> ---

Thanks,

Ragner
