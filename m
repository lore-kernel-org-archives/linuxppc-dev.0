Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1D582C038B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:52:30 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 18:22:26 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DAA47394003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:22:07 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RCsfsX36765760
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:24:41 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8RCqN7q014356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:22:23 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 05/11] kvm: powerpc: book3s: Add kvmppc_ops callback
 for HV and PR specific operations
In-Reply-To: <8EBD07D5-C57D-460C-9392-4933A0E340FA@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <8EBD07D5-C57D-460C-9392-4933A0E340FA@suse.de>
Date: Fri, 27 Sep 2013 18:22:22 +0530
Message-ID: <8738oqbf5l.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This moves HV and PR specific functions to kvmppc_ops callback.
>> This is needed so that we can enable HV and PR together in the
>> same kernel. Actual changes to enable both come in the later
>> patch.This also renames almost all of the symbols that exist in both PR and HV
>> KVM for clarity. Symbols in the PR KVM implementation get "_pr"
>> appended, and those in the HV KVM implementation get "_hv".  Then,
>> in book3s.c, we add a function with the name without the suffix and
>> arrange for it to call the appropriate kvmppc_ops callback depending on
>> which kvm type we selected during VM creation.
>> 
>> NOTE: we still don't enable selecting both the HV and PR together
>> in this commit that will be done by a later commit.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/include/asm/kvm_book3s.h |   5 +-
>> arch/powerpc/include/asm/kvm_ppc.h    |  63 ++++++++--
>> arch/powerpc/kvm/Kconfig              |  15 ++-
>> arch/powerpc/kvm/Makefile             |   9 +-
>> arch/powerpc/kvm/book3s.c             | 145 +++++++++++++++++++++-
>> arch/powerpc/kvm/book3s_32_mmu_host.c |   2 +-
>> arch/powerpc/kvm/book3s_64_mmu_host.c |   2 +-
>> arch/powerpc/kvm/book3s_64_mmu_hv.c   |  17 ++-
>> arch/powerpc/kvm/book3s_emulate.c     |   8 +-
>> arch/powerpc/kvm/book3s_hv.c          | 226 +++++++++++++++++++++++++---------
>> arch/powerpc/kvm/book3s_interrupts.S  |   2 +-
>> arch/powerpc/kvm/book3s_pr.c          | 196 ++++++++++++++++++-----------
>> arch/powerpc/kvm/emulate.c            |   6 +-
>> arch/powerpc/kvm/powerpc.c            |  58 +++------
>> 14 files changed, 539 insertions(+), 215 deletions(-)
>> 
>> 
>
> [...]
>
>> @@ -888,14 +890,8 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id, union kvmppc_one_reg *val)
>> 	return r;
>> }
>> 
>> -int kvmppc_core_check_processor_compat(void)
>> -{
>> -	if (cpu_has_feature(CPU_FTR_HVMODE))
>> -		return 0;
>> -	return -EIO;
>> -}
>> -
>> -struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
>> +static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
>> +						   unsigned int id)
>> {
>> 	struct kvm_vcpu *vcpu;
>> 	int err = -EINVAL;
>> @@ -920,7 +916,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
>> 	vcpu->arch.ctrl = CTRL_RUNLATCH;
>> 	/* default to host PVR, since we can't spoof it */
>> 	vcpu->arch.pvr = mfspr(SPRN_PVR);
>> -	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);
>
> Where is this one going?

That is same as the line above. 

void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
{
	vcpu->arch.pvr = pvr;
}


>
>> 	spin_lock_init(&vcpu->arch.vpa_update_lock);
>> 	spin_lock_init(&vcpu->arch.tbacct_lock);
>> 	vcpu->arch.busy_preempt = TB_NIL;
>> @@ -972,7 +967,7 @@ static void unpin_vpa(struct kvm *kvm, struct kvmppc_vpa *vpa)
>> 					vpa->dirty);
>> }
>> 
>> -void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>> +static void kvmppc_core_vcpu_free_hv(struct kvm_vcpu *vcpu)
>> {
>> 	spin_lock(&vcpu->arch.vpa_update_lock);
>> 	unpin_vpa(vcpu->kvm, &vcpu->arch.dtl);
>> @@ -983,6 +978,12 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>> 	kmem_cache_free(kvm_vcpu_cache, vcpu);
>> }
>> 
>> +static int kvmppc_core_check_requests_hv(struct kvm_vcpu *vcpu)
>> +{
>> +	/* Indicate we want to get back into the guest */
>> +	return 1;
>> +}
>> +
>> 
>
> [...]
>
>> +	case KVM_PPC_GET_HTAB_FD: {
>> +		struct kvm_get_htab_fd ghf;
>> +
>> +		r = -EFAULT;
>> +		if (copy_from_user(&ghf, argp, sizeof(ghf)))
>> +			break;
>> +		r = kvm_vm_ioctl_get_htab_fd(kvm, &ghf);
>> +		break;
>> +	}
>> +
>> +	default:
>> +		r = -ENOTTY;
>> +	}
>> +
>> +	return r;
>> }
>> 
>> -static int kvmppc_book3s_hv_init(void)
>> +/* FIXME!! move to header */
>
> Hrm :)

