Return-Path: <Hollis_Blanchard@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DDE56B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Aug 2010 03:26:56 +1000 (EST)
Message-ID: <4C5AEF4F.4010604@mentor.com>
Date: Thu, 05 Aug 2010 10:05:19 -0700
From: Hollis Blanchard <hollis_blanchard@mentor.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 01/27] KVM: PPC: Introduce shared page
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
	<1280407688-9815-2-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-2-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2010 05:47 AM, Alexander Graf wrote:
> For transparent variable sharing between the hypervisor and guest, I introduce
> a shared page. This shared page will contain all the registers the guest can
> read and write safely without exiting guest context.
>
> This patch only implements the stubs required for the basic structure of the
> shared page. The actual register moving follows.
>
> Signed-off-by: Alexander Graf<agraf@suse.de>
> ---
>   arch/powerpc/include/asm/kvm_host.h |    2 ++
>   arch/powerpc/include/asm/kvm_para.h |    5 +++++
>   arch/powerpc/kernel/asm-offsets.c   |    1 +
>   arch/powerpc/kvm/44x.c              |    7 +++++++
>   arch/powerpc/kvm/book3s.c           |    9 ++++++++-
>   arch/powerpc/kvm/e500.c             |    7 +++++++
>   6 files changed, 30 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index b0b23c0..53edacd 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -25,6 +25,7 @@
>   #include<linux/interrupt.h>
>   #include<linux/types.h>
>   #include<linux/kvm_types.h>
> +#include<linux/kvm_para.h>
>   #include<asm/kvm_asm.h>
>
>   #define KVM_MAX_VCPUS 1
> @@ -290,6 +291,7 @@ struct kvm_vcpu_arch {
>   	struct tasklet_struct tasklet;
>   	u64 dec_jiffies;
>   	unsigned long pending_exceptions;
> +	struct kvm_vcpu_arch_shared *shared;
>
>   #ifdef CONFIG_PPC_BOOK3S
>   	struct hlist_head hpte_hash_pte[HPTEG_HASH_NUM_PTE];
> diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
> index 2d48f6a..1485ba8 100644
> --- a/arch/powerpc/include/asm/kvm_para.h
> +++ b/arch/powerpc/include/asm/kvm_para.h
> @@ -20,6 +20,11 @@
>   #ifndef __POWERPC_KVM_PARA_H__
>   #define __POWERPC_KVM_PARA_H__
>
> +#include<linux/types.h>
> +
> +struct kvm_vcpu_arch_shared {
> +};
> +
>   #ifdef __KERNEL__
>
>   static inline int kvm_para_available(void)
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 496cc5b..944f593 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -400,6 +400,7 @@ int main(void)
>   	DEFINE(VCPU_SPRG6, offsetof(struct kvm_vcpu, arch.sprg6));
>   	DEFINE(VCPU_SPRG7, offsetof(struct kvm_vcpu, arch.sprg7));
>   	DEFINE(VCPU_SHADOW_PID, offsetof(struct kvm_vcpu, arch.shadow_pid));
> +	DEFINE(VCPU_SHARED, offsetof(struct kvm_vcpu, arch.shared));
>
>   	/* book3s */
>   #ifdef CONFIG_PPC_BOOK3S
> diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
> index 73c0a3f..e7b1f3f 100644
> --- a/arch/powerpc/kvm/44x.c
> +++ b/arch/powerpc/kvm/44x.c
> @@ -123,8 +123,14 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
>   	if (err)
>   		goto free_vcpu;
>
> +	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> +	if (!vcpu->arch.shared)
> +		goto uninit_vcpu;
> +
>   	return vcpu;
>
> +uninit_vcpu:
> +	kvm_vcpu_uninit(vcpu);
>   free_vcpu:
>   	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
>   out:
> @@ -135,6 +141,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>   {
>   	struct kvmppc_vcpu_44x *vcpu_44x = to_44x(vcpu);
>
> +	free_page((unsigned long)vcpu->arch.shared);
>   	kvm_vcpu_uninit(vcpu);
>   	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
>   }
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index a3cef30..b3385dd 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -1242,6 +1242,10 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
>   	if (err)
>   		goto free_shadow_vcpu;
>
> +	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> +	if (!vcpu->arch.shared)
> +		goto uninit_vcpu;
> +
>   	vcpu->arch.host_retip = kvm_return_point;
>   	vcpu->arch.host_msr = mfmsr();
>   #ifdef CONFIG_PPC_BOOK3S_64
> @@ -1268,10 +1272,12 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
>
>   	err = kvmppc_mmu_init(vcpu);
>   	if (err<  0)
> -		goto free_shadow_vcpu;
> +		goto uninit_vcpu;
>
>   	return vcpu;
>
> +uninit_vcpu:
> +	kvm_vcpu_uninit(vcpu);
>   free_shadow_vcpu:
>   	kfree(vcpu_book3s->shadow_vcpu);
>   free_vcpu:
> @@ -1284,6 +1290,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>   {
>   	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
>
> +	free_page((unsigned long)vcpu->arch.shared);
>   	kvm_vcpu_uninit(vcpu);
>   	kfree(vcpu_book3s->shadow_vcpu);
>   	vfree(vcpu_book3s);
> diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
> index e8a00b0..71750f2 100644
> --- a/arch/powerpc/kvm/e500.c
> +++ b/arch/powerpc/kvm/e500.c
> @@ -117,8 +117,14 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
>   	if (err)
>   		goto uninit_vcpu;
>
> +	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> +	if (!vcpu->arch.shared)
> +		goto uninit_tlb;
> +
>   	return vcpu;
>
> +uninit_tlb:
> +	kvmppc_e500_tlb_uninit(vcpu_e500);
>   uninit_vcpu:
>   	kvm_vcpu_uninit(vcpu);
>   free_vcpu:
> @@ -131,6 +137,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>   {
>   	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
>
> +	free_page((unsigned long)vcpu->arch.shared);
>   	kvmppc_e500_tlb_uninit(vcpu_e500);
>   	kvm_vcpu_uninit(vcpu);
>   	kmem_cache_free(kvm_vcpu_cache, vcpu_e500);
>    
Why not put all this in a common function like kvm_arch_vcpu_init()? 
There are layers of shared code inside arch/powerpc/kvm: e.g. powerpc.c 
-> booke.c -> 44x.c...

Hollis Blanchard
Mentor Graphics, Embedded Systems Division
