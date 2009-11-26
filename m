Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 9FAADB6F16
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 23:40:30 +1100 (EST)
Message-ID: <4B0E7738.5030506@redhat.com>
Date: Thu, 26 Nov 2009 14:40:24 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] PPC: Sync guest visible MMU state
References: <1259234174-1104-1-git-send-email-agraf@suse.de>
In-Reply-To: <1259234174-1104-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc <kvm-ppc@vger.kernel.org>, kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/26/2009 01:16 PM, Alexander Graf wrote:
> Currently userspace has no chance to find out which virtual address space we're
> in and resolve addresses. While that is a big problem for migration, it's also
> unpleasent when debugging, as gdb and the monitor don't work on virtual
> addresses.
>
> This patch exports enough of the MMU segment state to userspace to make
> debugging work and thus also includes the groundwork for migration.
>
>
>   struct kvm_sregs {
> -	__u32 pvr;
> -	char pad[1020];
> +	union {
> +		struct {
> +			__u32 pvr;
> +			__u64 sdr1;
> +			struct {
> +				struct {
> +					__u64 slbe;
> +					__u64 slbv;
> +				} slb[64];
> +			} ppc64;
> +			struct {
> +				__u32 sr[16];
> +				__u64 ibat[8];
> +				__u64 dbat[8];
> +			} ppc32;
> +		};
> +		__u8 pad[1024];
> +	};
>   };
>    

Please avoid unnamed unions in user-visible headers - they're a gcc 
extension.

Yes, we have them elsewhere, but let's not add to the pile.

