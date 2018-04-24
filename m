Return-Path: <clg@kaod.org>
Received: from 7.mo5.mail-out.ovh.net (7.mo5.mail-out.ovh.net [178.32.124.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VjNC1X47zF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 22:30:32 +1000 (AEST)
Received: from player737.ha.ovh.net (unknown [10.109.105.64])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id B00161A368C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 09:44:50 +0200 (CEST)
Subject: Re: [PATCH RFC 1/1] KVM: PPC: Book3S HV: pack VCORE IDs to access
 full VCPU ID space
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 paulus@samba.org
References: <70974cfb62a7f09a53ec914d2909639884228244.1523516498.git.sam.bobroff@au1.ibm.com>
 <20180416040942.GB20551@umbus.fritz.box>
 <1e01ea66-6103-94c8-ccb1-ed35b3a3104b@kaod.org>
 <20180424031914.GA25846@tungsten.ozlabs.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <42a0fb85-fe40-0d3c-5e06-55c3849e35b2@kaod.org>
Date: Tue, 24 Apr 2018 09:44:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180424031914.GA25846@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/24/2018 05:19 AM, Sam Bobroff wrote:
> On Mon, Apr 23, 2018 at 11:06:35AM +0200, Cédric Le Goater wrote:
>> On 04/16/2018 06:09 AM, David Gibson wrote:
>>> On Thu, Apr 12, 2018 at 05:02:06PM +1000, Sam Bobroff wrote:
>>>> It is not currently possible to create the full number of possible
>>>> VCPUs (KVM_MAX_VCPUS) on Power9 with KVM-HV when the guest uses less
>>>> threads per core than it's core stride (or "VSMT mode"). This is
>>>> because the VCORE ID and XIVE offsets to grow beyond KVM_MAX_VCPUS
>>>> even though the VCPU ID is less than KVM_MAX_VCPU_ID.
>>>>
>>>> To address this, "pack" the VCORE ID and XIVE offsets by using
>>>> knowledge of the way the VCPU IDs will be used when there are less
>>>> guest threads per core than the core stride. The primary thread of
>>>> each core will always be used first. Then, if the guest uses more than
>>>> one thread per core, these secondary threads will sequentially follow
>>>> the primary in each core.
>>>>
>>>> So, the only way an ID above KVM_MAX_VCPUS can be seen, is if the
>>>> VCPUs are being spaced apart, so at least half of each core is empty
>>>> and IDs between KVM_MAX_VCPUS and (KVM_MAX_VCPUS * 2) can be mapped
>>>> into the second half of each core (4..7, in an 8-thread core).
>>>>
>>>> Similarly, if IDs above KVM_MAX_VCPUS * 2 are seen, at least 3/4 of
>>>> each core is being left empty, and we can map down into the second and
>>>> third quarters of each core (2, 3 and 5, 6 in an 8-thread core).
>>>>
>>>> Lastly, if IDs above KVM_MAX_VCPUS * 4 are seen, only the primary
>>>> threads are being used and 7/8 of the core is empty, allowing use of
>>>> the 1, 3, 5 and 7 thread slots.
>>>>
>>>> (Strides less than 8 are handled similarly.)
>>>>
>>>> This allows the VCORE ID or offset to be calculated quickly from the
>>>> VCPU ID or XIVE server numbers, without access to the VCPU structure.
>>>>
>>>> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>>>> ---
>>>> Hello everyone,
>>>>
>>>> I've tested this on P8 and P9, in lots of combinations of host and guest
>>>> threading modes and it has been fine but it does feel like a "tricky"
>>>> approach, so I still feel somewhat wary about it.
>>
>> Have you done any migration ? 
> 
> No, but I will :-)
> 
>>>> I've posted it as an RFC because I have not tested it with guest native-XIVE,
>>>> and I suspect that it will take some work to support it.
>>
>> The KVM XIVE device will be different for XIVE exploitation mode, same structures 
>> though. I will send a patchset shortly. 
> 
> Great. This is probably where conflicts between the host and guest
> numbers will show up. (See dwg's question below.)

The 'server' part looks better than the XICS-over-XIVE glue in fact, 
may be because it has not yet been tortured.   


Here is my take on the server topic :

All the OPAL calls should take a 'vp_id' of some sort, the one from the 
struct kvmppc_xive_vcpu, or the result of a routine translating a guest 
side CPU number to a VP id in the range defined for the guest. Moreover,
it would be better to make sure the guest side CPU number is valid in 
KVM and do a kvmppc_xive_vcpu lookup each time we use one before calling
OPAL, like that we would also get the associated struct kvmppc_xive_vcpu 
and its 'vp_id'.

The 'server_num' of kvmppc_xive_vcpu should probably still be a guest 
side CPU number, but we need to check its usage. The only problem is 
when it is compared to 'act_server' of 'kvmppc_xive_irq_state'. 

if 'act_server' was a VP id that would make our life easier. we could 
get rid of xive->vp_base + NUMBER usage in : 

	xive_native_configure_irq( ..., xive->vp_base + server, ...)

Would it be complex to have a routine converting back a VP id to a
guest side cpu number ? we would need it in get_xive() and get_source()

If we start shuffling the XIVE code in the direction above, I rather
do it to make sure the XIVE native exploitation mode patchset stays in 
sync. 

>>>>  arch/powerpc/include/asm/kvm_book3s.h | 19 +++++++++++++++++++
>>>>  arch/powerpc/kvm/book3s_hv.c          | 14 ++++++++++----
>>>>  arch/powerpc/kvm/book3s_xive.c        |  9 +++++++--
>>>>  3 files changed, 36 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
>>>> index 376ae803b69c..1295056d564a 100644
>>>> --- a/arch/powerpc/include/asm/kvm_book3s.h
>>>> +++ b/arch/powerpc/include/asm/kvm_book3s.h
>>>> @@ -368,4 +368,23 @@ extern int kvmppc_h_logical_ci_store(struct kvm_vcpu *vcpu);
>>>>  #define SPLIT_HACK_MASK			0xff000000
>>>>  #define SPLIT_HACK_OFFS			0xfb000000
>>>>  
>>>> +/* Pack a VCPU ID from the [0..KVM_MAX_VCPU_ID) space down to the
>>>> + * [0..KVM_MAX_VCPUS) space, while using knowledge of the guest's core stride
>>>> + * (but not it's actual threading mode, which is not available) to avoid
>>>> + * collisions.
>>>> + */
>>>> +static inline u32 kvmppc_pack_vcpu_id(struct kvm *kvm, u32 id)
>>>> +{
>>>> +	const int block_offsets[MAX_SMT_THREADS] = {0, 4, 2, 6, 1, 5, 3, 7};
>>>
>>> I'd suggest 1,3,5,7 at the end rather than 1,5,3,7 - accomplishes
>>> roughly the same thing, but I think makes the pattern more obvious.
> 
> OK.
> 
>>>> +	int stride = kvm->arch.emul_smt_mode > 1 ?
>>>> +		     kvm->arch.emul_smt_mode : kvm->arch.smt_mode;
>>>
>>> AFAICT from BUG_ON()s etc. at the callsites, kvm->arch.smt_mode must
>>> always be 1 when this is called, so the conditional here doesn't seem
>>> useful.
> 
> Ah yes, right. (That was an older version when I was thinking of using
> it for P8 as well but that didn't seem to be a good idea.)
> 
>>>> +	int block = (id / KVM_MAX_VCPUS) * (MAX_SMT_THREADS / stride);
>>>> +	u32 packed_id;
>>>> +
>>>> +	BUG_ON(block >= MAX_SMT_THREADS);
>>>> +	packed_id = (id % KVM_MAX_VCPUS) + block_offsets[block];
>>>> +	BUG_ON(packed_id >= KVM_MAX_VCPUS);
>>>> +	return packed_id;
>>>> +}
>>>
>>> It took me a while to wrap my head around the packing function, but I
>>> think I got there in the end.  It's pretty clever.
> 
> Thanks, I'll try to add a better description as well :-)
> 
>>> One thing bothers me, though.  This certainly packs things under
>>> KVM_MAX_VCPUS, but not necessarily under the actual number of vcpus.
>>> e.g. KVM_MAC_VCPUS==16, 8 vcpus total, stride 8, 2 vthreads/vcore (as
>>> qemu sees it), gives both unpacked IDs (0, 1, 8, 9, 16, 17, 24, 25)
>>> and packed ids of (0, 1, 8, 9, 4, 5, 12, 13) - leaving 2, 3, 6, 7
>>> etc. unused.
> 
> That's right. The property it provides is that all the numbers are under
> KVM_MAX_VCPUS (which, see below, is the size of the fixed areas) not
> that they are sequential.
> 
>>> So again, the question is what exactly are these remapped IDs useful
>>> for.  If we're indexing into a bare array of structures of size
>>> KVM_MAX_VCPUS then we're *already* wasting a bunch of space by having
>>> more entries than vcpus.  If we're indexing into something sparser,
>>> then why is the remapping worthwhile?
> 
> Well, here's my thinking:
> 
> At the moment, kvm->vcores[] and xive->vp_base are both sized by NR_CPUS
> (via KVM_MAX_VCPUS and KVM_MAX_VCORES which are both NR_CPUS). This is
> enough space for the maximum number of VCPUs, and some space is wasted
> when the guest uses less than this (but KVM doesn't know how many will
> be created, so we can't do better easily). The problem is that the
> indicies overflow before all of those VCPUs can be created, not that
> more space is needed.
> 
> We could fix the overflow by expanding these areas to KVM_MAX_VCPU_ID
> but that will use 8x the space we use now, and we know that no more than
> KVM_MAX_VCPUS will be used so all this new space is basically wasted.
> 
> So remapping seems better if it will work. (Ben H. was strongly against
> wasting more XIVE space if possible.)

remapping is 'nearly' done. kvmppc_xive_vcpu holds both values already. 
it's a question of good usage. the KVM XIVE layer should use internally
VP ids and do a translation at the frontier: hcalls and host kernel 
routines (get/set_xive)

Thanks,

C.

> In short, remapping provides a way to allow the guest to create it's full set
> of VCPUs without wasting any more space than we do currently, without
> having to do something more complicated like tracking used IDs or adding
> additional KVM CAPs.
> 
>>>> +
>>>>  #endif /* __ASM_KVM_BOOK3S_H__ */
>>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>>>> index 9cb9448163c4..49165cc90051 100644
>>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>>> @@ -1762,7 +1762,7 @@ static int threads_per_vcore(struct kvm *kvm)
>>>>  	return threads_per_subcore;
>>>>  }
>>>>  
>>>> -static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
>>>> +static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int id)
>>>>  {
>>>>  	struct kvmppc_vcore *vcore;
>>>>  
>>>> @@ -1776,7 +1776,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
>>>>  	init_swait_queue_head(&vcore->wq);
>>>>  	vcore->preempt_tb = TB_NIL;
>>>>  	vcore->lpcr = kvm->arch.lpcr;
>>>> -	vcore->first_vcpuid = core * kvm->arch.smt_mode;
>>>> +	vcore->first_vcpuid = id;
>>>>  	vcore->kvm = kvm;
>>>>  	INIT_LIST_HEAD(&vcore->preempt_list);
>>>>  
>>>> @@ -1992,12 +1992,18 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>>>>  	mutex_lock(&kvm->lock);
>>>>  	vcore = NULL;
>>>>  	err = -EINVAL;
>>>> -	core = id / kvm->arch.smt_mode;
>>>> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>>>> +		BUG_ON(kvm->arch.smt_mode != 1);
>>>> +		core = kvmppc_pack_vcpu_id(kvm, id);
>>>> +	} else {
>>>> +		core = id / kvm->arch.smt_mode;
>>>> +	}
>>>>  	if (core < KVM_MAX_VCORES) {
>>>>  		vcore = kvm->arch.vcores[core];
>>>> +		BUG_ON(cpu_has_feature(CPU_FTR_ARCH_300) && vcore);
>>>>  		if (!vcore) {
>>>>  			err = -ENOMEM;
>>>> -			vcore = kvmppc_vcore_create(kvm, core);
>>>> +			vcore = kvmppc_vcore_create(kvm, id & ~(kvm->arch.smt_mode - 1));
>>>>  			kvm->arch.vcores[core] = vcore;
>>>>  			kvm->arch.online_vcores++;
>>>>  		}
>>>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>>>> index f9818d7d3381..681dfe12a5f3 100644
>>>> --- a/arch/powerpc/kvm/book3s_xive.c
>>>> +++ b/arch/powerpc/kvm/book3s_xive.c
>>>> @@ -317,6 +317,11 @@ static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
>>>>  	return -EBUSY;
>>>>  }
>>>>  
>>>> +static u32 xive_vp(struct kvmppc_xive *xive, u32 server)
>>>> +{
>>>> +	return xive->vp_base + kvmppc_pack_vcpu_id(xive->kvm, server);
>>>> +}
>>>> +
>>>
>>> I'm finding the XIVE indexing really baffling.  There are a bunch of
>>> other places where the code uses (xive->vp_base + NUMBER) directly.
> 
> Ugh, yes. It looks like I botched part of my final cleanup and all the
> cases you saw in kvm/book3s_xive.c should have been replaced with a call to
> xive_vp(). I'll fix it and sorry for the confusion.
> 
>> This links the QEMU vCPU server NUMBER to a XIVE virtual processor number 
>> in OPAL. So we need to check that all used NUMBERs are, first, consistent 
>> and then, in the correct range.
> 
> Right. My approach was to allow XIVE to keep using server numbers that
> are equal to VCPU IDs, and just pack down the ID before indexing into
> the vp_base area.
> 
>>> If those are host side references, I guess they don't need updates for
>>> this.
> 
> These are all guest side references.
> 
>>> But if that's the case, then how does indexing into the same array
>>> with both host and guest server numbers make sense?
> 
> Right, it doesn't make sense to mix host and guest server numbers when
> we're remapping only the guest ones, but in this case (without native
> guest XIVE support) it's just guest ones.
> 
>> yes. VPs are allocated with KVM_MAX_VCPUS :
>>
>> 	xive->vp_base = xive_native_alloc_vp_block(KVM_MAX_VCPUS);
>>
>> but
>>
>> 	#define KVM_MAX_VCPU_ID  (threads_per_subcore * KVM_MAX_VCORES)
>>
>> WE would need to change the allocation of the VPs I guess.
> 
> Yes, this is one of the structures that overflow if we don't pack the IDs.
> 
>>>>  static u8 xive_lock_and_mask(struct kvmppc_xive *xive,
>>>>  			     struct kvmppc_xive_src_block *sb,
>>>>  			     struct kvmppc_xive_irq_state *state)
>>>> @@ -1084,7 +1089,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>>>>  		pr_devel("Duplicate !\n");
>>>>  		return -EEXIST;
>>>>  	}
>>>> -	if (cpu >= KVM_MAX_VCPUS) {
>>>> +	if (cpu >= KVM_MAX_VCPU_ID) {>>
>>>>  		pr_devel("Out of bounds !\n");
>>>>  		return -EINVAL;
>>>>  	}
>>>> @@ -1098,7 +1103,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>>>>  	xc->xive = xive;
>>>>  	xc->vcpu = vcpu;
>>>>  	xc->server_num = cpu;
>>>> -	xc->vp_id = xive->vp_base + cpu;
>>>> +	xc->vp_id = xive_vp(xive, cpu);
>>>>  	xc->mfrr = 0xff;
>>>>  	xc->valid = true;
>>>>  
>>>
>>
