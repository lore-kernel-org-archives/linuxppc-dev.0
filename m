Return-Path: <srs0=ib65=kz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n1cJ1Gr1zF0WR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 20:30:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41n1cJ0nCvz8tBY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 20:30:56 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41n1cH3dcCz9s7Q
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 20:30:55 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7AAONx5104082
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 06:30:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ks5ea09kf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 06:30:53 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 10 Aug 2018 11:30:51 +0100
Subject: Re: [PATCH v7 5/9] powerpc/pseries: flush SLB contents on SLB MCE
 errors.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal Suchanek <msuchanek@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365142349.14256.9954484737438718329.stgit@jupiter.in.ibm.com>
 <20180808190456.59c03b8b@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2018 16:00:46 +0530
MIME-Version: 1.0
In-Reply-To: <20180808190456.59c03b8b@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <63bf4cc1-d595-5af6-1e5f-e9047461f3a2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2018 02:34 PM, Nicholas Piggin wrote:
> On Tue, 07 Aug 2018 19:47:14 +0530
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
>> Signed-off-by: Michal Suchanek <msuchanek@suse.com>
>> ---
>>
>> Changes in V7:
>> - Fold Michal's patch into this patch.
>> - Handle MSR_RI=0 and evil context case in MC handler.
>> ---
> 
> 
>> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>> index cb796724a6fc..e89f675f1b5e 100644
>> --- a/arch/powerpc/mm/slb.c
>> +++ b/arch/powerpc/mm/slb.c
>> @@ -145,6 +145,12 @@ void slb_flush_and_rebolt(void)
>>  	get_paca()->slb_cache_ptr = 0;
>>  }
>>  
>> +void slb_flush_and_rebolt_realmode(void)
>> +{
>> +	__slb_flush_and_rebolt();
>> +	get_paca()->slb_cache_ptr = 0;
>> +}
>> +
>>  void slb_vmalloc_update(void)
>>  {
>>  	unsigned long vflags;
> 
> Can you use this patch for the SLB flush?
> 
> https://patchwork.ozlabs.org/patch/953034/

Will use your v2.

Thanks,
-Mahesh.

> 
> Thanks,
> Nick
> 
