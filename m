Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 992031A0D1E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 09:12:57 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 23 Apr 2015 17:12:55 -0600
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6C0EF6E8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 19:04:40 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3NNCp9p63766664
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 23:12:51 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3NNCoZn013479
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 19:12:50 -0400
Message-ID: <55397C70.2060209@linux.vnet.ibm.com>
Date: Thu, 23 Apr 2015 16:12:48 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, anton@au1.ibm.com
Subject: Re: [PATCHv2] ibmveth: Fix off-by-one error in ibmveth_change_mtu()
References: <1429578471-9717-1-git-send-email-david@gibson.dropbear.id.au>
 <553815CD.1000407@linux.vnet.ibm.com>
In-Reply-To: <553815CD.1000407@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2015 02:42 PM, Thomas Falcon wrote:
> On 04/20/2015 08:07 PM, David Gibson wrote:
>> AFAIK the PAPR document which defines the virtual device interface used by
>> the ibmveth driver doesn't specify a specific maximum MTU.  So, in the

PAPR itself doesn't, but the max-frame-size property, which I understand
to be synonymous with max MTU, is required by PAPR to be present in the
Logical LAN OF node corresponding to the ibmveth device.

-Tyrel

>> ibmveth driver, the maximum allowed MTU is determined by the maximum
>> allocated buffer size of 64k (corresponding to one page in the common case)
>> minus the per-buffer overhead IBMVETH_BUFF_OH (which has value 22 for 14
>> bytes of ethernet header, plus 8 bytes for an opaque handle).
>>
>> This suggests a maximum allowable MTU of 65514 bytes, but in fact the
>> driver only permits a maximum MTU of 65513.  This is because there is a <
>> instead of an <= in ibmveth_change_mtu(), which only permits an MTU which
>> is strictly smaller than the buffer size, rather than allowing the buffer
>> to be completely filled.
>>
>> This patch fixes the buglet.
> 
> Thanks!
> 
> Acked-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> 
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>1
>> ---
>>  drivers/net/ethernet/ibm/ibmveth.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Changes since v1:
>>  * Fixed a second instance of the same off-by-one error.  Thanks to
>>    Thomas Falcon for spotting this.
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index cd7675a..1813476 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1238,7 +1238,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>>  		return -EINVAL;
>>  
>>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++)
>> -		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size)
>> +		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size)
>>  			break;
>>  
>>  	if (i == IBMVETH_NUM_BUFF_POOLS)
>> @@ -1257,7 +1257,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
>>  	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
>>  		adapter->rx_buff_pool[i].active = 1;
>>  
>> -		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size) {
>> +		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
>>  			dev->mtu = new_mtu;
>>  			vio_cmo_set_dev_desired(viodev,
>>  						ibmveth_get_desired_dma
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
