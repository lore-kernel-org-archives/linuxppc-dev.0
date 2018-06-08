Return-Path: <srs0=xhv0=i2=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412C1g43zPzF1fn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 16:19:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 412C1g2ZCBz8vBK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 16:19:51 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 412C1d5Dmsz9s1R
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2018 16:19:49 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w586If2a063251
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2018 02:19:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jfk39u00n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 08 Jun 2018 02:19:47 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 8 Jun 2018 07:19:45 +0100
Subject: Re: [v3 PATCH 4/5] powerpc/pseries: Dump and flush SLB contents on
 SLB MCE errors.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839253238.25118.3114450844744290470.stgit@jupiter.in.ibm.com>
 <20180608114844.2b38d590@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 8 Jun 2018 11:49:40 +0530
MIME-Version: 1.0
In-Reply-To: <20180608114844.2b38d590@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <11366c6b-3eaf-54ed-a82a-39ec96a96afb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/2018 07:18 AM, Nicholas Piggin wrote:
> On Thu, 07 Jun 2018 22:58:55 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> If we get a machine check exceptions due to SLB errors then dump the
>> current SLB contents which will be very much helpful in debugging the
>> root cause of SLB errors. On pseries, as of today system crashes on SLB
>> errors. These are soft errors and can be fixed by flushing the SLBs so
>> the kernel can continue to function instead of system crash. This patch
>> fixes that also.
> 
> So pseries never flushed SLB and reloaded in response to multi hit
> errors? This seems like quite a good improvement then. I like
> dumping SLB too.
> 
> It's a bit annoying we can't share the same code with xmon really,
> that's okay but I just suggest commenting them both if you take a
> copy like this with a note to keep them in synch if you re-post
> the series.
> 
>>
>> With this patch the console will log SLB contents like below on SLB MCE
>> errors:
>>
>> [  822.711728] slb contents:
> 
> Suggest keeping the same format as the xmon dump (in particular
> CPU number, even though it's probably printed elsewhere in the MCE
> message it doesn't hurt.

Sure will do that and repost.

Thanks,
-Mahesh.

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Thanks,
> Nick
> 
>> [  822.711730] 00 c000000008000000 400ea1b217000500
>> [  822.711731]   1T  ESID=   c00000  VSID=      ea1b217 LLP:100
>> [  822.711732] 01 d000000008000000 400d43642f000510
>> [  822.711733]   1T  ESID=   d00000  VSID=      d43642f LLP:110
>> [  822.711734] 09 f000000008000000 400a86c85f000500
>> [  822.711736]   1T  ESID=   f00000  VSID=      a86c85f LLP:100
>> [  822.711737] 10 00007f0008000000 400d1f26e3000d90
>> [  822.711738]   1T  ESID=       7f  VSID=      d1f26e3 LLP:110
>> [  822.711739] 11 0000000018000000 000e3615f520fd90
>> [  822.711740]  256M ESID=        1  VSID=   e3615f520f LLP:110
>> [  822.711740] 12 d000000008000000 400d43642f000510
>> [  822.711741]   1T  ESID=   d00000  VSID=      d43642f LLP:110
>> [  822.711742] 13 d000000008000000 400d43642f000510
>> [  822.711743]   1T  ESID=   d00000  VSID=      d43642f LLP:110
>>
>>
>> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1 +
>>  arch/powerpc/mm/slb.c                         |   35 +++++++++++++++++++++++++
>>  arch/powerpc/platforms/pseries/ras.c          |   29 ++++++++++++++++++++-
>>  3 files changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> index 50ed64fba4ae..c0da68927235 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -487,6 +487,7 @@ extern void hpte_init_native(void);
>>  
>>  extern void slb_initialize(void);
>>  extern void slb_flush_and_rebolt(void);
>> +extern void slb_dump_contents(void);
>>  
>>  extern void slb_vmalloc_update(void);
>>  extern void slb_set_size(u16 size);
>> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>> index 66577cc66dc9..799aa117cec3 100644
>> --- a/arch/powerpc/mm/slb.c
>> +++ b/arch/powerpc/mm/slb.c
>> @@ -145,6 +145,41 @@ void slb_flush_and_rebolt(void)
>>  	get_paca()->slb_cache_ptr = 0;
>>  }
>>  
>> +void slb_dump_contents(void)
>> +{
>> +	int i;
>> +	unsigned long e, v;
>> +	unsigned long llp;
>> +
>> +	pr_err("slb contents:\n");
>> +	for (i = 0; i < mmu_slb_size; i++) {
>> +		asm volatile("slbmfee  %0,%1" : "=r" (e) : "r" (i));
>> +		asm volatile("slbmfev  %0,%1" : "=r" (v) : "r" (i));
>> +
>> +		if (!e && !v)
>> +			continue;
>> +
>> +		pr_err("%02d %016lx %016lx", i, e, v);
>> +
>> +		if (!(e & SLB_ESID_V)) {
>> +			pr_err("\n");
>> +			continue;
>> +		}
>> +		llp = v & SLB_VSID_LLP;
>> +		if (v & SLB_VSID_B_1T) {
>> +			pr_err("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx\n",
>> +				GET_ESID_1T(e),
>> +				(v & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T,
>> +				llp);
>> +		} else {
>> +			pr_err(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx\n",
>> +				GET_ESID(e),
>> +				(v & ~SLB_VSID_B) >> SLB_VSID_SHIFT,
>> +				llp);
>> +		}
>> +	}
>> +}
>> +
>>  void slb_vmalloc_update(void)
>>  {
>>  	unsigned long vflags;
>> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
>> index 2edc673be137..e56759d92356 100644
>> --- a/arch/powerpc/platforms/pseries/ras.c
>> +++ b/arch/powerpc/platforms/pseries/ras.c
>> @@ -422,6 +422,31 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
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
>> +	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
>> +	if (pseries_log == NULL)
>> +		goto out;
>> +
>> +	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
>> +	error_type = rtas_mc_error_type(mce_log);
>> +
>> +	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
>> +			(error_type == PSERIES_MC_ERROR_TYPE_SLB)) {
>> +		slb_dump_contents();
>> +		slb_flush_and_rebolt();
>> +		disposition = RTAS_DISP_FULLY_RECOVERED;
>> +	}
>> +
>> +out:
>> +	return disposition;
>> +}
>> +
>>  /*
>>   * See if we can recover from a machine check exception.
>>   * This is only called on power4 (or above) and only via
>> @@ -434,7 +459,9 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
>>  static int recover_mce(struct pt_regs *regs, struct rtas_error_log *err)
>>  {
>>  	int recovered = 0;
>> -	int disposition = rtas_error_disposition(err);
>> +	int disposition;
>> +
>> +	disposition = mce_handle_error(err);
>>  
>>  	if (!(regs->msr & MSR_RI)) {
>>  		/* If MSR_RI isn't set, we cannot recover */
>>
> 
