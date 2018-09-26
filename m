Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L00Z2HlKzDrdd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 23:58:54 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
To: zhong jiang <zhongjiang@huawei.com>, paulus@samba.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fb8bc993-2adc-6a70-2643-6195ba5f020f@c-s.fr>
Date: Wed, 26 Sep 2018 15:58:48 +0200
MIME-Version: 1.0
In-Reply-To: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/09/2018 à 13:46, zhong jiang a écrit :
> It is safe to move dereference below a NULL test.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>   arch/powerpc/kernel/cacheinfo.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
> index a8f20e5..7f19714 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -401,14 +401,13 @@ static struct cache *cache_lookup_or_instantiate(struct device_node *node,
>   	struct cache *cache;
>   
>   	cache = cache_lookup_by_node(node);
> +	if (!cache)
> +		cache = cache_do_one_devnode(node, level);

But by doing this, you change the meaning of the following warning. Is 
that what you want ? In that case the text of the WARN_ONCE() should be 
changed, because the mismatch is not only on lookup now.

Christophe

>   
>   	WARN_ONCE(cache && cache->level != level,
>   		  "cache level mismatch on lookup (got %d, expected %d)\n",
>   		  cache->level, level);
>   
> -	if (!cache)
> -		cache = cache_do_one_devnode(node, level);
> -
>   	return cache;
>   }
>   
> 
