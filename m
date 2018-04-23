Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VK2W1LHwzDqRk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 07:13:51 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc/mm/radix: use do/while(0) trick for single
 statement block
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20180408194424.8719-1-malat@debian.org>
 <20180423193638.10535-1-malat@debian.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3aa2afca-5d9a-60a2-78d7-9504cf05f78c@infradead.org>
Date: Mon, 23 Apr 2018 14:13:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180423193638.10535-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/18 12:36, Mathieu Malaterre wrote:
> In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
> disable_radix") an `if` statement was added for a possible empty body
> (prom_debug).
> 
> Fix the following warning, treated as error with W=1:
> 
>   arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2: update macro directly
> 
>  arch/powerpc/kernel/prom_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 5ae153b97d0a..7edf3aa5bc6d 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -103,7 +103,7 @@ int of_workarounds;
>  #ifdef DEBUG_PROM
>  #define prom_debug(x...)	prom_printf(x)
>  #else
> -#define prom_debug(x...)
> +#define prom_debug(x...)	do { } while (0)
>  #endif
>  
>  
> 


-- 
~Randy
