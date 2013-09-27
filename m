Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id E77CD2C036B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:32:01 +1000 (EST)
Subject: Re: [RFC PATCH 09/11] kvm: simplify processor compat check
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 14:31:56 +0200
Message-Id: <E5A81672-864D-4E33-B15A-5F6927CC7C13@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Gleb Natapov <gleb@redhat.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
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

Missing patch description.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

I fail to see how this really simplifies things, but at the end of the =
day it's Gleb's and Paolo's call.

Which brings me to the next issue: You forgot to CC kvm@vger on your =
patch set. Gleb and Paolo don't read kvm-ppc@vger. And they shouldn't =
have to. Every kvm patch that you want review on or that should get =
applied needs to be sent to kvm@vger. If you want to tag it as PPC =
specific patch, do so by CC'ing kvm-ppc@vger.


Alex

> ---
> arch/arm/kvm/arm.c                 |  4 ++--
> arch/ia64/kvm/kvm-ia64.c           |  4 ++--
> arch/mips/kvm/kvm_mips.c           |  6 ++----
> arch/powerpc/include/asm/kvm_ppc.h |  2 +-
> arch/powerpc/kvm/44x.c             |  2 +-
> arch/powerpc/kvm/book3s.c          | 15 ++++++++++++---
> arch/powerpc/kvm/book3s_hv.c       |  9 ++++++---
> arch/powerpc/kvm/book3s_pr.c       |  5 +++--
> arch/powerpc/kvm/e500.c            |  2 +-
> arch/powerpc/kvm/e500mc.c          |  2 +-
> arch/powerpc/kvm/powerpc.c         |  5 -----
> arch/s390/kvm/kvm-s390.c           |  3 ++-
> arch/x86/kvm/x86.c                 | 13 +++++++++++--
> include/linux/kvm_host.h           |  2 +-
> virt/kvm/kvm_main.c                | 14 +++++---------
> 15 files changed, 50 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 9c697db..cccb121 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -109,9 +109,9 @@ void kvm_arch_hardware_unsetup(void)
> {
> }
>=20
> -void kvm_arch_check_processor_compat(void *rtn)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> -	*(int *)rtn =3D 0;
> +	return 0;
> }
>=20
> void kvm_arch_sync_events(struct kvm *kvm)
> diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
> index bdfd878..065942c 100644
> --- a/arch/ia64/kvm/kvm-ia64.c
> +++ b/arch/ia64/kvm/kvm-ia64.c
> @@ -185,9 +185,9 @@ void kvm_arch_hardware_disable(void *garbage)
> 	ia64_ptr_entry(0x3, slot);
> }
>=20
> -void kvm_arch_check_processor_compat(void *rtn)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> -	*(int *)rtn =3D 0;
> +	return 0;
> }
>=20
> int kvm_dev_ioctl_check_extension(long ext)
> diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
> index a7b0445..4512739 100644
> --- a/arch/mips/kvm/kvm_mips.c
> +++ b/arch/mips/kvm/kvm_mips.c
> @@ -97,11 +97,9 @@ void kvm_arch_hardware_unsetup(void)
> {
> }
>=20
> -void kvm_arch_check_processor_compat(void *rtn)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> -	int *r =3D (int *)rtn;
> -	*r =3D 0;
> -	return;
> +	return 0;
> }
>=20
> static void kvm_mips_init_tlbs(struct kvm *kvm)
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h =
b/arch/powerpc/include/asm/kvm_ppc.h
> index 58e732f..592501b 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -204,7 +204,7 @@ struct kvmppc_ops {
> 			      unsigned long npages);
> 	int (*init_vm)(struct kvm *kvm);
> 	void (*destroy_vm)(struct kvm *kvm);
> -	int (*check_processor_compat)(void);
> +	void (*check_processor_compat)(void *r);
> 	int (*get_smmu_info)(struct kvm *kvm, struct kvm_ppc_smmu_info =
*info);
> 	int (*emulate_op)(struct kvm_run *run, struct kvm_vcpu *vcpu,
> 			  unsigned int inst, int *advance);
> diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
> index 2f5c6b6..a1f4e60 100644
> --- a/arch/powerpc/kvm/44x.c
> +++ b/arch/powerpc/kvm/44x.c
> @@ -43,7 +43,7 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
> 	kvmppc_booke_vcpu_put(vcpu);
> }
>=20
> -int kvmppc_core_check_processor_compat(void)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> 	int r;
>=20
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index ca617e1..485a6ff 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -827,9 +827,18 @@ void kvmppc_core_destroy_vm(struct kvm *kvm)
> #endif
> }
>=20
> -int kvmppc_core_check_processor_compat(void)
> -{
> -	return kvmppc_ops->check_processor_compat();
> +int kvm_arch_check_processor_compat(void *opaque)
> +{
> +	int r,cpu;
> +	struct kvmppc_ops *kvm_ops =3D (struct kvmppc_ops *)opaque;
> +	for_each_online_cpu(cpu) {
> +		smp_call_function_single(cpu,
> +					 =
kvm_ops->check_processor_compat,
> +					 &r, 1);
> +		if (r < 0)
> +			break;
> +	}
> +	return r;
> }
>=20
> EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index ff57be8..4322db4 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1980,11 +1980,14 @@ static int kvmppc_core_emulate_mfspr_hv(struct =
kvm_vcpu *vcpu, int sprn,
> 	return EMULATE_FAIL;
> }
>=20
> -static int kvmppc_core_check_processor_compat_hv(void)
> +
> +static void kvmppc_core_check_processor_compat_hv(void *r)
> {
> 	if (!cpu_has_feature(CPU_FTR_HVMODE))
> -		return -EIO;
> -	return 0;
> +		*(int *)r =3D -EIO;
> +	else
> +		*(int *)r =3D 0;
> +	return;
> }
>=20
> static long kvm_arch_vm_ioctl_hv(struct file *filp,
> diff --git a/arch/powerpc/kvm/book3s_pr.c =
b/arch/powerpc/kvm/book3s_pr.c
> index df48d89..127b961 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1490,10 +1490,11 @@ static void kvmppc_core_destroy_vm_pr(struct =
kvm *kvm)
> 	enable_relon_interrupts(kvm);
> }
>=20
> -static int kvmppc_core_check_processor_compat_pr(void)
> +static void kvmppc_core_check_processor_compat_pr(void *r)
> {
> 	/* we are always compatible */
> -	return 0;
> +	*(int *)r =3D 0;
> +	return;
> }
>=20
> static long kvm_arch_vm_ioctl_pr(struct file *filp,
> diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
> index ce6b73c..0681cb1 100644
> --- a/arch/powerpc/kvm/e500.c
> +++ b/arch/powerpc/kvm/e500.c
> @@ -323,7 +323,7 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
> 	kvmppc_booke_vcpu_put(vcpu);
> }
>=20
> -int kvmppc_core_check_processor_compat(void)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> 	int r;
>=20
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index 19c8379..48b3ba5 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -169,7 +169,7 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
> 	kvmppc_booke_vcpu_put(vcpu);
> }
>=20
> -int kvmppc_core_check_processor_compat(void)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> 	int r;
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 3019edc..1404f4d 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -264,11 +264,6 @@ void kvm_arch_hardware_unsetup(void)
> {
> }
>=20
> -void kvm_arch_check_processor_compat(void *rtn)
> -{
> -	*(int *)rtn =3D kvmppc_core_check_processor_compat();
> -}
> -
> int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
> {
> 	if (type)
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 776dafe..01d4000 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -119,8 +119,9 @@ void kvm_arch_hardware_unsetup(void)
> 	gmap_unregister_ipte_notifier(&gmap_notifier);
> }
>=20
> -void kvm_arch_check_processor_compat(void *rtn)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> +	return 0;
> }
>=20
> int kvm_arch_init(void *opaque)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e5ca72a..53c8308 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6873,9 +6873,18 @@ void kvm_arch_hardware_unsetup(void)
> 	kvm_x86_ops->hardware_unsetup();
> }
>=20
> -void kvm_arch_check_processor_compat(void *rtn)
> +int kvm_arch_check_processor_compat(void *opaque)
> {
> -	kvm_x86_ops->check_processor_compatibility(rtn);
> +	int r,cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		smp_call_function_single(cpu,
> +			 kvm_x86_ops->check_processor_compatibility,
> +			 &r, 1);
> +		if (r < 0)
> +			break;
> +	}
> +	return r;
> }
>=20
> bool kvm_vcpu_compatible(struct kvm_vcpu *vcpu)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ca645a0..459b359 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -649,7 +649,7 @@ int kvm_arch_hardware_enable(void *garbage);
> void kvm_arch_hardware_disable(void *garbage);
> int kvm_arch_hardware_setup(void);
> void kvm_arch_hardware_unsetup(void);
> -void kvm_arch_check_processor_compat(void *rtn);
> +int kvm_arch_check_processor_compat(void *opaque);
> int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
> int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu);
>=20
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 66df1d2..0594b22 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3166,10 +3166,9 @@ static void kvm_sched_out(struct =
preempt_notifier *pn,
> }
>=20
> int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
> -		  struct module *module)
> +	     struct module *module)
> {
> 	int r;
> -	int cpu;
>=20
> 	r =3D kvm_arch_init(opaque);
> 	if (r)
> @@ -3195,13 +3194,10 @@ int kvm_init(void *opaque, unsigned vcpu_size, =
unsigned vcpu_align,
> 	if (r < 0)
> 		goto out_free_0a;
>=20
> -	for_each_online_cpu(cpu) {
> -		smp_call_function_single(cpu,
> -				kvm_arch_check_processor_compat,
> -				&r, 1);
> -		if (r < 0)
> -			goto out_free_1;
> -	}
> +
> +	r =3D kvm_arch_check_processor_compat(opaque);
> +	if (r < 0)
> +		goto out_free_1;
>=20
> 	r =3D register_cpu_notifier(&kvm_cpu_notifier);
> 	if (r)
> --=20
> 1.8.1.2
>=20
