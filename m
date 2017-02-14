Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMt6V1DpFzDqCr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 17:38:41 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E6Xui7017035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 01:38:39 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28km0cjwnb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 01:38:39 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Feb 2017 23:38:38 -0700
Subject: Re: [PATCH V2 1/2] powerpc/mm/slice: Move slice_mask struct
 definition to slice.c
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, Balbir Singh <bsingharora@gmail.com>
References: <1486988642-25000-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87mvdpmgpi.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 12:08:32 +0530
MIME-Version: 1.0
In-Reply-To: <87mvdpmgpi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <89a807a3-289c-3cca-dc52-930c6d7f4021@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 14 February 2017 11:55 AM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index b3f45e413a60..08ac27eae408 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -37,7 +37,16 @@
>>   #include <asm/hugetlb.h>
>>   
>>   static DEFINE_SPINLOCK(slice_convert_lock);
>> -
>> +/*
>> + * One bit per slice. We have lower slices which cover 256MB segments
>> + * upto 4G range. That gets us 16 low slices. For the rest we track slices
>> + * in 1TB size.
> Can we tighten this comment up a bit.
>
> What about:
>
>> + * One bit per slice. The low slices cover the range 0 - 4GB, each
>>    * slice being 256MB in size, for 16 low slices. The high slices
>>    * cover the rest of the address space at 1TB granularity, with the
>>    * exception of high slice 0 which covers the range 4GB - 1TB.
> OK?


good.

>
>> + * 64 below is actually SLICE_NUM_HIGH to fixup complie errros
> That line is bogus AFAICS, it refers to the old hardcoded value (prior
> to 512), I'll drop it.


Thanks


-aneesh
