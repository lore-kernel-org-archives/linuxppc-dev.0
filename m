Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 460151A0253
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 00:20:55 +1000 (EST)
Message-ID: <53C7DBC3.2060104@suse.de>
Date: Thu, 17 Jul 2014 16:20:51 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail
References: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
 <1405596148-1507-5-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1405596148-1507-5-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 17.07.14 13:22, Mihai Caraman wrote:
> On book3e, guest last instruction is read on the exit path using load
> external pid (lwepx) dedicated instruction. This load operation may fail
> due to TLB eviction and execute-but-not-read entries.
>
> This patch lay down the path for an alternative solution to read the guest
> last instruction, by allowing kvmppc_get_lat_inst() function to fail.
> Architecture specific implmentations of kvmppc_load_last_inst() may read
> last guest instruction and instruct the emulation layer to re-execute the
> guest in case of failure.
>
> Make kvmppc_get_last_inst() definition common between architectures.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v5
>   - don't swap when load fail
>   - convert the return value space of kvmppc_ld()
>
> v4:
>   - these changes compile on book3s, please validate the functionality and
>     do the necessary adaptations!
>   - common declaration and enum for kvmppc_load_last_inst()
>   - remove kvmppc_read_inst() in a preceding patch
>
> v3:
>   - rework patch description
>   - add common definition for kvmppc_get_last_inst()
>   - check return values in book3s code
>
> v2:
>   - integrated kvmppc_get_last_inst() in book3s code and checked build
>   - addressed cosmetic feedback
>
>   arch/powerpc/include/asm/kvm_book3s.h    | 26 -------------
>   arch/powerpc/include/asm/kvm_booke.h     |  5 ---
>   arch/powerpc/include/asm/kvm_ppc.h       | 25 +++++++++++++
>   arch/powerpc/kvm/book3s.c                | 17 +++++++++
>   arch/powerpc/kvm/book3s_64_mmu_hv.c      | 17 +++------
>   arch/powerpc/kvm/book3s_paired_singles.c | 38 ++++++++++++-------
>   arch/powerpc/kvm/book3s_pr.c             | 63 ++++++++++++++++++++++----------
>   arch/powerpc/kvm/booke.c                 |  3 ++
>   arch/powerpc/kvm/e500_mmu_host.c         |  6 +++
>   arch/powerpc/kvm/emulate.c               | 18 ++++++---
>   arch/powerpc/kvm/powerpc.c               | 11 +++++-
>   11 files changed, 144 insertions(+), 85 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index 20fb6f2..a86ca65 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -276,32 +276,6 @@ static inline bool kvmppc_need_byteswap(struct kvm_vcpu *vcpu)
>   	return (kvmppc_get_msr(vcpu) & MSR_LE) != (MSR_KERNEL & MSR_LE);
>   }
>   
> -static inline u32 kvmppc_get_last_inst_internal(struct kvm_vcpu *vcpu, ulong pc)
> -{
> -	/* Load the instruction manually if it failed to do so in the
> -	 * exit path */
> -	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
> -		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
> -
> -	return kvmppc_need_byteswap(vcpu) ? swab32(vcpu->arch.last_inst) :
> -		vcpu->arch.last_inst;
> -}
> -
> -static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
> -{
> -	return kvmppc_get_last_inst_internal(vcpu, kvmppc_get_pc(vcpu));
> -}
> -
> -/*
> - * Like kvmppc_get_last_inst(), but for fetching a sc instruction.
> - * Because the sc instruction sets SRR0 to point to the following
> - * instruction, we have to fetch from pc - 4.
> - */
> -static inline u32 kvmppc_get_last_sc(struct kvm_vcpu *vcpu)
> -{
> -	return kvmppc_get_last_inst_internal(vcpu, kvmppc_get_pc(vcpu) - 4);
> -}
> -
>   static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
>   {
>   	return vcpu->arch.fault_dar;
> diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
> index c7aed61..cbb1990 100644
> --- a/arch/powerpc/include/asm/kvm_booke.h
> +++ b/arch/powerpc/include/asm/kvm_booke.h
> @@ -69,11 +69,6 @@ static inline bool kvmppc_need_byteswap(struct kvm_vcpu *vcpu)
>   	return false;
>   }
>   
> -static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu->arch.last_inst;
> -}
> -
>   static inline void kvmppc_set_ctr(struct kvm_vcpu *vcpu, ulong val)
>   {
>   	vcpu->arch.ctr = val;
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index e2fd5a1..7f9c634 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -47,6 +47,11 @@ enum emulation_result {
>   	EMULATE_EXIT_USER,    /* emulation requires exit to user-space */
>   };
>   
> +enum instruction_type {
> +	INST_GENERIC,
> +	INST_SC,		/* system call */
> +};
> +
>   extern int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
>   extern int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
>   extern void kvmppc_handler_highmem(void);
> @@ -62,6 +67,9 @@ extern int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   			       u64 val, unsigned int bytes,
>   			       int is_default_endian);
>   
> +extern int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
> +				 enum instruction_type type, u32 *inst);
> +
>   extern int kvmppc_emulate_instruction(struct kvm_run *run,
>                                         struct kvm_vcpu *vcpu);
>   extern int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu);
> @@ -234,6 +242,23 @@ struct kvmppc_ops {
>   extern struct kvmppc_ops *kvmppc_hv_ops;
>   extern struct kvmppc_ops *kvmppc_pr_ops;
>   
> +static inline int kvmppc_get_last_inst(struct kvm_vcpu *vcpu,
> +					enum instruction_type type, u32 *inst)
> +{
> +	int ret = EMULATE_DONE;
> +
> +	/* Load the instruction manually if it failed to do so in the
> +	 * exit path */
> +	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
> +		ret = kvmppc_load_last_inst(vcpu, type, &vcpu->arch.last_inst);
> +
> +
> +	*inst = (ret == EMULATE_DONE && kvmppc_need_byteswap(vcpu)) ?
> +		swab32(vcpu->arch.last_inst) : vcpu->arch.last_inst;

This makes even less sense than the previous version. Either you treat 
inst as "definitely overwritten" or as "preserves previous data on failure".

So either you unconditionally swap like you did before or you do

if (ret == EMULATE_DONE)
     *inst = kvmppc_need_byteswap(vcpu) ? swab32(vcpu->arch.last_inst) : 
vcpu->arch.last_inst;

> +
> +	return ret;
> +}
> +
>   static inline bool is_kvmppc_hv_enabled(struct kvm *kvm)
>   {
>   	return kvm->arch.kvm_ops == kvmppc_hv_ops;
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 31facfc..522be6b 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -488,6 +488,23 @@ mmio:
>   }
>   EXPORT_SYMBOL_GPL(kvmppc_ld);
>   
> +int kvmppc_load_last_inst(struct kvm_vcpu *vcpu, enum instruction_type type,
> +					 u32 *inst)
> +{
> +	ulong pc = kvmppc_get_pc(vcpu);
> +	int r;
> +
> +	if (type == INST_SC)
> +		pc -= 4;
> +
> +	r = kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);

inst is unused?

The rest looks pretty nice though :).


Alex
