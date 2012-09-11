Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 891C82C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 03:24:44 +1000 (EST)
Message-ID: <504F73CA.4020209@freescale.com>
Date: Tue, 11 Sep 2012 12:24:26 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
References: <20120614234101.GB17147@tyr.buserror.net>
 <300B73AA675FCE4A93EB4FC1D42459FF1DC945@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF1DC945@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2012 12:06 PM, Caraman Mihai Claudiu-B02008 wrote:
>> diff --git a/arch/powerpc/mm/tlb_low_64e.S
>> b/arch/powerpc/mm/tlb_low_64e.S
>> index efe0f33..8e82772 100644
>> --- a/arch/powerpc/mm/tlb_low_64e.S
>> +++ b/arch/powerpc/mm/tlb_low_64e.S
>> @@ -232,6 +232,173 @@ itlb_miss_fault_bolted:
>>  	beq	tlb_miss_common_bolted
>>  	b	itlb_miss_kernel_bolted
>>
>> +/*
>> + * TLB miss handling for e6500 and derivatives, using hardware
>> tablewalk.
>> + *
>> + * Linear mapping is bolted: no virtual page table or nested TLB misses
>> + * Indirect entries in TLB1, hardware loads resulting direct entries
>> + *    into TLB0
>> + * No HES or NV hint on TLB1, so we need to do software round-robin
>> + * No tlbsrx. so we need a spinlock, and we have to deal
>> + *    with MAS-damage caused by tlbsx
>> + * 4K pages only
>> + */
>> +
>> +	START_EXCEPTION(instruction_tlb_miss_e6500)
>> +	tlb_prolog_bolted SPRN_SRR0
>> +
>> +	ld	r11,PACA_TLB_PER_CORE_PTR(r13)
>> +	srdi.	r15,r16,60		/* get region */
>> +	ori	r16,r16,1
>> +
>> +	TLB_MISS_STATS_SAVE_INFO_BOLTED
>> +	bne	tlb_miss_kernel_e6500	/* user/kernel test */
>> +
>> +	b	tlb_miss_common_e6500
>> +
>> +	START_EXCEPTION(data_tlb_miss_e6500)
>> +	tlb_prolog_bolted SPRN_DEAR
>> +
>> +	ld	r11,PACA_TLB_PER_CORE_PTR(r13)
>> +	srdi.	r15,r16,60		/* get region */
>> +	rldicr	r16,r16,0,62
>> +
>> +	TLB_MISS_STATS_SAVE_INFO_BOLTED
>> +	bne	tlb_miss_kernel_e6500	/* user vs kernel check */
>> +
> 
> This ends up calling DO_KVM macro twice with same parameters which
> generates the following compile error:
> 
>  arch/powerpc/mm/tlb_low_64e.S:307: Error: symbol `kvmppc_resume_14_0x01B' is already defined
>  arch/powerpc/mm/tlb_low_64e.S:319: Error: symbol `kvmppc_resume_13_0x01B' is already defined

I assume the reason you don't already see this is because you only did
DO_KVM for the bolted version of the handlers.

> We can live with it if we patch DO_KVM like this:
> 
> diff --git a/arch/powerpc/include/asm/kvm_booke_hv_asm.h b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> index 4610fb0..029ecab 100644
> --- a/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> +++ b/arch/powerpc/include/asm/kvm_booke_hv_asm.h
> @@ -55,9 +55,9 @@
>  #ifdef CONFIG_KVM_BOOKE_HV
>  BEGIN_FTR_SECTION
>         mtocrf  0x80, r11       /* check MSR[GS] without clobbering reg */
> -       bf      3, kvmppc_resume_\intno\()_\srr1
> +       bf      3, 1f
>         b       kvmppc_handler_\intno\()_\srr1
> -kvmppc_resume_\intno\()_\srr1:
> +1:
>  END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
>  #endif
>  .endm

Please do that, though maybe use a more unique label number in case the
calling context is using numbered labels.

-Scott
