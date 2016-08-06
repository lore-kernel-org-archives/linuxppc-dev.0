Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5pM66pLhzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 13:00:18 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s5pM62SfCz9t1C
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Aug 2016 13:00:18 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u762xB10013279
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Aug 2016 23:00:16 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24mud8y4g4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 05 Aug 2016 23:00:15 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sat, 6 Aug 2016 13:00:13 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1E22D2CE8054
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Aug 2016 13:00:10 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7630AMo28901624
 for <linuxppc-dev@ozlabs.org>; Sat, 6 Aug 2016 13:00:10 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u76309NQ018455
 for <linuxppc-dev@ozlabs.org>; Sat, 6 Aug 2016 13:00:09 +1000
Subject: Re: [PATCH] powernv: Load correct TOC pointer while waking up from
 winkle.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <147040459202.19770.16560483806363144997.stgit@jupiter.in.ibm.com>
 <1470436733.12584.164.camel@kernel.crashing.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Sat, 6 Aug 2016 08:30:06 +0530
MIME-Version: 1.0
In-Reply-To: <1470436733.12584.164.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <604967a6-9a17-dae1-b6b3-2aa02f32b3b4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2016 04:08 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2016-08-05 at 19:13 +0530, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The function pnv_restore_hyp_resource() loads the TOC into r2 from
>> the invalid PACA pointer before fixing r13 value. This do not affect
>> POWER ISA 3.0 but it does have an impact on POWER ISA 2.07 or less
>> leading CPU to get stuck forever.
> 
> When was this broken ? Should this get backported to stable ?

This is broken with recent Power9 cpu idle changes (commit bcef83a00)
that gone in Linus' master after V4.7. We are fine with v4.7

-Mahesh.

> 
>> 	login: [  471.830433] Processor 120 is stuck.
>>
>>
>> This can be easily reproducible using following steps:
>> - Turn off SMT
>> 	$ ppc64_cpu --smt=off
>> - offline/online any online cpu (Thread 0 of any core which is
>> online)
>> 	$ echo 0 > /sys/devices/system/cpu/cpu<num>/online
>> 	$ echo 1 > /sys/devices/system/cpu/cpu<num>/online
>>
>> For POWER ISA 2.07 or less, the last bit of HSPRG0 is set indicating
>> that thread is waking up from winkle. Hence, the last bit of
>> HSPRG0(r13)
>> needs to be clear before accessing it as PACA to avoid loading
>> invalid
>> values from invalid PACA pointer.
>>
>> Fix this by loading TOC after r13 register is corrected.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/idle_book3s.S |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/idle_book3s.S
>> b/arch/powerpc/kernel/idle_book3s.S
>> index 8a56a51..45784ec 100644
>> --- a/arch/powerpc/kernel/idle_book3s.S
>> +++ b/arch/powerpc/kernel/idle_book3s.S
>> @@ -363,8 +363,8 @@ _GLOBAL(power9_idle_stop)
>>   * cr3 - set to gt if waking up with partial/complete hypervisor
>> state loss
>>   */
>>  _GLOBAL(pnv_restore_hyp_resource)
>> -	ld	r2,PACATOC(r13);
>>  BEGIN_FTR_SECTION
>> +	ld	r2,PACATOC(r13);
>>  	/*
>>  	 * POWER ISA 3. Use PSSCR to determine if we
>>  	 * are waking up from deep idle state
>> @@ -395,6 +395,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>>  	 */
>>  	clrldi	r5,r13,63
>>  	clrrdi	r13,r13,1
>> +
>> +	/* Now that we are sure r13 is corrected, load TOC */
>> +	ld	r2,PACATOC(r13);
>>  	cmpwi	cr4,r5,1
>>  	mtspr	SPRN_HSPRG0,r13
>>  
> 
