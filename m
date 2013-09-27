Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D3112C0379
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 23:04:02 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 23:03:55 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0A3782BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 23:03:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8RCl0Vk1180012
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 22:47:00 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8RD3pcL004922
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 23:03:51 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 06/11] kvm: powerpc: book3s: Add is_hv_enabled to
 kvmppc_ops
In-Reply-To: <9BAA779D-FE0C-4971-992B-57D80F945906@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <9BAA779D-FE0C-4971-992B-57D80F945906@suse.de>
Date: Fri, 27 Sep 2013 18:33:46 +0530
Message-ID: <87zjqya025.fsf@linux.vnet.ibm.com>
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
>> This help us to identify whether we are running with hypervisor mode KVM
>> enabled. The change is needed so that we can have both HV and PR kvm
>> enabled in the same kernel.
>> 
>> If both HV and PR KVM are included, interrupts come in to the HV version
>> of the kvmppc_interrupt code, which then jumps to the PR handler,
>> renamed to kvmppc_interrupt_pr, if the guest is a PR guest.
>> 
>> Allowing both PR and HV in the same kernel required some changes to
>> kvm_dev_ioctl_check_extension(), since the values returned now can't
>> be selected with #ifdefs as much as previously. We look at is_hv_enabled
>> to return the right value when checking for capabilities.For capabilities that
>> are only provided by HV KVM, we return the HV value only if
>> is_hv_enabled is true. For capabilities provided by PR KVM but not HV,
>> we return the PR value only if is_hv_enabled is false.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/include/asm/kvm_book3s.h   | 53 --------------------------------
>> arch/powerpc/include/asm/kvm_ppc.h      |  5 +--
>> arch/powerpc/kvm/Makefile               |  2 +-
>> arch/powerpc/kvm/book3s.c               | 44 +++++++++++++++++++++++++++
>> arch/powerpc/kvm/book3s_hv.c            |  1 +
>> arch/powerpc/kvm/book3s_hv_rmhandlers.S |  4 +++
>> arch/powerpc/kvm/book3s_pr.c            |  1 +
>> arch/powerpc/kvm/book3s_segment.S       |  7 ++++-
>> arch/powerpc/kvm/book3s_xics.c          |  2 +-
>> arch/powerpc/kvm/powerpc.c              | 54 ++++++++++++++++++---------------
>> 10 files changed, 90 insertions(+), 83 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
>> index 3efba3c..ba33c49 100644
>> --- a/arch/powerpc/include/asm/kvm_book3s.h
>> +++ b/arch/powerpc/include/asm/kvm_book3s.h
>> @@ -297,59 +297,6 @@ static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
>> 	return vcpu->arch.fault_dar;
>> }
>> 
>> -#ifdef CONFIG_KVM_BOOK3S_PR
>> -
>> -static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
>> -{
>> -	return to_book3s(vcpu)->hior;
>> -}
>> -
>> -static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
>> -			unsigned long pending_now, unsigned long old_pending)
>> -{
>> -	if (pending_now)
>> -		vcpu->arch.shared->int_pending = 1;
>> -	else if (old_pending)
>> -		vcpu->arch.shared->int_pending = 0;
>> -}
>> -
>> -static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
>> -{
>> -	ulong crit_raw = vcpu->arch.shared->critical;
>> -	ulong crit_r1 = kvmppc_get_gpr(vcpu, 1);
>> -	bool crit;
>> -
>> -	/* Truncate crit indicators in 32 bit mode */
>> -	if (!(vcpu->arch.shared->msr & MSR_SF)) {
>> -		crit_raw &= 0xffffffff;
>> -		crit_r1 &= 0xffffffff;
>> -	}
>> -
>> -	/* Critical section when crit == r1 */
>> -	crit = (crit_raw == crit_r1);
>> -	/* ... and we're in supervisor mode */
>> -	crit = crit && !(vcpu->arch.shared->msr & MSR_PR);
>> -
>> -	return crit;
>> -}
>> -#else /* CONFIG_KVM_BOOK3S_PR */
>> -
>> -static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
>> -{
>> -	return 0;
>> -}
>> -
>> -static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
>> -			unsigned long pending_now, unsigned long old_pending)
>> -{
>> -}
>> -
>> -static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
>> -{
>> -	return false;
>> -}
>> -#endif
>> -
>> /* Magic register values loaded into r3 and r4 before the 'sc' assembly
>>  * instruction for the OSI hypercalls */
>> #define OSI_SC_MAGIC_R3			0x113724FA
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index 4d9641c..58e732f 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -169,6 +169,7 @@ extern int kvmppc_xics_int_on(struct kvm *kvm, u32 irq);
>> extern int kvmppc_xics_int_off(struct kvm *kvm, u32 irq);
>> 
>> struct kvmppc_ops {
>> +	bool is_hv_enabled;
>
> This doesn't really belong into an ops struct. Either you compare
>
>   if (kvmppc_ops == kvmppc_ops_pr)

will do that in the next update. 

>
> against a global known good ops struct or you put the hint somewhere into the kvm struct.
>
>> 	int (*get_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
>> 	int (*set_sregs)(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
>> 	int (*get_one_reg)(struct kvm_vcpu *vcpu, u64 id,
>> @@ -309,10 +310,10 @@ static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
>> 
>> static inline u32 kvmppc_get_xics_latch(void)
>> {
>> -	u32 xirr = get_paca()->kvm_hstate.saved_xirr;
>> +	u32 xirr;
>> 
>> +	xirr = get_paca()->kvm_hstate.saved_xirr;
>> 	get_paca()->kvm_hstate.saved_xirr = 0;
>> -
>
> I don't see any functionality change here?
>
>> 	return xirr;

Mistake on my side, I had a if condition in there before, which i later
removed. But forgot to move the assignment back. Will fix. 

>> }
>> 
>> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
>> index c343793..a514ecd 100644
>> --- a/arch/powerpc/kvm/Makefile
>> +++ b/arch/powerpc/kvm/Makefile
>> @@ -77,7 +77,7 @@ kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) += \
>> 	book3s_rmhandlers.o
>> endif
>> 
>> -kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV) := \
>> +kvm-book3s_64-objs-$(CONFIG_KVM_BOOK3S_64_HV)  += \
>
> This change looks unrelated?
>

yes. Will move it to the correct patch


>> 	book3s_hv.o \
>> 	book3s_hv_interrupts.o \
>> 	book3s_64_mmu_hv.o
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index bdc3f95..12f94bf 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -69,6 +69,50 @@ void kvmppc_core_load_guest_debugstate(struct kvm_vcpu *vcpu)
>> {
>> }
>> 
>> +static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
>
> Please drop the "inline" keyword on functions in .c files :). That way
> the compiler tells us about unused functions.

ok .

>
>> +{
>> +	if (!kvmppc_ops->is_hv_enabled)
>> +		return to_book3s(vcpu)->hior;
>> +	return 0;
>> +}
>> +
>> +static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
>> +			unsigned long pending_now, unsigned long old_pending)
>> +{
>> +	if (kvmppc_ops->is_hv_enabled)
>> +		return;
>> +	if (pending_now)
>> +		vcpu->arch.shared->int_pending = 1;
>> +	else if (old_pending)
>> +		vcpu->arch.shared->int_pending = 0;
>> +}
>> +

