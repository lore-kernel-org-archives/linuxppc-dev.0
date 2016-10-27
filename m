Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4V6s1dtZzDskb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 01:45:24 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9REjLpo032749
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:45:22 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bkghgj42-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 10:45:21 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Thu, 27 Oct 2016 10:44:37 -0400
Subject: Re: [PATCH net-next] ibmveth: v1 calculate correct gso_size and set
 gso_type
To: Jon Maxwell <jmaxwell37@gmail.com>
References: <1477440555-21133-1-git-send-email-jmaxwell37@gmail.com>
Cc: jmaxwell@redhat.com, hofrat@osadl.org, linux-kernel@vger.kernel.org,
 jarod@redhat.com, netdev@vger.kernel.org, paulus@samba.org,
 tom@herbertland.com, mleitner@redhat.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Thu, 27 Oct 2016 09:44:30 -0500
MIME-Version: 1.0
In-Reply-To: <1477440555-21133-1-git-send-email-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <10c6ca2b-eb57-2f56-d62c-968dd2d93a9f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/25/2016 07:09 PM, Jon Maxwell wrote:
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
Thanks, Jon.

Acked-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

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
>  			napi_gro_receive(napi, skb);	/* send it up */
>
>  			netdev->stats.rx_packets++;
