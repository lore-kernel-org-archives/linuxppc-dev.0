Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLZw22sxkzF0Xv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 03:11:14 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0GG9rRo041907
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 11:11:11 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fhkxajv62-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 11:11:11 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 16:11:09 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/8xx: Increase the number of mm slices
In-Reply-To: <aed2799c8b369bd2ffba9967ed052e21d33e76f0.1515169256.git.christophe.leroy@c-s.fr>
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <aed2799c8b369bd2ffba9967ed052e21d33e76f0.1515169256.git.christophe.leroy@c-s.fr>
Date: Tue, 16 Jan 2018 21:23:32 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zi5dajgj.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> On the 8xx, we can have as many slices as PMD entries.
> This means we could have 1024 slices in 4k size pages mode
> and 64 slices in 16k size pages.
>
> However, due to a stack overflow in slice_get_unmapped_area(),
> we limit to 512 slices.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/mmu-8xx.h | 6 +++++-
>  arch/powerpc/include/asm/page_32.h | 3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
> index d669d0062da4..40aa7b0cd0dc 100644
> --- a/arch/powerpc/include/asm/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/mmu-8xx.h
> @@ -171,7 +171,11 @@ typedef struct {
>  	unsigned long vdso_base;
>  #ifdef CONFIG_PPC_MM_SLICES
>  	u16 user_psize;		/* page size index */
> -	unsigned char low_slices_psize[8]; /* 16 slices */
> +#if defined(CONFIG_PPC_16K_PAGES)
> +	unsigned char low_slices_psize[32]; /* 64 slices */
> +#else
> +	unsigned char low_slices_psize[256]; /* 512 slices */
> +#endif

These #ifdef should be 8xx and then 16K.


>  	unsigned char high_slices_psize[0];
>  	unsigned long slb_addr_limit;
>  #endif
> diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
> index f7d1bd1183c8..43695ce7ee07 100644
> --- a/arch/powerpc/include/asm/page_32.h
> +++ b/arch/powerpc/include/asm/page_32.h
> @@ -62,7 +62,8 @@ extern void copy_page(void *to, void *from);
>  
>  #ifdef CONFIG_PPC_MM_SLICES
>  
> -#define SLICE_LOW_SHIFT		28
> +/* SLICE_LOW_SHIFT >= 23 to avoid stack overflow in slice_get_unmapped_area() */
> +#define SLICE_LOW_SHIFT		(PMD_SHIFT > 23 ? PMD_SHIFT : 23)
>  #define SLICE_HIGH_SHIFT	0
>  
>  #define SLICE_LOW_TOP		(0xfffffffful)
> -- 
> 2.13.3
