Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 04CD91400A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 00:41:41 +1100 (EST)
Message-ID: <53397091.4050601@suse.de>
Date: Mon, 31 Mar 2014 15:41:37 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] KVM: PPC: Bookehv: Get vcpu's last instruction for
 emulation
References: <1392913821-4520-1-git-send-email-mihai.caraman@freescale.com>
 <1392913821-4520-4-git-send-email-mihai.caraman@freescale.com>
 <1395868664.12738.68.camel@snotra.buserror.net>
In-Reply-To: <1395868664.12738.68.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2014 10:17 PM, Scott Wood wrote:
> On Thu, 2014-02-20 at 18:30 +0200, Mihai Caraman wrote:
>> Load external pid (lwepx) instruction faults (when called from
>> KVM with guest context) needs to be handled by KVM. This implies
>> additional code in DO_KVM macro to identify the source of the
>> exception (which oiginate from KVM host rather than the guest).
>> The hook requires to check the Exception Syndrome Register
>> ESR[EPID] and External PID Load Context Register EPLC[EGS] for
>> some exceptions (DTLB_MISS, DSI and LRAT). Doing this on Data TLB
>> miss exception is obvious intrusive for the host.
>>
>> Get rid of lwepx and acquire last instuction in kvmppc_get_last_inst()
>> by searching for the physical address and kmap it. This fixes an
>> infinite loop caused by lwepx's data TLB miss handled in the host
>> and the TODO for TLB eviction and execute-but-not-read entries.
>>
>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> ---
>>   arch/powerpc/kvm/bookehv_interrupts.S |   37 +++----------
>>   arch/powerpc/kvm/e500_mmu_host.c      |   93 +++++++++++++++++++++++++++++++++
>>   2 files changed, 102 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
>> index 20c7a54..c50490c 100644
>> --- a/arch/powerpc/kvm/bookehv_interrupts.S
>> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
>> @@ -119,38 +119,14 @@
>>   1:
>>   
>>   	.if	\flags & NEED_EMU
>> -	/*
>> -	 * This assumes you have external PID support.
>> -	 * To support a bookehv CPU without external PID, you'll
>> -	 * need to look up the TLB entry and create a temporary mapping.
>> -	 *
>> -	 * FIXME: we don't currently handle if the lwepx faults.  PR-mode
>> -	 * booke doesn't handle it either.  Since Linux doesn't use
>> -	 * broadcast tlbivax anymore, the only way this should happen is
>> -	 * if the guest maps its memory execute-but-not-read, or if we
>> -	 * somehow take a TLB miss in the middle of this entry code and
>> -	 * evict the relevant entry.  On e500mc, all kernel lowmem is
>> -	 * bolted into TLB1 large page mappings, and we don't use
>> -	 * broadcast invalidates, so we should not take a TLB miss here.
>> -	 *
>> -	 * Later we'll need to deal with faults here.  Disallowing guest
>> -	 * mappings that are execute-but-not-read could be an option on
>> -	 * e500mc, but not on chips with an LRAT if it is used.
>> -	 */
>> -
>> -	mfspr	r3, SPRN_EPLC	/* will already have correct ELPID and EGS */
>>   	PPC_STL	r15, VCPU_GPR(R15)(r4)
>>   	PPC_STL	r16, VCPU_GPR(R16)(r4)
>>   	PPC_STL	r17, VCPU_GPR(R17)(r4)
>>   	PPC_STL	r18, VCPU_GPR(R18)(r4)
>>   	PPC_STL	r19, VCPU_GPR(R19)(r4)
>> -	mr	r8, r3
>>   	PPC_STL	r20, VCPU_GPR(R20)(r4)
>> -	rlwimi	r8, r6, EPC_EAS_SHIFT - MSR_IR_LG, EPC_EAS
>>   	PPC_STL	r21, VCPU_GPR(R21)(r4)
>> -	rlwimi	r8, r6, EPC_EPR_SHIFT - MSR_PR_LG, EPC_EPR
>>   	PPC_STL	r22, VCPU_GPR(R22)(r4)
>> -	rlwimi	r8, r10, EPC_EPID_SHIFT, EPC_EPID
>>   	PPC_STL	r23, VCPU_GPR(R23)(r4)
>>   	PPC_STL	r24, VCPU_GPR(R24)(r4)
>>   	PPC_STL	r25, VCPU_GPR(R25)(r4)
>> @@ -160,10 +136,15 @@
>>   	PPC_STL	r29, VCPU_GPR(R29)(r4)
>>   	PPC_STL	r30, VCPU_GPR(R30)(r4)
>>   	PPC_STL	r31, VCPU_GPR(R31)(r4)
>> -	mtspr	SPRN_EPLC, r8
>> -	isync
>> -	lwepx   r9, 0, r5
>> -	mtspr	SPRN_EPLC, r3
>> +
>> +	/*
>> +	 * We don't use external PID support. lwepx faults would need to be
>> +	 * handled by KVM and this implies aditional code in DO_KVM (for
>> +	 * DTB_MISS, DSI and LRAT) to check ESR[EPID] and EPLC[EGS] which
>> +	 * is too intrusive for the host. Get last instuction in
>> +	 * kvmppc_get_last_inst().
>> +	 */
>> +	li	r9, KVM_INST_FETCH_FAILED
>>   	stw	r9, VCPU_LAST_INST(r4)
>>   	.endif
>>   
>> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
>> index 6025cb7..1b4cb41 100644
>> --- a/arch/powerpc/kvm/e500_mmu_host.c
>> +++ b/arch/powerpc/kvm/e500_mmu_host.c
>> @@ -598,9 +598,102 @@ void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 eaddr, gpa_t gpaddr,
>>   	}
>>   }
>>   
>> +#ifdef CONFIG_KVM_BOOKE_HV
>> +int kvmppc_ld_inst(struct kvm_vcpu *vcpu, u32 *instr)
> It'd be interesting to see what the performance impact of doing this on
> non-HV would be -- it would eliminate divergent code, eliminate the
> MSR_DS hack, and make exec-only mappings work.

