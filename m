Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgLPL1PGWzDsm7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 14:44:38 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sgLPK4SF2z9t14
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 14:44:37 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8N4hPpK045514
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 00:44:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25mqb6xuhh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2016 00:44:34 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 22:44:34 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/mm: export current mmu mode info
In-Reply-To: <92b66a3f-809b-bd63-22cd-56e7707de479@linux.vnet.ibm.com>
References: <147456009252.14735.18189822731283851598.stgit@hbathini.in.ibm.com>
 <87eg4bzyuf.fsf@linux.vnet.ibm.com>
 <92b66a3f-809b-bd63-22cd-56e7707de479@linux.vnet.ibm.com>
Date: Fri, 23 Sep 2016 10:14:27 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tujz0lw.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> Hi Aneesh,
>
>
> On Thursday 22 September 2016 09:54 PM, Aneesh Kumar K.V wrote:
>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>
>>> The kernel now supports both radix and hash MMU modes. Tools like crash
>>> and makedumpfile need to know the current MMU mode the kernel is using,
>>> to debug/analyze it.  The current MMU mode depends on hardware support
>>> and also whether disable_radix cmdline parameter is passed to the kernel.
>>> The mmu_features member of cpu_spec structure holds the current MMU mode
>>> a cpu is using. But the above mentioned tools need to know the MMU mode
>>> early in their init process, when they may not have access to offset info
>>> of structure members. A hard-coded offset may help but it won't be robust.
>> IIUC, you walk the linux page table and that should be more or less same
>
> Taking the case of crash tool, vmemmap start value is currently
> hard-coded to 0xf000000000000000UL but it changed to
> 0xc00a000000000000UL in case of radix.

All of that is already defined as variables in the kernel. You can look at
radix__early_init_mmu().


>
>> between radix/hash right except few bits. Now what crash will be
>> interested in will be the RPN part of the table which should be same
>> between hash/radix.
>
> Though the walk is pretty much the same, the tool still needs to know
> the right index values and vmemmap start to use, as they are different
> for radix and hash..
>
>>> This patch introduces a new global variable, which holds the current MMU
>>> mode the kernel is running in and can be accessed by tools early in thier
>>> init process,
>> Init process of what ? kernel or crash tool ?
>
> tool initialization - crash or makedumpfile..
>
>>> helping tools to initialize accurately for each MMU mode.
>>> This patch also optimizes the radix_enabled() function call.
>>>
>> how do you differentiate between the hold linux page table format and
>> the new ? Can you also summarize what crash tool look for in the page
>> table ?
>
> It needs the index sizes, masked bit values and page flag info to
> do the page table walk. Since they can be different for hash and
> radix..
>

Can you look at radix__early_init_mmu/hash__early_init_mmu and see you
can work with the variables defined there ?

-aneesh
