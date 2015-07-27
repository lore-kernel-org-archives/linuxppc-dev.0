Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0120.outbound.protection.outlook.com [65.55.169.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BAFC1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 07:20:57 +1000 (AEST)
Message-ID: <1438032043.2993.311.camel@freescale.com>
Subject: Re: [RFC v2] genalloc:add an gen_pool_first_fit_align algo to genalloc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <lauraa@codeaurora.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <akpm@linux-foundation.org>,
 <olof@lixom.net>, <catalin.marinas@arm.com>, <X.xie@freescale.com>
Date: Mon, 27 Jul 2015 16:20:43 -0500
In-Reply-To: <1437991074-35377-1-git-send-email-qiang.zhao@freescale.com>
References: <1437991074-35377-1-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-27 at 17:57 +0800, Zhao Qiang wrote:
> diff --git a/lib/genalloc.c b/lib/genalloc.c
> index d214866..e6608cd 100644
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -509,6 +509,31 @@ unsigned long gen_pool_first_fit(unsigned long *map, 
> unsigned long size,
>  EXPORT_SYMBOL(gen_pool_first_fit);
>  
>  /**
> + * gen_pool_first_fit_align - find the first available region
> + * of memory matching the size requirement (no alignment constraint)
> + * @map: The address to base the search on
> + * @size: The bitmap size in bits
> + * @start: The bitnumber to start searching at
> + * @nr: The number of zeroed bits we're looking for
> + * @data: additional data - unused
> + */
> +unsigned long gen_pool_first_fit_align(unsigned long *map, unsigned long 
> size,
> +             unsigned long start, unsigned int nr, void *data)
> +{
> +     unsigned long align_mask;
> +     int order;
> +
> +     if (data && data->pool) {

There is no way that this compiles.  You can't dereference a void pointer.

Please test your code before submitting, even for an RFC.

> +             order = data->pool->min_alloc_order;

I don't think pool belongs in data.  It's fundamental enough that, if a 
pointer to pool is needed, it should be an argument to the algorithm.

> +             align_mask = ((data->align + (1UL << order) - 1) >> order) - 1;
> +     } else {
> +             pr_err("no data or data->pool\n");
> +     }

This is way too vague and unobtrusive of an error message, and also not rate-
limited, etc.  I wouldn't bother checking at all.  Just let it crash on the 
developer's machine if they use this without passing in data.

Where's the part that adds the ability to pass in data to each allocation 
call, as per the previous discussion?

-Scott
