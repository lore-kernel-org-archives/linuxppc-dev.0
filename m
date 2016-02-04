Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CC3E1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 22:37:35 +1100 (AEDT)
Received: by mail-yw0-x244.google.com with SMTP id c124so1017667ywe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 03:37:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <42d5343703a9e67b5a2d94c8877bc0098448f71b.1454538980.git.christophe.leroy@c-s.fr>
References: <cover.1454538974.git.christophe.leroy@c-s.fr>
 <42d5343703a9e67b5a2d94c8877bc0098448f71b.1454538980.git.christophe.leroy@c-s.fr>
Date: Thu, 4 Feb 2016 14:37:32 +0300
Message-ID: <CAOJe8K2qmRARai6okSXtvpkt2JOfJCrqwUOinDAyo2Qoypd7uw@mail.gmail.com>
Subject: Re: [PATCH v5 21/23] powerpc: Simplify test in __dma_sync()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/4/16, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> This simplification helps the compiler. We now have only one test
> instead of two, so it reduces the number of branches.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2: new
> v3: no change
> v4: no change
> v5: no change
>
>  arch/powerpc/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/dma-noncoherent.c
> b/arch/powerpc/mm/dma-noncoherent.c
> index 169aba4..2dc74e5 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -327,7 +327,7 @@ void __dma_sync(void *vaddr, size_t size, int direction)
>  		 * invalidate only when cache-line aligned otherwise there is
>  		 * the potential for discarding uncommitted data from the cache
>  		 */
> -		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
> +		if ((start | end) & (L1_CACHE_BYTES - 1))
>  			flush_dcache_range(start, end);
>  		else
>  			invalidate_dcache_range(start, end);
The previous version of address cache-line aligned check reads perfectly fine.
What's the benefit of this micro optimization?
> --
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
