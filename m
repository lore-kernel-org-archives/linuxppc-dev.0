Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w02ml19S2zDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Apr 2017 00:59:50 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v37EmdhI106801
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Apr 2017 10:59:45 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29p2h6hu32-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Apr 2017 10:59:45 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Sat, 8 Apr 2017 00:59:42 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v37ExV5G44040224
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Apr 2017 00:59:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v37Ex7PU007202
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 8 Apr 2017 00:59:07 +1000
Subject: Re: [PATCH V4] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <5fb76b92-2988-1207-2bed-814a96e6a51a@linux.vnet.ibm.com>
 <20170407035539.21688-1-khandual@linux.vnet.ibm.com>
 <87lgrcgynk.fsf@concordia.ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 20:28:44 +0530
MIME-Version: 1.0
In-Reply-To: <87lgrcgynk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <6776b39d-ce6a-82fd-8e25-01de9374d4ef@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/07/2017 06:31 PM, Michael Ellerman wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> This just adds user space exported ABI definitions for 2MB, 16MB, 1GB,
>> 16GB non default huge page sizes to be used with mmap() system call.
> 
> I updated this for you to include all the sizes.
> 
>> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
>> index 03c06ba..ebe99c7 100644
>> --- a/arch/powerpc/include/uapi/asm/mman.h
>> +++ b/arch/powerpc/include/uapi/asm/mman.h
>> @@ -29,4 +29,18 @@
>>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
>>  
>> +/*
>> + * These constant defines should be used for creating the
>> + * 'flags' argument (26:31 bit positions) for mmap() system
>> + * call should the caller decide to use non default HugeTLB
>> + * page size.
>> + */
> 
> And I reworded the comment the make it clearer (I think) that most users
> shouldn't need to use these, and should just use the default size:
> 
> /*
>  * When MAP_HUGETLB is set bits [26:31] encode the log2 of the huge page size.
>  * A value of zero indicates that the default huge page size should be used.
>  * To use a non-default huge page size, one of these defines can be used, or the
>  * size can be encoded by hand. Note that on most systems only a subset, or
>  * possibly none, of these sizes will be available.
>  */

Yeah its clearer, thanks.

> 
> 
> Also do you want to send a patch to the man page?
> 
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/mmap.2#n248
> 

Sure, will do it.
