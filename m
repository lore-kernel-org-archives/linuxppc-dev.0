Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJxvP1bPSzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 23:18:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shailendra Singh <shailendras@nvidia.com>, linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org, apopple@au1.ibm.com, balbirs@au1.ibm.com, aritger@nvidia.com,
 jhubbard@nvidia.com, scheung@nvidia.com, amanjunatha@nvidia.com,
 jmckenna@nvidia.com, david.daney@cavium.com, robh@kernel.org,
 will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: Fix inconsistent of_node_to_nid EXPORT_SYMBOL
 handling
In-Reply-To: <1485989562-16741-1-git-send-email-shailendras@nvidia.com>
References: <1485989562-16741-1-git-send-email-shailendras@nvidia.com>
Date: Thu, 09 Feb 2017 23:18:56 +1100
Message-ID: <87poir8slr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shailendra Singh <shailendras@nvidia.com> writes:

> The generic implementation of of_node_to_nid is EXPORT_SYMBOL.

True. Added in 298535c00a2c, in April 2016.

> The powerpc implementation added by following commit is EXPORT_SYMBOL_GPL.
> commit 953039c8df7b ("[PATCH] powerpc: Allow devices to register with numa
> topology")

Which was merged in May 2006.

So the powerpc version has almost 10 years precedence.

> This creates an inconsistency for of_node_to_nid callers across
> architectures.
>
> Update the powerpc implementation to be exported consistently with the
> generic implementation.

But I guess it's a pretty boring API. So I'll merge this unless anyone
else objects.

cheers


> Signed-off-by: Shailendra Singh <shailendras@nvidia.com>
> Reviewed-by: Andy Ritger <aritger@nvidia.com>
> ---
>  arch/powerpc/mm/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index b1099cb2f393..8aa4ca3c84c9 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -290,7 +290,7 @@ int of_node_to_nid(struct device_node *device)
>  
>  	return nid;
>  }
> -EXPORT_SYMBOL_GPL(of_node_to_nid);
> +EXPORT_SYMBOL(of_node_to_nid);
>  
>  static int __init find_min_common_depth(void)
>  {
> -- 
> 2.4.11