>
>   struct kvm_fpu {
> diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
> index 19ddb35..af2abe7 100644
> --- a/arch/powerpc/include/asm/kvm_asm.h
> +++ b/arch/powerpc/include/asm/kvm_asm.h
> @@ -87,6 +87,7 @@
>   #define BOOK3S_IRQPRIO_MAX			16
>
>   #define BOOK3S_HFLAG_DCBZ32			0x1
> +#define BOOK3S_HFLAG_SLB			0x2
>
>   #define RESUME_FLAG_NV          (1<<0)  /* Reload guest nonvolatile state? */
>   #define RESUME_FLAG_HOST        (1<<1)  /* Resume host? */
> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
> index c601133..74b7369 100644
> --- a/arch/powerpc/include/asm/kvm_book3s.h
> +++ b/arch/powerpc/include/asm/kvm_book3s.h
> @@ -46,6 +46,7 @@ struct kvmppc_sr {
>   };
>
>   struct kvmppc_bat {
> +	u64 raw;
>   	u32 bepi;
>   	u32 bepi_mask;
>   	bool vs;
> @@ -113,6 +114,8 @@ extern struct kvmppc_pte *kvmppc_mmu_find_pte(struct kvm_vcpu *vcpu, u64 ea, boo
>   extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong eaddr, int size, void *ptr, bool data);
>   extern int kvmppc_st(struct kvm_vcpu *vcpu, ulong eaddr, int size, void *ptr);
>   extern void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec);
> +extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
> +			   bool upper, u32 val);
>
>   extern u32 kvmppc_trampoline_lowmem;
>   extern u32 kvmppc_trampoline_enter;
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 42037d4..650ebf8 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -281,6 +281,7 @@ void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
>
>   void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
>   {
> +	vcpu->arch.hflags&= ~BOOK3S_HFLAG_SLB;
>   	vcpu->arch.pvr = pvr;
>   	if ((pvr>= 0x330000)&&  (pvr<  0x70330000)) {
>   		kvmppc_mmu_book3s_64_init(vcpu);
> @@ -762,14 +763,60 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>   int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
>                                     struct kvm_sregs *sregs)
>   {
> +	int i;
> +
>   	sregs->pvr = vcpu->arch.pvr;
> +
> +	sregs->sdr1 = to_book3s(vcpu)->sdr1;
> +	if (vcpu->arch.hflags&  BOOK3S_HFLAG_SLB) {
> +		for (i = 0; i<  64; i++) {
> +			sregs->ppc64.slb[i].slbe = to_book3s(vcpu)->slb[i].orige | i;
> +			sregs->ppc64.slb[i].slbv = to_book3s(vcpu)->slb[i].origv;
> +		}
> +	} else {
> +		for (i = 0; i<  16; i++) {
> +			sregs->ppc32.sr[i] = to_book3s(vcpu)->sr[i].raw;
> +			sregs->ppc32.sr[i] = to_book3s(vcpu)->sr[i].raw;
> +		}
> +		for (i = 0; i<  8; i++) {
> +			sregs->ppc32.ibat[i] = to_book3s(vcpu)->ibat[i].raw;
> +			sregs->ppc32.dbat[i] = to_book3s(vcpu)->dbat[i].raw;
> +		}
> +	}
>   	return 0;
>   }
>
>   int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
>                                     struct kvm_sregs *sregs)
>   {
> +	int i;
> +
>   	kvmppc_set_pvr(vcpu, sregs->pvr);
> +
> +	to_book3s(vcpu)->sdr1 = sregs->sdr1;
> +	if (vcpu->arch.hflags&  BOOK3S_HFLAG_SLB) {
> +		for (i = 0; i<  64; i++) {
> +			vcpu->arch.mmu.slbmte(vcpu, sregs->ppc64.slb[i].slbv,
> +						    sregs->ppc64.slb[i].slbe);
> +		}
> +	} else {
> +		for (i = 0; i<  16; i++) {
> +			vcpu->arch.mmu.mtsrin(vcpu, i, sregs->ppc32.sr[i]);
> +		}
> +		for (i = 0; i<  8; i++) {
> +			kvmppc_set_bat(vcpu,&(to_book3s(vcpu)->ibat[i]), false,
> +				       (u32)sregs->ppc32.ibat[i]);
> +			kvmppc_set_bat(vcpu,&(to_book3s(vcpu)->ibat[i]), true,
> +				       (u32)(sregs->ppc32.ibat[i]>>  32));
> +			kvmppc_set_bat(vcpu,&(to_book3s(vcpu)->dbat[i]), false,
> +				       (u32)sregs->ppc32.dbat[i]);
> +			kvmppc_set_bat(vcpu,&(to_book3s(vcpu)->dbat[i]), true,
> +				       (u32)(sregs->ppc32.dbat[i]>>  32));
> +		}
> +	}
> +
> +	/* Flush the MMU after messing with the segments */
> +	kvmppc_mmu_pte_flush(vcpu, 0, 0);
>   	return 0;
>   }
>
> diff --git a/arch/powerpc/kvm/book3s_64_emulate.c b/arch/powerpc/kvm/book3s_64_emulate.c
> index c343e67..1027eac 100644
> --- a/arch/powerpc/kvm/book3s_64_emulate.c
> +++ b/arch/powerpc/kvm/book3s_64_emulate.c
> @@ -185,7 +185,27 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	return emulated;
>   }
>
> -static void kvmppc_write_bat(struct kvm_vcpu *vcpu, int sprn, u64 val)
> +void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat, bool upper,
> +                    u32 val)
> +{
> +	if (upper) {
> +		/* Upper BAT */
> +		u32 bl = (val>>  2)&  0x7ff;
> +		bat->bepi_mask = (~bl<<  17);
> +		bat->bepi = val&  0xfffe0000;
> +		bat->vs = (val&  2) ? 1 : 0;
> +		bat->vp = (val&  1) ? 1 : 0;
> +		bat->raw = (bat->raw&  0xffffffff00000000ULL) | val;
> +	} else {
> +		/* Lower BAT */
> +		bat->brpn = val&  0xfffe0000;
> +		bat->wimg = (val>>  3)&  0xf;
> +		bat->pp = val&  3;
> +		bat->raw = (bat->raw&  0x00000000ffffffffULL) | ((u64)val<<  32);
> +	}
> +}
> +
> +static void kvmppc_write_bat(struct kvm_vcpu *vcpu, int sprn, u32 val)
>   {
>   	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
>   	struct kvmppc_bat *bat;
> @@ -207,19 +227,7 @@ static void kvmppc_write_bat(struct kvm_vcpu *vcpu, int sprn, u64 val)
>   		BUG();
>   	}
>
> -	if (!(sprn % 2)) {
> -		/* Upper BAT */
> -		u32 bl = (val>>  2)&  0x7ff;
> -		bat->bepi_mask = (~bl<<  17);
> -		bat->bepi = val&  0xfffe0000;
> -		bat->vs = (val&  2) ? 1 : 0;
> -		bat->vp = (val&  1) ? 1 : 0;
> -	} else {
> -		/* Lower BAT */
> -		bat->brpn = val&  0xfffe0000;
> -		bat->wimg = (val>>  3)&  0xf;
> -		bat->pp = val&  3;
> -	}
> +	kvmppc_set_bat(vcpu, bat, !(sprn % 2), val);
>   }
>
>   int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
> @@ -243,7 +251,7 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
>   	case SPRN_IBAT4U ... SPRN_IBAT7L:
>   	case SPRN_DBAT0U ... SPRN_DBAT3L:
>   	case SPRN_DBAT4U ... SPRN_DBAT7L:
> -		kvmppc_write_bat(vcpu, sprn, vcpu->arch.gpr[rs]);
> +		kvmppc_write_bat(vcpu, sprn, (u32)vcpu->arch.gpr[rs]);
>   		/* BAT writes happen so rarely that we're ok to flush
>   		 * everything here */
>   		kvmppc_mmu_pte_flush(vcpu, 0, 0);
> diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
> index a31f9c6..5598f88 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu.c
> @@ -473,4 +473,6 @@ void kvmppc_mmu_book3s_64_init(struct kvm_vcpu *vcpu)
>   	mmu->esid_to_vsid = kvmppc_mmu_book3s_64_esid_to_vsid;
>   	mmu->ea_to_vp = kvmppc_mmu_book3s_64_ea_to_vp;
>   	mmu->is_dcbz32 = kvmppc_mmu_book3s_64_is_dcbz32;
> +
> +	vcpu->arch.hflags |= BOOK3S_HFLAG_SLB;
>   }
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 692c370..d82551e 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -144,6 +144,9 @@ int kvm_dev_ioctl_check_extension(long ext)
>   	int r;
>
>   	switch (ext) {
> +	case KVM_CAP_PPC_SEGSTATE:
> +		r = 1;
> +		break;
>   	case KVM_CAP_COALESCED_MMIO:
>   		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
>   		break;
> diff --git a/include/linux/kvm.h b/include/linux/kvm.h
> index f8f8900..caf6173 100644
> --- a/include/linux/kvm.h
> +++ b/include/linux/kvm.h
> @@ -436,6 +436,9 @@ struct kvm_ioeventfd {
>   #endif
>   #define KVM_CAP_IOEVENTFD 36
>   #define KVM_CAP_SET_IDENTITY_MAP_ADDR 37
> +/* KVM upstream has more features, but we synced this number.
> +   Linus, please remove this comment on rebase. */
> +#define KVM_CAP_PPC_SEGSTATE 43
>
>   #ifdef KVM_CAP_IRQ_ROUTING
>
>    


-- 
error compiling committee.c: too many arguments to function
