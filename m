Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FF261A0068
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 17:31:09 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 9 Sep 2014 17:31:09 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8E1432BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 17:31:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8977EVU38600832
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 17:07:14 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s897V3Hf023099
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 17:31:04 +1000
Message-ID: <540EACB4.6040009@linux.vnet.ibm.com>
Date: Tue, 09 Sep 2014 13:01:00 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH 1/2 v5] powerpc/kvm: support to handle sw breakpoint
References: <1410107494-25556-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1410107494-25556-2-git-send-email-maddy@linux.vnet.ibm.com>
 <540DA980.1050708@suse.de>
In-Reply-To: <540DA980.1050708@suse.de>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 08 September 2014 06:35 PM, Alexander Graf wrote:
> 
> 
> On 07.09.14 18:31, Madhavan Srinivasan wrote:
>> This patch adds kernel side support for software breakpoint.
>> Design is that, by using an illegal instruction, we trap to hypervisor
>> via Emulation Assistance interrupt, where we check for the illegal instruction
>> and accordingly we return to Host or Guest. Patch also adds support for
>> software breakpoint in PR KVM.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kvm_ppc.h |  6 ++++++
>>  arch/powerpc/kvm/book3s.c          |  3 ++-
>>  arch/powerpc/kvm/book3s_hv.c       | 41 ++++++++++++++++++++++++++++++++++----
>>  arch/powerpc/kvm/book3s_pr.c       |  3 +++
>>  arch/powerpc/kvm/emulate.c         | 18 +++++++++++++++++
>>  5 files changed, 66 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index fb86a22..dd83c9a 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -38,6 +38,12 @@
>>  #include <asm/paca.h>
>>  #endif
>>  
>> +/*
>> + * KVMPPC_INST_SW_BREAKPOINT is debug Instruction
>> + * for supporting software breakpoint.
>> + */
>> +#define KVMPPC_INST_SW_BREAKPOINT	0x00dddd00
>> +
>>  enum emulation_result {
>>  	EMULATE_DONE,         /* no further processing */
>>  	EMULATE_DO_MMIO,      /* kvm_run filled with MMIO request */
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index dd03f6b..00e9c9f 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -778,7 +778,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>>  int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>>  					struct kvm_guest_debug *dbg)
>>  {
>> -	return -EINVAL;
>> +	vcpu->guest_debug = dbg->control;
>> +	return 0;
>>  }
>>  
>>  void kvmppc_decrementer_func(unsigned long data)
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 27cced9..3a2414c 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -725,6 +725,30 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
>>  	return kvmppc_hcall_impl_hv_realmode(cmd);
>>  }
>>  
>> +static int kvmppc_emulate_debug_inst(struct kvm_run *run,
>> +					struct kvm_vcpu *vcpu)
>> +{
>> +	u32 last_inst;
>> +
>> +	if(kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst) !=
>> +					EMULATE_DONE) {
>> +		/*
>> +		 * Fetch failed, so return to guest and
>> +		 * try executing it again.
>> +		 */
>> +		return RESUME_GUEST;
> 
> Please end the if() here. In the kernel we usually treat abort
> situations as separate.
> 

OK. Will change it.

>> +	} else {
>> +		if (last_inst == KVMPPC_INST_SW_BREAKPOINT) {
>> +			run->exit_reason = KVM_EXIT_DEBUG;
>> +			run->debug.arch.address = kvmppc_get_pc(vcpu);
>> +			return RESUME_HOST;
>> +		} else {
>> +			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>> +			return RESUME_GUEST;
>> +		}
>> +	}
>> +}
>> +
>>  static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  				 struct task_struct *tsk)
>>  {
>> @@ -807,12 +831,18 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  		break;
>>  	/*
>>  	 * This occurs if the guest executes an illegal instruction.
>> -	 * We just generate a program interrupt to the guest, since
>> -	 * we don't emulate any guest instructions at this stage.
>> +	 * If the guest debug is disabled, generate a program interrupt
>> +	 * to the guest. If guest debug is enabled, we need to check
>> +	 * whether the instruction is a software breakpoint instruction.
>> +	 * Accordingly return to Guest or Host.
>>  	 */
>>  	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
>> -		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>> -		r = RESUME_GUEST;
>> +		if(vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP) {
>> +			r = kvmppc_emulate_debug_inst(run, vcpu);
>> +		} else {
>> +			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>> +			r = RESUME_GUEST;
>> +		}
>>  		break;
>>  	/*
>>  	 * This occurs if the guest (kernel or userspace), does something that
>> @@ -922,6 +952,9 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>>  	long int i;
>>  
>>  	switch (id) {
>> +	case KVM_REG_PPC_DEBUG_INST:
>> +		*val = get_reg_val(id, KVMPPC_INST_SW_BREAKPOINT);
>> +		break;
>>  	case KVM_REG_PPC_HIOR:
>>  		*val = get_reg_val(id, 0);
>>  		break;
>> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>> index faffb27..6d73708 100644
>> --- a/arch/powerpc/kvm/book3s_pr.c
>> +++ b/arch/powerpc/kvm/book3s_pr.c
>> @@ -1319,6 +1319,9 @@ static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
>>  	int r = 0;
>>  
>>  	switch (id) {
>> +	case KVM_REG_PPC_DEBUG_INST:
>> +		*val = get_reg_val(id, KVMPPC_INST_SW_BREAKPOINT);
>> +		break;
>>  	case KVM_REG_PPC_HIOR:
>>  		*val = get_reg_val(id, to_book3s(vcpu)->hior);
>>  		break;
>> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
>> index e96b50d..30f326b 100644
>> --- a/arch/powerpc/kvm/emulate.c
>> +++ b/arch/powerpc/kvm/emulate.c
>> @@ -274,6 +274,24 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
>>  		}
>>  		break;
>>  
>> +	case 0:
>> +		/*
>> +		 * Instruction with primary opcode 0. Based on PowerISA
>> +		 * these are illegal instructions.
>> +		 */
>> +		if(inst == KVMPPC_INST_SW_BREAKPOINT) {
> 
> Here you're missing a space between if and (. Are you sure that you ran
> checkpatch.pl?
> 

No. my bad. Did not run checkpatch.pl. Will fix it.

> 
>> +			run->exit_reason = KVM_EXIT_DEBUG;
>> +			run->debug.arch.address = kvmppc_get_pc(vcpu);
>> +			emulated = EMULATE_EXIT_USER;
>> +			advance = 0;
>> +			printk(KERN_INFO "pr_emulate: debug instr \n");
>> +		} else {
>> +			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>> +			emulated = EMULATE_DONE;
>> +			advance = 0;
> 
> Just set emulated = EMULATE_FAIL here, the same as default:.
> 
> 

Ok sure will do.

Thanks for review.
Maddy

> Alex
> 
>> +		}
>> +		break;	
>> +
>>  	default:
>>  		emulated = EMULATE_FAIL;
>>  	}
>>
> 
