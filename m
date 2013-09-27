Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 787A32C0356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:26:02 +1000 (EST)
Subject: Re: [RFC PATCH 08/11] kvm: powerpc: book3s: Support building HV and
 PR KVM as module
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1380276233-17095-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 14:25:57 +0200
Message-Id: <32B8402B-25D1-41F4-A3FB-B945B72EDC4C@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> arch/powerpc/kvm/Kconfig              |  6 +++---
> arch/powerpc/kvm/Makefile             | 12 ++++++++----
> arch/powerpc/kvm/book3s.c             | 19 ++++++++++++++++++-
> arch/powerpc/kvm/book3s_64_mmu_host.c |  1 +
> arch/powerpc/kvm/book3s_emulate.c     |  2 +-
> arch/powerpc/kvm/book3s_hv.c          |  4 ++++
> arch/powerpc/kvm/book3s_pr.c          |  5 ++++-
> arch/powerpc/kvm/book3s_rtas.c        |  1 +
> arch/powerpc/kvm/emulate.c            |  1 +
> arch/powerpc/kvm/powerpc.c            |  6 ++++++
> virt/kvm/kvm_main.c                   |  3 +++
> 11 files changed, 50 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 5c62459..f63fd8f 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -73,7 +73,7 @@ config KVM_BOOK3S_64
> 	  If unsure, say N.
>=20
> config KVM_BOOK3S_64_HV
> -	bool "KVM support for POWER7 and PPC970 using hypervisor mode in =
host"
> +	tristate "KVM support for POWER7 and PPC970 using hypervisor =
mode in host"
> 	depends on KVM_BOOK3S_64
> 	select KVM_BOOK3S_HV
> 	select MMU_NOTIFIER
> @@ -94,8 +94,8 @@ config KVM_BOOK3S_64_HV
> 	  If unsure, say N.
>=20
> config KVM_BOOK3S_64_PR
> -	bool "KVM support without using hypervisor mode in host"
> -	depends on KVM_BOOK3S_64 && !KVM_BOOK3S_64_HV
> +	tristate "KVM support without using hypervisor mode in host"
> +	depends on KVM_BOOK3S_64
> 	select KVM_BOOK3S_PR
> 	---help---
> 	  Support running guest kernels in virtual machines on =
processors
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index a514ecd..861b8da 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -56,8 +56,7 @@ kvm-objs-$(CONFIG_KVM_E500MC) :=3D =
$(kvm-e500mc-objs)
> kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) :=3D \
> 	book3s_64_vio_hv.o
>=20
> -kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_PR) :=3D \
> -	$(KVM)/coalesced_mmio.o \
> +kvm-pr-y :=3D \
> 	fpu.o \
> 	book3s_paired_singles.o \
> 	book3s_pr.o \
> @@ -77,7 +76,7 @@ =
kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) +=3D \
> 	book3s_rmhandlers.o
> endif
>=20
> -kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV)  +=3D \
> +kvm-hv-y +=3D \
> 	book3s_hv.o \
> 	book3s_hv_interrupts.o \
> 	book3s_64_mmu_hv.o
> @@ -85,13 +84,15 @@ kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV)  +=3D =
\
> kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) :=3D \
> 	book3s_hv_rm_xics.o
>=20
> -kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HV) +=3D \
> +ifdef CONFIG_KVM_BOOK3S_HV
> +kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) +=3D \
> 	book3s_hv_rmhandlers.o \
> 	book3s_hv_rm_mmu.o \
> 	book3s_hv_ras.o \
> 	book3s_hv_builtin.o \
> 	book3s_hv_cma.o \
> 	$(kvm-book3s_64-builtin-xics-objs-y)
> +endif
>=20
> kvm-book3s_64-objs-$(CONFIG_KVM_XICS) +=3D \
> 	book3s_xics.o
> @@ -132,4 +133,7 @@ obj-$(CONFIG_KVM_E500MC) +=3D kvm.o
> obj-$(CONFIG_KVM_BOOK3S_64) +=3D kvm.o
> obj-$(CONFIG_KVM_BOOK3S_32) +=3D kvm.o
>=20
> +obj-$(CONFIG_KVM_BOOK3S_64_PR) +=3D kvm-pr.o
> +obj-$(CONFIG_KVM_BOOK3S_64_HV) +=3D kvm-hv.o
> +
> obj-y +=3D $(kvm-book3s_64-builtin-objs-y)
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 12f94bf..ca617e1 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -170,13 +170,14 @@ void kvmppc_book3s_queue_irqprio(struct kvm_vcpu =
*vcpu, unsigned int vec)
> 	printk(KERN_INFO "Queueing interrupt %x\n", vec);
> #endif
> }
> -
> +EXPORT_SYMBOL_GPL(kvmppc_book3s_queue_irqprio);
>=20
> void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags)
> {
> 	/* might as well deliver this straight away */
> 	kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_PROGRAM, flags);
> }
> +EXPORT_SYMBOL_GPL(kvmppc_core_queue_program);
>=20
> void kvmppc_core_queue_dec(struct kvm_vcpu *vcpu)
> {
> @@ -351,6 +352,7 @@ pfn_t kvmppc_gfn_to_pfn(struct kvm_vcpu *vcpu, =
gfn_t gfn)
>=20
> 	return gfn_to_pfn(vcpu->kvm, gfn);
> }
> +EXPORT_SYMBOL_GPL(kvmppc_gfn_to_pfn);
>=20
> static int kvmppc_xlate(struct kvm_vcpu *vcpu, ulong eaddr, bool data,
> 			 struct kvmppc_pte *pte)
> @@ -418,6 +420,7 @@ int kvmppc_st(struct kvm_vcpu *vcpu, ulong *eaddr, =
int size, void *ptr,
>=20
> 	return EMULATE_DONE;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_st);
>=20
> int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void =
*ptr,
> 		      bool data)
> @@ -448,6 +451,7 @@ nopte:
> mmio:
> 	return EMULATE_DO_MMIO;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_ld);
>=20
> int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
> {
> @@ -693,6 +697,7 @@ void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 =
msr)
> {
> 	kvmppc_ops->set_msr(vcpu, msr);
> }
> +EXPORT_SYMBOL_GPL(kvmppc_set_msr);
>=20
> int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
> {
> @@ -774,6 +779,7 @@ int kvm_unmap_hva(struct kvm *kvm, unsigned long =
hva)
> {
> 	return kvmppc_ops->unmap_hva(kvm, hva);
> }
> +EXPORT_SYMBOL_GPL(kvm_unmap_hva);
>=20
> int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned =
long end)
> {
> @@ -825,3 +831,14 @@ int kvmppc_core_check_processor_compat(void)
> {
> 	return kvmppc_ops->check_processor_compat();
> }
> +
> +EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
> +EXPORT_SYMBOL_GPL(kvmppc_core_pending_dec);
> +EXPORT_SYMBOL_GPL(kvmppc_init_lpid);
> +EXPORT_SYMBOL_GPL(kvmppc_core_dequeue_dec);
> +EXPORT_SYMBOL_GPL(kvmppc_claim_lpid);
> +EXPORT_SYMBOL_GPL(kvmppc_alloc_lpid);
> +EXPORT_SYMBOL_GPL(kvmppc_core_prepare_to_enter);
> +EXPORT_SYMBOL_GPL(kvmppc_core_queue_dec);
> +EXPORT_SYMBOL_GPL(kvmppc_free_lpid);
> +
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c =
b/arch/powerpc/kvm/book3s_64_mmu_host.c
> index fd5b393..775d368 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_host.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
> @@ -27,6 +27,7 @@
> #include <asm/machdep.h>
> #include <asm/mmu_context.h>
> #include <asm/hw_irq.h>
> +

Stray whitespace change

> #include "trace_pr.h"
>=20
> #define PTE_SIZE 12
> diff --git a/arch/powerpc/kvm/book3s_emulate.c =
b/arch/powerpc/kvm/book3s_emulate.c
> index b9841ad..20d03c2 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -172,7 +172,7 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 			vcpu->arch.mmu.tlbie(vcpu, addr, large);
> 			break;
> 		}
> -#ifdef CONFIG_KVM_BOOK3S_64_PR
> +#ifdef CONFIG_KVM_BOOK3S_PR

