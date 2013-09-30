Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 442C42C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 04:40:31 +1000 (EST)
Message-ID: <5249C593.90707@suse.de>
Date: Mon, 30 Sep 2013 20:40:19 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 36/39] powerpc/kvm/book3s_hv: Add little endian guest
 support
References: <1379901913-5945-1-git-send-email-anton@samba.org>
 <1379901913-5945-37-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-37-git-send-email-anton@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/23/2013 04:05 AM, Anton Blanchard wrote:
> Add support for the H_SET_MODE hcall so we can select the
> endianness of our exceptions.
>
> We create a guest MSR from scratch when delivering exceptions in
> a few places and instead of extracing the LPCR[ILE] and inserting
> it into MSR_LE each time simply create a new variable intr_msr which
> contains the entire MSR to use.
>
> Signed-off-by: Anton Blanchard<anton@samba.org>
> Cc: Alexander Graf<agraf@suse.de>
> ---
>   arch/powerpc/include/asm/kvm_host.h     |  1 +
>   arch/powerpc/kernel/asm-offsets.c       |  1 +
>   arch/powerpc/kvm/book3s_64_mmu_hv.c     |  2 +-
>   arch/powerpc/kvm/book3s_hv.c            | 44 +++++++++++++++++++++++++++++++++
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S | 15 ++++-------
>   5 files changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 3328353..50f204e 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -605,6 +605,7 @@ struct kvm_vcpu_arch {
>   	spinlock_t tbacct_lock;
>   	u64 busy_stolen;
>   	u64 busy_preempt;
> +	unsigned long intr_msr;
>   #endif
>   };
>
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index d8958be..3967b15 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -490,6 +490,7 @@ int main(void)
>   	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
>   	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
>   	DEFINE(VCPU_VPA_DIRTY, offsetof(struct kvm_vcpu, arch.vpa.dirty));
> +	DEFINE(VCPU_INTR_MSR, offsetof(struct kvm_vcpu, arch.intr_msr));
>   #endif
>   #ifdef CONFIG_PPC_BOOK3S
>   	DEFINE(VCPU_VCPUID, offsetof(struct kvm_vcpu, vcpu_id));
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 043eec8..30459bd 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -266,7 +266,7 @@ void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
>
>   static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
>   {
> -	kvmppc_set_msr(vcpu, MSR_SF | MSR_ME);
> +	kvmppc_set_msr(vcpu, vcpu->arch.intr_msr);
>   }
>
>   /*
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 62a2b5a..c9b90b8 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -503,6 +503,43 @@ static void kvmppc_create_dtl_entry(struct kvm_vcpu *vcpu,
>   	vcpu->arch.dtl.dirty = true;
>   }
>
> +static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
> +			     unsigned long resource, unsigned long value1,
> +			     unsigned long value2)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_vcpu *v;
> +	int n;
> +
> +	if (resource == 4) {
> +		if (value1)
> +			return H_P3;
> +		if (value2)
> +			return H_P4;
> +
> +		switch (mflags) {
> +		case 0:
> +			kvm->arch.lpcr&= ~LPCR_ILE;

Can we live migrate this properly?


Alex
