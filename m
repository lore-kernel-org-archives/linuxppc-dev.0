Return-Path: <maynardj@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4CA4DB7BA0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 06:14:05 +1000 (EST)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A32D6DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 06:14:04 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8EKA6tV026356
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:10:06 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8EKDqkB032640
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:13:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8EKDq8E018855
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:13:52 -0600
Message-ID: <4AAEA40A.6040701@us.ibm.com>
Date: Mon, 14 Sep 2009 15:14:02 -0500
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Fix bug where perf_counters breaks oprofile
References: <19111.37067.783017.427206@cargo.ozlabs.ibm.com>
	<4AA7AE3B.30809@us.ibm.com>
In-Reply-To: <4AA7AE3B.30809@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Maynard Johnson <mpjohn@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maynard Johnson wrote:
> Paul Mackerras wrote:
>> Currently there is a bug where if you use oprofile on a pSeries
>> machine, then use perf_counters, then use oprofile again, oprofile
>> will not work correctly; it will lose the PMU configuration the next
>> time the hypervisor does a partition context switch, and thereafter
>> won't count anything.
Ben,
Is there any way to get this bug fix into 2.6.31 or is the window closed?  Once the problem occurs, you can't get oprofile to work again without a reboot.  Really would be nice (for many reasons) to get this fixed in .31.

Thanks.
-Maynard
>>
>> Maynard Johnson identified the sequence causing the problem:
>> - oprofile setup calls ppc_enable_pmcs(), which calls
>>   pseries_lpar_enable_pmcs, which tells the hypervisor that we want
>>   to use the PMU, and sets the "PMU in use" flag in the lppaca.
>>   This flag tells the hypervisor whether it needs to save and restore
>>   the PMU config.
>> - The perf_counter code sets and clears the "PMU in use" flag directly
>>   as it context-switches the PMU between tasks, and leaves it clear
>>   when it finishes.
>> - oprofile setup, called for a new oprofile run, calls ppc_enable_pmcs,
>>   which does nothing because it has already been called.  In particular
>>   it doesn't set the "PMU in use" flag.
>>
>> This fixes the problem by arranging for ppc_enable_pmcs to always set
>> the "PMU in use" flag.  It makes the perf_counter code call
>> ppc_enable_pmcs also rather than calling the lower-level function
>> directly, and removes the setting of the "PMU in use" flag from
>> pseries_lpar_enable_pmcs, since that is now done in its caller.
>>
>> This also removes the declaration of pasemi_enable_pmcs because it
>> isn't defined anywhere.
> Thanks, Paul.  I tested the patch, and oprofile and perf now play nicely together.
> 
> -Maynard
>> Reported-by: Maynard Johnson <mpjohn@us.ibm.com>
>> Signed-off-by: Paul Mackerras <paulus@samba.org>
>> ---
>>  arch/powerpc/include/asm/pmc.h         |   16 ++++++++++++++--
>>  arch/powerpc/kernel/perf_counter.c     |   13 +++----------
>>  arch/powerpc/kernel/sysfs.c            |    3 +++
>>  arch/powerpc/platforms/pseries/setup.c |    4 ----
>>  4 files changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/pmc.h b/arch/powerpc/include/asm/pmc.h
>> index d6a616a..ccc68b5 100644
>> --- a/arch/powerpc/include/asm/pmc.h
>> +++ b/arch/powerpc/include/asm/pmc.h
>> @@ -27,10 +27,22 @@ extern perf_irq_t perf_irq;
>>
>>  int reserve_pmc_hardware(perf_irq_t new_perf_irq);
>>  void release_pmc_hardware(void);
>> +void ppc_enable_pmcs(void);
>>
>>  #ifdef CONFIG_PPC64
>> -void power4_enable_pmcs(void);
>> -void pasemi_enable_pmcs(void);
>> +#include <asm/lppaca.h>
>> +
>> +static inline void ppc_set_pmu_inuse(int inuse)
>> +{
>> +	get_lppaca()->pmcregs_in_use = inuse;
>> +}
>> +
>> +extern void power4_enable_pmcs(void);
>> +
>> +#else /* CONFIG_PPC64 */
>> +
>> +static inline void ppc_set_pmu_inuse(int inuse) { }
>> +
>>  #endif
>>
>>  #endif /* __KERNEL__ */
>> diff --git a/arch/powerpc/kernel/perf_counter.c b/arch/powerpc/kernel/perf_counter.c
>> index 70e1f57..ccd6b21 100644
>> --- a/arch/powerpc/kernel/perf_counter.c
>> +++ b/arch/powerpc/kernel/perf_counter.c
>> @@ -62,7 +62,6 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
>>  {
>>  	return 0;
>>  }
>> -static inline void perf_set_pmu_inuse(int inuse) { }
>>  static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp) { }
>>  static inline u32 perf_get_misc_flags(struct pt_regs *regs)
>>  {
>> @@ -93,11 +92,6 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
>>  	return 0;
>>  }
>>
>> -static inline void perf_set_pmu_inuse(int inuse)
>> -{
>> -	get_lppaca()->pmcregs_in_use = inuse;
>> -}
>> -
>>  /*
>>   * The user wants a data address recorded.
>>   * If we're not doing instruction sampling, give them the SDAR
>> @@ -531,8 +525,7 @@ void hw_perf_disable(void)
>>  		 * Check if we ever enabled the PMU on this cpu.
>>  		 */
>>  		if (!cpuhw->pmcs_enabled) {
>> -			if (ppc_md.enable_pmcs)
>> -				ppc_md.enable_pmcs();
>> +			ppc_enable_pmcs();
>>  			cpuhw->pmcs_enabled = 1;
>>  		}
>>
>> @@ -594,7 +587,7 @@ void hw_perf_enable(void)
>>  		mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
>>  		mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
>>  		if (cpuhw->n_counters == 0)
>> -			perf_set_pmu_inuse(0);
>> +			ppc_set_pmu_inuse(0);
>>  		goto out_enable;
>>  	}
>>
>> @@ -627,7 +620,7 @@ void hw_perf_enable(void)
>>  	 * bit set and set the hardware counters to their initial values.
>>  	 * Then unfreeze the counters.
>>  	 */
>> -	perf_set_pmu_inuse(1);
>> +	ppc_set_pmu_inuse(1);
>>  	mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
>>  	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
>>  	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index f41aec8..956ab33 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -17,6 +17,7 @@
>>  #include <asm/prom.h>
>>  #include <asm/machdep.h>
>>  #include <asm/smp.h>
>> +#include <asm/pmc.h>
>>
>>  #include "cacheinfo.h"
>>
>> @@ -123,6 +124,8 @@ static DEFINE_PER_CPU(char, pmcs_enabled);
>>
>>  void ppc_enable_pmcs(void)
>>  {
>> +	ppc_set_pmu_inuse(1);
>> +
>>  	/* Only need to enable them once */
>>  	if (__get_cpu_var(pmcs_enabled))
>>  		return;
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 8d75ea2..ca5f2e1 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -223,10 +223,6 @@ static void pseries_lpar_enable_pmcs(void)
>>  	set = 1UL << 63;
>>  	reset = 0;
>>  	plpar_hcall_norets(H_PERFMON, set, reset);
>> -
>> -	/* instruct hypervisor to maintain PMCs */
>> -	if (firmware_has_feature(FW_FEATURE_SPLPAR))
>> -		get_lppaca()->pmcregs_in_use = 1;
>>  }
>>
>>  static void __init pseries_discover_pic(void)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
