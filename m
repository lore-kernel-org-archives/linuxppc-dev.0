Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4W2r1kzJzDsyP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 02:27:00 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i85so2937485pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 08:27:00 -0700 (PDT)
Message-ID: <1477582016.7065.212.camel@edumazet-glaptop3.roam.corp.google.com>
Subject: Re: [PATCH net-next] ibmveth: v1 calculate correct gso_size and set
 gso_type
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Jon Maxwell <jmaxwell37@gmail.com>
Cc: tlfalcon@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, davem@davemloft.net, tom@herbertland.com,
 jarod@redhat.com,  hofrat@osadl.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 mleitner@redhat.com, jmaxwell@redhat.com
Date: Thu, 27 Oct 2016 08:26:56 -0700
In-Reply-To: <1477440555-21133-1-git-send-email-jmaxwell37@gmail.com>
References: <1477440555-21133-1-git-send-email-jmaxwell37@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-26 at 11:09 +1100, Jon Maxwell wrote:
> We recently encountered a bug where a few customers using ibmveth on the 
> same LPAR hit an issue where a TCP session hung when large receive was
> enabled. Closer analysis revealed that the session was stuck because the 
> one side was advertising a zero window repeatedly.
> 
> We narrowed this down to the fact the ibmveth driver did not set gso_size 
> which is translated by TCP into the MSS later up the stack. The MSS is 
> used to calculate the TCP window size and as that was abnormally large, 
> it was calculating a zero window, even although the sockets receive buffer 
> was completely empty. 
> 
> We were able to reproduce this and worked with IBM to fix this. Thanks Tom 
> and Marcelo for all your help and review on this.
> 
> The patch fixes both our internal reproduction tests and our customers tests.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 29c05d0..c51717e 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1182,6 +1182,8 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	int frames_processed = 0;
>  	unsigned long lpar_rc;
>  	struct iphdr *iph;
> +	bool large_packet = 0;
> +	u16 hdr_len = ETH_HLEN + sizeof(struct tcphdr);
>  
>  restart_poll:
>  	while (frames_processed < budget) {
> @@ -1236,10 +1238,28 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  						iph->check = 0;
>  						iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
>  						adapter->rx_large_packets++;
> +						large_packet = 1;
>  					}
>  				}
>  			}
>  
> +			if (skb->len > netdev->mtu) {
> +				iph = (struct iphdr *)skb->data;
> +				if (be16_to_cpu(skb->protocol) == ETH_P_IP &&
> +				    iph->protocol == IPPROTO_TCP) {
> +					hdr_len += sizeof(struct iphdr);
> +					skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
> +					skb_shinfo(skb)->gso_size = netdev->mtu - hdr_len;
> +				} else if (be16_to_cpu(skb->protocol) == ETH_P_IPV6 &&
> +					   iph->protocol == IPPROTO_TCP) {
> +					hdr_len += sizeof(struct ipv6hdr);
> +					skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
> +					skb_shinfo(skb)->gso_size = netdev->mtu - hdr_len;
> +				}
> +				if (!large_packet)
> +					adapter->rx_large_packets++;
> +			}
> +
>  

This might break forwarding and PMTU discovery.

You force gso_size to device mtu, regardless of real MSS used by the TCP
sender.

Don't you have the MSS provided in RX descriptor, instead of guessing
the value ?
