Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 295B52C0199
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2012 18:57:14 +1100 (EST)
Received: from telerig.nabble.com ([192.168.236.162])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <bounces@nabble.com>) id 1TgWKV-0008Ak-Pn
 for linuxppc-dev@ozlabs.org; Wed, 05 Dec 2012 23:57:11 -0800
Message-ID: <34765222.post@talk.nabble.com>
Date: Wed, 5 Dec 2012 23:57:11 -0800 (PST)
From: Pegasus11 <aijazbaig1.new@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Understanding how kernel updates MMU hash table
In-Reply-To: <1354766337.2351.41.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <34760537.post@talk.nabble.com> <1354695642.2351.8.camel@pasglop>
 <34762800.post@talk.nabble.com> <1354766337.2351.41.camel@pasglop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben.

Got it..no more quoting replies...

You mentioned the MMU looking into a hash table if it misses a translation
entry in the TLB. This means that there is a hardware TLB for sure. By your
words, I understand that the hash table is an in-memory cache of
translations meaning it is implemented in software. So whenever the MMU
wishes to translate a virtual address, it first checks the TLB and if it
isn't found there, it looks for it in the hash table. Now this seems fine to
me when looked at from the perspective of the MMU. Now when I look at it
from the kernel's perspective, I am a bit confused.

So when we (the kernel) encounter a virtual address, we walk the page tables
and if we find that there is no valid entry for this address, we page fault
which causes an exception right? And this exception then takes us to the
exception handler which I guess is 'do_page_fault'. On checking this
function I see that it gets the PGD, allocates a PMD, allocates a PTE and
then it calls handle_pte_fault. The comment banner for handle_pte_fault
reads:

1638 /* These routines also need to handle stuff like marking pages dirty
1639 * and/or accessed for architectures that don't do it in hardware (most
1640 * RISC architectures).  The early dirtying is also good on the i386.
1641 *
1642 * There is also a hook called "update_mmu_cache()" that architectures
1643 * with external mmu caches can use to update those (ie the Sparc or
1644 * PowerPC hashed page tables that act as extended TLBs)....
.........
*/

It is from such comments that I inferred that the hash tables were being
used as "extended TLBs". However the above also infers (atleast to me) that
these caches are in hardware as theyve used the word 'extended'. Pardon me
if I am being nitpicky but these things are confusing me a bit. So to clear
this confusion, there are three things I would like to know.
1. Is the MMU cache implemented in hardware or software? I trust you on it
being software but it would be great if you could address my concern in the
above paragraph.
2. The kernel, it looks from the do_page_fault sequence, is updating its
internal page table first and then it goes on to update the mmu cache. So
this only means it is satisfying the requirement of someone else, perhaps
the MMU here. This should imply that this MMU cache does the kernel no good
in fact it adds one more entry in its to-do list when it plays around with a
process's page table.
3. If the above is true, where is the TLB for the kernel? I mean when I see
head.S for the ppc64 architecture (all files are from 2.6.10 by the way), I
do see an unconditional branch for do_hash_page wherein we "try to insert an
HPTE". Within do_hash_page, after doing some sanity checking to make sure we
don't have any weird conditions here, we jump to 'handle_page_fault' which
is again encoded in assembly and in the same file viz. head.S. Following it
I again arrive back to handle_mm_fault from within 'do_page_fault' and we
are back to square one. I understand that stuff is happening transparently
behind our backs, but what and where exactly? I mean if I could understand
this sequence of what is in hardware, what is in software and the sequence,
perhaps I could get my head around it a lot better...

Again, I am keen to hear from you and I am sorry if I going round round and
round..but I seriously am a bit confused with this..

Thanks again.

