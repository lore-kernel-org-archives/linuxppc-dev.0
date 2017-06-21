Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsqg03zV5zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 13:18:36 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L3DmFC131010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:18:33 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b70ev2nv0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 23:18:33 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 13:18:30 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5L3ISl27471390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 13:18:28 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5L3IKcT014313
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 13:18:20 +1000
Subject: Re: [RFC v2 09/12] powerpc: Deliver SEGV signal on pkey violation.
To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-10-git-send-email-linuxram@us.ibm.com>
 <f4e6e6ce-ba84-f8fc-78af-d482afa7a6b5@linux.vnet.ibm.com>
 <20170620235610.GK17588@ram.oc3035372033.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 21 Jun 2017 08:48:20 +0530
MIME-Version: 1.0
In-Reply-To: <20170620235610.GK17588@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <ea83afac-10bd-b008-e522-aebbf3deb735@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2017 05:26 AM, Ram Pai wrote:
> On Tue, Jun 20, 2017 at 12:24:53PM +0530, Anshuman Khandual wrote:
>> On 06/17/2017 09:22 AM, Ram Pai wrote:
>>> The value of the AMR register at the time of exception
>>> is made available in gp_regs[PT_AMR] of the siginfo.
>>>
>>> This field can be used to reprogram the permission bits of
>>> any valid pkey.
>>>
>>> Similarly the value of the pkey, whose protection got violated,
>>> is made available at si_pkey field of the siginfo structure.
>>>
>>> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/paca.h        |  1 +
>>>  arch/powerpc/include/uapi/asm/ptrace.h |  3 ++-
>>>  arch/powerpc/kernel/asm-offsets.c      |  5 ++++
>>>  arch/powerpc/kernel/exceptions-64s.S   |  8 ++++++
>>>  arch/powerpc/kernel/signal_32.c        | 14 ++++++++++
>>>  arch/powerpc/kernel/signal_64.c        | 14 ++++++++++
>>>  arch/powerpc/kernel/traps.c            | 49 ++++++++++++++++++++++++++++++++++
>>>  arch/powerpc/mm/fault.c                |  4 +++
>>>  8 files changed, 97 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>>> index 1c09f8f..a41afd3 100644
>>> --- a/arch/powerpc/include/asm/paca.h
>>> +++ b/arch/powerpc/include/asm/paca.h
>>> @@ -92,6 +92,7 @@ struct paca_struct {
>>>  	struct dtl_entry *dispatch_log_end;
>>>  #endif /* CONFIG_PPC_STD_MMU_64 */
>>>  	u64 dscr_default;		/* per-CPU default DSCR */
>>> +	u64 paca_amr;			/* value of amr at exception */
>>>
>>>  #ifdef CONFIG_PPC_STD_MMU_64
>>>  	/*
>>> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
>>> index 8036b38..7ec2428 100644
>>> --- a/arch/powerpc/include/uapi/asm/ptrace.h
>>> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
>>> @@ -108,8 +108,9 @@ struct pt_regs {
>>>  #define PT_DAR	41
>>>  #define PT_DSISR 42
>>>  #define PT_RESULT 43
>>> -#define PT_DSCR 44
>>>  #define PT_REGS_COUNT 44
>>> +#define PT_DSCR 44
>>> +#define PT_AMR	45
>>
>> PT_REGS_COUNT is not getting incremented even after adding
>> one more element into the pack ?
> 
> Correct. there are 48 entires in gp_regs table AFAICT, only the first 45
> are exposed through pt_regs and through gp_regs. the remaining
> are exposed through gp_regs only.
> 
>>
>>>
>>>  #define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
>>>
>>> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
>>> index 709e234..17f5d8a 100644
>>> --- a/arch/powerpc/kernel/asm-offsets.c
>>> +++ b/arch/powerpc/kernel/asm-offsets.c
>>> @@ -241,6 +241,11 @@ int main(void)
>>>  	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
>>>  	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
>>>  	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
>>> +
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	OFFSET(PACA_AMR, paca_struct, paca_amr);
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>
>> So we now have a place in PACA for AMR.
> 
> yes.
> 
>>
>>>  	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
>>>  	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
>>>  	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
>>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>>> index 3fd0528..8db9ef8 100644
>>> --- a/arch/powerpc/kernel/exceptions-64s.S
>>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>>> @@ -493,6 +493,10 @@ EXC_COMMON_BEGIN(data_access_common)
>>>  	ld	r12,_MSR(r1)
>>>  	ld	r3,PACA_EXGEN+EX_DAR(r13)
>>>  	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	mfspr	r5,SPRN_AMR
>>> +	std	r5,PACA_AMR(r13)
>>> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>>  	li	r5,0x300
>>>  	std	r3,_DAR(r1)
>>>  	std	r4,_DSISR(r1)
>>> @@ -561,6 +565,10 @@ EXC_COMMON_BEGIN(instruction_access_common)
>>>  	ld	r12,_MSR(r1)
>>>  	ld	r3,_NIP(r1)
>>>  	andis.	r4,r12,0x5820
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	mfspr	r5,SPRN_AMR
>>> +	std	r5,PACA_AMR(r13)
>>> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>
>> Saving the AMR context on page faults, this seems to be
>> changing in the next patch again based on whether any
>> key was active at that point and fault happened for the
>> key enforcement ?
> 
> yes. i am going to merge the next patch with this patch.
> 
> 
>>
>>>  	li	r5,0x400
>>>  	std	r3,_DAR(r1)
>>>  	std	r4,_DSISR(r1)
>>> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
>>> index 97bb138..059766a 100644
>>> --- a/arch/powerpc/kernel/signal_32.c
>>> +++ b/arch/powerpc/kernel/signal_32.c
>>> @@ -500,6 +500,11 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
>>>  				   (unsigned long) &frame->tramp[2]);
>>>  	}
>>>
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	if (__put_user(get_paca()->paca_amr, &frame->mc_gregs[PT_AMR]))
>>> +		return 1;
>>> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>>  	return 0;
>>>  }
>>>
>>> @@ -661,6 +666,9 @@ static long restore_user_regs(struct pt_regs *regs,
>>>  	long err;
>>>  	unsigned int save_r2 = 0;
>>>  	unsigned long msr;
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	unsigned long amr;
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>>  #ifdef CONFIG_VSX
>>>  	int i;
>>>  #endif
>>> @@ -750,6 +758,12 @@ static long restore_user_regs(struct pt_regs *regs,
>>>  		return 1;
>>>  #endif /* CONFIG_SPE */
>>>
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	err |= __get_user(amr, &sr->mc_gregs[PT_AMR]);
>>> +	if (!err && amr != get_paca()->paca_amr)
>>> +		write_amr(amr);
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>>  	return 0;
>>>  }
>>>
>>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
>>> index c83c115..35df2e4 100644
>>> --- a/arch/powerpc/kernel/signal_64.c
>>> +++ b/arch/powerpc/kernel/signal_64.c
>>> @@ -174,6 +174,10 @@ static long setup_sigcontext(struct sigcontext __user *sc,
>>>  	if (set != NULL)
>>>  		err |=  __put_user(set->sig[0], &sc->oldmask);
>>>
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	err |= __put_user(get_paca()->paca_amr, &sc->gp_regs[PT_AMR]);
>>> +#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>>  	return err;
>>>  }
>>>
>>> @@ -327,6 +331,9 @@ static long restore_sigcontext(struct task_struct *tsk, sigset_t *set, int sig,
>>>  	unsigned long save_r13 = 0;
>>>  	unsigned long msr;
>>>  	struct pt_regs *regs = tsk->thread.regs;
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	unsigned long amr;
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>>  #ifdef CONFIG_VSX
>>>  	int i;
>>>  #endif
>>> @@ -406,6 +413,13 @@ static long restore_sigcontext(struct task_struct *tsk, sigset_t *set, int sig,
>>>  			tsk->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
>>>  	}
>>>  #endif
>>> +
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	err |= __get_user(amr, &sc->gp_regs[PT_AMR]);
>>> +	if (!err && amr != get_paca()->paca_amr)
>>> +		write_amr(amr);
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>>  	return err;
>>>  }
>>>
>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
>>> index d4e545d..cc4bde8b 100644
>>> --- a/arch/powerpc/kernel/traps.c
>>> +++ b/arch/powerpc/kernel/traps.c
>>> @@ -20,6 +20,7 @@
>>>  #include <linux/sched/debug.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/mm.h>
>>> +#include <linux/pkeys.h>
>>>  #include <linux/stddef.h>
>>>  #include <linux/unistd.h>
>>>  #include <linux/ptrace.h>
>>> @@ -247,6 +248,49 @@ void user_single_step_siginfo(struct task_struct *tsk,
>>>  	info->si_addr = (void __user *)regs->nip;
>>>  }
>>>
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
>>> +{
>>> +	struct vm_area_struct *vma;
>>> +
>>> +	/* Fault not from Protection Keys: nothing to do */
>>> +	if (si_code != SEGV_PKUERR)
>>> +		return;
>>
>> Should have checked this in the caller ?
> 
> maybe. currently there is only one caller to this function. so either
> way is ok. But if more than one callers show up later having the check 
> here reduces the burden on the caller.
> 
> 
>>
>>> +
>>> +	down_read(&current->mm->mmap_sem);
>>> +	/*
>>> +	 * we could be racing with pkey_mprotect().
>>> +	 * If pkey_mprotect() wins the key value could
>>> +	 * get modified...xxx
>>> +	 */
>>> +	vma = find_vma(current->mm, addr);
>>> +	up_read(&current->mm->mmap_sem);
>>> +
>>> +	/*
>>> +	 * force_sig_info_fault() is called from a number of
>>> +	 * contexts, some of which have a VMA and some of which
>>> +	 * do not.  The Pkey-fault handing happens after we have a
>>> +	 * valid VMA, so we should never reach this without a
>>> +	 * valid VMA.
>>> +	 */
>>
>> Also because pkey can only be used from user space when we will
>> definitely have a VMA associated with it.
>>
>>> +	if (!vma) {
>>> +		WARN_ONCE(1, "Pkey fault with no VMA passed in");
>>> +		info->si_pkey = 0;
>>> +		return;
>>> +	}
>>> +
>>> +	/*
>>> +	 * We could report the incorrect key because of the reason
>>> +	 * explained above.
>>
>> What if we hold mm->mmap_sem for some more time till we update
>> info->si_pkey ? Is there still a chance that pkey would have
>> changed by the time siginfo returns to user space ? I am still
>> wondering is there way to hold up VMA changes to be on safer
>> side. Is the race conditions exists on x86 as well ?

Is the race condition exists on x86 system as well ? Can we hold
up little more the mmap_sem to improve our chances ?

>>
>>> +	 *
>>> +	 * si_pkey should be thought off as trong hint, but not
>>> +	 * an absolutely guarantee because of the race explained
>>> +	 * above.
>>> +	 */
>>> +	info->si_pkey = vma_pkey(vma);
>>> +}
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>>  void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
>>>  {
>>>  	siginfo_t info;
>>> @@ -274,6 +318,11 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
>>>  	info.si_signo = signr;
>>>  	info.si_code = code;
>>>  	info.si_addr = (void __user *) addr;
>>> +
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +	fill_sig_info_pkey(code, &info, addr);
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>>  	force_sig_info(signr, &info, current);
>>>  }
>>>
>>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>>> index c31624f..dd448d2 100644
>>> --- a/arch/powerpc/mm/fault.c
>>> +++ b/arch/powerpc/mm/fault.c
>>> @@ -453,6 +453,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>>>  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>>>  					flags & FAULT_FLAG_INSTRUCTION,
>>>  					0)) {
>>> +
>>> +		/* our caller may not have saved the amr. Lets save it */
>>> +		get_paca()->paca_amr = read_amr();
>>> +
>>
>> Something is not right here. PACA save should have happened before we
>> come here. Why say the caller might not have saved the AMR ? Is there
>> a path when its possible ?
> 
> This is a case, where the fault is cause because of page not yet being
> hashed, but at the same time could have violated a protection key.
> Since the page is not hashed yet, there is no protection-key fault
> and hence the caller would have not saved the AMR. We do it here to 
> catch that case.

Is that because of the above optimization you have added in the page
fault path ?
