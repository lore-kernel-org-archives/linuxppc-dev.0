Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 946302C0351
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:04:34 +1000 (EST)
Subject: Re: [RFC PATCH 05/11] kvm: powerpc: book3s: Add kvmppc_ops callback
 for HV and PR specific operations
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1380276233-17095-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 14:04:28 +0200
Message-Id: <8EBD07D5-C57D-460C-9392-4933A0E340FA@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 27.09.2013, at 12:03, Aneesh Kumar K.V wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> This moves HV and PR specific functions to kvmppc_ops callback.
> This is needed so that we can enable HV and PR together in the
> same kernel. Actual changes to enable both come in the later
> patch.This also renames almost all of the symbols that exist in both =
PR and HV
> KVM for clarity. Symbols in the PR KVM implementation get "_pr"
> appended, and those in the HV KVM implementation get "_hv".  Then,
> in book3s.c, we add a function with the name without the suffix and
> arrange for it to call the appropriate kvmppc_ops callback depending =
on
> which kvm type we selected during VM creation.
>=20
> NOTE: we still don't enable selecting both the HV and PR together
> in this commit that will be done by a later commit.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> arch/powerpc/include/asm/kvm_book3s.h |   5 +-
> arch/powerpc/include/asm/kvm_ppc.h    |  63 ++++++++--
> arch/powerpc/kvm/Kconfig              |  15 ++-
> arch/powerpc/kvm/Makefile             |   9 +-
> arch/powerpc/kvm/book3s.c             | 145 +++++++++++++++++++++-
> arch/powerpc/kvm/book3s_32_mmu_host.c |   2 +-
> arch/powerpc/kvm/book3s_64_mmu_host.c |   2 +-
> arch/powerpc/kvm/book3s_64_mmu_hv.c   |  17 ++-
> arch/powerpc/kvm/book3s_emulate.c     |   8 +-
> arch/powerpc/kvm/book3s_hv.c          | 226 =
+++++++++++++++++++++++++---------
> arch/powerpc/kvm/book3s_interrupts.S  |   2 +-
> arch/powerpc/kvm/book3s_pr.c          | 196 =
++++++++++++++++++-----------
> arch/powerpc/kvm/emulate.c            |   6 +-
> arch/powerpc/kvm/powerpc.c            |  58 +++------
> 14 files changed, 539 insertions(+), 215 deletions(-)
>=20
>=20

[...]

> @@ -888,14 +890,8 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 =
id, union kvmppc_one_reg *val)
> 	return r;
> }
>=20
> -int kvmppc_core_check_processor_compat(void)
> -{
> -	if (cpu_has_feature(CPU_FTR_HVMODE))
> -		return 0;
> -	return -EIO;
> -}
> -
> -struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned =
int id)
> +static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
> +						   unsigned int id)
> {
> 	struct kvm_vcpu *vcpu;
> 	int err =3D -EINVAL;
> @@ -920,7 +916,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct =
kvm *kvm, unsigned int id)
> 	vcpu->arch.ctrl =3D CTRL_RUNLATCH;
> 	/* default to host PVR, since we can't spoof it */
> 	vcpu->arch.pvr =3D mfspr(SPRN_PVR);
> -	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);

Where is this one going?

> 	spin_lock_init(&vcpu->arch.vpa_update_lock);
> 	spin_lock_init(&vcpu->arch.tbacct_lock);
> 	vcpu->arch.busy_preempt =3D TB_NIL;
> @@ -972,7 +967,7 @@ static void unpin_vpa(struct kvm *kvm, struct =
kvmppc_vpa *vpa)
> 					vpa->dirty);
> }
>=20
> -void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
> +static void kvmppc_core_vcpu_free_hv(struct kvm_vcpu *vcpu)
> {
> 	spin_lock(&vcpu->arch.vpa_update_lock);
> 	unpin_vpa(vcpu->kvm, &vcpu->arch.dtl);
> @@ -983,6 +978,12 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
> 	kmem_cache_free(kvm_vcpu_cache, vcpu);
> }
>=20
> +static int kvmppc_core_check_requests_hv(struct kvm_vcpu *vcpu)
> +{
> +	/* Indicate we want to get back into the guest */
> +	return 1;
> +}
> +
>=20

[...]

> +	case KVM_PPC_GET_HTAB_FD: {
> +		struct kvm_get_htab_fd ghf;
> +
> +		r =3D -EFAULT;
> +		if (copy_from_user(&ghf, argp, sizeof(ghf)))
> +			break;
> +		r =3D kvm_vm_ioctl_get_htab_fd(kvm, &ghf);
> +		break;
> +	}
> +
> +	default:
> +		r =3D -ENOTTY;
> +	}
> +
> +	return r;
> }
>=20
> -static int kvmppc_book3s_hv_init(void)
> +/* FIXME!! move to header */

