Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWCKD3mstzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 12:59:12 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA71t1iD056708
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 20:59:09 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e31k7navu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 20:59:09 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Nov 2017 18:59:08 -0700
Subject: Re: [PATCH 0/5] VA allocator fixes
To: Nicholas Piggin <npiggin@gmail.com>, Florian Weimer <fweimer@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <cc66ea81-fd9a-0bd5-8a8c-5abdc604200b@redhat.com>
 <20171107110611.30cfede4@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 7 Nov 2017 07:29:01 +0530
MIME-Version: 1.0
In-Reply-To: <20171107110611.30cfede4@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f2535e23-4a06-ba61-86fd-3558ddad2e15@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/07/2017 05:36 AM, Nicholas Piggin wrote:
> On Mon, 6 Nov 2017 16:16:07 +0100
> Florian Weimer <fweimer@redhat.com> wrote:
> 
>> On 11/06/2017 11:03 AM, Nicholas Piggin wrote:
>>> Florian found a nasty corner case with the VA allocation logic
>>> for crossing from 128TB to 512TB limit on hash, and made a
>>> really superb report of the problem -- traces, reproducer recipes,
>>> analysis, etc. which already mostly solved it.
>>>
>>> The first patch in the series should solve Florian's particular
>>> case, the next 3 are other issues with addr_limit. The last
>>> patch is technically a cleanup but I think it's fairly important
>>> in terms of understanding the code and also enabling some BUG
>>> checks (when addr_limit == 0).
>>>
>>> I have not tested these exactly on Florian's test case, but
>>> some tests of my own behave better afterwards. Hopefully he has
>>> time to re-test. Some careful review would be welcome too.
>>
>> I think I have applied the five patches you posted, but I still get a
>> brk value above 128 TiB:
>>
>> # /lib64/ld64.so.1 ./a.out
>> initial brk value: 0x7fffde960000
>> probing at 0x80000001fffc
>>
>> I assumed you wanted to reject those?
> 
> It was difficult to understand what the intended semantics are, but I
> think brk should succeed (it is implemented with MAP_FIXED). Of course
> it should not succeed then segfault when you try to access it.
> 
>>
>> In either case, I recommend to tweak the VM layout, so that ld.so does
>> not land closely to to the 128 TiB limit, so that the brk failure or
>> returning of 48-bit addresses is avoided.
> 
> Yeah well that's yet another issue. I was not really involved with the
> address space extension work. Anees, Kirill, was the intention for the
> 128T->512T extension logic to be a no-op for all address space allocaiton
> except those with explicit addresses?
> 

yes.

-aneesh
