Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2txG09KLzDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 22:17:37 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8SCFXGA004817
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 08:17:34 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d8yr4c3km-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 08:17:33 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 28 Sep 2017 13:17:31 +0100
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
Date: Thu, 28 Sep 2017 14:17:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170925163443.260d6092160ec704e2b04653@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d6ceae3b-09c0-0642-ff56-c31d044e805e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

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

I do agree and I could just encourage people to do so :/

> I'll be taking a close look at it all over the next couple of weeks.

Thanks Andrew for giving it a close look.

> One terribly important thing (especially for a patchset this large and
> intrusive) is the rationale for merging it: the justification, usually
> in the form of end-user benefit.

The benefit is only for multi-threaded processes. But even on *small* 
systems with 16 CPUs, there is a real benefit.

> 
> Laurent's [0/n] provides some nice-looking performance benefits for
> workloads which are chosen to show performance benefits(!) but, alas,
> no quantitative testing results for workloads which we may suspect will
> be harmed by the changes(?).

I did test with kernbench, involving gcc/ld which are not 
multi-threaded, AFAIK, and I didn't see any impact.
But if you know additional test I should give a try, please advise.

Regarding ebizzy, it was designed to simulate web server's activity, so 
I guess there will be improvements when running real web servers.

>  Even things as simple as impact upon
> single-threaded pagefault-intensive workloads and its effect upon
> CONFIG_SMP=n .text size?
> 
> If you have additional usecases then please, spell them out for us in
> full detail so we can better understand the benefits which this
> patchset provides.

The other use-case I'm aware of is on memory database, where performance 
improvements is really significant, as I mentioned in the header of my 
series.

Cheers,
Laurent.