yes, want to get something out for review. Will fix if we agree on the
approach.

>
>> +extern void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
>> +					 struct kvm_memory_slot *memslot);
>> +extern int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva);
>> +extern int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long start,
>> +				  unsigned long end);
>> +extern int kvm_age_hva_hv(struct kvm *kvm, unsigned long hva);
>> +extern int kvm_test_age_hva_hv(struct kvm *kvm, unsigned long hva);
>> +extern void kvm_set_spte_hva_hv(struct kvm *kvm, unsigned long hva, pte_t pte);
>> +
>> +static struct kvmppc_ops kvmppc_hv_ops = {
>> +	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
>> +	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
>> +	.get_one_reg = kvmppc_get_one_reg_hv,
>> +	.set_one_reg = kvmppc_set_one_reg_hv,
>> +	.vcpu_load   = kvmppc_core_vcpu_load_hv,
>> +	.vcpu_put    = kvmppc_core_vcpu_put_hv,
>> +	.set_msr     = kvmppc_set_msr_hv,
>> +	.vcpu_run    = kvmppc_vcpu_run_hv,
>> +	.vcpu_create = kvmppc_core_vcpu_create_hv,
>> +	.vcpu_free   = kvmppc_core_vcpu_free_hv,
>> +	.check_requests = kvmppc_core_check_requests_hv,
>> +	.get_dirty_log  = kvm_vm_ioctl_get_dirty_log_hv,
>> +	.flush_memslot  = kvmppc_core_flush_memslot_hv,
>> +	.prepare_memory_region = kvmppc_core_prepare_memory_region_hv,
>> +	.commit_memory_region  = kvmppc_core_commit_memory_region_hv,
>> +	.unmap_hva = kvm_unmap_hva_hv,
>> +	.unmap_hva_range = kvm_unmap_hva_range_hv,
>> +	.age_hva  = kvm_age_hva_hv,
>> +	.test_age_hva = kvm_test_age_hva_hv,
>> +	.set_spte_hva = kvm_set_spte_hva_hv,
>> +	.mmu_destroy  = kvmppc_mmu_destroy_hv,
>> +	.free_memslot = kvmppc_core_free_memslot_hv,
>> +	.create_memslot = kvmppc_core_create_memslot_hv,
>> +	.init_vm =  kvmppc_core_init_vm_hv,
>> +	.destroy_vm = kvmppc_core_destroy_vm_hv,
>> +	.check_processor_compat = kvmppc_core_check_processor_compat_hv,
>> +	.get_smmu_info = kvm_vm_ioctl_get_smmu_info_hv,
>> +	.emulate_op = kvmppc_core_emulate_op_hv,
>> +	.emulate_mtspr = kvmppc_core_emulate_mtspr_hv,
>> +	.emulate_mfspr = kvmppc_core_emulate_mfspr_hv,
>> +	.fast_vcpu_kick = kvmppc_fast_vcpu_kick_hv,
>> +	.arch_vm_ioctl  = kvm_arch_vm_ioctl_hv,
>> +};
>> +
>> 
>
> [...]
>
>> @@ -1390,8 +1389,42 @@ out:
>> 	return r;
>> }
>> 
>> +static void kvmppc_core_flush_memslot_pr(struct kvm *kvm,
>> +					 struct kvm_memory_slot *memslot)
>> +{
>> +	return;
>> +}
>> +
>> +static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
>> +					struct kvm_memory_slot *memslot,
>> +					struct kvm_userspace_memory_region *mem)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void kvmppc_core_commit_memory_region_pr(struct kvm *kvm,
>> +				struct kvm_userspace_memory_region *mem,
>> +				const struct kvm_memory_slot *old)
>> +{
>> +	return;
>> +}
>> +
>> +static void kvmppc_core_free_memslot_pr(struct kvm_memory_slot *free,
>> +					struct kvm_memory_slot *dont)
>> +{
>> +	return;
>> +}
>> +
>> +static int kvmppc_core_create_memslot_pr(struct kvm_memory_slot *slot,
>> +					 unsigned long npages)
>> +{
>> +	return 0;
>> +}
>> +
>> +
>> #ifdef CONFIG_PPC64
>> -int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm, struct kvm_ppc_smmu_info *info)
>> +static int kvm_vm_ioctl_get_smmu_info_pr(struct kvm *kvm,
>> +					 struct kvm_ppc_smmu_info *info)
>
> You're dereferencing this function unconditionally now, probably
> breaking book3s_32 along the way :).


will double check that.

>
> I'm not really happy with the naming scheme either, but I can't really
> think of anything better right now. In an ideal world all functions
> would still have the same names and we merely make them static and
> refer to them through structs :).

I was following rest of the kernel source there. For ex: struct
file_operations function pointers get pointed to by different fs
specific callback, they all have fs details in their name. I also found
that having _hv and _pr in the name allowed for easy grep and clarity
in what different files should contain.

-aneesh
