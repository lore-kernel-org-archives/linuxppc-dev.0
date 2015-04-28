Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44A531A0140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 10:25:08 +1000 (AEST)
Received: by igbhj9 with SMTP id hj9so8085324igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 17:25:06 -0700 (PDT)
Message-ID: <1430179812.22254.240.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [PATCH net-next v2 4/4] ibmveth: Add support for Large Receive
 Offload
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1430172655-17606-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1430172655-17606-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
 <1430172655-17606-4-git-send-email-tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Apr 2015 17:10:12 -0700
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-04-27 at 17:10 -0500, Thomas Falcon wrote:




> +				if (be16_to_cpu(skb->protocol) == ETH_P_IP) {
> +					skb_set_network_header(skb, 0);
> +					skb_set_transport_header(skb, sizeof(struct iphdr));
> +					iph = ip_hdr(skb);
> +

All this should really be :

if (skb->protocol == htons(ETH_P_IP)) {
	iph = (struct iphdr *)skb->data;

Because setting network header and a (potentially wrong) transport
header is confusing at this stage.

(It should be done later in core networking stack)
