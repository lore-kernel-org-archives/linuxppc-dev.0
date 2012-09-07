Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 88ACE2C0093
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2012 09:01:34 +1000 (EST)
Message-ID: <504A7CBC.80803@freescale.com>
Date: Fri, 7 Sep 2012 18:01:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
References: <20120614234101.GB17147@tyr.buserror.net>
 <1346992880.2385.51.camel@pasglop> <504A4C3D.3040709@freescale.com>
In-Reply-To: <504A4C3D.3040709@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/2012 02:34 PM, Scott Wood wrote:
> On 09/06/2012 11:41 PM, Benjamin Herrenschmidt wrote:
>>> diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
>>> index eeabcdb..3072aa0 100644
>>> --- a/arch/powerpc/include/asm/mmu-book3e.h
>>> +++ b/arch/powerpc/include/asm/mmu-book3e.h
>>> @@ -264,8 +264,21 @@ extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>>>  extern int mmu_linear_psize;
>>>  extern int mmu_vmemmap_psize;
>>>  
>>> +struct book3e_tlb_per_core {
>>> +	/* For software way selection, as on Freescale TLB1 */
>>> +	u8 esel_next, esel_max, esel_first;
>>> +
>>> +	/* Per-core spinlock for e6500 TLB handlers (no tlbsrx.) */
>>> +	u8 lock;
>>> +};
>>
>> I'm no fan of the name ... tlb_core_data ?

tlb_core_data is fine with me.

>> Probably don't even need the book3e prefix really.

Right, it's already in a book3e file.

>>>  #if defined(CONFIG_PPC_STD_MMU_64)
>>>  /* 64-bit classic hash table MMU */
>>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>>> index daf813f..4e18bb5 100644
>>> --- a/arch/powerpc/include/asm/paca.h
>>> +++ b/arch/powerpc/include/asm/paca.h
>>> @@ -108,6 +108,12 @@ struct paca_struct {
>>>  	/* Keep pgd in the same cacheline as the start of extlb */
>>>  	pgd_t *pgd __attribute__((aligned(0x80))); /* Current PGD */
>>>  	pgd_t *kernel_pgd;		/* Kernel PGD */
>>> +
>>> +	struct book3e_tlb_per_core tlb_per_core;
>>> +
>>> +	/* Points to the tlb_per_core of the first thread on this core. */
>>> +	struct book3e_tlb_per_core *tlb_per_core_ptr;
>>> +
>>
>> That's gross. Can't you allocate them elsewhere and then populate the
>> PACA pointers ?

That would be one more cache line that misses need... and the threads
share cache, so there's no ping-pong.

>>> @@ -142,6 +173,8 @@ static void check_smt_enabled(void)
>>>  			of_node_put(dn);
>>>  		}
>>>  	}
>>> +
>>> +	setup_tlb_per_core();
>>>  }
>>
>> I'd rather you move that to the caller

OK.

>>> +/*
>>> + * TLB miss handling for e6500 and derivatives, using hardware tablewalk.
>>> + *
>>> + * Linear mapping is bolted: no virtual page table or nested TLB misses
>>> + * Indirect entries in TLB1, hardware loads resulting direct entries
>>> + *    into TLB0
>>> + * No HES or NV hint on TLB1, so we need to do software round-robin
>>> + * No tlbsrx. so we need a spinlock, and we have to deal
>>> + *    with MAS-damage caused by tlbsx
>>
>> Ouch ... so for every indirect entry you have to take a lock, backup the
>> MAS, do a tlbsx, restore the MAS, insert the entry and drop the lock ?

Pretty much (only a couple of the MASes need to be restored).

>> After all that, do you have some bullets left for the HW designers ?

They seem to not care much about making our lives easier, only how bad
the benchmarks will be without it -- and they seem to think TLB miss
performance is no longer important since we won't take them as often
with hardware tablewalk.  I suspect they'll be regretting that when they
see workloads that thrash TLB1's ability to hold 2MiB indirect pages.
Then it'll probably be "why can't you use larger page tables?" :-P

>>> +tlb_miss_common_e6500:
>>> +	/*
>>> +	 * Search if we already have an indirect entry for that virtual
>>> +	 * address, and if we do, bail out.
>>> +	 *
>>> +	 * MAS6:IND should be already set based on MAS4
>>> +	 */
>>> +	addi	r10,r11,PERCORE_TLB_LOCK
>>> +1:	lbarx	r15,0,r10
>>> +	cmpdi	r15,0
>>> +	bne	2f
>>> +	li	r15,1
>>> +	stbcx.	r15,0,r10
>>
>> No need for barriers here ?

I don't think so.  We're not guarding memory accesses, just the
tlbsx+tlbwe.  At least on FSL cores those instructions have enough
internal sync that isync shouldn't be needed (according to the core
manual tlbsx, tlbwe, and stbcx. all have presync and postsync, so
nothing else should be able to run at the same time).  And this is
FSL-specific code. :-)

>>>  #endif /* CONFIG_PPC64 */
>>> @@ -377,7 +382,7 @@ void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
>>>  {
>>>  	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
>>>  
>>> -	if (book3e_htw_enabled) {
>>> +	if (book3e_htw_mode) {
>>
>> Make it if (boot3e_htw_enabled != PPC_HTW_NONE)

Seems a little verbose, but OK.

Same with things like this, I guess:
	book3e_htw_mode ? "enabled" : "not supported"

-Scott