Why?

> 		case OP_31_XOP_FAKE_SC1:
> 		{
> 			/* SC 1 papr hypercalls */
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index eec353d..ff57be8 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -53,6 +53,8 @@
> #include <linux/highmem.h>
> #include <linux/hugetlb.h>
>=20
> +#include <linux/module.h>
> +
> /* #define EXIT_DEBUG */
> /* #define EXIT_DEBUG_SIMPLE */
> /* #define EXIT_DEBUG_INT */
> @@ -2104,3 +2106,5 @@ static void kvmppc_book3s_exit_hv(void)
>=20
> module_init(kvmppc_book3s_init_hv);
> module_exit(kvmppc_book3s_exit_hv);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/arch/powerpc/kvm/book3s_pr.c =
b/arch/powerpc/kvm/book3s_pr.c
> index 99d0839..df48d89 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -40,6 +40,7 @@
> #include <linux/sched.h>
> #include <linux/vmalloc.h>
> #include <linux/highmem.h>
> +#include <linux/module.h>
>=20
> #define CREATE_TRACE_POINTS
> #include "trace_pr.h"
> @@ -871,7 +872,7 @@ program_interrupt:
> 			ulong cmd =3D kvmppc_get_gpr(vcpu, 3);
> 			int i;
>=20
> -#ifdef CONFIG_KVM_BOOK3S_64_PR
> +#ifdef CONFIG_PPC_BOOK3S_64

Why?


Alex

> 			if (kvmppc_h_pr(vcpu, cmd) =3D=3D EMULATE_DONE) =
{
> 				r =3D RESUME_GUEST;
> 				break;
> @@ -1567,3 +1568,5 @@ static void kvmppc_book3s_exit_pr(void)
>=20
> module_init(kvmppc_book3s_init_pr);
> module_exit(kvmppc_book3s_exit_pr);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/arch/powerpc/kvm/book3s_rtas.c =
b/arch/powerpc/kvm/book3s_rtas.c
> index 3219ba8..cf95cde 100644
> --- a/arch/powerpc/kvm/book3s_rtas.c
> +++ b/arch/powerpc/kvm/book3s_rtas.c
> @@ -260,6 +260,7 @@ fail:
> 	 */
> 	return rc;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_rtas_hcall);
>=20
> void kvmppc_rtas_tokens_free(struct kvm *kvm)
> {
> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index 81762eb..de9a340 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -483,3 +483,4 @@ int kvmppc_emulate_instruction(struct kvm_run =
*run, struct kvm_vcpu *vcpu)
>=20
> 	return emulated;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_emulate_instruction);
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00a96fc..3019edc 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -126,6 +126,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>=20
> 	return r;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_prepare_to_enter);
>=20
> int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
> {
> @@ -179,6 +180,7 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
>=20
> 	return r;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_kvm_pv);
>=20
> int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
> {
> @@ -207,6 +209,7 @@ out:
> 	vcpu->arch.sane =3D r;
> 	return r ? 0 : -EINVAL;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_sanity_check);
>=20
> int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
> {
> @@ -241,6 +244,7 @@ int kvmppc_emulate_mmio(struct kvm_run *run, =
struct kvm_vcpu *vcpu)
>=20
> 	return r;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_emulate_mmio);
>=20
> int kvm_arch_hardware_enable(void *garbage)
> {
> @@ -665,6 +669,7 @@ int kvmppc_handle_load(struct kvm_run *run, struct =
kvm_vcpu *vcpu,
>=20
> 	return EMULATE_DO_MMIO;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_handle_load);
>=20
> /* Same as above, but sign extends */
> int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
> @@ -726,6 +731,7 @@ int kvmppc_handle_store(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>=20
> 	return EMULATE_DO_MMIO;
> }
> +EXPORT_SYMBOL_GPL(kvmppc_handle_store);
>=20
> int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run =
*run)
> {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index bf040c4..66df1d2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -186,6 +186,7 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
> 		++kvm->stat.remote_tlb_flush;
> 	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
> }
> +EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
>=20
> void kvm_reload_remote_mmus(struct kvm *kvm)
> {
> @@ -1648,6 +1649,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
> 	memslot =3D gfn_to_memslot(kvm, gfn);
> 	mark_page_dirty_in_slot(kvm, memslot, gfn);
> }
> +EXPORT_SYMBOL_GPL(mark_page_dirty);
>=20
> /*
>  * The vCPU has executed a HLT instruction with in-kernel mode =
enabled.
> @@ -1673,6 +1675,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>=20
> 	finish_wait(&vcpu->wq, &wait);
> }
> +EXPORT_SYMBOL_GPL(kvm_vcpu_block);
>=20
> #ifndef CONFIG_S390
> /*
> --=20
> 1.8.1.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
