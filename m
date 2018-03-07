Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx1Vn3lBGzF1jM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 15:53:21 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w274oQaq044145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 23:53:19 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gj79nc2rd-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 23:53:19 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 04:53:17 -0000
Subject: Re: [PATCH 2/2] powerpc/perf: Fix the kernel address leak to
 userspace via SDAR
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1520164518-19097-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1520164518-19097-2-git-send-email-maddy@linux.vnet.ibm.com>
 <1520237954.soawktcmbp.naveen@linux.ibm.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 10:23:11 +0530
MIME-Version: 1.0
In-Reply-To: <1520237954.soawktcmbp.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d9861e22-8c00-2a86-db0c-096411fac004@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 05 March 2018 01:51 PM, Naveen N. Rao wrote:
> Madhavan Srinivasan wrote:
>> Sampled Data Address Register (SDAR) is a 64-bit
>> register that contains the effective address of
>> the storage operand of an instruction that was
>> being executed, possibly out-of-order, at or around
>> the time that the Performance Monitor alert occurred.
>>
>> In certain scenario SDAR happen to contain the kernel
>> address even for userspace only sampling. Add checks
>> to prevent it.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/core-book3s.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c 
>> b/arch/powerpc/perf/core-book3s.c
>> index 337db5831749..c4525323d691 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -95,7 +95,7 @@ static inline unsigned long perf_ip_adjust(struct 
>> pt_regs *regs)
>>  {
>>      return 0;
>>  }
>> -static inline void perf_get_data_addr(struct pt_regs *regs, u64 
>> *addrp) { }
>> +static inline void perf_get_data_addr(struct pt_regs *regs, u64 
>> *addrp, struct perf_event *event) { }
>>  static inline u32 perf_get_misc_flags(struct pt_regs *regs)
>>  {
>>      return 0;
>> @@ -174,7 +174,7 @@ static inline unsigned long perf_ip_adjust(struct 
>> pt_regs *regs)
>>   * pointed to by SIAR; this is indicated by the 
>> [POWER6_]MMCRA_SDSYNC, the
>>   * [POWER7P_]MMCRA_SDAR_VALID bit in MMCRA, or the SDAR_VALID bit in 
>> SIER.
>>   */
>> -static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
>> +static inline void perf_get_data_addr(struct pt_regs *regs, u64 
>> *addrp, struct perf_event *event)
>>  {
>>      unsigned long mmcra = regs->dsisr;
>>      bool sdar_valid;
>> @@ -198,6 +198,11 @@ static inline void perf_get_data_addr(struct 
>> pt_regs *regs, u64 *addrp)
>>
>>      if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
>>          *addrp = mfspr(SPRN_SDAR);
>> +
>> +    if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
>> +        (event->attr.exclude_kernel || event->attr.exclude_hv) &&
>
> I may be missing something, but if !capable(CAP_SYS_ADMIN), should we 
> still check the exclude_kernel/exclude_hv fields in the event 
> attribute?  Aren't those user controlled?
>

Yes that right. But i also want to handle the case when we sampling only 
for userspace even with higher privilege level. May be I should handle 
that as a separate patch.
I will respin this patch to check only for the privilege level and 
change the commit message accordingly.

Thanks for review
Maddy


> - Naveen
>
>> +        is_kernel_addr(mfspr(SPRN_SDAR)))
>> +        *addrp = 0;
>>  }
>>
>>  static bool regs_sihv(struct pt_regs *regs)
>> @@ -2054,7 +2059,7 @@ static void record_and_restart(struct 
>> perf_event *event, unsigned long val,
>>
>>          if (event->attr.sample_type &
>>              (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
>> -            perf_get_data_addr(regs, &data.addr);
>> +            perf_get_data_addr(regs, &data.addr, event);
>>
>>          if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
>>              struct cpu_hw_events *cpuhw;
>> -- 
>> 2.7.4
>>
>>
