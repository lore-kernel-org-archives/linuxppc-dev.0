Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 137221A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 08:00:26 +1000 (AEST)
Received: by iecrt8 with SMTP id rt8so14362269iec.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:00:23 -0700 (PDT)
Message-ID: <1429048822.7346.53.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [PATCH 4/5] ibmveth: Add support for Large Receive Offload
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Tue, 14 Apr 2015 15:00:22 -0700
In-Reply-To: <1429043704-22552-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1429043704-22552-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1429043704-22552-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-14 at 15:35 -0500, Thomas Falcon wrote:
> Enables receiving large packets from other LPARs. These packets
> have a -1 IP header checksum, so we must recalculate to have
> a valid checksum.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmveth.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 08970c7..05eaca6a 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1092,6 +1092,7 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
>  	struct net_device *netdev = adapter->netdev;
>  	int frames_processed = 0;
>  	unsigned long lpar_rc;
> +	struct iphdr *iph;
>  
>  restart_poll:
>  	while (frames_processed < budget) {
> @@ -1134,8 +1135,20 @@ restart_poll:
>  			skb_put(skb, length);
>  			skb->protocol = eth_type_trans(skb, netdev);
>  
> -			if (csum_good)
> +			if (csum_good) {
>  				skb->ip_summed = CHECKSUM_UNNECESSARY;
> +				if (be16_to_cpu(skb->protocol) == ETH_P_IP) {
> +					skb_set_network_header(skb, 0);
> +					skb_set_transport_header(skb, sizeof(struct iphdr));
> +					iph = ip_hdr(skb);
> +
> +					/* If the IP checksum is not offloaded and if the packet
> +					 *  is large send, the checksum must be rebuilt.
> +					 */
> +					if (iph->check == 0xffff)
> +						iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);


How can this possibly work ?

Normally you would have to set iph->check to 0 before calling
ip_fast_csum(), as done in ip_send_check()
