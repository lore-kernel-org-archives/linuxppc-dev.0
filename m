Return-Path: <brking@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F007DDDE42
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 08:07:18 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l77M7E4S017602
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 18:07:14 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l77M7DBI552684
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 18:07:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l77M7DBX027479
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 18:07:13 -0400
Message-ID: <46B8ED10.1060701@linux.vnet.ibm.com>
Date: Tue, 07 Aug 2007 17:07:12 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/6] ibmveth: Implement ethtool hooks to enable/disable
	checksum offload
References: <11864293333377-patch-mail.ibm.com>
	<200708061942.l76JgLrU009242@d01av04.pok.ibm.com>
	<46B8E891.80403@garzik.org>
In-Reply-To: <46B8E891.80403@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, rcjenn@linux.vnet.ibm.com,
	santil@linux.vnet.ibm.com, netdev@vger.kernel.org
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Garzik wrote:
> Brian King wrote:
>> This patch adds the appropriate ethtool hooks to allow for enabling/disabling
>> of hypervisor assisted checksum offload for TCP.
>>
>> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
>> ---
>>
>>  linux-2.6-bjking1/drivers/net/ibmveth.c |  118 +++++++++++++++++++++++++++++++-
>>  linux-2.6-bjking1/drivers/net/ibmveth.h |    1 
>>  2 files changed, 117 insertions(+), 2 deletions(-)
>>
>> diff -puN drivers/net/ibmveth.c~ibmveth_csum_offload_ethtool drivers/net/ibmveth.c
>> --- linux-2.6/drivers/net/ibmveth.c~ibmveth_csum_offload_ethtool	2007-08-01 14:55:14.000000000 -0500
>> +++ linux-2.6-bjking1/drivers/net/ibmveth.c	2007-08-01 14:55:14.000000000 -0500
>> @@ -641,12 +641,125 @@ static u32 netdev_get_link(struct net_de
>>  	return 1;
>>  }
>>  
>> +static void ibmveth_set_rx_csum_flags(struct net_device *dev, u32 data)
>> +{
>> +	struct ibmveth_adapter *adapter = dev->priv;
>> +
>> +	if (data)
>> +		adapter->rx_csum = 1;
>> +	else {
>> +		adapter->rx_csum = 0;
>> +		dev->features &= ~NETIF_F_IP_CSUM;
> 
> why does this RX-related code clear a TX-related flag?

Its related to how the pSeries firmware works. The firmware provides an interface
to enable "checksum offload", which means both tx and rx checksum offload from
the firmware's point of view. The firmware does not support enabling checksum
offload for only rx. If I disable it for rx I have to disable it for tx as
well, otherwise the firmware will reject all future tx buffers I throw at it
that are not checksummed.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