Hrm :)

> +extern void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
> +					 struct kvm_memory_slot =
*memslot);
> +extern int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva);
> +extern int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long =
start,
> +				  unsigned long end);
> +extern int kvm_age_hva_hv(struct kvm *kvm, unsigned long hva);
> +extern int kvm_test_age_hva_hv(struct kvm *kvm, unsigned long hva);
> +extern void kvm_set_spte_hva_hv(struct kvm *kvm, unsigned long hva, =
pte_t pte);
> +
> +static struct kvmppc_ops kvmppc_hv_ops =3D {
> +	.get_sregs =3D kvm_arch_vcpu_ioctl_get_sregs_hv,
> +	.set_sregs =3D kvm_arch_vcpu_ioctl_set_sregs_hv,
> +	.get_one_reg =3D kvmppc_get_one_reg_hv,
> +	.set_one_reg =3D kvmppc_set_one_reg_hv,
> +	.vcpu_load   =3D kvmppc_core_vcpu_load_hv,
> +	.vcpu_put    =3D kvmppc_core_vcpu_put_hv,
> +	.set_msr     =3D kvmppc_set_msr_hv,
> +	.vcpu_run    =3D kvmppc_vcpu_run_hv,
> +	.vcpu_create =3D kvmppc_core_vcpu_create_hv,
> +	.vcpu_free   =3D kvmppc_core_vcpu_free_hv,
> +	.check_requests =3D kvmppc_core_check_requests_hv,
> +	.get_dirty_log  =3D kvm_vm_ioctl_get_dirty_log_hv,
> +	.flush_memslot  =3D kvmppc_core_flush_memslot_hv,
> +	.prepare_memory_region =3D kvmppc_core_prepare_memory_region_hv,
> +	.commit_memory_region  =3D kvmppc_core_commit_memory_region_hv,
> +	.unmap_hva =3D kvm_unmap_hva_hv,
> +	.unmap_hva_range =3D kvm_unmap_hva_range_hv,
> +	.age_hva  =3D kvm_age_hva_hv,
> +	.test_age_hva =3D kvm_test_age_hva_hv,
> +	.set_spte_hva =3D kvm_set_spte_hva_hv,
> +	.mmu_destroy  =3D kvmppc_mmu_destroy_hv,
> +	.free_memslot =3D kvmppc_core_free_memslot_hv,
> +	.create_memslot =3D kvmppc_core_create_memslot_hv,
> +	.init_vm =3D  kvmppc_core_init_vm_hv,
> +	.destroy_vm =3D kvmppc_core_destroy_vm_hv,
> +	.check_processor_compat =3D =
kvmppc_core_check_processor_compat_hv,
> +	.get_smmu_info =3D kvm_vm_ioctl_get_smmu_info_hv,
> +	.emulate_op =3D kvmppc_core_emulate_op_hv,
> +	.emulate_mtspr =3D kvmppc_core_emulate_mtspr_hv,
> +	.emulate_mfspr =3D kvmppc_core_emulate_mfspr_hv,
> +	.fast_vcpu_kick =3D kvmppc_fast_vcpu_kick_hv,
> +	.arch_vm_ioctl  =3D kvm_arch_vm_ioctl_hv,
> +};
> +
>=20

[...]

> @@ -1390,8 +1389,42 @@ out:
> 	return r;
> }
>=20
> +static void kvmppc_core_flush_memslot_pr(struct kvm *kvm,
> +					 struct kvm_memory_slot =
*memslot)
> +{
> +	return;
> +}
> +
> +static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
> +					struct kvm_memory_slot *memslot,
> +					struct =
kvm_userspace_memory_region *mem)
> +{
> +	return 0;
> +}
> +
> +static void kvmppc_core_commit_memory_region_pr(struct kvm *kvm,
> +				struct kvm_userspace_memory_region *mem,
> +				const struct kvm_memory_slot *old)
> +{
> +	return;
> +}
> +
> +static void kvmppc_core_free_memslot_pr(struct kvm_memory_slot *free,
> +					struct kvm_memory_slot *dont)
> +{
> +	return;
> +}
> +
> +static int kvmppc_core_create_memslot_pr(struct kvm_memory_slot =
*slot,
> +					 unsigned long npages)
> +{
> +	return 0;
> +}
> +
> +
> #ifdef CONFIG_PPC64
> -int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm, struct =
kvm_ppc_smmu_info *info)
> +static int kvm_vm_ioctl_get_smmu_info_pr(struct kvm *kvm,
> +					 struct kvm_ppc_smmu_info *info)

You're dereferencing this function unconditionally now, probably =
breaking book3s_32 along the way :).

I'm not really happy with the naming scheme either, but I can't really =
think of anything better right now. In an ideal world all functions =
would still have the same names and we merely make them static and refer =
to them through structs :).


Alex
