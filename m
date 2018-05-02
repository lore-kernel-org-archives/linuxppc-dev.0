Return-Path: <clg@kaod.org>
Received: from 3.mo178.mail-out.ovh.net (3.mo178.mail-out.ovh.net
 [46.105.44.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bdMS45krzF2SV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 22:46:58 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.105.57])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 234D115D43
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 14:31:08 +0200 (CEST)
Subject: Re: [PATCH v2 RFC 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, paulus@samba.org,
 david@gibson.dropbear.id.au
References: <aafa1e1ec2e331b0842855c2e5e46a0c2d011acc.1525150933.git.sbobroff@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0cadab31-6122-c789-7137-2172585ecc74@kaod.org>
Date: Wed, 2 May 2018 14:30:51 +0200
MIME-Version: 1.0
In-Reply-To: <aafa1e1ec2e331b0842855c2e5e46a0c2d011acc.1525150933.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2018 07:04 AM, Sam Bobroff wrote:
> From: Sam Bobroff <sam.bobroff@au1.ibm.com>
> 
> It is not currently possible to create the full number of possible
> VCPUs (KVM_MAX_VCPUS) on Power9 with KVM-HV when the guest uses less
> threads per core than it's core stride (or "VSMT mode"). This is
> because the VCORE ID and XIVE offsets to grow beyond KVM_MAX_VCPUS
> even though the VCPU ID is less than KVM_MAX_VCPU_ID.
> 
> To address this, "pack" the VCORE ID and XIVE offsets by using
> knowledge of the way the VCPU IDs will be used when there are less
> guest threads per core than the core stride. The primary thread of
> each core will always be used first. Then, if the guest uses more than
> one thread per core, these secondary threads will sequentially follow
> the primary in each core.
> 
> So, the only way an ID above KVM_MAX_VCPUS can be seen, is if the
> VCPUs are being spaced apart, so at least half of each core is empty
> and IDs between KVM_MAX_VCPUS and (KVM_MAX_VCPUS * 2) can be mapped
> into the second half of each core (4..7, in an 8-thread core).
> 
> Similarly, if IDs above KVM_MAX_VCPUS * 2 are seen, at least 3/4 of
> each core is being left empty, and we can map down into the second and
> third quarters of each core (2, 3 and 5, 6 in an 8-thread core).
> 
> Lastly, if IDs above KVM_MAX_VCPUS * 4 are seen, only the primary
> threads are being used and 7/8 of the core is empty, allowing use of
> the 1, 3, 5 and 7 thread slots.
> 
> (Strides less than 8 are handled similarly.)
> 
> This allows the VCORE ID or offset to be calculated quickly from the
> VCPU ID or XIVE server numbers, without access to the VCPU structure.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> Hello everyone,
> 
> I've tested this on P8 and P9, in lots of combinations of host and guest
> threading modes and it has been fine but it does feel like a "tricky"
> approach, so I still feel somewhat wary about it.
> 
> I've posted it as an RFC because I have not tested it with guest native-XIVE,
> and I suspect that it will take some work to support it.
> ====== v1 -> v2: ======
> 
> Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID space
> * Corrected places in kvm/book3s_xive.c where IDs weren't packed.
> * Because kvmppc_pack_vcpu_id() is only called on P9, there is no need to test "emul_smt_mode > 1", so remove it.
> * Re-ordered block_offsets[] to be more ascending.
> * Added more detailed description of the packing algorithm.
> 
> ====== v1: ======
> 
> Patch 1/1: KVM: PPC: Book3S HV: pack VCORE IDs to access full VCPU ID space
> 
>  arch/powerpc/include/asm/kvm_book3s.h | 44 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_hv.c          | 14 +++++++----
>  arch/powerpc/kvm/book3s_xive.c        | 19 +++++++++------
>  3 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index 376ae803b69c..a8d9d625e873 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -368,4 +368,48 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu *vcpu);
>  #define SPLIT_HACK_MASK			0xff000000
>  #define SPLIT_HACK_OFFS			0xfb000000
>  
> +/* Pack a VCPU ID from the [0..KVM_MAX_VCPU_ID) space down to the
> + * [0..KVM_MAX_VCPUS) space, while using knowledge of the guest's core stride
> + * (but not it's actual threading mode, which is not available) to avoid
> + * collisions.
> + *
> + * The implementation leaves VCPU IDs from the range [0..KVM_MAX_VCPUS) (block
> + * 0) unchanged: if the guest is filling each VCORE completely then it will be
> + * using consecutive IDs and it will fill the space without any packing.
> + *
> + * For higher VCPU IDs, the packed ID is based on the VCPU ID modulo
> + * KVM_MAX_VCPUS (effectively masking off the top bits) and then an offset is
> + * added to avoid collisions.
> + *
> + * VCPU IDs in the range [KVM_MAX_VCPUS..(KVM_MAX_VCPUS*2)) (block 1) are only
> + * possible if the guest is leaving at least 1/2 of each VCORE empty, so IDs
> + * can be safely packed into the second half of each VCORE by adding an offset
> + * of (stride / 2).
> + *
> + * Similarly, if VCPU IDs in the range [(KVM_MAX_VCPUS*2)..(KVM_MAX_VCPUS*4))
> + * (blocks 2 and 3) are seen, the guest must be leaving at least 3/4 of each
> + * VCORE empty so packed IDs can be offset by (stride / 4) and (stride * 3 / 4).
> + *
> + * Finally, VCPU IDs from blocks 5..7 will only be seen if the guest is using a
> + * stride of 8 and 1 thread per core so the remaining offsets of 1, 3, 5 and 7
> + * must be free to use.
> + *
> + * (The offsets for each block are stored in block_offsets[], indexed by the
> + * block number if the stride is 8. For cases where the guest's stride is less
> + * than 8, we can re-use the block_offsets array by multiplying the block
> + * number by (MAX_SMT_THREADS / stride) to reach the correct entry.)
> + */
> +static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
> +{
> +	const int block_offsets[MAX_SMT_THREADS] = {0, 4, 2, 6, 1, 3, 5, 7};
> +	int stride = kvm->arch.emul_smt_mode;
> +	int block = (id / KVM_MAX_VCPUS) * (MAX_SMT_THREADS / stride);
> +	u32 packed_id;
> +
> +	BUG_ON(block >= MAX_SMT_THREADS);
> +	packed_id = (id % KVM_MAX_VCPUS) + block_offsets[block];
> +	BUG_ON(packed_id >= KVM_MAX_VCPUS);
> +	return packed_id;
> +}
> +
>  #endif /* __ASM_KVM_BOOK3S_H__ */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 9cb9448163c4..49165cc90051 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1762,7 +1762,7 @@ static int threads_per_vcore(struct kvm *kvm)
>  	return threads_per_subcore;
>  }
>  
> -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int id)
>  {
>  	struct kvmppc_vcore *vcore;
>  
> @@ -1776,7 +1776,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
>  	init_swait_queue_head(&vcore->wq);
>  	vcore->preempt_tb = TB_NIL;
>  	vcore->lpcr = kvm->arch.lpcr;
> -	vcore->first_vcpuid = core * kvm->arch.smt_mode;
> +	vcore->first_vcpuid = id;
>  	vcore->kvm = kvm;
>  	INIT_LIST_HEAD(&vcore->preempt_list);
>  
> @@ -1992,12 +1992,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>  	mutex_lock(&kvm->lock);
>  	vcore = NULL;
>  	err = -EINVAL;
> -	core = id / kvm->arch.smt_mode;
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		BUG_ON(kvm->arch.smt_mode != 1);
> +		core = kvmppc_pack_vcpu_id(kvm, id);
> +	} else {
> +		core = id / kvm->arch.smt_mode;
> +	}
>  	if (core < KVM_MAX_VCORES) {
>  		vcore = kvm->arch.vcores[core];
> +		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);
>  		if (!vcore) {
>  			err = -ENOMEM;
> -			vcore = kvmppc_vcore_create(kvm, core);
> +			vcore = kvmppc_vcore_create(kvm, id & ~(kvm->arch.smt_mode - 1));
>  			kvm->arch.vcores[core] = vcore;
>  			kvm->arch.online_vcores++;
>  		}
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> index f9818d7d3381..dbd5887daf4a 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -317,6 +317,11 @@ static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
>  	return -EBUSY;
>  }

 
Quick check : 

