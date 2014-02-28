Return-Path: <qemulist@gmail.com>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com
 [IPv6:2a00:1450:4010:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 579E02C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 13:54:59 +1100 (EST)
Received: by mail-la0-f45.google.com with SMTP id hr17so2313306lab.32
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 18:54:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140227154104.4e3572f1d9e2692d431d1a4e@linux-foundation.org>
References: <1391563546-26052-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20140213152009.b16a30d2a5b5c5706fc8952a@linux-foundation.org>
 <87k3cifgzz.fsf@linux.vnet.ibm.com>
 <20140227154104.4e3572f1d9e2692d431d1a4e@linux-foundation.org>
From: liu ping fan <qemulist@gmail.com>
Date: Fri, 28 Feb 2014 10:54:33 +0800
Message-ID: <CAJnKYQnK57Z-FVVXTJ9u5ijTh8QFCw1PnEj_526Q4DzeyyWRTw@mail.gmail.com>
Subject: Re: [PATCH] mm: numa: bugfix for LAST_CPUPID_NOT_IN_PAGE_FLAGS
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 28, 2014 at 7:41 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 26 Feb 2014 13:22:16 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Andrew Morton <akpm@linux-foundation.org> writes:
>>
>> > On Wed,  5 Feb 2014 09:25:46 +0800 Liu Ping Fan <qemulist@gmail.com> wrote:
>> >
>> >> When doing some numa tests on powerpc, I triggered an oops bug. I find
>> >> it is caused by using page->_last_cpupid.  It should be initialized as
>> >> "-1 & LAST_CPUPID_MASK", but not "-1". Otherwise, in task_numa_fault(),
>> >> we will miss the checking (last_cpupid == (-1 & LAST_CPUPID_MASK)).
>> >> And finally cause an oops bug in task_numa_group(), since the online cpu is
>> >> less than possible cpu.
>> >
>> > I grabbed this.  I added this to the changelog:
>> >
>> > : PPC needs the LAST_CPUPID_NOT_IN_PAGE_FLAGS case because ppc needs to
>> > : support a large physical address region, up to 2^46 but small section size
>> > : (2^24).  So when NR_CPUS grows up, it is easily to cause
>> > : not-in-page-flags.
>> >
>> > to hopefully address Peter's observation.
>> >
>> > How should we proceed with this?  I'm getting the impression that numa
>> > balancing on ppc is a dead duck in 3.14, so perhaps this and
>> >
>> > powerpc-mm-add-new-set-flag-argument-to-pte-pmd-update-function.patch
>> > mm-dirty-accountable-change-only-apply-to-non-prot-numa-case.patch
>> > mm-use-ptep-pmdp_set_numa-for-updating-_page_numa-bit.patch
>> >
>>
>> All these are already in 3.14  ?
>
> Yes.
>
>> > are 3.15-rc1 material?
>> >
>>
>> We should push the first hunk to 3.14. I will wait for Liu to redo the
>> patch. BTW this should happen only when SPARSE_VMEMMAP is not
>> specified. Srikar had reported the issue here
>>
>> http://mid.gmane.org/20140219180200.GA29257@linux.vnet.ibm.com
>>
>> #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>> #define SECTIONS_WIDTH                SECTIONS_SHIFT
>> #else
>> #define SECTIONS_WIDTH                0
>> #endif
>>
>
> I'm lost.  What patch are you talking about?  The first hunk of what?
>
I think Aneesh was talking about the chunk of patch, which modified
the file "page-flags-layout.h".
I tried to collapse and simplify the logic, but it will incur that
LAST_CPUPID_WIDTH depends on CONFIG_NUMA_BALANCING.
It is an error since we need LAST_CPUPID_WIDTH even without
CONFIG_NUMA_BALANCING. (Sorry, I compiled and run kernel, but not find
this).

Thanks and best regards,
Fan

> I assume we're talking about
> mm-numa-bugfix-for-last_cpupid_not_in_page_flags.patch, which I had
> queued for 3.14.  I'll put it on hold until there's some clarity here.
>
