Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY5qR04HpzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 22:58:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 3/6] powerpc/mm: Ensure cpumask update is ordered
In-Reply-To: <20170811210656.5a19dda1@roar.ozlabs.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-3-benh@kernel.crashing.org>
 <20170724212007.7f472332@roar.ozlabs.ibm.com>
 <20170811210656.5a19dda1@roar.ozlabs.ibm.com>
Date: Thu, 17 Aug 2017 22:58:10 +1000
Message-ID: <878tiibbbx.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Mon, 24 Jul 2017 21:20:07 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> On Mon, 24 Jul 2017 14:28:00 +1000
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> 
>> > There is no guarantee that the various isync's involved with
>> > the context switch will order the update of the CPU mask with
>> > the first TLB entry for the new context being loaded by the HW.
>> > 
>> > Be safe here and add a memory barrier to order any subsequent
>> > load/store which may bring entries into the TLB.
>> > 
>> > The corresponding barrier on the other side already exists as
>> > pte updates use pte_xchg() which uses __cmpxchg_u64 which has
>> > a sync after the atomic operation.
>> > 
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > ---
>> >  arch/powerpc/include/asm/mmu_context.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
>> > index ed9a36ee3107..ff1aeb2cd19f 100644
>> > --- a/arch/powerpc/include/asm/mmu_context.h
>> > +++ b/arch/powerpc/include/asm/mmu_context.h
>> > @@ -110,6 +110,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
>> >  	/* Mark this context has been used on the new CPU */
>> >  	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next))) {
>> >  		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
>> > +		smp_mb();
>> >  		new_on_cpu = true;
>> >  	}
>> >    
>> 
>> I think this is the right thing to do, but it should be commented.
>> Is hwsync the right barrier? (i.e., it will order the page table walk)
>
> After some offline discussion, I think we have an agreement that
> this is the right barrier, as it orders with the subsequent load
> of next->context.id that the mtpid depends on (or slbmte for HPT).
>
> So we should have a comment here to that effect, and including
> the pte_xchg comments from your changelog. Some comment (at least
> refer back to here) added at pte_xchg too please.
>
> Other than that your series seems good to me if you repost it you
> can add
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>
> This one out of the series is the bugfix so it should go to stable
> as well, right?

So I'm waiting on a v2?

cheers