I suppose that the numbers used in the QEMU/KVM ioctl calls are 
the same than the ones used by the guest OS in the RTAS calls,
set-xive and get-xive, and in the hcalls, H_IPI and H_IPOLL. 
cpu->vcpu_id under QEMU ? 


The xive part looks sane but I think it would look even better 
if we could get rid of the 'xive->vp_base + NUMBER' beforehand. 
These calculations are shortcuts between CPU number spaces.
To fix that, we could add a 'act_vp_id' field under 
kvmppc_xive_irq_state which would be assigned to the 'vp_id' 
of the selected target. And so, xive_select_target() needs some 
changes.


C.

> +static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
> +{
> +	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
> +}
> +
>  static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>  			     struct kvmppc_xive_src_block *sb,
>  			     struct kvmppc_xive_irq_state *state)
> @@ -362,7 +367,7 @@ static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>  	 */
>  	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
>  		xive_native_configure_irq(hw_num,
> -					  xive->vp_base + state->act_server,
> +					  xive_vp(xive, state->act_server),
>  					  MASKED, state->number);
>  		/* set old_p so we can track if an H_EOI was done */
>  		state->old_p = true;
> @@ -418,7 +423,7 @@ static void xive_finish_unmask(struct kvmppc_xive *xive,
>  	 */
>  	if (xd->flags & OPAL_XIVE_IRQ_MASK_VIA_FW) {
>  		xive_native_configure_irq(hw_num,
> -					  xive->vp_base + state->act_server,
> +					  xive_vp(xive, state->act_server),
>  					  state->act_priority, state->number);
>  		/* If an EOI is needed, do it here */
>  		if (!state->old_p)
> @@ -495,7 +500,7 @@ static int xive_target_interrupt(struct kvm *kvm,
>  	kvmppc_xive_select_irq(state, &hw_num, NULL);
>  
>  	return xive_native_configure_irq(hw_num,
> -					 xive->vp_base + server,
> +					 xive_vp(xive, server),
>  					 prio, state->number);
>  }
>  
> @@ -883,7 +888,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
>  	 * which is fine for a never started interrupt.
>  	 */
>  	xive_native_configure_irq(hw_irq,
> -				  xive->vp_base + state->act_server,
> +				  xive_vp(xive, state->act_server),
>  				  state->act_priority, state->number);
>  
>  	/*
> @@ -959,7 +964,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
>  
>  	/* Reconfigure the IPI */
>  	xive_native_configure_irq(state->ipi_number,
> -				  xive->vp_base + state->act_server,
> +				  xive_vp(xive, state->act_server),
>  				  state->act_priority, state->number);
>  
>  	/*
> @@ -1084,7 +1089,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  		pr_devel("Duplicate !\n");
>  		return -EEXIST;
>  	}
> -	if (cpu >= KVM_MAX_VCPUS) {
> +	if (cpu >= KVM_MAX_VCPU_ID) {
>  		pr_devel("Out of bounds !\n");
>  		return -EINVAL;
>  	}
> @@ -1098,7 +1103,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	xc->xive = xive;
>  	xc->vcpu = vcpu;
>  	xc->server_num = cpu;
> -	xc->vp_id = xive->vp_base + cpu;
> +	xc->vp_id = xive_vp(xive, cpu);
>  	xc->mfrr = 0xff;
>  	xc->valid = true;
>  
> 
