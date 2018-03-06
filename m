Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x236.google.com (mail-pl0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwdkG576GzF1GC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 01:01:56 +1100 (AEDT)
Received: by mail-pl0-x236.google.com with SMTP id w22-v6so691337pll.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 06:01:56 -0800 (PST)
Date: Wed, 7 Mar 2018 00:01:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 05/10] powerpc/mm/slice: implement a slice mask cache
Message-ID: <20180307000142.45e5d80f@roar.ozlabs.ibm.com>
In-Reply-To: <81a073ab-398f-be65-eb3c-5d5ac180ec94@c-s.fr>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-6-npiggin@gmail.com>
 <81a073ab-398f-be65-eb3c-5d5ac180ec94@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Mar 2018 14:49:57 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :

> > @@ -201,6 +206,15 @@ typedef struct {
> >   	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
> >   	unsigned char high_slices_psize[0];
> >   	unsigned long slb_addr_limit;
> > +# ifdef CONFIG_PPC_16K_PAGES
> > +	struct slice_mask mask_16k;
> > +# else
> > +	struct slice_mask mask_4k;
> > +# endif  
> 
> Could we just call it mask_base or something like that regardless of the 
> standard page size ?

[...]

> > +#elif defined(CONFIG_PPC_8xx)
> > +static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
> > +{
> > +#ifdef CONFIG_PPC_16K_PAGES
> > +	if (psize == MMU_PAGE_16K)
> > +		return &mm->context.mask_16k;
> > +#else
> > +	if (psize == MMU_PAGE_4K)
> > +		return &mm->context.mask_4k;
> > +#endif  
> 
> What about the following instead:
> +	if (psize == mmu_virtual_size)
> +		return &mm->context.mask_base;

Sure if you prefer. It should generate the same code right?

Thanks,
Nick
