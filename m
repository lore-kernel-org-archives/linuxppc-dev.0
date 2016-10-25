Return-Path: <jmaxwell37@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3Qzd2tZRzDvPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 08:20:29 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id e12so9368194oib.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 14:20:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161025103126.GW2948@localhost.localdomain>
References: <1477372421-11656-1-git-send-email-jmaxwell37@gmail.com>
 <20161025103126.GW2948@localhost.localdomain>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Wed, 26 Oct 2016 08:20:26 +1100
Message-ID: <CAGHK07Dtzr-o7zOAMA7ykiWXjHoY4+HFJwQoFmhgeh93SyexxA@mail.gmail.com>
Subject: Re: [PATCH net-next] ibmveth: calculate correct gso_size and set
 gso_type
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: tlfalcon@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, David Miller <davem@davemloft.net>,
 Tom Herbert <tom@herbertland.com>,
 jarod@redhat.com, hofrat@osadl.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> +     u16 hdr_len = ETH_HLEN + sizeof(struct tcphdr);

> Compiler may optmize this, but maybe move hdr_len to [*] ?>

There are other places in the stack where a u16 is used for the
same purpose. So I'll rather stick to that convention.

I'll make the other formatting changes you suggested and
resubmit as v1.

Thanks

Jon

On Tue, Oct 25, 2016 at 9:31 PM, Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
> On Tue, Oct 25, 2016 at 04:13:41PM +1100, Jon Maxwell wrote:
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
>>  drivers/net/ethernet/ibm/ibmveth.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
>> index 29c05d0..3028c33 100644
>> --- a/drivers/net/ethernet/ibm/ibmveth.c
>> +++ b/drivers/net/ethernet/ibm/ibmveth.c
>> @@ -1182,6 +1182,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>       int frames_processed = 0;
>>       unsigned long lpar_rc;
>>       struct iphdr *iph;
>> +     bool large_packet = 0;
>> +     u16 hdr_len = ETH_HLEN + sizeof(struct tcphdr);
>
> Compiler may optmize this, but maybe move hdr_len to [*] ?
>
>>
>>  restart_poll:
>>       while (frames_processed < budget) {
>> @@ -1236,10 +1238,27 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>>                                               iph->check = 0;
>>                                               iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
>>                                               adapter->rx_large_packets++;
>> +                                             large_packet = 1;
>>                                       }
>>                               }
>>                       }
>>
>> +                     if (skb->len > netdev->mtu) {
>
> [*]
>
>> +                             iph = (struct iphdr *)skb->data;
>> +                             if (be16_to_cpu(skb->protocol) == ETH_P_IP && iph->protocol == IPPROTO_TCP) {
>
> The if line above is too long, should be broken in two.
>
>> +                                     hdr_len += sizeof(struct iphdr);
>> +                                     skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
>> +                                     skb_shinfo(skb)->gso_size = netdev->mtu - hdr_len;
>> +                             } else if (be16_to_cpu(skb->protocol) == ETH_P_IPV6 &&
>> +                                     iph->protocol == IPPROTO_TCP) {
>                                         ^
> And this one should start 3 spaces later, right below be16_....
>
>   Marcelo
>
>> +                                     hdr_len += sizeof(struct ipv6hdr);
>> +                                     skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
>> +                                     skb_shinfo(skb)->gso_size = netdev->mtu - hdr_len;
>> +                             }
>> +                             if (!large_packet)
>> +                                     adapter->rx_large_packets++;
>> +                     }
>> +
>>                       napi_gro_receive(napi, skb);    /* send it up */
>>
>>                       netdev->stats.rx_packets++;
>> --
>> 1.8.3.1
>>
