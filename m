Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18FD71A000B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 17:26:34 +1000 (EST)
Message-ID: <53E87023.6080200@suse.de>
Date: Mon, 11 Aug 2014 09:26:27 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH v3] powerpc/kvm: support to handle sw breakpoint
References: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.08.14 06:50, Madhavan Srinivasan wrote:
> This patch adds kernel side support for software breakpoint.
> Design is that, by using an illegal instruction, we trap to hypervisor
> via Emulation Assistance interrupt, where we check for the illegal instruction
> and accordingly we return to Host or Guest. Patch also adds support for
> software breakpoint in PR KVM.
>
> Changes v2->v3:
>   Changed the debug instructions. Using the all zero opcode in the instruction word
>    as illegal instruction as mentioned in Power ISA instead of ABS
>   Removed reg updated in emulation assist and added a call to
>    kvmppc_emulate_instruction for reg update.
>
> Changes v1->v2:
>
>   Moved the debug instruction #def to kvm_book3s.h. This way PR_KVM can also share it.
>   Added code to use KVM get one reg infrastructure to get debug opcode.
>   Updated emulate.c to include emulation of debug instruction incase of PR_KVM.
>   Made changes to commit message.
>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/kvm_book3s.h |  7 +++++++
>   arch/powerpc/include/asm/ppc-opcode.h |  5 +++++
>   arch/powerpc/kvm/book3s.c             |  3 ++-
>   arch/powerpc/kvm/book3s_hv.c          | 12 ++++++++++--
>   arch/powerpc/kvm/book3s_pr.c          |  3 +++
>   arch/powerpc/kvm/emulate.c            |  9 +++++++++
>   6 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index f52f656..f17e3fd 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -24,6 +24,13 @@
>   #include <linux/kvm_host.h>
>   #include <asm/kvm_book3s_asm.h>
>   
> +/*
> + * KVMPPC_INST_BOOK3S_DEBUG is debug Instruction for supporting Software Breakpoint.
> + * Based on PowerISA v2.07, Instruction with opcode 0s will be treated as illegal
> + * instruction.
> + */
> +#define KVMPPC_INST_BOOK3S_DEBUG	0x00dddd00
> +
>   struct kvmppc_bat {
>   	u64 raw;
>   	u32 bepi;
> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> index 3132bb9..56739b3 100644
> --- a/arch/powerpc/include/asm/ppc-opcode.h
> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> @@ -111,6 +111,11 @@
>   #define OP_31_XOP_LHBRX     790
>   #define OP_31_XOP_STHBRX    918
>   
> +/* KVMPPC_INST_BOOK3S_DEBUG -- Software breakpoint Instruction
> + * 0x00dddd00 -- Primary opcode is 0s
> + */
> +#define OP_ZERO                 0x0
> +
>   #define OP_LWZ  32
>   #define OP_LD   58
>   #define OP_LWZU 33
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index c254c27..b40fe5d 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -789,7 +789,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
>   int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>   					struct kvm_guest_debug *dbg)
>   {
> -	return -EINVAL;
> +	vcpu->guest_debug = dbg->control;
> +	return 0;
>   }
>   
>   void kvmppc_decrementer_func(unsigned long data)
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 7a12edb..7c16f4f 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -725,8 +725,13 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	 * we don't emulate any guest instructions at this stage.
>   	 */
>   	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
> -		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> -		r = RESUME_GUEST;
> +		if (kvmppc_get_last_inst(vcpu) == KVMPPC_INST_BOOK3S_DEBUG) {
> +			kvmppc_emulate_instruction(run, vcpu);

I changed the emulation code flow very recently, so while I advised you 
to write it this way this won't work with recent git versions anymore :(.

Please just create a tiny static function that handles this particular 
inst and duplicate the logic in book3s_emulate.c (for PR) as well as 
here (for HV).

> +			r = RESUME_HOST;
> +		} else {
> +			kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> +			r = RESUME_GUEST;
> +		}
>   		break;
>   	/*
>   	 * This occurs if the guest (kernel or userspace), does something that
> @@ -831,6 +836,9 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
>   	long int i;
>   
>   	switch (id) {
> +	case KVM_REG_PPC_DEBUG_INST:
> +		*val = get_reg_val(id, KVMPPC_INST_BOOK3S_DEBUG);
> +		break;
>   	case KVM_REG_PPC_HIOR:
>   		*val = get_reg_val(id, 0);
>   		break;
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 8eef1e5..27f5234 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1229,6 +1229,9 @@ static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
>   	int r = 0;
>   
>   	switch (id) {
> +	case KVM_REG_PPC_DEBUG_INST:
> +		*val = get_reg_val(id, KVMPPC_INST_BOOK3S_DEBUG);
> +		break;
>   	case KVM_REG_PPC_HIOR:
>   		*val = get_reg_val(id, to_book3s(vcpu)->hior);
>   		break;
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index da86d9b..d95014e 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c

This should be book3s_emulate.c.


Alex
