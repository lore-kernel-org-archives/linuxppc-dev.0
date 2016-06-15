Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV68S5WDdzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 23:01:12 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FCxPNb055267
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 09:01:10 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jggtb88g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 09:01:10 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 23:01:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D8492BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 23:01:03 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5FD136o6947294
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 23:01:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5FD12X0032470
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 23:01:03 +1000
Date: Wed, 15 Jun 2016 18:30:58 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: ego@linux.vnet.ibm.com, mikey@neuling.org, benh@au1.ibm.com,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v6,
 08/11] powerpc/powernv: Add platform support for stop instruction
References: <3rV3nm07hsz9t1V@ozlabs.org>
In-Reply-To: <3rV3nm07hsz9t1V@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5761518A.1040709@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 06/15/2016 04:44 PM, Michael Ellerman wrote:
> Hi Shreyas,
> 
> Comments inline ...
> 
> On Wed, 2016-08-06 at 16:54:28 UTC, "Shreyas B. Prabhu" wrote:
>> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>>  a) new instruction named stop is added. This instruction replaces
>> 	instructions like nap, sleep, rvwinkle.
>>  b) new per thread SPR named Processor Stop Status and Control Register
>> 	(PSSCR) is added which controls the behavior of stop instruction.
>>
>> PSSCR layout:
>> ----------------------------------------------------------
>> | PLS | /// | SD | ESL | EC | PSLL | /// | TR | MTL | RL |
>> ----------------------------------------------------------
>> 0      4     41   42    43   44     48    54   56    60
>>
>> PSSCR key fields:
>> 	Bits 0:3  - Power-Saving Level Status. This field indicates the lowest
>> 	power-saving state the thread entered since stop instruction was last
>> 	executed.
>>
>> 	Bit 42 - Enable State Loss
>> 	0 - No state is lost irrespective of other fields
>> 	1 - Allows state loss
>>
>> 	Bits 44:47 - Power-Saving Level Limit
>> 	This limits the power-saving level that can be entered into.
>>
>> 	Bits 60:63 - Requested Level
>> 	Used to specify which power-saving level must be entered on executing
>> 	stop instruction
> 
> That would probably be good as a comment somewhere too, maybe idle.c
> 

Ok. I'll add it there.

>> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
>> index d2f99ca..3d7fc06 100644
>> --- a/arch/powerpc/include/asm/cpuidle.h
>> +++ b/arch/powerpc/include/asm/cpuidle.h
>> @@ -13,6 +13,8 @@
>>  #ifndef __ASSEMBLY__
>>  extern u32 pnv_fastsleep_workaround_at_entry[];
>>  extern u32 pnv_fastsleep_workaround_at_exit[];
>> +
>> +extern u64 pnv_first_deep_stop_state;
> 
> Should this have some safe initial value?
> 
>> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
>> index 6bdcd0d..ae3b155 100644
>> --- a/arch/powerpc/include/asm/machdep.h
>> +++ b/arch/powerpc/include/asm/machdep.h
>> @@ -262,6 +262,7 @@ struct machdep_calls {
>>  extern void e500_idle(void);
>>  extern void power4_idle(void);
>>  extern void power7_idle(void);
>> +extern void power_stop0(void);
> 
> Can that have a better name please?

What do you have in mind?
power_arch300_idle0()?
power_arch300_stop0()?
or I can use power9_idle() here. But we will still need a better
replacement for power_stop() below.

> 
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index 9bb8ddf..7f3f8c6 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -162,13 +162,20 @@
>>  
>>  /* Device tree flags */
>>  
>> -/* Flags set in power-mgmt nodes in device tree if
>> - * respective idle states are supported in the platform.
>> +/*
>> + * Flags set in power-mgmt nodes in device tree describing
>> + * idle states that are supported in the platform.
>>   */
>> +
>> +#define OPAL_PM_TIMEBASE_STOP		0x00000002
>> +#define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
>> +#define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
>>  #define OPAL_PM_NAP_ENABLED		0x00010000
>>  #define OPAL_PM_SLEEP_ENABLED		0x00020000
>>  #define OPAL_PM_WINKLE_ENABLED		0x00040000
>>  #define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000 /* with workaround */
>> +#define OPAL_PM_STOP_INST_FAST		0x00100000
>> +#define OPAL_PM_STOP_INST_DEEP		0x00200000
> 
> I don't see the above in skiboot yet?

I've posted it here -
http://patchwork.ozlabs.org/patch/617828/
> 
>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>> index 546540b..ae91b44 100644
>> --- a/arch/powerpc/include/asm/paca.h
>> +++ b/arch/powerpc/include/asm/paca.h
>> @@ -171,6 +171,8 @@ struct paca_struct {
>>  	/* Mask to denote subcore sibling threads */
>>  	u8 subcore_sibling_mask;
>>  #endif
>> +	/* Template for PSSCR with EC, ESL, TR, PSLL, MTL fields set */
>> +	u64 thread_psscr;
> 
> I'm not entirely clear on why that needs to be in the paca. Could it not be global?
> 

While we use Requested Level (RL) field of PSSCR to request a stop
level, other fields in the SPR like EC, ESL, TR, PSLL, MTL can be
modified by individual threads less frequently to alter the behaviour of
stop. So the idea was to have a per-thread variable with all (except RL)
fields of PSSCR set appropriately. Threads at the time of entering idle,
can modify the RL field in the variable and execute stop instruction.


>> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
>> index 009fab1..7f92fc8 100644
>> --- a/arch/powerpc/include/asm/processor.h
>> +++ b/arch/powerpc/include/asm/processor.h
>> @@ -457,6 +457,7 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
>>  extern unsigned long power7_nap(int check_irq);
>>  extern unsigned long power7_sleep(void);
>>  extern unsigned long power7_winkle(void);
>> +extern unsigned long power_stop(unsigned long state);
> 
> Can that also have a better name?

power_arch300_idle?

> 
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index a0948f4..89a00d9 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -145,6 +145,16 @@
>>  #define MSR_64BIT	0
>>  #endif
>>  
>> +/* Power Management - PSSCR Fields */
>> +#define PSSCR_RL_MASK		0x0000000F
>> +#define PSSCR_MTL_MASK		0x000000F0
>> +#define PSSCR_TR_MASK		0x00000300
>> +#define PSSCR_PSLL_MASK		0x000F0000
>> +#define PSSCR_EC		0x00100000
>> +#define PSSCR_ESL		0x00200000
>> +#define PSSCR_SD		0x00400000
> 
> Can we get a comment for each #define saying what it is?
> 

Yes, Sam and Madhavan suggested this as well. I'll put the comments in
the next revision.

>> @@ -288,6 +298,7 @@
>>  #define SPRN_PMICR	0x354   /* Power Management Idle Control Reg */
>>  #define SPRN_PMSR	0x355   /* Power Management Status Reg */
>>  #define SPRN_PMMAR	0x356	/* Power Management Memory Activity Register */
>> +#define SPRN_PSSCR	0x357	/* Processor Stop Status and Control Register */
> 
> Can you add ISA 3, eg:
> 
> #define SPRN_PSSCR	0x357	/* Processor Stop Status and Control Register (ISA 3.0) */
> 
> I know we haven't been very consistent about that in the past, but we can always try :)
> 

Ok.

>> @@ -761,6 +772,9 @@
>>  #define   SIER_SDAR_VALID	0x0200000	/* SDAR contents valid */
>>  #define SPRN_SIAR	796
>>  #define SPRN_SDAR	797
>> +#define SPRN_LMRR	813
>> +#define SPRN_LMSER	814
>> +#define SPRN_ASDR	816
> 
> Ditto, comments with ISA 3 please.
> 
>> diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
>> index 2f909a1..c6c2f66 100644
>> --- a/arch/powerpc/kernel/idle_power_common.S
>> +++ b/arch/powerpc/kernel/idle_power_common.S
>> @@ -50,6 +55,15 @@
>>  	IDLE_INST;						\
>>  	b	.
>>  
>> +/*
>> + * rA - Requested stop state
>> + * rB - Spare reg that can be used
>> + */
>> +#define PSSCR_REQUEST_STATE(rA, rB) 		\
>> +	ld	rB, PACA_THREAD_PSSCR(r13);	\
>> +	or	rB,rB,rA;			\
>> +	mtspr	SPRN_PSSCR, rB;
> 
> I only see this used once, so it can just be inline.
> 
Yes. Will do that.
>> +
>>  	.text
>>  
>>  /*
>> @@ -61,8 +75,19 @@ save_sprs_to_stack:
>>  	 * Note all register i.e per-core, per-subcore or per-thread is saved
>>  	 * here since any thread in the core might wake up first
>>  	 */
>> +BEGIN_FTR_SECTION
>> +	mfspr	r3,SPRN_PTCR
>> +	std	r3,_PTCR(r1)
>> +	mfspr	r3,SPRN_LMRR
>> +	std	r3,_LMRR(r1)
>> +	mfspr	r3,SPRN_LMSER
>> +	std	r3,_LMSER(r1)
>> +	mfspr	r3,SPRN_ASDR
>> +	std	r3,_ASDR(r1)
>> +FTR_SECTION_ELSE
> 
> A comment here saying that SDR1 is removed in ISA 3.0 would be helpful.
> 

Ok.

>>  	mfspr	r3,SPRN_SDR1
>>  	std	r3,_SDR1(r1)
>> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> 
>> @@ -293,6 +354,21 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>>  
>>  
>>  /*
>> + * Used for ppc_md.power_save which needs a function with no parameters
>> + */
>> +_GLOBAL(power_stop0)
>> +	li	r3,0
> 
> Zero?
> 
Passing 0 to power_stop. This is just to have a function with no
parameters that can be used for ppc_md.power_save.

>> +	/* Fall through to power_stop */
> 
> I think I'd rather you just did that as a C function.
> 

Ok.

>> +/*
>> + * r3 - requested stop state
>> + */
>> +_GLOBAL(power_stop)
>> +	PSSCR_REQUEST_STATE(r3,r4)
>> +	li	r4, 1
>> +	LOAD_REG_ADDR(r5,power_enter_stop)
>> +	b	pnv_powersave_common
>> +	/* No return */
>> +/*
>>   * Called from reset vector. Check whether we have woken up with
>>   * hypervisor state loss. If yes, restore hypervisor state and return
>>   * back to reset vector.
>> @@ -301,7 +377,32 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>>   * cr3 - set to gt if waking up with partial/complete hypervisor state loss
>>   */
>>  _GLOBAL(pnv_restore_hyp_resource)
>> +BEGIN_FTR_SECTION
>>  	/*
>> +	 * POWER ISA 3. Use PSSCR to determine if we
>> +	 * are waking up from deep idle state
>> +	 */
>> +	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
> 
> That's an @got load using r2, but have we restored r2 yet?

That's a bug. I'll fix it in the next revision.

> 
>> +	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
>> +
>> +	mfspr	r5,SPRN_PSSCR
> 
>> @@ -397,8 +507,11 @@ first_thread_in_subcore:
>>  	bne	cr4,subcore_state_restored
>>  
>>  	/* Restore per-subcore state */
> 
> We don't have subcores on P9, or did I miss a memo?
> 
> A comment somewhere explaining that would help I think, it's not clear AFAICS.
> 

Ok.

>> +BEGIN_FTR_SECTION
>>  	ld      r4,_SDR1(r1)
>>  	mtspr   SPRN_SDR1,r4
>> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>> +
>>  	ld      r4,_RPR(r1)
>>  	mtspr   SPRN_RPR,r4
>>  	ld	r4,_AMOR(r1)
> 
>> @@ -477,6 +601,21 @@ common_exit:
>>  	slbmte	r6,r5
>>  1:	addi	r8,r8,16
>>  	.endr
>> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
>> +
>> +	/* Restore per thread state */
>> +BEGIN_FTR_SECTION
>> +	bl      __restore_cpu_power9
>> +
>> +	ld	r4,_LMRR(r1)
>> +	mtspr	SPRN_LMRR,r4
>> +	ld	r4,_LMSER(r1)
>> +	mtspr	SPRN_LMSER,r4
>> +	ld	r4,_ASDR(r1)
>> +	mtspr	SPRN_ASDR,r4
> 
> Should those be in __restore_cpu_power9 ?

I was not sure how these registers will be used, but after speaking to
Aneesh and Mikey I realized these registers will not need restoring.
LMRR and LMSER are associated with the context and ADSR will be consumed
before entering stop. So I'll be dropping the this hunk in next revision.

> 
>> +FTR_SECTION_ELSE
>> +	bl	__restore_cpu_power8
>> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> 
> Then we could potentially do the above by calling through cur_cpu_spec.
>


I'll call cur_cpu_spec->cpu_restore() here.

>> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
>> index fbb09fb..bfbd359 100644
>> --- a/arch/powerpc/platforms/powernv/idle.c
>> +++ b/arch/powerpc/platforms/powernv/idle.c
>> @@ -27,9 +27,11 @@
>>  #include "powernv.h"
>>  #include "subcore.h"
>>  
>> +#define MAX_STOP_STATE	0xF
> 
> Says who?
>

ISA. I'll add a comment.

>> @@ -130,8 +136,8 @@ static void pnv_alloc_idle_core_states(void)
>>  
>>  	update_subcore_sibling_mask();
>>  
>> -	if (supported_cpuidle_states & OPAL_PM_WINKLE_ENABLED)
>> -		pnv_save_sprs_for_winkle();
>> +	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
>> +		pnv_save_sprs_for_deep_states();
> 
> How does that work on old skiboot that doesn't set OPAL_PM_LOSE_FULL_CONTEXT but
> still sets OPAL_PM_WINKLE_ENABLED?
>

Even old skiboot has OPAL_PM_LOSE_FULL_CONTEXT flag set for winkle. So
this will be backward compatible.

>>  }
>>  
>>  u32 pnv_get_supported_cpuidle_states(void)
>> @@ -230,11 +236,18 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
>>  			show_fastsleep_workaround_applyonce,
>>  			store_fastsleep_workaround_applyonce);
>>  
>> +/*
>> + * First deep stop state. Used to figure out when to save/restore
>> + * hypervisor context.
>> + */
>> +u64 pnv_first_deep_stop_state;
>> +
>>  static int __init pnv_init_idle_states(void)
>>  {
>>  	struct device_node *power_mgt;
> 
> I prefer just "np" - it's shorter and I immediately know what it is.
> 

Ok.
>>  	int dt_idle_states;
>>  	u32 *flags;
>> +	u64 *psscr_val = NULL;
>>  	int i;
>>  
>>  	supported_cpuidle_states = 0;
>> @@ -264,6 +277,32 @@ static int __init pnv_init_idle_states(void)
>>  		goto out_free;
>>  	}
>>  
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> 
>> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
>> +					GFP_KERNEL);
>> +		if (!psscr_val)
>> +			goto out_free;
> 
> Newline please.

