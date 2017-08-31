Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjYwY3mNqzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 17:31:57 +1000 (AEST)
Date: Thu, 31 Aug 2017 09:31:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
Message-ID: <20170831073121.ptxjsvibekxudzbx@hirez.programming.kicks-ass.net>
References: <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
 <507e79d5-59df-c5b5-106d-970c9353d9bc@linux.vnet.ibm.com>
 <20170829120426.4ar56rbmiupbqmio@hirez.programming.kicks-ass.net>
 <848fa2c6-dbda-9a1e-2efd-3ce9b083365e@linux.vnet.ibm.com>
 <20170829134550.t7du5zdssvlzemtk@hirez.programming.kicks-ass.net>
 <ab0634c4-274d-208f-fc4b-43991986bacf@linux.vnet.ibm.com>
 <20170830055800.GG32112@worktop.programming.kicks-ass.net>
 <12d54f18-6dec-5067-db87-d1a176d5160f@linux.vnet.ibm.com>
 <0add5ad0-fd3d-efb7-f00c-7232dfc768af@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0add5ad0-fd3d-efb7-f00c-7232dfc768af@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 31, 2017 at 12:25:16PM +0530, Anshuman Khandual wrote:
> On 08/30/2017 03:02 PM, Laurent Dufour wrote:
> > On 30/08/2017 07:58, Peter Zijlstra wrote:
> >> On Wed, Aug 30, 2017 at 10:33:50AM +0530, Anshuman Khandual wrote:
> >>> diff --git a/mm/filemap.c b/mm/filemap.c
> >>> index a497024..08f3042 100644
> >>> --- a/mm/filemap.c
> >>> +++ b/mm/filemap.c
> >>> @@ -1181,6 +1181,18 @@ int __lock_page_killable(struct page *__page)
> >>>  int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
> >>>                          unsigned int flags)
> >>>  {
> >>> +       if (flags & FAULT_FLAG_SPECULATIVE) {
> >>> +               if (flags & FAULT_FLAG_KILLABLE) {
> >>> +                       int ret;
> >>> +
> >>> +                       ret = __lock_page_killable(page);
> >>> +                       if (ret)
> >>> +                               return 0;
> >>> +               } else
> >>> +                       __lock_page(page);
> >>> +               return 1;
> >>> +       }
> >>> +
> >>>         if (flags & FAULT_FLAG_ALLOW_RETRY) {
> >>>                 /*
> >>>                  * CAUTION! In this case, mmap_sem is not released
> >>
> >> Yeah, that looks right.
> > 
> > Hum, I'm wondering if FAULT_FLAG_RETRY_NOWAIT should be forced in the
> > speculative path in that case to match the semantics of
> > __lock_page_or_retry().
> 
> Doing that would force us to have another retry through classic fault
> path wasting all the work done till now through SPF. Hence it may be
> better to just wait, get the lock here and complete the fault. Peterz,
> would you agree ? Or we should do as suggested by Laurent. More over,
> forcing FAULT_FLAG_RETRY_NOWAIT on FAULT_FLAG_SPECULTIVE at this point
> would look like a hack.

Is there ever a situation where SPECULATIVE and NOWAIT are used
together? That seems like something to avoid.

A git-grep seems to suggest gup() can set it, but gup() will not be
doing speculative faults. s390 also sets it, but then again, they don't
have speculative fault support yet and when they do they can avoid
setting them together.

So maybe put in a WARN_ON_ONCE() on having both of them, it is not
something that makes sense to me, but maybe someone sees a rationale for
it?
