Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22d.google.com (mail-pg0-x22d.google.com
 [IPv6:2607:f8b0:400e:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwtQQ11xrzF1ZY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 10:34:06 +1100 (AEDT)
Received: by mail-pg0-x22d.google.com with SMTP id y8so162904pgr.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 15:34:05 -0800 (PST)
Date: Wed, 7 Mar 2018 09:33:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/10] powerpc/mm/slice: Use const pointers to cached
 slice masks where possible
Message-ID: <20180307093356.16fb66e6@roar.ozlabs.ibm.com>
In-Reply-To: <248c0062-7710-bb96-6677-3c6d7bdc13ee@c-s.fr>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-9-npiggin@gmail.com>
 <248c0062-7710-bb96-6677-3c6d7bdc13ee@c-s.fr>
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

On Tue, 6 Mar 2018 15:55:04 +0100
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 06/03/2018 à 14:25, Nicholas Piggin a écrit :

> > @@ -572,11 +555,19 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
> >   #ifdef CONFIG_PPC_64K_PAGES
> >   	/* If we support combo pages, we can allow 64k pages in 4k slices */
> >   	if (psize == MMU_PAGE_64K) {
> > -		compat_mask = *slice_mask_for_size(mm, MMU_PAGE_4K);
> > +		compat_maskp = slice_mask_for_size(mm, MMU_PAGE_4K);
> >   		if (fixed)
> > -			slice_or_mask(&good_mask, &good_mask, &compat_mask);
> > -	}
> > +			slice_or_mask(&good_mask, maskp, compat_maskp);
> > +		else
> > +			slice_copy_mask(&good_mask, maskp);
> > +	} else
> >   #endif
> > +	{
> > +		slice_copy_mask(&good_mask, maskp);
> > +	}  
> 
> You could get something nicer by removing that #ifdef and doing instead:
> 
> 	if (IS_ENABLED(CONFIG_PPC_64K_PAGES) && psize == MMU_PAGE_64K) {
> 		...
> 	} else {
> 		slice_copy_mask(&good_mask, maskp);
> 	}

Yeah that's nicer.

> >   
> > -#if 0 /* too verbose */
> > -	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
> > -		 mm, addr, len);
> > -	slice_print_mask(" mask", &mask);
> > -	slice_print_mask(" available", &available);
> > -#endif  
> 
> That's cleanup, should be in a previous patch.

Okay.

Thanks,
Nick
