Return-Path: <srs0=jnjv=jt=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KbBq4drXzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 17:21:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41KbBq3t5bz8sy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 17:21:07 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41KbBp6HdZz9s29
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2018 17:21:06 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w637EMXX102987
 for <linuxppc-dev@ozlabs.org>; Tue, 3 Jul 2018 03:21:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jyya3tmxf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 03 Jul 2018 03:21:04 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 3 Jul 2018 08:21:02 +0100
Subject: Re: [PATCH v5 5/7] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>
References: <153051022088.30541.5610525713141009848.stgit@jupiter.in.ibm.com>
 <153051042206.30541.2156877677180900261.stgit@jupiter.in.ibm.com>
 <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 3 Jul 2018 12:50:57 +0530
MIME-Version: 1.0
In-Reply-To: <20180703080814.5a57f52b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <a3b37c2a-671b-0018-55f3-91d68af6492f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2018 03:38 AM, Nicholas Piggin wrote:
> On Mon, 02 Jul 2018 11:17:06 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> On pseries, as of today system crashes if we get a machine check
>> exceptions due to SLB errors. These are soft errors and can be fixed by
>> flushing the SLBs so the kernel can continue to function instead of
>> system crash. We do this in real mode before turning on MMU. Otherwise
>> we would run into nested machine checks. This patch now fetches the
>> rtas error log in real mode and flushes the SLBs on SLB errors.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1 
>>  arch/powerpc/include/asm/machdep.h            |    1 
>>  arch/powerpc/kernel/exceptions-64s.S          |   42 +++++++++++++++++++++
>>  arch/powerpc/kernel/mce.c                     |   16 +++++++-
>>  arch/powerpc/mm/slb.c                         |    6 +++
>>  arch/powerpc/platforms/powernv/opal.c         |    1 
>>  arch/powerpc/platforms/pseries/pseries.h      |    1 
>>  arch/powerpc/platforms/pseries/ras.c          |   51 +++++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/setup.c        |    1 
>>  9 files changed, 116 insertions(+), 4 deletions(-)
>>
> 
> 
>> +TRAMP_REAL_BEGIN(machine_check_pSeries_early)
>> +BEGIN_FTR_SECTION
>> +	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
>> +	mr	r10,r1			/* Save r1 */
>> +	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
>> +	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
>> +	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
>> +	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
>> +	EXCEPTION_PROLOG_COMMON_1()
>> +	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
>> +	EXCEPTION_PROLOG_COMMON_3(0x200)
>> +	addi	r3,r1,STACK_FRAME_OVERHEAD
>> +	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call ABI */
> 
> Is there any reason you can't use the existing
> machine_check_powernv_early code to do all this?

I did think about that :-). But the machine_check_powernv_early code
does bit of extra stuff which isn't required in pseries like touching ME
bit in MSR and lots of checks that are done in
machine_check_handle_early() before going to virtual mode. But on second
look I see that we can bypass all that with HVMODE FTR section. Will
rename machine_check_powernv_early to machine_check_common_early and
reuse it.

