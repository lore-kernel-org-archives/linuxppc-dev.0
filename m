Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42A6A14009B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 23:31:07 +1000 (EST)
Message-ID: <536B8716.5010807@suse.de>
Date: Thu, 08 May 2014 15:31:02 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
Subject: Re: [PATCH v2 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-4-git-send-email-mihai.caraman@freescale.com>
 <53636B71.2020103@suse.de>
 <f5c0d1ca058346edb91f347eeb399cac@BY2PR03MB508.namprd03.prod.outlook.com>
In-Reply-To: <f5c0d1ca058346edb91f347eeb399cac@BY2PR03MB508.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2014 09:06 PM, mihai.caraman@freescale.com wrote:
>> -----Original Message-----
>> From: Alexander Graf [mailto:agraf@suse.de]
>> Sent: Friday, May 02, 2014 12:55 PM
>> To: Caraman Mihai Claudiu-B02008
>> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH v2 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
>>
>> On 05/01/2014 02:45 AM, Mihai Caraman wrote:
> ...
>>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h
>> b/arch/powerpc/include/asm/kvm_ppc.h
>>> index 4096f16..6e7c358 100644
>>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>> @@ -72,6 +72,8 @@ extern int kvmppc_sanity_check(struct kvm_vcpu
>> *vcpu);
>>>    extern int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu);
>>>    extern void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu);
>>>
>>> +extern int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst);
>> Phew. Moving this into a separate function sure has some performance
>> implications. Was there no way to keep it in a header?
>>
>> You could just move it into its own .h file which we include after
>> kvm_ppc.h. That way everything's available. That would also help me a
>> lot with the little endian port where I'm also struggling with header
>> file inclusion order and kvmppc_need_byteswap().
> Great, I will do this.
>
>>> diff --git a/arch/powerpc/kvm/book3s_pr.c
>> b/arch/powerpc/kvm/book3s_pr.c
>>> index c5c052a..b7fffd1 100644
>>> --- a/arch/powerpc/kvm/book3s_pr.c
>>> +++ b/arch/powerpc/kvm/book3s_pr.c
>>> @@ -608,12 +608,9 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu,
>> ulong msr)
>>>    static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
>>>    {
>>> -	ulong srr0 = kvmppc_get_pc(vcpu);
>>> -	u32 last_inst = kvmppc_get_last_inst(vcpu);
>>> -	int ret;
>>> +	u32 last_inst;
>>>
>>> -	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
>>> -	if (ret == -ENOENT) {
>>> +	if (kvmppc_get_last_inst(vcpu, &last_inst) == -ENOENT) {
>> ENOENT?
> You have to tell us :) Why does kvmppc_ld() mix emulation_result
> enumeration with generic errors? Do you want to change that and
> use EMULATE_FAIL instead?

Haha you're right. Man, this code sucks :). No, leave it be for now.

>
>>>    		ulong msr = vcpu->arch.shared->msr;
>>>
>>>    		msr = kvmppc_set_field(msr, 33, 33, 1);
>>> @@ -867,15 +864,18 @@ int kvmppc_handle_exit_pr(struct kvm_run *run,
>> struct kvm_vcpu *vcpu,
>>>    	{
>>>    		enum emulation_result er;
>>>    		ulong flags;
>>> +		u32 last_inst;
>>>
>>>    program_interrupt:
>>>    		flags = vcpu->arch.shadow_srr1 & 0x1f0000ull;
>>> +		kvmppc_get_last_inst(vcpu, &last_inst);
>> No check for the return value?
> Should we queue a program exception and resume guest?

Depends on the return code. We need to be able to handle EMULATE_AGAIN 
everywhere now.

>
>>>    		if (vcpu->arch.shared->msr & MSR_PR) {
>>>    #ifdef EXIT_DEBUG
>>> -			printk(KERN_INFO "Userspace triggered 0x700 exception
>> at 0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
>>> +			pr_info("Userspace triggered 0x700 exception at\n"
>>> +			    "0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), last_inst);
>>>    #endif
>>> -			if ((kvmppc_get_last_inst(vcpu) & 0xff0007ff) !=
>>> +			if ((last_inst & 0xff0007ff) !=
>>>    			    (INS_DCBZ & 0xfffffff7)) {
>>>    				kvmppc_core_queue_program(vcpu, flags);
>>>    				r = RESUME_GUEST;
>>> @@ -894,7 +894,7 @@ program_interrupt:
>>>    			break;
>>>    		case EMULATE_FAIL:
>>>    			printk(KERN_CRIT "%s: emulation at %lx failed
>> (%08x)\n",
>>> -			       __func__, kvmppc_get_pc(vcpu),
>> kvmppc_get_last_inst(vcpu));
>>> +			       __func__, kvmppc_get_pc(vcpu), last_inst);
>>>    			kvmppc_core_queue_program(vcpu, flags);
>>>    			r = RESUME_GUEST;
>>>    			break;
>>> @@ -911,8 +911,12 @@ program_interrupt:
>>>    		break;
>>>    	}
>>>    	case BOOK3S_INTERRUPT_SYSCALL:
>>> +	{
>>> +		u32 last_sc;
>>> +
>>> +		kvmppc_get_last_sc(vcpu, &last_sc);
>> No check for the return value?
> The existing code does not handle KVM_INST_FETCH_FAILED.
> How should we continue if papr is enabled and last_sc fails?

I'd say go back into the guest and try again ;). Keep in mind that sc 
already sets srr0 to pc + 4, so we need to subtract 4 from pc and then 
go back into the guest.

>
>>>    		if (vcpu->arch.papr_enabled &&
>>> -		    (kvmppc_get_last_sc(vcpu) == 0x44000022) &&
>>> +		    (last_sc == 0x44000022) &&
>>>    		    !(vcpu->arch.shared->msr & MSR_PR)) {
>>>    			/* SC 1 papr hypercalls */
>>>    			ulong cmd = kvmppc_get_gpr(vcpu, 3);
>>> @@ -957,6 +961,7 @@ program_interrupt:
>>>    			r = RESUME_GUEST;
>>>    		}
>>>    		break;
>>> +	}
>>>    	case BOOK3S_INTERRUPT_FP_UNAVAIL:
>>>    	case BOOK3S_INTERRUPT_ALTIVEC:
>>>    	case BOOK3S_INTERRUPT_VSX:
>>> @@ -985,15 +990,20 @@ program_interrupt:
>>>    		break;
>>>    	}
>>>    	case BOOK3S_INTERRUPT_ALIGNMENT:
>>> +	{
>>> +		u32 last_inst;
>>> +
>>>    		if (kvmppc_read_inst(vcpu) == EMULATE_DONE) {
>>> -			vcpu->arch.shared->dsisr = kvmppc_alignment_dsisr(vcpu,
>>> -				kvmppc_get_last_inst(vcpu));
>>> -			vcpu->arch.shared->dar = kvmppc_alignment_dar(vcpu,
>>> -				kvmppc_get_last_inst(vcpu));
>>> +			kvmppc_get_last_inst(vcpu, &last_inst);
>> I think with an error returning kvmppc_get_last_inst we can just use
>> completely get rid of kvmppc_read_inst() and only use
>> kvmppc_get_last_inst() instead.
> The only purpose of kvmppc_read_inst() function is to generate an
> instruction storage interrupt in case of load failure. It is also called
> from kvmppc_check_ext(). Do you suggest to get rid of this logic? Or to
> duplicate it in order to avoid kvmppc_get_last_inst() redundant call?

I don't think we need that logic. If we get EMULATE_AGAIN, we just have 
to make sure we go back into the guest. No need to inject an ISI into 
the guest - it'll do that all by itself.


Alex
