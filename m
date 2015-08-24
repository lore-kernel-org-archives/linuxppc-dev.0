Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03AF61A0E56
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 09:10:52 +1000 (AEST)
Subject: Re: [PATCH v6 1/3] genalloc:support memory-allocation with
 bytes-alignment to genalloc
To: Zhao Qiang <qiang.zhao@freescale.com>, scottwood@freescale.com
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 lauraa@codeaurora.org, X.xie@freescale.com, benh@kernel.crashing.org,
 leoli@freescale.com, paulus@samba.org
From: Laura Abbott <labbott@redhat.com>
Message-ID: <55DBA477.5020608@redhat.com>
Date: Mon, 24 Aug 2015 16:10:47 -0700
MIME-Version: 1.0
In-Reply-To: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2015 02:31 AM, Zhao Qiang wrote:
> Bytes alignment is required to manage some special RAM,
> so add gen_pool_first_fit_align to genalloc,
> meanwhile add gen_pool_alloc_data to pass data to
> gen_pool_first_fit_align(modify gen_pool_alloc as a wrapper)
>
> Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
> ---
> Changes for v6:
> 	- patches set v6 include a new patch because of using
> 	- genalloc to manage QE MURAM, patch 0001 is the new
> 	- patch, adding bytes alignment for allocation for use.
>
>   include/linux/genalloc.h | 23 +++++++++++++++----
>   lib/genalloc.c           | 58 +++++++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 72 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> index 1ccaab4..55da07e 100644
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@ -34,6 +34,7 @@
>
>   struct device;
>   struct device_node;
> +struct gen_pool;
>
>   /**
>    * Allocation callback function type definition
> @@ -47,7 +48,7 @@ typedef unsigned long (*genpool_algo_t)(unsigned long *map,
>   			unsigned long size,
>   			unsigned long start,
>   			unsigned int nr,
> -			void *data);
> +			void *data, struct gen_pool *pool);
>
>   /*
>    *  General purpose special memory pool descriptor.
> @@ -73,6 +74,13 @@ struct gen_pool_chunk {
>   	unsigned long bits[0];		/* bitmap for allocating memory chunk */
>   };
>
> +/*
> + *  gen_pool data descriptor for gen_pool_first_fit_align.
> + */
> +struct genpool_data_align {
> +	int align;		/* alignment by bytes for starting address */
> +};
> +

(sorry for chiming in late, I've been traveling)

Is there an advantage here to wrapping this in a structure instead of just
passing a pointer to an align integer?

Thanks,
Laura