> 
>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>> index efdd16a79075..221271c96a57 100644
>> --- a/arch/powerpc/kernel/mce.c
>> +++ b/arch/powerpc/kernel/mce.c
>> @@ -488,9 +488,21 @@ long machine_check_early(struct pt_regs *regs)
>>  {
>>  	long handled = 0;
>>  
>> -	__this_cpu_inc(irq_stat.mce_exceptions);
>> +	/*
>> +	 * For pSeries we count mce when we go into virtual mode machine
>> +	 * check handler. Hence skip it. Also, We can't access per cpu
>> +	 * variables in real mode for LPAR.
>> +	 */
>> +	if (early_cpu_has_feature(CPU_FTR_HVMODE))
>> +		__this_cpu_inc(irq_stat.mce_exceptions);
>>  
>> -	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
>> +	/*
>> +	 * See if platform is capable of handling machine check.
>> +	 * Otherwise fallthrough and allow CPU to handle this machine check.
>> +	 */
>> +	if (ppc_md.machine_check_early)
>> +		handled = ppc_md.machine_check_early(regs);
>> +	else if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
>>  		handled = cur_cpu_spec->machine_check_early(regs);
> 
> Would be good to add a powernv ppc_md handler which does the
> cur_cpu_spec->machine_check_early() call now that other platforms are
> calling this code. Because those aren't valid as a fallback call, but
> specific to powernv.
> 
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 48fbb41af5d1..ed548d40a9e1 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -417,7 +417,6 @@ static int opal_recover_mce(struct pt_regs *regs,
>>  
>>  	if (!(regs->msr & MSR_RI)) {
>>  		/* If MSR_RI isn't set, we cannot recover */
>> -		pr_err("Machine check interrupt unrecoverable: MSR(RI=0)\n");
> 
> What's the reason for this change?

Err... This is by mistake.. My bad. Thanks for catching this. Will
remove this hunk in next revision. We need a similar print for pSeries
in ras.c.

> 
>>  		recovered = 0;
>>  	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
>>  		/* Platform corrected itself */
>> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
>> index 60db2ee511fb..3611db5dd583 100644
>> --- a/arch/powerpc/platforms/pseries/pseries.h
>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>> @@ -24,6 +24,7 @@ struct pt_regs;
>>  
>>  extern int pSeries_system_reset_exception(struct pt_regs *regs);
>>  extern int pSeries_machine_check_exception(struct pt_regs *regs);
>> +extern int pSeries_machine_check_realmode(struct pt_regs *regs);
>>  
>>  #ifdef CONFIG_SMP
>>  extern void smp_init_pseries(void);
>> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
>> index 851ce326874a..9aa7885e0148 100644
>> --- a/arch/powerpc/platforms/pseries/ras.c
>> +++ b/arch/powerpc/platforms/pseries/ras.c
>> @@ -427,6 +427,35 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
>>  	return 0; /* need to perform reset */
>>  }
>>  
>> +static int mce_handle_error(struct rtas_error_log *errp)
>> +{
>> +	struct pseries_errorlog *pseries_log;
>> +	struct pseries_mc_errorlog *mce_log;
>> +	int disposition = rtas_error_disposition(errp);
>> +	uint8_t error_type;
>> +
>> +	if (!rtas_error_extended(errp))
>> +		goto out;
>> +
>> +	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
>> +	if (pseries_log == NULL)
>> +		goto out;
>> +
>> +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
>> +	error_type = rtas_mc_error_type(mce_log);
>> +
>> +	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
>> +			(error_type == PSERIES_MC_ERROR_TYPE_SLB)) {
>> +		/* Store the old slb content someplace. */
>> +		slb_flush_and_rebolt_realmode();
>> +		disposition = RTAS_DISP_FULLY_RECOVERED;
>> +		rtas_set_disposition_recovered(errp);
>> +	}
>> +
>> +out:
>> +	return disposition;
>> +}
>> +
>>  /*
>>   * Process MCE rtas errlog event.
>>   */
>> @@ -503,11 +532,31 @@ int pSeries_machine_check_exception(struct pt_regs *regs)
>>  	struct rtas_error_log *errp;
>>  
>>  	if (fwnmi_active) {
>> -		errp = fwnmi_get_errinfo(regs);
>>  		fwnmi_release_errinfo();
> 
> Should the fwnmi_release_errinfo be done in the realmode path as well
> now, or is there some reason to leave it here?

In real mode calling fwnmi_release_errinfo() causes kernel panic.
Couldn't debug further to find out why. So decided to keep it in virtual
mode. I have mentioned that in comment below in
pSeries_machine_check_realmode().

> 
>> +		errp = fwnmi_get_errlog();
>>  		if (errp && recover_mce(regs, errp))
>>  			return 1;
>>  	}
>>  
>>  	return 0;
>>  }
>> +
>> +int pSeries_machine_check_realmode(struct pt_regs *regs)
>> +{
>> +	struct rtas_error_log *errp;
>> +	int disposition;
>> +
>> +	if (fwnmi_active) {
>> +		errp = fwnmi_get_errinfo(regs);
>> +		/*
>> +		 * Call to fwnmi_release_errinfo() in real mode causes kernel
>> +		 * to panic. Hence we will call it as soon as we go into
>> +		 * virtual mode.
>> +		 */
>> +		disposition = mce_handle_error(errp);
>> +		if (disposition == RTAS_DISP_FULLY_RECOVERED)
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 60a067a6e743..249b02bc5c41 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -999,6 +999,7 @@ define_machine(pseries) {
>>  	.calibrate_decr		= generic_calibrate_decr,
>>  	.progress		= rtas_progress,
>>  	.system_reset_exception = pSeries_system_reset_exception,
>> +	.machine_check_early	= pSeries_machine_check_realmode,
>>  	.machine_check_exception = pSeries_machine_check_exception,
>>  #ifdef CONFIG_KEXEC_CORE
>>  	.machine_kexec          = pSeries_machine_kexec,
>>
> 

Thanks for your review.
