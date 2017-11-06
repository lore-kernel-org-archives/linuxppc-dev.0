Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVm2s4vthzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:30:13 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA68T4vd050034
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 03:30:10 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e2kr79pt9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 03:30:10 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Nov 2017 01:30:09 -0700
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
To: Nicholas Piggin <npiggin@gmail.com>, Florian Weimer <fweimer@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 14:00:01 +0530
MIME-Version: 1.0
In-Reply-To: <20171106192524.12ea3187@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/06/2017 01:55 PM, Nicholas Piggin wrote:
> On Mon, 6 Nov 2017 09:11:37 +0100
> Florian Weimer <fweimer@redhat.com> wrote:
> 
>> On 11/06/2017 07:47 AM, Nicholas Piggin wrote:
>>> "You get < 128TB unless explicitly requested."
>>>
>>> Simple, reasonable, obvious rule. Avoids breaking apps that store
>>> some bits in the top of pointers (provided that memory allocator
>>> userspace libraries also do the right thing).
>>
>> So brk would simplify fail instead of crossing the 128 TiB threshold?
> 
> Yes, that was the intention and that's what x86 seems to do.
> 
>>
>> glibc malloc should cope with that and switch to malloc, but this code
>> path is obviously less well-tested than the regular way.
> 
> Switch to mmap() I guess you meant?
> 
> powerpc has a couple of bugs in corner cases, so those should be fixed
> according to intended policy for stable kernels I think.
> 
> But I question the policy. Just seems like an ugly and ineffective wart.
> Exactly for such cases as this -- behaviour would change from run to run
> depending on your address space randomization for example! In case your
> brk happens to land nicely on 128TB then the next one would succeed.

Why ? It should not change between run to run. We limit the free
area search range based on hint address. So we should get consistent 
results across run. even if we changed the context.addr_limit.

-aneesh
