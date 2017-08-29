Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhVKQ0JQQzDqXl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 23:46:18 +1000 (AEST)
Date: Tue, 29 Aug 2017 15:45:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, paulmck@linux.vnet.ibm.com,
 akpm@linux-foundation.org, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
Message-ID: <20170829134550.t7du5zdssvlzemtk@hirez.programming.kicks-ass.net>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
 <507e79d5-59df-c5b5-106d-970c9353d9bc@linux.vnet.ibm.com>
 <20170829120426.4ar56rbmiupbqmio@hirez.programming.kicks-ass.net>
 <848fa2c6-dbda-9a1e-2efd-3ce9b083365e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <848fa2c6-dbda-9a1e-2efd-3ce9b083365e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 29, 2017 at 03:18:25PM +0200, Laurent Dufour wrote:
> On 29/08/2017 14:04, Peter Zijlstra wrote:
> > On Tue, Aug 29, 2017 at 09:59:30AM +0200, Laurent Dufour wrote:
> >> On 27/08/2017 02:18, Kirill A. Shutemov wrote:
> >>>> +
> >>>> +	if (unlikely(!vma->anon_vma))
> >>>> +		goto unlock;
> >>>
> >>> It deserves a comment.
> >>
> >> You're right I'll add it in the next version.
> >> For the record, the root cause is that __anon_vma_prepare() requires the
> >> mmap_sem to be held because vm_next and vm_prev must be safe.
> > 
> > But should that test not be:
> > 
> > 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> > 		goto unlock;
> > 
> > Because !anon vmas will never have ->anon_vma set and you don't want to
> > exclude those.
> 
> Yes in the case we later allow non anonymous vmas to be handled.
> Currently only anonymous vmas are supported so the check is good enough,
> isn't it ?

That wasn't at all clear from reading the code. This makes it clear
->anon_vma is only ever looked at for anonymous.

And like Kirill says, we _really_ should start allowing some (if not
all) vm_ops. Large file based mappings aren't particularly rare.

I'm not sure we want to introduce a white-list or just bite the bullet
and audit all ->fault() implementations. But either works and isn't
terribly difficult, auditing all is more work though.
