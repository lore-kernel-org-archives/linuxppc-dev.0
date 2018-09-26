Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42L0Wy6m5tzF3Kb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 00:22:38 +1000 (AEST)
Date: Wed, 26 Sep 2018 16:22:32 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: zhong jiang <zhongjiang@huawei.com>
Cc: <paulus@samba.org>, <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
Message-ID: <20180926162232.250c0090@naga>
In-Reply-To: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 26 Sep 2018 19:46:08 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> It is safe to move dereference below a NULL test.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/powerpc/kernel/cacheinfo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c
> b/arch/powerpc/kernel/cacheinfo.c index a8f20e5..7f19714 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -401,14 +401,13 @@ static struct cache
> *cache_lookup_or_instantiate(struct device_node *node, struct cache
> *cache; 
>  	cache = cache_lookup_by_node(node);
> +	if (!cache)
> +		cache = cache_do_one_devnode(node, level);
>  
>  	WARN_ONCE(cache && cache->level != level,

This has also null test so cache should be dereferenced only when
non-null here.

Thanks

Michal
