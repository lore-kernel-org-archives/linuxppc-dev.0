Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqN4d3XlnzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 23:28:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mhairgrove@nvidia.com, shailendras@nvidia.com,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 3/3] powerpc/powernv: Introduce address translation
 services for Nvlink2
In-Reply-To: <1490154573-22475-3-git-send-email-alistair@popple.id.au>
References: <1490154573-22475-1-git-send-email-alistair@popple.id.au>
 <1490154573-22475-3-git-send-email-alistair@popple.id.au>
Date: Fri, 24 Mar 2017 23:28:32 +1100
Message-ID: <87k27ex3in.fsf@concordia.ellerman.id.au>
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

Alistair Popple <alistair@popple.id.au> writes:

> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index 6095575..fc61fca 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -63,15 +63,21 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
>  }
>  
>  #ifdef CONFIG_SMP
> +/* If there is an NPU context associated with this thread it may have
> + * been active on a GPU which has issued translation requests via the
> + * nest mmu. In this case we need to do a broadcast tlb to invalidate
> + * any caches on the nest mmu. Invalidations on the GPU are handled
> + * via mmu notfiers.
> + */
>  static inline int mm_is_core_local(struct mm_struct *mm)
>  {
> -	return cpumask_subset(mm_cpumask(mm),
> +	return !mm->context.npu_context && cpumask_subset(mm_cpumask(mm),
>  			      topology_sibling_cpumask(smp_processor_id()));
>  }

This breaks the BookE build (corenet64_smp_defconfig):

23:22:58 In file included from arch/powerpc/mm/pgtable-book3e.c:15:0:
23:22:58 ./arch/powerpc/include/asm/tlb.h: In function 'mm_is_core_local':
23:22:58 ./arch/powerpc/include/asm/tlb.h:75:21: error: 'mm_context_t {aka struct <anonymous>}' has no member named 'npu_context'
23:22:58   return !mm->context.npu_context && cpumask_subset(mm_cpumask(mm),
23:22:58                      ^

cheers
