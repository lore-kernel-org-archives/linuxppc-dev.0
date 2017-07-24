Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGJnp73MBzDqwx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 21:20:30 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 123so857650pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 04:20:30 -0700 (PDT)
Date: Mon, 24 Jul 2017 21:20:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 3/6] powerpc/mm: Ensure cpumask update is ordered
Message-ID: <20170724212007.7f472332@roar.ozlabs.ibm.com>
In-Reply-To: <20170724042803.25848-3-benh@kernel.crashing.org>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Jul 2017 14:28:00 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> There is no guarantee that the various isync's involved with
> the context switch will order the update of the CPU mask with
> the first TLB entry for the new context being loaded by the HW.
> 
> Be safe here and add a memory barrier to order any subsequent
> load/store which may bring entries into the TLB.
> 
> The corresponding barrier on the other side already exists as
> pte updates use pte_xchg() which uses __cmpxchg_u64 which has
> a sync after the atomic operation.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index ed9a36ee3107..ff1aeb2cd19f 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -110,6 +110,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
>  	/* Mark this context has been used on the new CPU */
>  	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
>  		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
> +		smp_mb();
>  		new_on_cpu = true;
>  	}
>  

I think this is the right thing to do, but it should be commented.
Is hwsync the right barrier? (i.e., it will order the page table walk)

Thanks,
Nick
