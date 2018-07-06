Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MPGR5kD0zF2Wm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 16:00:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v4 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
In-Reply-To: <20180705080133.18690-3-aik@ozlabs.ru>
References: <20180705080133.18690-1-aik@ozlabs.ru>
 <20180705080133.18690-3-aik@ozlabs.ru>
Date: Fri, 06 Jul 2018 16:00:30 +1000
Message-ID: <874lhclx8h.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index abb4364..11e1029 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -159,6 +161,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
>  
> +	mem->pageshift = __builtin_ctzl(ua | (entries << PAGE_SHIFT));

__builtin_ctzl(0) is undefined, so are we guaranteed that
(ua | (entries << PAGE_SHIFT)) is never zero? I couldn't convince
myself.

> @@ -199,9 +202,17 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  			}
>  		}
>  populate:
> +		pageshift = PAGE_SHIFT;
> +		if (PageCompound(page))
> +			pageshift += compound_order(compound_head(page));
> +		mem->pageshift = min(mem->pageshift, pageshift);
>  		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
>  	}
>  
> +	/* We have an incomplete huge page, default to PAGE_SHIFT */
> +	if (head)
> +		mem->pageshift = PAGE_SHIFT;
> +

You never set head AFIACS? (other than in the initialiser)

cheers