We hit the instruction emulation path a lot more often on non-HV, so 
even a slight performance impact that might not be a major bummer for HV 
would become critical for PR.

But I agree - it'd be interesting to see numbers.

>
>> +{
>> +	gva_t geaddr;
>> +	hpa_t addr;
>> +	hfn_t pfn;
>> +	hva_t eaddr;
>> +	u32 mas0, mas1, mas2, mas3;
>> +	u64 mas7_mas3;
>> +	struct page *page;
>> +	unsigned int addr_space, psize_shift;
>> +	bool pr;
>> +	unsigned long flags;
>> +
>> +	/* Search TLB for guest pc to get the real address */
>> +	geaddr = kvmppc_get_pc(vcpu);
>> +	addr_space = (vcpu->arch.shared->msr & MSR_IS) >> MSR_IR_LG;
>> +
>> +	local_irq_save(flags);
>> +	mtspr(SPRN_MAS6, (vcpu->arch.pid << MAS6_SPID_SHIFT) | addr_space);
>> +	mtspr(SPRN_MAS5, MAS5_SGS | vcpu->kvm->arch.lpid);
>> +	isync();
>> +	asm volatile("tlbsx 0, %[geaddr]\n" : : [geaddr] "r" (geaddr));
> We can probably get away without that isync, despite what the manual
> says.  We've been doing it in other contexts on e500 since forever, and
> tlbsx has presync serialization which means it already waits for all
> previous instructions to complete before beginning execution.
>
>> +	mtspr(SPRN_MAS5, 0);
>> +	mtspr(SPRN_MAS8, 0);
>> +	mas0 = mfspr(SPRN_MAS0);
>> +	mas1 = mfspr(SPRN_MAS1);
>> +	mas2 = mfspr(SPRN_MAS2);
>> +	mas3 = mfspr(SPRN_MAS3);
>> +	mas7_mas3 = (((u64) mfspr(SPRN_MAS7)) << 32) | mfspr(SPRN_MAS3);
> Why read mas3 twice?
>
>> +	local_irq_restore(flags);
>> +
>> +	/*
>> +	 * If the TLB entry for guest pc was evicted, return to the guest.
>> +	 * There are high chances to find a valid TLB entry next time.
>> +	 */
>> +	if (!(mas1 & MAS1_VALID))
>> +		return EMULATE_AGAIN;
>> +
>> +	/*
>> +	 * Another thread may rewrite the TLB entry in parallel, don't
>> +	 * execute from the address if the execute permission is not set
>> +	 */

What happens when another thread rewrites the TLB entry in parallel? 
Does tlbsx succeed? Does it fail? Do we see failure indicated somehow? 
Are the contents of the MAS registers consistent at this point or 
inconsistent?

There has to be a good way to detect such a race and deal with it, no?

>> +	pr = vcpu->arch.shared->msr & MSR_PR;
>> +	if ((pr && (!(mas3 & MAS3_UX))) || ((!pr) && (!(mas3 & MAS3_SX)))) {
>> +		kvmppc_core_queue_inst_storage(vcpu, 0);
>> +		return EMULATE_AGAIN;
>> +	}
> s/(!foo)/!foo/g
>
>> +	/*
>> +	 * We will map the real address through a cacheable page, so we will
>> +	 * not support cache-inhibited guest pages. Fortunately emulated
>> +	 * instructions should not live there.
>> +	 */
>> +	if (mas2 & MAS2_I) {
>> +		printk(KERN_CRIT "Instuction emulation from cache-inhibited "
>> +				"guest pages is not supported\n");
>> +		return EMULATE_FAIL;
>> +	}
> This message needs to be ratelimited, and use pr_err() (or maybe even
> pr_debug()).

I'd go for pr_debug(). If anything we'd want a trace point indicating 
whether instruction fetching worked.


Alex
