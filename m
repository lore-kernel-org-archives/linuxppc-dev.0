Return-Path: <srs0=gqm2=lg=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wxgf274LzF2Py
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 18:01:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41wxgd3mvgz8w0X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 18:01:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41wxgc4f3Bz9sBn
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 18:01:16 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7N7xaxt069170
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 04:01:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m1r06jnej-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 04:01:12 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Aug 2018 09:01:11 +0100
Subject: Re: [RESEND PATCH v2] powerpc/mce: Fix SLB rebolting during MCE
 recovery path.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <153500619258.20614.8965724795728734200.stgit@jupiter.in.ibm.com>
 <87d0u9lgyt.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 23 Aug 2018 13:31:07 +0530
MIME-Version: 1.0
In-Reply-To: <87d0u9lgyt.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <10dfea17-e98b-7a46-6dba-b222a6cf0c96@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2018 12:14 PM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> With the powerpc next commit e7e81847478 (powerpc/mce: Fix SLB rebolting
>> during MCE recovery path.),
> 
> That commit description is wrong, I'll fix it up.

Ouch.. My bad.. :-(

> 
> cheers
> 
>> the SLB error recovery is broken. The new
>> change now does not add index value to RB[52-63] that selects the SLB
>> entry while rebolting, instead it assumes that the shadow save area
>> already have index embeded correctly in esid field. While all valid bolted
>> save areas do contain index value set correctly, there is a case where
>> 3rd (KSTACK_INDEX) entry for kernel stack does not embed index for NULL
>> esid entry. This patch fixes that.
>>
>> Without this patch the SLB rebolt code overwrites the 1st entry of kernel
>> linear mapping and causes SLB recovery to fail.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/mm/slb.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>> index 0b095fa54049..9f574e59d178 100644
>> --- a/arch/powerpc/mm/slb.c
>> +++ b/arch/powerpc/mm/slb.c
>> @@ -70,7 +70,7 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
>>  
>>  static inline void slb_shadow_clear(enum slb_index index)
>>  {
>> -	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
>> +	WRITE_ONCE(get_slb_shadow()->save_area[index].esid, cpu_to_be64(index));
>>  }
>>  
>>  static inline void create_shadowed_slbe(unsigned long ea, int ssize,
> 
