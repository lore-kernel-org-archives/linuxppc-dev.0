Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjY6f50SrzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 16:55:38 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7V6rfOB117443
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 02:55:33 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cpa77wgx2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 02:55:33 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 16:55:30 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7V6tS9339977172
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 16:55:28 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7V6tIXQ007752
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 16:55:19 +1000
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
 <507e79d5-59df-c5b5-106d-970c9353d9bc@linux.vnet.ibm.com>
 <20170829120426.4ar56rbmiupbqmio@hirez.programming.kicks-ass.net>
 <848fa2c6-dbda-9a1e-2efd-3ce9b083365e@linux.vnet.ibm.com>
 <20170829134550.t7du5zdssvlzemtk@hirez.programming.kicks-ass.net>
 <ab0634c4-274d-208f-fc4b-43991986bacf@linux.vnet.ibm.com>
 <20170830055800.GG32112@worktop.programming.kicks-ass.net>
 <12d54f18-6dec-5067-db87-d1a176d5160f@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, paulmck@linux.vnet.ibm.com,
 akpm@linux-foundation.org, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 12:25:16 +0530
MIME-Version: 1.0
In-Reply-To: <12d54f18-6dec-5067-db87-d1a176d5160f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <0add5ad0-fd3d-efb7-f00c-7232dfc768af@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/2017 03:02 PM, Laurent Dufour wrote:
> On 30/08/2017 07:58, Peter Zijlstra wrote:
>> On Wed, Aug 30, 2017 at 10:33:50AM +0530, Anshuman Khandual wrote:
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index a497024..08f3042 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -1181,6 +1181,18 @@ int __lock_page_killable(struct page *__page)
>>>  int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>>>                          unsigned int flags)
>>>  {
>>> +       if (flags & FAULT_FLAG_SPECULATIVE) {
>>> +               if (flags & FAULT_FLAG_KILLABLE) {
>>> +                       int ret;
>>> +
>>> +                       ret = __lock_page_killable(page);
>>> +                       if (ret)
>>> +                               return 0;
>>> +               } else
>>> +                       __lock_page(page);
>>> +               return 1;
>>> +       }
>>> +
>>>         if (flags & FAULT_FLAG_ALLOW_RETRY) {
>>>                 /*
>>>                  * CAUTION! In this case, mmap_sem is not released
>>
>> Yeah, that looks right.
> 
> Hum, I'm wondering if FAULT_FLAG_RETRY_NOWAIT should be forced in the
> speculative path in that case to match the semantics of
> __lock_page_or_retry().

Doing that would force us to have another retry through classic fault
path wasting all the work done till now through SPF. Hence it may be
better to just wait, get the lock here and complete the fault. Peterz,
would you agree ? Or we should do as suggested by Laurent. More over,
forcing FAULT_FLAG_RETRY_NOWAIT on FAULT_FLAG_SPECULTIVE at this point
would look like a hack.
