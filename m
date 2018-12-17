Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C8C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB238206A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB238206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JJBb5mqJzDqlJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 22:01:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JHn80kySzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 21:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JHn75cNrz9sBh;
 Mon, 17 Dec 2018 21:43:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: frowand.list@gmail.com, robh+dt@kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] of: of_node_get()/of_node_put() nodes held in
 phandle cache
In-Reply-To: <1545033396-24485-2-git-send-email-frowand.list@gmail.com>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-2-git-send-email-frowand.list@gmail.com>
Date: Mon, 17 Dec 2018 21:43:19 +1100
Message-ID: <874lbcv3g8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Frank,

frowand.list@gmail.com writes:
> From: Frank Rowand <frank.rowand@sony.com>
>
> The phandle cache contains struct device_node pointers.  The refcount
> of the pointers was not incremented while in the cache, allowing use
> after free error after kfree() of the node.  Add the proper increment
> and decrement of the use count.
>
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

Can we also add:

Cc: stable@vger.kernel.org # v4.17+


This and the next patch solve WARN_ONs and other problems for us on some
systems so I think they meet the criteria for a stable backport.

Rest of the patch LGTM, I'm not able to test it unfortunately, I have to
defer to mwb for that.

cheers

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 09692c9b32a7..6c33d63361b8 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -116,9 +116,6 @@ int __weak of_node_to_nid(struct device_node *np)
>  }
>  #endif
>  
> -static struct device_node **phandle_cache;
> -static u32 phandle_cache_mask;
> -
>  /*
>   * Assumptions behind phandle_cache implementation:
>   *   - phandle property values are in a contiguous range of 1..n
> @@ -127,6 +124,44 @@ int __weak of_node_to_nid(struct device_node *np)
>   *   - the phandle lookup overhead reduction provided by the cache
>   *     will likely be less
>   */
> +
> +static struct device_node **phandle_cache;
> +static u32 phandle_cache_mask;
> +
> +/*
> + * Caller must hold devtree_lock.
> + */
> +static void __of_free_phandle_cache(void)
> +{
> +	u32 cache_entries = phandle_cache_mask + 1;
> +	u32 k;
> +
> +	if (!phandle_cache)
> +		return;
> +
> +	for (k = 0; k < cache_entries; k++)
> +		of_node_put(phandle_cache[k]);
> +
> +	kfree(phandle_cache);
> +	phandle_cache = NULL;
> +}
> +
> +int of_free_phandle_cache(void)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	__of_free_phandle_cache();
> +
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +
> +	return 0;
> +}
> +#if !defined(CONFIG_MODULES)
> +late_initcall_sync(of_free_phandle_cache);
> +#endif
> +
>  void of_populate_phandle_cache(void)
>  {
>  	unsigned long flags;
> @@ -136,8 +171,7 @@ void of_populate_phandle_cache(void)
>  
>  	raw_spin_lock_irqsave(&devtree_lock, flags);
>  
> -	kfree(phandle_cache);
> -	phandle_cache = NULL;
> +	__of_free_phandle_cache();
>  
>  	for_each_of_allnodes(np)
>  		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> @@ -155,30 +189,15 @@ void of_populate_phandle_cache(void)
>  		goto out;
>  
>  	for_each_of_allnodes(np)
> -		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> +		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL) {
> +			of_node_get(np);
>  			phandle_cache[np->phandle & phandle_cache_mask] = np;
> +		}
>  
>  out:
>  	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>  }
>  
> -int of_free_phandle_cache(void)
> -{
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&devtree_lock, flags);
> -
> -	kfree(phandle_cache);
> -	phandle_cache = NULL;
> -
> -	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> -
> -	return 0;
> -}
> -#if !defined(CONFIG_MODULES)
> -late_initcall_sync(of_free_phandle_cache);
> -#endif
> -
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
> @@ -1195,8 +1214,11 @@ struct device_node *of_find_node_by_phandle(phandle handle)
>  	if (!np) {
>  		for_each_of_allnodes(np)
>  			if (np->phandle == handle) {
> -				if (phandle_cache)
> +				if (phandle_cache) {
> +					/* will put when removed from cache */
> +					of_node_get(np);
>  					phandle_cache[masked_handle] = np;
> +				}
>  				break;
>  			}
>  	}
> -- 
> Frank Rowand <frank.rowand@sony.com>
