Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 992761A0173
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 20:17:54 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sat, 23 Aug 2014 20:17:53 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EF3AD2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 20:17:49 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7NAIlBF16777356
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 20:18:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7NAHn4B012854
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 20:17:49 +1000
Message-ID: <53F86A4A.6080303@linux.vnet.ibm.com>
Date: Sat, 23 Aug 2014 15:47:46 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH v4] powerpc/kvm: support to handle sw breakpoint
References: <1408513929-5267-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53F5B77D.3000007@suse.de>
In-Reply-To: <53F5B77D.3000007@suse.de>
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

On Thursday 21 August 2014 02:40 PM, Alexander Graf wrote:
> 
> 
> On 20.08.14 07:52, Madhavan Srinivasan wrote:
>> This patch adds kernel side support for software breakpoint.
>> Design is that, by using an illegal instruction, we trap to hypervisor
>> via Emulation Assistance interrupt, where we check for the illegal instruction
>> and accordingly we return to Host or Guest. Patch also adds support for
>> software breakpoint in PR KVM.
>>
>> Changes v3->v4:
>>  Made changes to code comments and removed #define of zero opcode
>>  Added a new function to handle the debug instruction emulation in book3s_hv
>>  Rebased the code to latest upstream source.
>>
>> Changes v2->v3:
>>  Changed the debug instructions. Using the all zero opcode in the instruction word
>>   as illegal instruction as mentioned in Power ISA instead of ABS
>>  Removed reg updated in emulation assist and added a call to
>>   kvmppc_emulate_instruction for reg update.
>>
>> Changes v1->v2:
>>
>>  Moved the debug instruction #def to kvm_book3s.h. This way PR_KVM can also share it.
>>  Added code to use KVM get one reg infrastructure to get debug opcode.
>>  Updated emulate.c to include emulation of debug instruction incase of PR_KVM.
>>  Made changes to commit message.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kvm_book3s.h |  7 +++++++
>>  arch/powerpc/kvm/book3s.c             |  3 ++-
>>  arch/powerpc/kvm/book3s_hv.c          | 32 ++++++++++++++++++++++++++++++--
>>  arch/powerpc/kvm/book3s_pr.c          |  3 +++
>>  arch/powerpc/kvm/emulate.c            | 11 +++++++++++
>>  5 files changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
>> index 6acf0c2..a1944f8 100644
>> --- a/arch/powerpc/include/asm/kvm_book3s.h
>> +++ b/arch/powerpc/include/asm/kvm_book3s.h
>> @@ -24,6 +24,13 @@
>>  #include <linux/kvm_host.h>
>>  #include <asm/kvm_book3s_asm.h>
>>  
>> +/*
>> + * KVMPPC_INST_BOOK3S_DEBUG is debug Instruction for supporting Software Breakpoint.
>> + * Based on PowerISA v2.07, Instruction with primary opcode 0 will be treated as illegal
>> + * instruction.
>> + */
>> +#define KVMPPC_INST_BOOK3S_DEBUG	0x00dddd00
> 
> Please change the BookE version of this as well, put the define in a
> common header and use a non book specific name.
> 

I first wanted to get the server side in and then take up this, but i
can do it with this, just concerned incase of booke testing :(

>> +
>>  struct kvmppc_bat {
>>  	u64 raw;
>>  	u32 bepi;
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
>> index 27cced9..0a92e45 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -725,6 +725,14 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
>>  	return kvmppc_hcall_impl_hv_realmode(cmd);
>>  }
>>  
>> +static int kvmppc_emulate_debug_instruction_hv(struct kvm_run *run,
>> +					struct kvm_vcpu *vcpu)
>> +{
>> +	run->exit_reason = KVM_EXIT_DEBUG;
>> +	run->debug.arch.address = kvmppc_get_pc(vcpu);
>> +	return 0;
>> +}
>> +
>>  static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  				 struct task_struct *tsk)
>>  {
>> @@ -811,9 +819,26 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>  	 * we don't emulate any guest instructions at this stage.
> 
> This comment is no longer true, it should get changed.
> 

Will change it.

>>  	 */
>>  	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
>> -		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>> -		r = RESUME_GUEST;
>> +	{
>> +		u32 last_inst;
>> +		if(kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst) !=
>> +					EMULATE_DONE) {
> 
> Please only do this if debugging is active.
> 

Ok sure. But i will add in the else part of the check. Since we do the
instruction check there.

>> +			/*
>> +			 * Fetch failed, so return to guest and
>> +			 * try executing it again.
>> +			 */
>> +			r = RESUME_GUEST;
>> +		} else {
>> +			if (last_inst == KVMPPC_INST_BOOK3S_DEBUG) {
>> +				kvmppc_emulate_debug_instruction_hv(run, vcpu);
>> +				r = RESUME_HOST;
>> +			} else {
>> +				kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>> +				r = RESUME_GUEST;
>> +			}
>> +		}
>>  		break;
>> +	}
>>  	/*
>>  	 * This occurs if the guest (kernel or userspace), does something that
>>  	 * is prohibited by HFSCR.  We just generate a program interrupt to
>> @@ -922,6 +947,9 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>>  	long int i;
>>  
>>  	switch (id) {
>> +	case KVM_REG_PPC_DEBUG_INST:
>> +		*val = get_reg_val(id, KVMPPC_INST_BOOK3S_DEBUG);
>> +		break;
>>  	case KVM_REG_PPC_HIOR:
>>  		*val = get_reg_val(id, 0);
>>  		break;
>> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>> index faffb27..cd2a39d 100644
>> --- a/arch/powerpc/kvm/book3s_pr.c
>> +++ b/arch/powerpc/kvm/book3s_pr.c
>> @@ -1319,6 +1319,9 @@ static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
>>  	int r = 0;
>>  
>>  	switch (id) {
>> +	case KVM_REG_PPC_DEBUG_INST:
>> +		*val = get_reg_val(id, KVMPPC_INST_BOOK3S_DEBUG);
>> +		break;
>>  	case KVM_REG_PPC_HIOR:
>>  		*val = get_reg_val(id, to_book3s(vcpu)->hior);
>>  		break;
>> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
>> index e96b50d..68f38b2 100644
>> --- a/arch/powerpc/kvm/emulate.c
>> +++ b/arch/powerpc/kvm/emulate.c
>> @@ -274,6 +274,17 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
>>  		}
>>  		break;
>>  
>> +	case 0:
>> +		/*
>> +		 * Instruction with primary opcode 0. Based on PowerISA
>> +		 * these are illegal instructions.
>> +		 */
>> +		run->exit_reason = KVM_EXIT_DEBUG;
> 
> This is wrong. We need to check that the instruction is 0x00dddd00. Any
> other op0 instruction should trigger an invalid instruction trap.
> 

Ok.

Thanks for review
Regards
Maddy
> 
> Alex
> 
>> +		run->debug.arch.address = kvmppc_get_pc(vcpu);
>> +		emulated = EMULATE_EXIT_USER;
>> +		advance = 0;
>> +		break;
>> +
>>  	default:
>>  		emulated = EMULATE_FAIL;
>>  	}
>>
> 
