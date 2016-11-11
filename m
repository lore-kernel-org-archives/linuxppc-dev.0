Return-Path: <brking@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFp632sd4zDvnj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 05:16:58 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uABIEisa037747
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 13:16:56 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26nfda8mnv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 13:16:56 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Fri, 11 Nov 2016 11:16:55 -0700
Subject: Re: [PATCH net-next] ibmveth: v1 calculate correct gso_size and set
 gso_type
To: Eric Dumazet <eric.dumazet@gmail.com>, Jon Maxwell <jmaxwell37@gmail.com>
References: <1477440555-21133-1-git-send-email-jmaxwell37@gmail.com>
 <1477582016.7065.212.camel@edumazet-glaptop3.roam.corp.google.com>
Cc: tlfalcon@linux.vnet.ibm.com, jmaxwell@redhat.com, hofrat@osadl.org,
 linux-kernel@vger.kernel.org, jarod@redhat.com, netdev@vger.kernel.org,
 paulus@samba.org, tom@herbertland.com, mleitner@redhat.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 11 Nov 2016 12:16:49 -0600
MIME-Version: 1.0
In-Reply-To: <1477582016.7065.212.camel@edumazet-glaptop3.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <639034ef-530f-2ce1-4739-c3ea8f6a61df@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/27/2016 10:26 AM, Eric Dumazet wrote:
> On Wed, 2016-10-26 at 11:09 +1100, Jon Maxwell wrote:
>> We recently encountered a bug where a few customers using ibmveth on the 
>> same LPAR hit an issue where a TCP session hung when large receive was
>> enabled. Closer analysis revealed that the session was stuck because the 
>> one side was advertising a zero window repeatedly.
>>
>> We narrowed this down to the fact the ibmveth driver did not set gso_size 
>> which is translated by TCP into the MSS later up the stack. The MSS is 
>> used to calculate the TCP window size and as that was abnormally large, 
>> it was calculating a zero window, even although the sockets receive buffer 
>> was completely empty. 
>>
>> We were able to reproduce this and worked with IBM to fix this. Thanks Tom 
>> and Marcelo for all your help and review on this.
>>
>> The patch fixes both our internal reproduction tests and our customers tests.
>>
>> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>> ---
>>  drivers/net/ethernet/ibm/ibmveth.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 29c05d0..c51717e 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1182,6 +1182,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>  	int frames_processed = 0;
>>  	unsigned long lpar_rc;
>>  	struct iphdr *iph;
>> +	bool large_packet = 0;
>> +	u16 hdr_len = ETH_HLEN + sizeof(struct tcphdr);
>>  
>>  restart_poll:
>>  	while (frames_processed < budget) {
>> @@ -1236,10 +1238,28 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>  						iph->check = 0;
>>  						iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
>>  						adapter->rx_large_packets++;
>> +						large_packet = 1;
>>  					}
>>  				}
>>  			}
>>  
>> +			if (skb->len > netdev->mtu) {
>> +				iph = (struct iphdr *)skb->data;
>> +				if (be16_to_cpu(skb->protocol) == ETH_P_IP &&
>> +				    iph->protocol == IPPROTO_TCP) {
>> +					hdr_len += sizeof(struct iphdr);
>> +					skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
>> +					skb_shinfo(skb)->gso_size = netdev->mtu - hdr_len;
>> +				} else if (be16_to_cpu(skb->protocol) == ETH_P_IPV6 &&
>> +					   iph->protocol == IPPROTO_TCP) {
>> +					hdr_len += sizeof(struct ipv6hdr);
>> +					skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
>> +					skb_shinfo(skb)->gso_size = netdev->mtu - hdr_len;
>> +				}
>> +				if (!large_packet)
>> +					adapter->rx_large_packets++;
>> +			}
>> +
>>  
> 
> This might break forwarding and PMTU discovery.
> 
> You force gso_size to device mtu, regardless of real MSS used by the TCP
> sender.
> 
> Don't you have the MSS provided in RX descriptor, instead of guessing
> the value ?

Eric,

We are currently pursuing making changes to the Power Virtual I/O Server to provide
the MSS to the ibmveth driver. However, this will take time to go through test
and ultimately get released. Although imperfect, this patch does help a real customer
hitting this issue right now. Would you object to this patch getting merged as is,
with the understanding that when we get the change in the Virtual I/O Server released,
we will revert this interim change and apply the new method?

Thanks,

Brian


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
