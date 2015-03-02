Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F9E41A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 04:53:43 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Mon, 2 Mar 2015 10:53:41 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 04EAD19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 10:44:46 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t22HrTBv53870676
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 10:53:37 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t22Hr47p004923
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 10:53:04 -0700
Message-ID: <54F4A366.90005@linux.vnet.ibm.com>
Date: Mon, 02 Mar 2015 11:52:38 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCHi v2] ibmveth: Add function to enable live MAC address
 changes
References: <1425102964-3131-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <20150228085932.GA2012@nanopsycho.orion>
In-Reply-To: <20150228085932.GA2012@nanopsycho.orion>
Content-Type: text/plain; charset=windows-1252
Cc: brking@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/28/2015 02:59 AM, Jiri Pirko wrote:
> Sat, Feb 28, 2015 at 06:56:04AM CET, tlfalcon@linux.vnet.ibm.com wrote:
>> Add a function that will enable changing the MAC address
>> of an ibmveth interface while it is still running.
>>
>> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
>> ---
>> v2:
>>   If h_change_logical_lan_mac fails, dev->dev_addr will not be changed.
>>
>> drivers/net/ethernet/ibm/ibmveth.c | 25 ++++++++++++++++++++++++-
>> 1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 21978cc..b6ac676 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1327,6 +1327,29 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
>> 	return ret;
>> }
>>
>> +static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
>> +{
>> +	struct ibmveth_adapter *adapter = netdev_priv(dev);
>> +	struct sockaddr *addr = p;
>> +	u64 mac_address;
>> +	int rc;
>> +
>> +	if (!is_valid_ether_addr(addr->sa_data))
>> +		return -EADDRNOTAVAIL;
>> +
>> +	mac_address = ibmveth_encode_mac_addr(addr->sa_data);
>> +	rc = h_change_logical_lan_mac(adapter->vdev->unit_address, mac_address);
>> +	if (rc) {
>> +		netdev_err(adapter->netdev, "h_change_logical_lan_mac failed "
>> +			   "with rc=%d\n", rc);
> Please do not wrap text in message. For that, 80-char limit does not apply.

I will send a new patch fixing this shortly.  Thanks to you, Brian, and Dave for reviewing this patch.

>
>
>> +		return rc;
>> +	}
>> +
>> +	ether_addr_copy(dev->dev_addr, addr->sa_data);
>> +
>> +	return 0;
>> +}
>> +
>> static const struct net_device_ops ibmveth_netdev_ops = {
>> 	.ndo_open		= ibmveth_open,
>> 	.ndo_stop		= ibmveth_close,
>> @@ -1337,7 +1360,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
>> 	.ndo_fix_features	= ibmveth_fix_features,
>> 	.ndo_set_features	= ibmveth_set_features,
>> 	.ndo_validate_addr	= eth_validate_addr,
>> -	.ndo_set_mac_address	= eth_mac_addr,
>> +	.ndo_set_mac_address    = ibmveth_set_mac_addr,
>> #ifdef CONFIG_NET_POLL_CONTROLLER
>> 	.ndo_poll_controller	= ibmveth_poll_controller,
>> #endif
>> -- 
>> 1.8.3.1
>>
