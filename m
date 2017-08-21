Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbhGc6GRGzDqms
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 03:57:10 +1000 (AEST)
Date: Mon, 21 Aug 2017 10:57:06 -0700 (PDT)
Message-Id: <20170821.105706.646457120423300952.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dpaa_eth: add NETIF_F_RXHASH
From: David Miller <davem@davemloft.net>
In-Reply-To: <1503046588-24349-5-git-send-email-madalin.bucur@nxp.com>
References: <1503046588-24349-1-git-send-email-madalin.bucur@nxp.com>
 <1503046588-24349-5-git-send-email-madalin.bucur@nxp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Fri, 18 Aug 2017 11:56:26 +0300

> +	if (net_dev->features & NETIF_F_RXHASH && priv->keygen_in_use &&
> +	    !fman_port_get_hash_result_offset(priv->mac_dev->port[RX],
> +					      &hash_offset))
> +		skb_set_hash(skb, be32_to_cpu(*(u32 *)(vaddr + hash_offset)),
> +			     // if L4 exists, it was used in the hash generation
> +			     be32_to_cpu(fd->status) & FM_FD_STAT_L4CV ?
> +				PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);

We do not use "//" c++ style comments in the kernel.

And putting a comment right in the middle of a set of arguments being
passed to a function makes the code harder to read, so please do not
do this.
