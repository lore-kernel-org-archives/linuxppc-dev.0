Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJWGz3LBCzDvqX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 15:19:07 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG4IYKg004729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 23:19:04 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rdbnwrrd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 23:19:04 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 09:49:00 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CD31CE0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:49:08 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAG4IvC124117350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:48:57 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAG4Isu6026785
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:48:57 +0530
Subject: Re: [PATCH v7 06/11] x86, paravirt: Add interface to support kvm/xen
 vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1478077718-37424-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1478077718-37424-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20161115154706.GF11311@worktop.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
 kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com,
 bsingharora@gmail.com, boqun.feng@gmail.com, borntraeger@de.ibm.com,
 rkrcmar@redhat.com, David.Laight@ACULAB.COM, dave@stgolabs.net,
 konrad.wilk@oracle.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Wed, 16 Nov 2016 12:19:09 +0800
MIME-Version: 1.0
In-Reply-To: <20161115154706.GF11311@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <a6026a0c-9ad8-5025-c616-eb33f96e91ce@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/11/15 23:47, Peter Zijlstra 写道:
> On Wed, Nov 02, 2016 at 05:08:33AM -0400, Pan Xinhui wrote:
>> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
>> index 0f400c0..38c3bb7 100644
>> --- a/arch/x86/include/asm/paravirt_types.h
>> +++ b/arch/x86/include/asm/paravirt_types.h
>> @@ -310,6 +310,8 @@ struct pv_lock_ops {
>>
>>  	void (*wait)(u8 *ptr, u8 val);
>>  	void (*kick)(int cpu);
>> +
>> +	bool (*vcpu_is_preempted)(int cpu);
>>  };
>
> So that ends up with a full function call in the native case. I did
> something like the below on top, completely untested, not been near a
> compiler etc..
>
Hi, Peter.
	I think we can avoid a function call in a simpler way. How about below

static inline bool vcpu_is_preempted(int cpu)
{
	/* only set in pv case*/
	if (pv_lock_ops.vcpu_is_preempted)
		return pv_lock_ops.vcpu_is_preempted(cpu);
	return false;
}


> It doesn't get rid of the branch, but at least it avoids the function
> call, and hardware should have no trouble predicting a constant
> condition.
>
> Also, it looks like you end up not setting vcpu_is_preempted when KVM
> doesn't support steal clock, which would end up in an instant NULL
> deref. Fixed that too.
>
maybe not true. There is .vcpu_is_preempted = native_vcpu_is_preempted when we define pv_lock_ops.

your patch is a good example for any people who want to add any native/pv function. :)

thanks
xinhui

> ---
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -673,6 +673,11 @@ static __always_inline void pv_kick(int
>  	PVOP_VCALL1(pv_lock_ops.kick, cpu);
>  }
>
> +static __always_inline void pv_vcpu_is_prempted(int cpu)
> +{
> +	PVOP_VCALLEE1(pv_lock_ops.vcpu_is_preempted, cpu);
> +}
> +
>  #endif /* SMP && PARAVIRT_SPINLOCKS */
>
>  #ifdef CONFIG_X86_32
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -309,7 +309,7 @@ struct pv_lock_ops {
>  	void (*wait)(u8 *ptr, u8 val);
>  	void (*kick)(int cpu);
>
> -	bool (*vcpu_is_preempted)(int cpu);
> +	struct paravirt_callee_save vcpu_is_preempted;
>  };
>
>  /* This contains all the paravirt structures: we get a convenient
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -32,6 +32,12 @@ static inline void queued_spin_unlock(st
>  {
>  	pv_queued_spin_unlock(lock);
>  }
> +
> +#define vcpu_is_preempted vcpu_is_preempted
> +static inline bool vcpu_is_preempted(int cpu)
> +{
> +	return pv_vcpu_is_preempted(cpu);
> +}
>  #else
>  static inline void queued_spin_unlock(struct qspinlock *lock)
>  {
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -26,14 +26,6 @@
>  extern struct static_key paravirt_ticketlocks_enabled;
>  static __always_inline bool static_key_false(struct static_key *key);
>
> -#ifdef CONFIG_PARAVIRT_SPINLOCKS
> -#define vcpu_is_preempted vcpu_is_preempted
> -static inline bool vcpu_is_preempted(int cpu)
> -{
> -	return pv_lock_ops.vcpu_is_preempted(cpu);
> -}
> -#endif
> -
>  #include <asm/qspinlock.h>
>
>  /*
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -415,15 +415,6 @@ void kvm_disable_steal_time(void)
>  	wrmsr(MSR_KVM_STEAL_TIME, 0, 0);
>  }
>
> -static bool kvm_vcpu_is_preempted(int cpu)
> -{
> -	struct kvm_steal_time *src;
> -
> -	src = &per_cpu(steal_time, cpu);
> -
> -	return !!src->preempted;
> -}
> -
>  #ifdef CONFIG_SMP
>  static void __init kvm_smp_prepare_boot_cpu(void)
>  {
> @@ -480,9 +471,6 @@ void __init kvm_guest_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
>  		has_steal_clock = 1;
>  		pv_time_ops.steal_clock = kvm_steal_clock;
> -#ifdef CONFIG_PARAVIRT_SPINLOCKS
> -		pv_lock_ops.vcpu_is_preempted = kvm_vcpu_is_preempted;
> -#endif
>  	}
>
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> @@ -604,6 +592,14 @@ static void kvm_wait(u8 *ptr, u8 val)
>  	local_irq_restore(flags);
>  }
>
> +static bool __kvm_vcpu_is_preempted(int cpu)
> +{
> +	struct kvm_steal_time *src = &per_cpu(steal_time, cpu);
> +
> +	return !!src->preempted;
> +}
> +PV_CALLEE_SAVE_REGS_THUNK(__kvm_vcpu_is_preempted);
> +
>  /*
>   * Setup pv_lock_ops to exploit KVM_FEATURE_PV_UNHALT if present.
>   */
> @@ -620,6 +616,12 @@ void __init kvm_spinlock_init(void)
>  	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
>  	pv_lock_ops.wait = kvm_wait;
>  	pv_lock_ops.kick = kvm_kick_cpu;
> +	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(__native_vcpu_is_preempted);
> +
> +	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
> +		pv_lock_ops.vcpu_is_preempted =
> +			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
> +	}
>  }
>
>  static __init int kvm_spinlock_init_jump(void)
> --- a/arch/x86/kernel/paravirt-spinlocks.c
> +++ b/arch/x86/kernel/paravirt-spinlocks.c
> @@ -12,7 +12,6 @@ __visible void __native_queued_spin_unlo
>  {
>  	native_queued_spin_unlock(lock);
>  }
> -
>  PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
>
>  bool pv_is_native_spin_unlock(void)
> @@ -21,9 +20,16 @@ bool pv_is_native_spin_unlock(void)
>  		__raw_callee_save___native_queued_spin_unlock;
>  }
>
> -static bool native_vcpu_is_preempted(int cpu)
> +__visible bool __native_vcpu_is_preempted(int cpu)
>  {
> -	return 0;
> +	return false;
> +}
> +PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
> +
> +bool pv_is_native_vcpu_is_preempted(void)
> +{
> +	return pv_lock_ops.queued_spin_unlock.func ==
> +		__raw_callee_save__native_vcpu_is_preempted;
>  }
>
copy-paste issue...

