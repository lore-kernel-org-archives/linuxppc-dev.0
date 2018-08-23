Return-Path: <srs0=gqm2=lg=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wryK4WjwzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 14:28:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41wryK3kyfz8wHR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 14:28:41 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41wryJ6nXHz9s7X
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 14:28:40 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7N4OMWp073095
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 00:28:38 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2m1kucbtkb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 00:28:37 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Aug 2018 05:28:36 +0100
Subject: Re: [PATCH] poewrpc/mce: Fix SLB rebolting during MCE recovery path.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <153449765953.21426.6928471250286444535.stgit@jupiter.in.ibm.com>
 <20180821202702.4198d426@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 23 Aug 2018 09:58:31 +0530
MIME-Version: 1.0
In-Reply-To: <20180821202702.4198d426@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <4dc90537-0fde-ab1a-8372-aba2d82ebd8c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2018 03:57 PM, Nicholas Piggin wrote:
> On Fri, 17 Aug 2018 14:51:47 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> With the powrpc next commit e7e81847478 (poewrpc/mce: Fix SLB rebolting
>> during MCE recovery path.), the SLB error recovery is broken. The
>> commit missed a crucial change of OR-ing index value to RB[52-63] which
>> selects the SLB entry while rebolting. This patch fixes that.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/mm/slb.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>> index 0b095fa54049..6dd9913425bc 100644
>> --- a/arch/powerpc/mm/slb.c
>> +++ b/arch/powerpc/mm/slb.c
>> @@ -101,9 +101,12 @@ void __slb_restore_bolted_realmode(void)
>>  
>>  	 /* No isync needed because realmode. */
>>  	for (index = 0; index < SLB_NUM_BOLTED; index++) {
>> +		unsigned long rb = be64_to_cpu(p->save_area[index].esid);
>> +
>> +		rb = (rb & ~0xFFFul) | index;
>>  		asm volatile("slbmte  %0,%1" :
>>  		     : "r" (be64_to_cpu(p->save_area[index].vsid)),
>> -		       "r" (be64_to_cpu(p->save_area[index].esid)));
>> +		       "r" (rb));
>>  	}
>>  }
>>  
>>
> 
> I'm just looking at this again. The bolted save areas do have the
> index field set. So for the OS, your patch should be equivalent to
> this, right?
> 
>  static inline void slb_shadow_clear(enum slb_index index)
>  {
> -       WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
> +       WRITE_ONCE(get_slb_shadow()->save_area[index].esid, index);
>  }
> 
> Which seems like a better fix.

Yeah this also fixes the issue. The only additional change required is
cpu_to_be64(index). As long as we maintain index in bolted save areas
(for valid/invalid entries) we should be ok. Will respin v2 with this
change.

Thanks,
-Mahesh.