Benjamin Herrenschmidt wrote:
> 
> On Wed, 2012-12-05 at 09:14 -0800, Pegasus11 wrote:
>> Hi Ben.
>> 
>> Thanks for your input. Please find my comments inline.
> 
> Please don't quote your replies ! Makes it really hard to read.
> 
>> 
>> Benjamin Herrenschmidt wrote:
>> > 
>> > On Tue, 2012-12-04 at 21:56 -0800, Pegasus11 wrote:
>> >> Hello.
>> >> 
>> >> Ive been trying to understand how an hash PTE is updated. Im on a
>> >> PPC970MP
>> >> machine which using the IBM PowerPC 604e core. 
>> > 
>> > Ben: Ah no, the 970 is a ... 970 core :-) It's a derivative of POWER4+
>> > which
>> > is quite different from the old 32-bit 604e.
>> > 
>> > Peg: So the 970 is a 64bit core whereas the 604e is a 32 bit core. The
>> > former is used in the embedded segment whereas the latter for server
>> > market right?
> 
> Not quite. The 604e is an ancient core, I don't think it's still used
> anymore. It was a "server class" (sort-of) 32-bit core. Embedded
> nowadays would be things like FSL e500 etc...
> 
> 970 aka G5 is a 64-bit server class core designed originally for Apple
> G5 machines, derivative of the POWER4+ design.
> 
> IE. They are both server-class (or "classic") processors, not embedded
> though of course they can be used in embedded setups as well.
> 
>> >> My Linux version is 2.6.10 (I
>> >> am sorry I cannot migrate at the moment. Management issues and I can't
>> >> help
>> >> :-(( )
>> >> 
>> >> Now onto the problem:
>> >> hpte_update is invoked to sync the on-chip MMU cache which Linux uses
>> as
>> >> its
>> >> TLB.
>> > 
>> > Ben: It's actually in-memory cache. There's also an on-chip TLB.
> 
>> > Peg: An in-memory cache of what?
> 
> Of translations :-) It's sort-of a memory overflow of the TLB, it's read
> by HW though.
> 
>>  You mean the kernel caches the PTEs in its own software cache as well?
> 
> No. The HW MMU will look into the hash table if it misses the TLB, so
> the hash table is part of the HW architecture definition. It can be seen
> as a kind of in-memory cache of the TLB.
> 
> The kernel populates it from the Linux page table PTEs "on demand".
> 
>> And is this cache not related in anyway to
>> > the on-chip TLB? 
> 
> It is in that it's accessed by HW when the TLB misses.
> 
>> If that is indeed the case, then ive read a paper on some
>> > of the MMU tricks for the PPC by court dougan which says Linux uses (or
>> > perhaps used to when he wrote that) the MMU hardware cache as the
>> hardware
>> > TLB. What is that all about? Its called : Optimizing the Idle Task and
>> > Other MMU Tricks - Usenix
> 
> Probably very ancient and not very relevant anymore :-)
> 
>> >>  So whenever a change is made to the PTE, it has to be propagated to
>> the
>> >> corresponding TLB entry. And this uses hpte_update for the same. Am I
>> >> right
>> >> here?
>> > 
>> > Ben: hpte_update takes care of tracking whether a Linux PTE was also
>> > cached
>> > into the hash, in which case the hash is marked for invalidation. I
>> > don't remember precisely how we did it in 2.6.10 but it's possible that
>> > the actual invalidation of the hash and the corresponding TLB
>> > invalidations are delayed.
>> > Peg: But in 2.6.10, Ive seen the code first check for the existence of
>> the
>> > HASHPTE flag in a given PTE and if it exists, only then is this
>> > hpte_update function being called. Could you for the love of tux
>> elaborate
>> > a bit on how the hash and the underlying TLB entries are related? I'll
>> > then try to see how it was done back then..since it would probably be
>> > quite similar at least conceptually (if I am lucky :jumping:)
> 
> Basically whenever there's a HW fault (TLB miss -> hash miss), we try to
> populate the hash table based on the content of the linux PTE and if we
> succeed (permission ok etc...) we set the HASHPTE flag in the PTE. This
> indicates that this PTE was hashed at least once.
> 
> This is used in a couple of cases, such as when doing invalidations, in
> order to know whether it's worth searching the hash for a match that
> needs to be cleared as well, and issuing a tlbie instruction to flush
> any corresponding TLB entry or not.
> 
>> >> Now  http://lxr.linux.no/linux-bk+*/+code=hpte_update hpte_update  is
>> >> declared as
>> >>  
>> >> ' void hpte_update(pte_t *ptep, unsigned long pte, int wrprot) '. 
>> >> The arguments to this function is a POINTER to the PTE entry (needed
>> to
>> >> make
>> >> a change persistent across function call right?), the PTE entry (as in
>> >> the
>> >> value) as well the wrprot flag.
>> >> 
>> >> Now the code snippet thats bothering me is this:
>> >> '
>> >>   86        ptepage = virt_to_page(ptep);
>> >>   87        mm = (struct mm_struct *) ptepage->mapping;
>> >>   88        addr = ptepage->index +
>> >>   89                (((unsigned long)ptep & ~PAGE_MASK) *
>> PTRS_PER_PTE);
>> >> '
>> >> 
>> >> On line 86, we get the page structure for a given PTE but we pass the
>> >> pointer to PTE not the PTE itself whereas virt_to_page is a macro
>> defined
>> >> as:
>> > 
>> > I don't remember why we did that in 2.6.10 however...
>> > 
>> >> #define virt_to_page(kaddr)   pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>> >> 
>> >> Why are passing the POINTER to pte here? I mean are we looking for the
>> >> PAGE
>> >> that is described by the PTE or are we looking for the PAGE which
>> >> contains
>> >> the pointer to PTE? Me things it is the later since the former is
>> given
>> >> by
>> >> the VALUE of the PTE not its POINTER. Right?
>> > 
>> > Ben: The above gets the page that contains the PTEs indeed, in order to
>> > get
>> > the associated mapping pointer which points to the struct mm_struct,
>> and
>> > the index, which together are used to re-constitute the virtual
>> address,
>> > probably in order to perform the actual invalidation. Nowadays, we just
>> > pass the virtual address down from the call site.
>> > Peg: Re-constitute the virtual address of what exactly? The virtual
>> > address that led us to the PTE is the most natural thought that comes
>> to
>> > mind.
> 
> Yes.
> 
>>  However, the page which contains all these PTEs, would be typically
>> > categorized as a page directory right? So are we trying to get the page
>> > directory here...Sorry for sounding a bit hazy on this one...but I
>> really
>> > am on this...:confused:
> 
> The struct page corresponding to the page directory page contains some
> information about the context which allows us to re-constitute the
> virtual address. It's nasty and awkward and we don't do it that way
> anymore in recent kernels, the vaddr is passed all the way down as
> argument.
> 
> That vaddr is necessary to locate the corresponding hash entries and to
> perform TLB invalidations if needed.
> 
>> >> So if it indeed the later, what trickery are we here after? Perhaps
>> >> following the snippet will make us understand? As I see from above,
>> after
>> >> that we get the 'address space object' associated with this page. 
>> >> 
>> >> What I don't understand is the following line:
>> >>  addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) *
>> >> PTRS_PER_PTE);
>> >> 
>> >> First we get the index of the page in the file i.e. the number of
>> pages
>> >> preceding the page which holds the address of PTEP. Then we get the
>> lower
>> >> 12
>> >> bits of this page. Then we shift that these bits to the left by 12
>> again
>> >> and
>> >> to it we add the above index. What is this doing?
>> >> 
>> >> There are other things in this function that I do not understand. I'd
>> be
>> >> glad if someone could give me a heads up on this.
>> > 
>> > Ben: It's gross, the point is to rebuild the virtual address. You
>> should
>> > *REALLY* update to a more recent kernel, that ancient code is broken in
>> > many ways as far as I can tell.
>> > Peg: Well Ben, if I could I would..but you do know the higher ups..and
>> the
>> > way those baldies think now don't u? Its hard as such to work with
>> > them..helping them to a platter of such goodies would only mean that
>> one
>> > is trying to undermine them (or so they'll think)...So Im between a
>> rock
>> > and a hard place here....hence..i'd rather go with the hard place..and
>> > hope nice folks like yourself would help me make my life just a lil bit
>> > easier...:handshake:
> 
> Are you aware of how old 2.6.10 is ? I know higher ups and I know they
> are capable of getting it sometimes ... :-)
> 
> Cheers,
> Ben.
> 
>> > Thanks again.
>> > 
>> > Pegasus
>> > 
>> > Cheers,
>> > Ben.
>> > 
>> > 
>> > _______________________________________________
>> > Linuxppc-dev mailing list
>> > Linuxppc-dev@lists.ozlabs.org
>> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>> > 
>> > 
>> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://old.nabble.com/Understanding-how-kernel-updates-MMU-hash-table-tp34760537p34765222.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
