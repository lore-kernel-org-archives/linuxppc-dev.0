Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5s3p3pKlzDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 19:03:33 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v937x6uI100283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Oct 2017 04:03:30 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dbwsyfs14-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Oct 2017 04:03:28 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 3 Oct 2017 09:03:26 +0100
Subject: Re: [PATCH v3 00/20] Speculative page faults
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, kirill@shutemov.name,
 Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 dave@stgolabs.net, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, haren@linux.vnet.ibm.com,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, "x86@kernel.org" <x86@kernel.org>
References: <CAADnVQLmSbLHwj9m33kpzAidJPvq3cbdnXjaew6oTLqHWrBbZQ@mail.gmail.com>
 <20170925163443.260d6092160ec704e2b04653@linux-foundation.org>
 <924a79af-6d7a-316a-1eee-3aebbfd4addf@linux.vnet.ibm.com>
 <20170928133850.90c5bf2aac0f1a63e29c01a3@linux-foundation.org>
 <64e9759b-a4fb-63d3-a811-3e35ae5a1028@linux.vnet.ibm.com>
 <873771dnrl.fsf@concordia.ellerman.id.au>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 3 Oct 2017 10:03:18 +0200
MIME-Version: 1.0
In-Reply-To: <873771dnrl.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <177195b3-2d99-94e6-f334-843bd19042a1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2017 03:27, Michael Ellerman wrote:
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> 
>> Hi Andrew,
>>
>> On 28/09/2017 22:38, Andrew Morton wrote:
>>> On Thu, 28 Sep 2017 14:29:02 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
>>>
>>>>> Laurent's [0/n] provides some nice-looking performance benefits for
>>>>> workloads which are chosen to show performance benefits(!) but, alas,
>>>>> no quantitative testing results for workloads which we may suspect will
>>>>> be harmed by the changes(?).  Even things as simple as impact upon
>>>>> single-threaded pagefault-intensive workloads and its effect upon
>>>>> CONFIG_SMP=n .text size?
>>>>
>>>> I forgot to mention in my previous email the impact on the .text section.
>>>>
>>>> Here are the metrics I got :
>>>>
>>>> .text size	UP		SMP		Delta
>>>> 4.13-mmotm	8444201		8964137		6.16%
>>>> '' +spf		8452041		8971929		6.15%
>>>> 	Delta	0.09%		0.09%	
>>>>
>>>> No major impact as you could see.
>>>
>>> 8k text increase seems rather a lot actually.  That's a lot more
>>> userspace cacheclines that get evicted during a fault...
>>>
>>> Is the feature actually beneficial on uniprocessor?
>>
>> This is useless on uniprocessor, and I will disable it on x86 when !SMP 
>> by not defining __HAVE_ARCH_CALL_SPF.
>> So the speculative page fault handler will not be built but the vm 
>> sequence counter and the SCRU stuff will still be there. I may also make 
>> it disabled through macro when __HAVE_ARCH_CALL_SPF is not defined, but 
>> this may obfuscated the code a bit...
>>
>> On ppc64, as this feature requires book3s, it can't be built without SMP 
>> support.
> 
> Book3S doesn't force SMP, eg. PMAC is Book3S but can be built with SMP=n.
> 
> It's true that POWERNV and PSERIES both force SMP, and those are the
> platforms used on modern Book3S CPUs.

Thanks Michael,

I'll add a check on CONFIG_SMP on ppc too.

Laurent.