....

>> diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
>> index 1abe478..e0229dd 100644
>> --- a/arch/powerpc/kvm/book3s_segment.S
>> +++ b/arch/powerpc/kvm/book3s_segment.S
>> @@ -161,9 +161,14 @@ kvmppc_handler_trampoline_enter_end:
>> .global kvmppc_handler_trampoline_exit
>> kvmppc_handler_trampoline_exit:
>> 
>> +#if defined(CONFIG_KVM_BOOK3S_HV)
>> +.global kvmppc_interrupt_pr
>> +kvmppc_interrupt_pr:
>> +	ld	r9, HSTATE_SCRATCH2(r13)
>> +#else
>> .global kvmppc_interrupt
>> kvmppc_interrupt:
>
> Just always call it kvmppc_interrupt_pr and thus share at least that
> part of the code :).

But if i don't have HV enabled, we don't compile book3s_hv_rmhandlers.S
Hence don't have the kvmppc_interrupt symbol defined.

>
>> -
>> +#endif
>> 	/* Register usage at this point:
>> 	 *
>> 	 * SPRG_SCRATCH0  = guest R13
>> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
>> index f0c732e..fa7625d 100644
>> --- a/arch/powerpc/kvm/book3s_xics.c
>> +++ b/arch/powerpc/kvm/book3s_xics.c
>> @@ -818,7 +818,7 @@ int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 req)
>> 	}
>> 
>> 	/* Check for real mode returning too hard */
>> -	if (xics->real_mode)
>> +	if (xics->real_mode && kvmppc_ops->is_hv_enabled)
>> 		return kvmppc_xics_rm_complete(vcpu, req);
>> 
>> 	switch (req) {
>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 69b9305..00a96fc 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -52,7 +52,6 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>> 	return 1;
>> }
>> 
>> -#ifndef CONFIG_KVM_BOOK3S_64_HV
>> /*
>>  * Common checks before entering the guest world.  Call with interrupts
>>  * disabled.
>> @@ -127,7 +126,6 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>> 
>> 	return r;
>> }
>> -#endif /* CONFIG_KVM_BOOK3S_64_HV */
>> 
>> int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
>> {
>> @@ -194,11 +192,9 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
>> 	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
>> 		goto out;
>> 
>> -#ifdef CONFIG_KVM_BOOK3S_64_HV
>> 	/* HV KVM can only do PAPR mode for now */
>> -	if (!vcpu->arch.papr_enabled)
>> +	if (!vcpu->arch.papr_enabled && kvmppc_ops->is_hv_enabled)
>> 		goto out;
>> -#endif
>> 
>> #ifdef CONFIG_KVM_BOOKE_HV
>> 	if (!cpu_has_feature(CPU_FTR_EMB_HV))
>> @@ -322,22 +318,26 @@ int kvm_dev_ioctl_check_extension(long ext)
>> 	case KVM_CAP_DEVICE_CTRL:
>> 		r = 1;
>> 		break;
>> -#ifndef CONFIG_KVM_BOOK3S_64_HV
>> 	case KVM_CAP_PPC_PAIRED_SINGLES:
>> 	case KVM_CAP_PPC_OSI:
>> 	case KVM_CAP_PPC_GET_PVINFO:
>> #if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
>> 	case KVM_CAP_SW_TLB:
>> #endif
>> -#ifdef CONFIG_KVM_MPIC
>> -	case KVM_CAP_IRQ_MPIC:
>> -#endif
>> -		r = 1;
>> +		/* We support this only for PR */
>> +		r = !kvmppc_ops->is_hv_enabled;
>
> Reading this, have you test compiled your code against e500 configs?


Not yet.


>
>> 		break;
>> +#ifdef CONFIG_KVM_MMIO
>> 	case KVM_CAP_COALESCED_MMIO:
>> 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
>> 		break;
>> #endif
>> +#ifdef CONFIG_KVM_MPIC
>> +	case KVM_CAP_IRQ_MPIC:
>> +		r = 1;
>> +		break;
>> +#endif
>> +
>> #ifdef CONFIG_PPC_BOOK3S_64
>> 	case KVM_CAP_SPAPR_TCE:
>> 	case KVM_CAP_PPC_ALLOC_HTAB:
>> @@ -348,32 +348,37 @@ int kvm_dev_ioctl_check_extension(long ext)
>> 		r = 1;
>> 		break;
>> #endif /* CONFIG_PPC_BOOK3S_64 */
>> -#ifdef CONFIG_KVM_BOOK3S_64_HV
>> +#ifdef CONFIG_KVM_BOOK3S_HV
>> 	case KVM_CAP_PPC_SMT:
>> -		r = threads_per_core;
>> +		if (kvmppc_ops->is_hv_enabled)
>> +			r = threads_per_core;
>> +		else
>> +			r = 0;
>
> 0? Or 1?
>

That check extension was not supported before on PR. So not sure what
the value should be. May be 1 is better indicating we have one thread.
Will change.

-aneesh
