Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2vBl1L29zDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 22:29:18 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8SCO8qC062695
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 08:29:16 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d8xbu1gfn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 08:29:15 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 28 Sep 2017 13:29:13 +0100
Subject: Re: [PATCH v3 00/20] Speculative page faults
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, kirill@shutemov.name,
 Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 dave@stgolabs.net, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
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
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 28 Sep 2017 14:29:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170925163443.260d6092160ec704e2b04653@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <924a79af-6d7a-316a-1eee-3aebbfd4addf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On 26/09/2017 01:34, Andrew Morton wrote:
> On Mon, 25 Sep 2017 09:27:43 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
>> On Mon, Sep 18, 2017 at 12:15 AM, Laurent Dufour
>> <ldufour@linux.vnet.ibm.com> wrote:
>>> Despite the unprovable lockdep warning raised by Sergey, I didn't get any
>>> feedback on this series.
>>>
>>> Is there a chance to get it moved upstream ?
>>
>> what is the status ?
>> We're eagerly looking forward for this set to land,
>> since we have several use cases for tracing that
>> will build on top of this set as discussed at Plumbers.
> 
> There has been sadly little review and testing so far :(
> 
> I'll be taking a close look at it all over the next couple of weeks.
> 
> One terribly important thing (especially for a patchset this large and
> intrusive) is the rationale for merging it: the justification, usually
> in the form of end-user benefit.
> 
> Laurent's [0/n] provides some nice-looking performance benefits for
> workloads which are chosen to show performance benefits(!) but, alas,
> no quantitative testing results for workloads which we may suspect will
> be harmed by the changes(?).  Even things as simple as impact upon
> single-threaded pagefault-intensive workloads and its effect upon
> CONFIG_SMP=n .text size?

I forgot to mention in my previous email the impact on the .text section.

Here are the metrics I got :

.text size	UP		SMP		Delta
4.13-mmotm	8444201		8964137		6.16%
'' +spf		8452041		8971929		6.15%
	Delta	0.09%		0.09%	

No major impact as you could see.

Thanks,
Laurent

> If you have additional usecases then please, spell them out for us in
> full detail so we can better understand the benefits which this
> patchset provides.
> 
