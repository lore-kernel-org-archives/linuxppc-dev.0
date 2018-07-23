Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Yr584DkYzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 15:43:40 +1000 (AEST)
Date: Mon, 23 Jul 2018 15:43:37 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au, clg@kaod.org
Subject: Re: [PATCH v3 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
Message-ID: <20180723054337.GA29207@fergus>
References: <1fb3aea5f44f1029866ee10db40abde7e18b24ad.1531967105.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1fb3aea5f44f1029866ee10db40abde7e18b24ad.1531967105.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2018 at 12:25:10PM +1000, Sam Bobroff wrote:
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

I have some comments relating to the situation where the stride
(i.e. kvm->arch.emul_smt_mode) is less than 8; see below.

[snip]
> +static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
> +{
> +	const int block_offsets[MAX_SMT_THREADS] = {0, 4, 2, 6, 1, 3, 5, 7};

This needs to be {0, 4, 2, 6, 1, 5, 3, 7} (with the 3 and 5 swapped
from what you have) for the case when stride == 4 and block == 3.  In
that case we need block_offsets[block] to be 3; if it is 5, then we
will collide with the case where block == 2 for the next virtual core.

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
> index de686b340f4a..363c2fb0d89e 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1816,7 +1816,7 @@ static int threads_per_vcore(struct kvm *kvm)
>  	return threads_per_subcore;
>  }
>  
> -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int id)
>  {
>  	struct kvmppc_vcore *vcore;
>  
> @@ -1830,7 +1830,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
>  	init_swait_queue_head(&vcore->wq);
>  	vcore->preempt_tb = TB_NIL;
>  	vcore->lpcr = kvm->arch.lpcr;
> -	vcore->first_vcpuid = core * kvm->arch.smt_mode;
> +	vcore->first_vcpuid = id;
>  	vcore->kvm = kvm;
>  	INIT_LIST_HEAD(&vcore->preempt_list);
>  
> @@ -2048,12 +2048,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>  	mutex_lock(&kvm->lock);
>  	vcore = NULL;
>  	err = -EINVAL;
> -	core = id / kvm->arch.smt_mode;
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		BUG_ON(kvm->arch.smt_mode != 1);
> +		core = kvmppc_pack_vcpu_id(kvm, id);

We now have a way for userspace to trigger a BUG_ON, as far as I can
see.  The only check on id up to this point is that it is less than
KVM_MAX_VCPU_ID, which means that the BUG_ON(block >= MAX_SMT_THREADS)
can be triggered, if kvm->arch.emul_smt_mode < MAX_SMT_THREADS, by
giving an id that is greater than or equal to KVM_MAX_VCPUS *
kvm->arch.emul_smt+mode.

> +	} else {
> +		core = id / kvm->arch.smt_mode;
> +	}
>  	if (core < KVM_MAX_VCORES) {
>  		vcore = kvm->arch.vcores[core];
> +		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);

Doesn't this just mean that userspace has chosen an id big enough to
cause a collision in the output space of kvmppc_pack_vcpu_id()?  How
is this not user-triggerable?

Paul.