Ok.
> 
>> +		if (of_property_read_u64_array(power_mgt,
>> +			"ibm,cpu-idle-state-psscr",
>> +			psscr_val, dt_idle_states)) {
>> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
>> +			goto out_free_psscr;
>> +		}
>> +
>> +		/*
>> +		 * Set pnv_first_deep_stop_state to the first stop level
>> +		 * to cause hypervisor state loss
>> +		 */
>> +		pnv_first_deep_stop_state = MAX_STOP_STATE;
>> +		for (i = 0; i < dt_idle_states; i++) {
>> +			u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
>> +
>> +			if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
>> +			     (pnv_first_deep_stop_state > psscr_rl))
>> +				pnv_first_deep_stop_state = psscr_rl;
>> +		}
>> +	}
> 
> This function is >110 lines, which is too big for my taste.
> 
> The above would be better as a separate function I think.

Ok. I'll break this up.
> 
>>  	for (i = 0; i < dt_idle_states; i++)
>>  		supported_cpuidle_states |= flags[i];
>>  
>> @@ -286,8 +325,29 @@ static int __init pnv_init_idle_states(void)
>>  
>>  	pnv_alloc_idle_core_states();
>>  
>> +	if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
>> +		for_each_possible_cpu(i) {
>> +
>> +			u64 psscr_init_val = PSSCR_ESL | PSSCR_EC |
>> +					PSSCR_PSLL_MASK | PSSCR_TR_MASK |
>> +					PSSCR_MTL_MASK;
>> +
>> +			paca[i].thread_psscr = psscr_init_val;
>> +			/*
>> +			 * Memory barrier to ensure that the writes to PACA
>> +			 * goes through before ppc_md.power_save is updated
>> +			 * below.
>> +			 */
>> +			mb();
>> +		}
> 
> And likewise that loop.
> 
Ok.

Thanks for review.
--Shreyas
