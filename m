Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fvgN2yCnzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 21:42:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH resend] powerpc/64s: fix page table fragment refcount race
 vs speculative references
In-Reply-To: <20180728023255.720d594c@roar.ozlabs.ibm.com>
References: <20180727114817.27190-1-npiggin@gmail.com>
 <20180727134156.GA13348@bombadil.infradead.org>
 <20180728002906.531d0211@roar.ozlabs.ibm.com>
 <20180727153834.GC13348@bombadil.infradead.org>
 <20180728023255.720d594c@roar.ozlabs.ibm.com>
Date: Tue, 31 Jul 2018 21:42:22 +1000
Message-ID: <87600vhbs1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Fri, 27 Jul 2018 08:38:35 -0700
> Matthew Wilcox <willy@infradead.org> wrote:
>> On Sat, Jul 28, 2018 at 12:29:06AM +1000, Nicholas Piggin wrote:
>> > On Fri, 27 Jul 2018 06:41:56 -0700
>> > Matthew Wilcox <willy@infradead.org> wrote:
>> > > On Fri, Jul 27, 2018 at 09:48:17PM +1000, Nicholas Piggin wrote:  
>> > > > The page table fragment allocator uses the main page refcount racily
>> > > > with respect to speculative references. A customer observed a BUG due
>> > > > to page table page refcount underflow in the fragment allocator. This
>> > > > can be caused by the fragment allocator set_page_count stomping on a
>> > > > speculative reference, and then the speculative failure handler
>> > > > decrements the new reference, and the underflow eventually pops when
>> > > > the page tables are freed.    
>> > > 
>> > > Oof.  Can't you fix this instead by using page_ref_add() instead of
>> > > set_page_count()?  
>> > 
>> > It's ugly doing it that way. The problem is we have a page table
>> > destructor and that would be missed if the spec ref was the last
>> > put. In practice with RCU page table freeing maybe you can say
>> > there will be no spec ref there (unless something changes), but
>> > still it just seems much simpler doing this and avoiding any
>> > complexity or relying on other synchronization.  
>> 
>> I don't want to rely on the speculative reference not happening by the
>> time the page table is torn down; that's way too black-magic for me.
>> Another possibility would be to use, say, the top 16 bits of the
>> atomic for your counter and call the dtor once the atomic is below 64k.
>> I'm also thinking about overhauling the dtor system so it's not tied to
>> compound pages; anyone with a bit in page_type would be able to use it.
>> That way you'd always get your dtor called, even if the speculative
>> reference was the last one.
>
> Yeah we could look at doing either of those if necessary.
>
>> > > > Any objection to the struct page change to grab the arch specific
>> > > > page table page word for powerpc to use? If not, then this should
>> > > > go via powerpc tree because it's inconsequential for core mm.    
>> > > 
>> > > I want (eventually) to get to the point where every struct page carries
>> > > a pointer to the struct mm that it belongs to.  It's good for debugging
>> > > as well as handling memory errors in page tables.  
>> > 
>> > That doesn't seem like it should be a problem, there's some spare
>> > words there for arch independent users.  
>> 
>> Could you take one of the spare words instead then?  My intent was to
>> just take the 'x86 pgds only' comment off that member.  _pt_pad_2 looks
>> ideal because it'll be initialised to 0 and you'll return it to 0 by
>> the time you're done.
>
> It doesn't matter for powerpc where the atomic_t goes, so I'm fine with
> moving it. But could you juggle the fields with your patch instead? I
> thought it would be nice to using this field that has been already
> tested on x86 not to overlap with any other data for
> bug fix that'll have to be widely backported.

Can we come to a conclusion on this one?

As far as backporting goes pt_mm is new in 4.18-rc so the patch will
need to be manually backported anyway. But I agree with Nick we'd rather
use a slot that is known to be free for arch use.

cheers
