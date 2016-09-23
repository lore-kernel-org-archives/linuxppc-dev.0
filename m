Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgNVj2h14zDsn6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 16:19:25 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sgNVh2P6pz9t14
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 16:19:24 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N6HZIA115381
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 02:19:22 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25mqb514va-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 02:19:21 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 23 Sep 2016 11:49:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8A9D9125805F
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 11:49:34 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8N6JFj131129816
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 11:49:15 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8N6JC4K004923
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 11:49:14 +0530
Subject: Re: [PATCH v2] powerpc/mm: export current mmu mode info
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <147456009252.14735.18189822731283851598.stgit@hbathini.in.ibm.com>
 <87eg4bzyuf.fsf@linux.vnet.ibm.com>
 <92b66a3f-809b-bd63-22cd-56e7707de479@linux.vnet.ibm.com>
 <878tujz0lw.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 23 Sep 2016 11:48:59 +0530
MIME-Version: 1.0
In-Reply-To: <878tujz0lw.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <615ad108-be19-9be9-77d3-1f3b08b92ba0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 23 September 2016 10:14 AM, Aneesh Kumar K.V wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> Hi Aneesh,
>>
>>
>> On Thursday 22 September 2016 09:54 PM, Aneesh Kumar K.V wrote:
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>>
>>>> The kernel now supports both radix and hash MMU modes. Tools like crash
>>>> and makedumpfile need to know the current MMU mode the kernel is using,
>>>> to debug/analyze it.  The current MMU mode depends on hardware support
>>>> and also whether disable_radix cmdline parameter is passed to the kernel.
>>>> The mmu_features member of cpu_spec structure holds the current MMU mode
>>>> a cpu is using. But the above mentioned tools need to know the MMU mode
>>>> early in their init process, when they may not have access to offset info
>>>> of structure members. A hard-coded offset may help but it won't be robust.
>>> IIUC, you walk the linux page table and that should be more or less same
>> Taking the case of crash tool, vmemmap start value is currently
>> hard-coded to 0xf000000000000000UL but it changed to
>> 0xc00a000000000000UL in case of radix.
> All of that is already defined as variables in the kernel. You can look at
> radix__early_init_mmu().
>
>
>>> between radix/hash right except few bits. Now what crash will be
>>> interested in will be the RPN part of the table which should be same
>>> between hash/radix.
>> Though the walk is pretty much the same, the tool still needs to know
>> the right index values and vmemmap start to use, as they are different
>> for radix and hash..
>>
>>>> This patch introduces a new global variable, which holds the current MMU
>>>> mode the kernel is running in and can be accessed by tools early in thier
>>>> init process,
>>> Init process of what ? kernel or crash tool ?
>> tool initialization - crash or makedumpfile..
>>
>>>> helping tools to initialize accurately for each MMU mode.
>>>> This patch also optimizes the radix_enabled() function call.
>>>>
>>> how do you differentiate between the hold linux page table format and
>>> the new ? Can you also summarize what crash tool look for in the page
>>> table ?
>> It needs the index sizes, masked bit values and page flag info to
>> do the page table walk. Since they can be different for hash and
>> radix..
>>
> Can you look at radix__early_init_mmu/hash__early_init_mmu and see you
> can work with the variables defined there ?

Did consider that but didn't opt for it for a few reasons:

1. Will still need to know the MMU mode as huge page address translation
    is not the same for radix & hash.

2. Will have to get all these values from a crashed kernel when I can 
set them
    based on MMU mode. Less dependence on the failed kernel, the better..

3. Stash more variables in vmcoreinfo (for makedumpfile) when one is 
sufficient
    to serve the purpose.

Thanks
Hari