>  struct pv_lock_ops pv_lock_ops = {
> @@ -32,7 +38,7 @@ struct pv_lock_ops pv_lock_ops = {
>  	.queued_spin_unlock = PV_CALLEE_SAVE(__native_queued_spin_unlock),
>  	.wait = paravirt_nop,
>  	.kick = paravirt_nop,
> -	.vcpu_is_preempted = native_vcpu_is_preempted,
> +	.vcpu_is_preempted = PV_CALLEE_SAVE(__native_vcpu_is_preempted),
>  #endif /* SMP */
>  };
>  EXPORT_SYMBOL(pv_lock_ops);
> --- a/arch/x86/kernel/paravirt_patch_32.c
> +++ b/arch/x86/kernel/paravirt_patch_32.c
> @@ -11,6 +11,7 @@ DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %c
>
>  #if defined(CONFIG_PARAVIRT_SPINLOCKS)
>  DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
> +DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "movl $0, %eax");
>  #endif
>
>  unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
> @@ -26,6 +27,7 @@ unsigned paravirt_patch_ident_64(void *i
>  }
>
>  extern bool pv_is_native_spin_unlock(void);
> +extern bool pv_is_native_vcpu_is_preempted(void);
>
>  unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
>  		      unsigned long addr, unsigned len)
> @@ -54,6 +56,12 @@ unsigned native_patch(u8 type, u16 clobb
>  				end   = end_pv_lock_ops_queued_spin_unlock;
>  				goto patch_site;
>  			}
> +		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
> +			if (pv_is_native_vcpu_is_preempted()) {
> +				start = start_pv_lock_ops_vcpu_is_preempted;
> +				end   = end_pv_lock_ops_vcpu_is_preempted;
> +				goto patch_site;
> +			}
>  #endif
>
>  	default:
> --- a/arch/x86/kernel/paravirt_patch_64.c
> +++ b/arch/x86/kernel/paravirt_patch_64.c
> @@ -20,6 +20,7 @@ DEF_NATIVE(, mov64, "mov %rdi, %rax");
>
>  #if defined(CONFIG_PARAVIRT_SPINLOCKS)
>  DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
> +DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "movl $0, rax");
>  #endif
>
>  unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
> @@ -35,6 +36,7 @@ unsigned paravirt_patch_ident_64(void *i
>  }
>
>  extern bool pv_is_native_spin_unlock(void);
> +extern bool pv_is_native_vcpu_is_preempted(void);
>
>  unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
>  		      unsigned long addr, unsigned len)
> @@ -66,6 +68,12 @@ unsigned native_patch(u8 type, u16 clobb
>  				end   = end_pv_lock_ops_queued_spin_unlock;
>  				goto patch_site;
>  			}
> +		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
> +			if (pv_is_native_vcpu_is_preempted()) {
> +				start = start_pv_lock_ops_vcpu_is_preempted;
> +				end   = end_pv_lock_ops_vcpu_is_preempted;
> +				goto patch_site;
> +			}
>  #endif
>
>  	default:
> --- a/arch/x86/xen/spinlock.c
> +++ b/arch/x86/xen/spinlock.c
> @@ -114,6 +114,8 @@ void xen_uninit_lock_cpu(int cpu)
>  	per_cpu(irq_name, cpu) = NULL;
>  }
>
> +PV_CALLEE_SAVE_REGS_THUNK(xen_vcpu_stolen);
> +
>  /*
>   * Our init of PV spinlocks is split in two init functions due to us
>   * using paravirt patching and jump labels patching and having to do
> @@ -136,8 +138,7 @@ void __init xen_init_spinlocks(void)
>  	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
>  	pv_lock_ops.wait = xen_qlock_wait;
>  	pv_lock_ops.kick = xen_qlock_kick;
> -
> -	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
> +	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
>  }
>
>  /*
>
