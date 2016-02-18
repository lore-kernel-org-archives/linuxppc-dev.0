Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5831E1A042E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 13:40:02 +1100 (AEDT)
Received: by mail-pa0-x236.google.com with SMTP id fl4so21971390pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:40:02 -0800 (PST)
Subject: Re: [PATCH kernel v3 7/7] KVM: PPC: Add support for multiple-TCE
 hcalls
To: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-8-git-send-email-aik@ozlabs.ru>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56C52EF8.4050409@ozlabs.ru>
Date: Thu, 18 Feb 2016 13:39:52 +1100
MIME-Version: 1.0
In-Reply-To: <1455501309-47200-8-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2016 12:55 PM, Alexey Kardashevskiy wrote:
> This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT and
> H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
> devices or emulated PCI. These calls allow adding multiple entries
> (up to 512) into the TCE table in one call which saves time on
> transition between kernel and user space.
>
> The current implementation of kvmppc_h_stuff_tce() allows it to be
> executed in both real and virtual modes so there is one helper.
> The kvmppc_rm_h_put_tce_indirect() needs to translate the guest address
> to the host address and since the translation is different, there are
> 2 helpers - one for each mode.
>
> This implements the KVM_CAP_PPC_MULTITCE capability. When present,
> the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE if these
> are enabled by the userspace via KVM_CAP_PPC_ENABLE_HCALL.
> If they can not be handled by the kernel, they are passed on to
> the user space. The user space still has to have an implementation
> for these.
>
> Both HV and PR-syle KVM are supported.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
[skip]

> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
> index b608fdd..0486aa2 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -14,6 +14,7 @@
>    *
>    * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>    * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
> + * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
>    */
>
>   #include <linux/types.h>
> @@ -30,6 +31,7 @@
>   #include <asm/kvm_ppc.h>
>   #include <asm/kvm_book3s.h>
>   #include <asm/mmu-hash64.h>
> +#include <asm/mmu_context.h>
>   #include <asm/hvcall.h>
>   #include <asm/synch.h>
>   #include <asm/ppc-opcode.h>
> @@ -37,6 +39,7 @@
>   #include <asm/udbg.h>
>   #include <asm/iommu.h>
>   #include <asm/tce.h>
> +#include <asm/iommu.h>
>
>   #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
>
> @@ -46,7 +49,7 @@
>    * WARNING: This will be called in real or virtual mode on HV KVM and virtual
>    *          mode on PR KVM
>    */
> -static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
> +struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>   		unsigned long liobn)
>   {
>   	struct kvm *kvm = vcpu->kvm;
> @@ -58,6 +61,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>
>   	return NULL;
>   }
> +EXPORT_SYMBOL_GPL(kvmppc_find_table);
>
>   /*
>    * Validates IO address.
> @@ -151,9 +155,29 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
>   }
>   EXPORT_SYMBOL_GPL(kvmppc_tce_put);
>
> -/* WARNING: This will be called in real-mode on HV KVM and virtual
> - *          mode on PR KVM
> - */
> +long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
> +		unsigned long *ua, unsigned long **prmap)
> +{
> +	unsigned long gfn = gpa >> PAGE_SHIFT;
> +	struct kvm_memory_slot *memslot;
> +
> +	memslot = search_memslots(kvm_memslots(kvm), gfn);
> +	if (!memslot)
> +		return -EINVAL;
> +
> +	*ua = __gfn_to_hva_memslot(memslot, gfn) |
> +		(gpa & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	if (prmap)
> +		*prmap = &memslot->arch.rmap[gfn - memslot->base_gfn];
> +#endif
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
> +
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>   long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>   		      unsigned long ioba, unsigned long tce)
>   {
> @@ -180,6 +204,122 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>   }
>   EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
>
> +static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
> +		unsigned long ua, unsigned long *phpa)
> +{
> +	pte_t *ptep, pte;
> +	unsigned shift = 0;
> +
> +	ptep = __find_linux_pte_or_hugepte(vcpu->arch.pgdir, ua, NULL, &shift);



The latest powerkvm kernel passes @thp instead of NULL and check for it 
below in addition to (shift > PAGE_SHIFT), should it be fixed here as well?

Is that possible for __find_linux_pte_or_hugepte() return thp==true but 
shift<=PAGE_SHIT, assuming we call it on vcpu->arch.pgdir, not an ordinary 
task pgdir?



> +	if (!ptep || !pte_present(*ptep))
> +		return -ENXIO;
> +	pte = *ptep;
> +
> +	if (!shift)
> +		shift = PAGE_SHIFT;
> +
> +	/* Avoid handling anything potentially complicated in realmode */
> +	if (shift > PAGE_SHIFT)
> +		return -EAGAIN;
> +
> +	if (!pte_young(pte))
> +		return -EAGAIN;
> +
> +	*phpa = (pte_pfn(pte) << PAGE_SHIFT) | (ua & ((1ULL << shift) - 1)) |
> +			(ua & ~PAGE_MASK);
> +
> +	return 0;
> +}


-- 
Alexey
