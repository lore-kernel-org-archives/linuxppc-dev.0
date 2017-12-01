Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yp9b16M0XzDsMD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 21:33:01 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1ATSTA055884
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 05:32:59 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ek51wh64h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 05:32:58 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 05:32:58 -0500
Subject: Re: [PATCH] powerpc/mm: Invalidate subpage_prot() system call on
 radix platforms
To: Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20171130061215.22861-1-khandual@linux.vnet.ibm.com>
 <87r2sebuz2.fsf@concordia.ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 1 Dec 2017 16:02:52 +0530
MIME-Version: 1.0
In-Reply-To: <87r2sebuz2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0cb9d39f-f76c-dcc0-bbd4-b432baa1f8b4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/01/2017 04:01 PM, Michael Ellerman wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> Radix enabled platforms don't support subpage_prot() system calls. But
>> at present the system calls goes through without an error and fails
>> later on while validating expected subpage accesses. Lets not allow
>> the system call on powerpc radix platforms to begin with to prevent
>> this confusion in user space.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/mm/subpage-prot.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
>> index 781532d..4005468 100644
>> --- a/arch/powerpc/mm/subpage-prot.c
>> +++ b/arch/powerpc/mm/subpage-prot.c
>> @@ -195,6 +195,9 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
>>   	unsigned long next, limit;
>>   	int err;
>>   
>> +	if (radix_enabled())
>> +		return -ENOSYS;
> 
> It's considered poor form for syscalls to return ENOSYS. That is meant
> to mean one thing only, which is that the syscall does not exist.
> 
> See:
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/asm-generic/errno.h#n10
> 
> 
> Now arguably in this case ENOSYS does make some sense, because we'd
> really like it if the syscall didn't exist when radix is enabled.
> 
> But I still don't like it, it means without changing the kernel version,
> the syscall would appear or disappear based on which MMU mode you booted
> into - which is weird.
> 
> So I think ENOENT would be better. It says "the thing you're trying to
> access doesn't exist", where in this case "the thing" is "the subpage
> protection map for this address range". It's better than EINVAL because
> there's no implication that changing the arguments would result in
> different behaviour.
> 

Why not ENOTSUPP?

-aneesh
