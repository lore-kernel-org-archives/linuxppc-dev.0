Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A2EA72C01C2
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2012 08:11:07 +1100 (EST)
Message-ID: <1355087457.28585.61.camel@pasglop>
Subject: Re: Understanding how kernel updates MMU hash table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pegasus11 <aijazbaig1.new@gmail.com>
Date: Mon, 10 Dec 2012 08:10:57 +1100
In-Reply-To: <34775807.post@talk.nabble.com>
References: <34760537.post@talk.nabble.com>
 <1354695642.2351.8.camel@pasglop> <34762800.post@talk.nabble.com>
 <1354766337.2351.41.camel@pasglop> <34765222.post@talk.nabble.com>
 <1354794967.28585.16.camel@pasglop> <34775807.post@talk.nabble.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-12-08 at 23:18 -0800, Pegasus11 wrote:
> 3. For 64bit architecture there is no such 'segment register we use a
> segment table entry (STE) from within an SLB (segment lookaside buffer)
> which caches recently used mappings from ESID (part of effective address) to
> VSID (part of Virtual address). This SLB is again maintained in main memory
> by the OS.

Almost ;-) Older processors (pre-power4) used the STAB in memory. Since
power4 however (and thus including 970), the segments are
software-loaded in the SLB. IE. Whenever there's a segment "miss", an
interrupt is generated (0x380 or 0x480) which directly reloads a new
entry in the SLB HW buffer, without going via an STAB in memory. The SLB
is 64-entries up to power6 and 32 entries on power7 and 8.

The reduction in the number of entries comes with the support for 1T
segments which was added on power5+ (arch 2.03), which reduces the
pressure on the SLB significantly.

> 4. This hashed page table is located in a fixed region of main memory, the
> starting address of which is given by the SDR1 register.

Yes, and it's size too.

> 5. (Now this is something that I was perhaps missing. Please correct me if I
> am wrong). Every access to a memory location will picture the MMU since it
> is a hardware component which is always between the CPU bus and the memory
> bus. This basic fact of computer design was somehow escaping me,,i wonder
> why :thinking:. Thus the MMU first consulting the hardware TLB and on
> encountering a TLB miss, it looking for the same in the hashed page table,

Yes. There's actually two levels of HW TLB but you generally don't need
to be too much concerned about it. The ERAT is right in the core, is
small, fast, split (I and D are separate) and translates all the way
from effective addresses to real addresses (the translations in there
encompass both the SLB and hash). It's flushed automatically when either
flushing a TLB entry or an SLB entry. The TLB is larger, a bit further
away from the core (thus higher latency to access), and is more strictly
a cache of the hash table.

So the actual scenario for translating an address is:

 * Lookup in I or D ERAT, hit->done, miss->...
 * Lookup in SLB, miss->fault (0x480 or 0x380), hit->...
 * With SLB entry, construct the VA (replace the top bits with VSID)...
 * Lookup in TLB, hit->populate ERAT & done, miss->...
 * Lookup in hash table, hit->populate TLB & ERAT, done, miss->fault
(0400 or 0x300).

> is something that happens without any sort of OS interference (as the HW has
> been programmed to do).

Yes.

> 6. So now when you say that the kernel's job is to maintain this hashed
> paged table, since the MMU will need it during a TLB miss, makes sense to me
> now. And this page table has a peculiar format of Page table entry groups
> (PTEGs) and for each translation first the primary PTEG is searched and if
> the entry isn't found in it, the MMU searches the secondary PTEG for the
> same.

Yes.

>  All this happens in the background without the OS having as much as a
> hint for the same unless of course the entry is not found even in the
> secondary PTEG upon which a page fault exception is generated and the
> subsequent handling code ensues.

Correct.

> Now that I have spelled out what I understand (and ask you to please let me
> know if I am missing anything anywhere), what is there for me to understand
> is the relation between Linux's page table that is a pure software construct
> dictated by the kernel itself and the hardware dictated page table (which in
> my case here is an inverted page table maintained in a fixed location in
> main memory). I stumbled upon this link:
> http://yarchive.net/comp/linux/page_tables.html . Although its an old link,
> linus, in his usual candid style explains to a curios fellow the
> significance of maintaining a seperate page table distinct from the hardware
> dictated page table.

This is the story. Basically Linux can't easily be made to use something
other than a radix tree (though there is some flexibility as to the
format of the tree) so on "server class" powerpc, we pretty much have to
maintain a separate construct.

> Now, pardon me if my post hereon digresses a bit on the semantics of Linux
> page tables in general. I believe understanding why things are the way they
> are, would ultimately help me understand how Linux works so well on a
> plethora of hardware architectures including powerpc. In the link, he talks
> about 'Linux page tables matching hardware architectures closely' for a lot
> of architectures and machines. Which means Linux is using the page tables
> to, sort of, mirror the virtual memory related hardware as closely as
> possible. So in addition to satisfying what the architecture vendor
> specifies as the job of the OS in maintaining the VM infrastructure, it has
> its own VM infrastructure which it used to keep track of the Virtual memory.
> Right?

Yes.

> In that same link, Linus again stresses the fact that, such hash tables can
> be used as extended TLBs for the kernel. And he seems to have a particular
> dislike for PPC virtual memory management. He calls the architecture (or
> called it back then) a 'sick puppy' =^D.

Linus is known for is strong opinions and associated language :-) It did
still enjoy the use of a Mac G5 for a few years so he wasn't *that*
disgusted about it that he wouldn't use it :-)

> Now coming to the topic of TLB flush, all we are really talking about is
> invalidating the MMU hash table right?

Not exactly, see below.

>  But you mentioned that the kernel
> does not populate the TLB, the MMU does that from the hash table. So what
> exactly are we referring to as a TLB here? Linus considers the hash table as
> an 'extended TLB' but extended to what? The hardware TLBs? 

Yes, the hardware TLB, it needs to be flushed when a translation is
modified in the hash table.

> So when we talk about flushing the TLB which one are we talking about? The
> in memory hash table or the TLB or both? Or does it depend on the virtual
> address(es)?

Well, from a Linux perspective both. Ie. we modify the Linux PTE which
in our case is a SW only construct, and if the HASHPTE bit is set, which
is whenever we have hashed that at least once, we then also update the
hash table, and if something was found in there, perform the appropriate
HW invalidation sequence to make sure the HW TLB is also aware of the
change (tlbie instruction along with various synchronization).

> And since it is NOT in the form of a tree, invalidating an entire hash
> table, should be faster than clear a page table atleast on paper. Right?

We never invalidate the entire hash. When invalidating a single page we
target that specific page. On recent kernels at least (dunno about
2.6.10) we also keep track in the PTE of which slot in which group a
given linux PTE has been hashed which makes it faster to target it for
invalidation.

Unfortunately, when invalidating an entire process address space, we
have no choice but walk all the PTEs and target the ones that have been
hashed, though we do a little bit of batching here to improve
performances.

>  Is
> there any way one can actually speedup the TLB flush if one has such
> inverted Hash tables (which I think) are being used as extended TLBs? Linus
> seems to have a pretty nasty opinion about them old PPC machines
> though...but im still interested to know if any good could come out of it.
> 
> You also said that, most hash table loads tend to be cache misses. I believe
> you've used the term 'cache' here loosely and it corresponds to the three
> hardware TLBs that you had mentioned. Right? Since it there the MMU first
> looks for before taking a shot at the in-memory hash table isn't it?

No, I mean L2/L3 caches. IE, the powerpc hash table is fairly big and
the access pattern fairly random, meaning that the chances of hitting
the L2 or L3 when doing the HW lookup in the hash table are pretty low.

Cheers,
Ben.

> Keen to know more Ben. Thanks in advance.
> :-)
> Cheers. 
> 
> 
> 
> > By your words, I understand that the hash table is an in-memory cache of
> > translations meaning it is implemented in software.
> 
> Well, it's populated by software and read by HW. IE. On x86, the MMU
> will walk a radix tree of page tables, on powerpc it will walk an in
> memory hash table. The main difference is that on x86, there is usually
> a tree per process while the powerpc hash table tends to be global.
> 
> > So whenever the MMU wishes to translate a virtual address, it first checks
> > the TLB and if it
> > isn't found there, it looks for it in the hash table. Now this seems fine
> > to
> > me when looked at from the perspective of the MMU. Now when I look at it
> > from the kernel's perspective, I am a bit confused.
> > 
> > So when we (the kernel) encounter a virtual address, we walk the page
> > tables
> > and if we find that there is no valid entry for this address, we page
> > fault
> > which causes an exception right?
> 
> Hrm ... not sure what we mean by "the kernel". There are two different
> path here, but let's focus on the usual case... the processor encounters
> an address, whether it's trying to fetch an instruction, or having done
> that, is performing a load or a store. This will use what we call in
> powerpc lingua an "effective" address. This gets in turn turned into a
> "virtual address" after an SLB lookup.
> 
> I refer you to the architecture here, it's a bit tricky but basically
> the principle is that the virtual address space is *somewhat* the
> effective address space along with the process id. Except that on
> powerpc, we do that per-segment (we divide the address space into
> segments) so each segment has its top bits "transformed" into something
> larger called the VSID.
> 
> In any case, this results in a virtual address which is then looked up
> in the TLB (I'm ignoring the ERAT here which is the 1-st level TLB but
> let's not complicate things even more). If that misses, the CPU looks up
> in the hash table. If that misses, it causes an exception (0x300 for
> data accesses, 0x400 for instruction accesses).
> 
> There, Linux will usually go into hash_page which looks for the Linux
> PTE. If the PTE is absent (or has any other reason to be unusable such
> as being read-only for a write access), we get to do_page_fault.
> 
> Else, we populate the hash table with a translation, set the HASHPTE bit
> in the PTE, and retry the access.
> 
> >  And this exception then takes us to the
> > exception handler which I guess is 'do_page_fault'. On checking this
> > function I see that it gets the PGD, allocates a PMD, allocates a PTE and
> > then it calls handle_pte_fault. The comment banner for handle_pte_fault
> > reads:
> > 
> > 1638 /* These routines also need to handle stuff like marking pages dirty
> > 1639 * and/or accessed for architectures that don't do it in hardware
> > (most
> > 1640 * RISC architectures).  The early dirtying is also good on the i386.
> > 1641 *
> > 1642 * There is also a hook called "update_mmu_cache()" that architectures
> > 1643 * with external mmu caches can use to update those (ie the Sparc or
> > 1644 * PowerPC hashed page tables that act as extended TLBs)....
> > .........
> > */
> 
> Yes, when we go to do_page_fault() because the PTE wasn't populated in
> the first place, we have a hook to pre-fill the hash table instead of
> taking a fault again which will fill it the second time around. It's
> just a shortcut.
> 
> > It is from such comments that I inferred that the hash tables were being
> > used as "extended TLBs". However the above also infers (atleast to me)
> > that
> > these caches are in hardware as theyve used the word 'extended'. Pardon me
> > if I am being nitpicky but these things are confusing me a bit. So to
> > clear
> > this confusion, there are three things I would like to know.
> > 1. Is the MMU cache implemented in hardware or software? I trust you on it
> > being software but it would be great if you could address my concern in
> > the
> > above paragraph.
> 
> The TLB is a piece of HW. (there's really three in fact, the I-ERAT, the
> D-ERAT and the TLB ;-)
> 
> The Hash Table is a piece of RAM (pointed to by the SDR1 register) setup
> by the OS and populated by the OS but read by the HW. Just like the page
> tables on x86.
> 
> > 2. The kernel, it looks from the do_page_fault sequence, is updating its
> > internal page table first and then it goes on to update the mmu cache. So
> > this only means it is satisfying the requirement of someone else, perhaps
> > the MMU here. 
> 
> update_mmu_cache() is just a shortcut.
> 
> As I explained above, we populate the hash table lazily on fault.
> However, when taking an actual high level page fault (do_page_fault), we
> *know* the hash doesn't have an appropriate translation, so rather than
> just filling up the linux PTE and then taking the fault again to fill
> the hash from the linux PTE, we have a hook so we can pre-fill the hash.
> 
> > This should imply that this MMU cache does the kernel no good
> > in fact it adds one more entry in its to-do list when it plays around with
> > a
> > process's page table.
> 
> This is a debatable topic ;-) Some of us do indeed thing that the hash
> table isn't a very useful construct in the grand scheme of things and
> ends up being fairly inefficient, for a variety of reasons including the
> added overhead of maintaining it that you mention above, though that can
> easily be dwarfed by the overhead caused by the fact that most hash
> table loads tend to be cache misses (the hash is simply not very cache
> friendly).
> 
> On the other hand, it means that unlike a page table tree, the hash tend
> to resolve a translation in a single load, at least when well primed and
> big enough. So for some types of workloads, it makes quite a bit of
> sense, at least on paper.
> 
> > 3. If the above is true, where is the TLB for the kernel? I mean when I
> > see
> > head.S for the ppc64 architecture (all files are from 2.6.10 by the way),
> > I
> > do see an unconditional branch for do_hash_page wherein we "try to insert
> > an
> > HPTE". Within do_hash_page, after doing some sanity checking to make sure
> > we
> > don't have any weird conditions here, we jump to 'handle_page_fault' which
> > is again encoded in assembly and in the same file viz. head.S. Following
> > it
> > I again arrive back to handle_mm_fault from within 'do_page_fault' and we
> > are back to square one. I understand that stuff is happening transparently
> > behind our backs, but what and where exactly? I mean if I could understand
> > this sequence of what is in hardware, what is in software and the
> > sequence,
> > perhaps I could get my head around it a lot better...
> > 
> > Again, I am keen to hear from you and I am sorry if I going round round
> > and
> > round..but I seriously am a bit confused with this..
> 
> The TLB is not directly populated by the kernel, the HW does it by
> reading from the hash table, though we do invalidate it ourselves.
> 
> Cheers,
> Ben.
> 
> > Thanks again.
> > 
> > Benjamin Herrenschmidt wrote:
> > > 
> > > On Wed, 2012-12-05 at 09:14 -0800, Pegasus11 wrote:
> > >> Hi Ben.
> > >> 
> > >> Thanks for your input. Please find my comments inline.
> > > 
> > > Please don't quote your replies ! Makes it really hard to read.
> > > 
> > >> 
> > >> Benjamin Herrenschmidt wrote:
> > >> > 
> > >> > On Tue, 2012-12-04 at 21:56 -0800, Pegasus11 wrote:
> > >> >> Hello.
> > >> >> 
> > >> >> Ive been trying to understand how an hash PTE is updated. Im on a
> > >> >> PPC970MP
> > >> >> machine which using the IBM PowerPC 604e core. 
> > >> > 
> > >> > Ben: Ah no, the 970 is a ... 970 core :-) It's a derivative of
> > POWER4+
> > >> > which
> > >> > is quite different from the old 32-bit 604e.
> > >> > 
> > >> > Peg: So the 970 is a 64bit core whereas the 604e is a 32 bit core.
> > The
> > >> > former is used in the embedded segment whereas the latter for server
> > >> > market right?
> > > 
> > > Not quite. The 604e is an ancient core, I don't think it's still used
> > > anymore. It was a "server class" (sort-of) 32-bit core. Embedded
> > > nowadays would be things like FSL e500 etc...
> > > 
> > > 970 aka G5 is a 64-bit server class core designed originally for Apple
> > > G5 machines, derivative of the POWER4+ design.
> > > 
> > > IE. They are both server-class (or "classic") processors, not embedded
> > > though of course they can be used in embedded setups as well.
> > > 
> > >> >> My Linux version is 2.6.10 (I
> > >> >> am sorry I cannot migrate at the moment. Management issues and I
> > can't
> > >> >> help
> > >> >> :-(( )
> > >> >> 
> > >> >> Now onto the problem:
> > >> >> hpte_update is invoked to sync the on-chip MMU cache which Linux
> > uses
> > >> as
> > >> >> its
> > >> >> TLB.
> > >> > 
> > >> > Ben: It's actually in-memory cache. There's also an on-chip TLB.
> > > 
> > >> > Peg: An in-memory cache of what?
> > > 
> > > Of translations :-) It's sort-of a memory overflow of the TLB, it's read
> > > by HW though.
> > > 
> > >>  You mean the kernel caches the PTEs in its own software cache as well?
> > > 
> > > No. The HW MMU will look into the hash table if it misses the TLB, so
> > > the hash table is part of the HW architecture definition. It can be seen
> > > as a kind of in-memory cache of the TLB.
> > > 
> > > The kernel populates it from the Linux page table PTEs "on demand".
> > > 
> > >> And is this cache not related in anyway to
> > >> > the on-chip TLB? 
> > > 
> > > It is in that it's accessed by HW when the TLB misses.
> > > 
> > >> If that is indeed the case, then ive read a paper on some
> > >> > of the MMU tricks for the PPC by court dougan which says Linux uses
> > (or
> > >> > perhaps used to when he wrote that) the MMU hardware cache as the
> > >> hardware
> > >> > TLB. What is that all about? Its called : Optimizing the Idle Task
> > and
> > >> > Other MMU Tricks - Usenix
> > > 
> > > Probably very ancient and not very relevant anymore :-)
> > > 
> > >> >>  So whenever a change is made to the PTE, it has to be propagated to
> > >> the
> > >> >> corresponding TLB entry. And this uses hpte_update for the same. Am
> > I
> > >> >> right
> > >> >> here?
> > >> > 
> > >> > Ben: hpte_update takes care of tracking whether a Linux PTE was also
> > >> > cached
> > >> > into the hash, in which case the hash is marked for invalidation. I
> > >> > don't remember precisely how we did it in 2.6.10 but it's possible
> > that
> > >> > the actual invalidation of the hash and the corresponding TLB
> > >> > invalidations are delayed.
> > >> > Peg: But in 2.6.10, Ive seen the code first check for the existence
> > of
> > >> the
> > >> > HASHPTE flag in a given PTE and if it exists, only then is this
> > >> > hpte_update function being called. Could you for the love of tux
> > >> elaborate
> > >> > a bit on how the hash and the underlying TLB entries are related?
> > I'll
> > >> > then try to see how it was done back then..since it would probably be
> > >> > quite similar at least conceptually (if I am lucky :jumping:)
> > > 
> > > Basically whenever there's a HW fault (TLB miss -> hash miss), we try to
> > > populate the hash table based on the content of the linux PTE and if we
> > > succeed (permission ok etc...) we set the HASHPTE flag in the PTE. This
> > > indicates that this PTE was hashed at least once.
> > > 
> > > This is used in a couple of cases, such as when doing invalidations, in
> > > order to know whether it's worth searching the hash for a match that
> > > needs to be cleared as well, and issuing a tlbie instruction to flush
> > > any corresponding TLB entry or not.
> > > 
> > >> >> Now  http://lxr.linux.no/linux-bk+*/+code=hpte_update hpte_update 
> > is
> > >> >> declared as
> > >> >>  
> > >> >> ' void hpte_update(pte_t *ptep, unsigned long pte, int wrprot) '. 
> > >> >> The arguments to this function is a POINTER to the PTE entry (needed
> > >> to
> > >> >> make
> > >> >> a change persistent across function call right?), the PTE entry (as
> > in
> > >> >> the
> > >> >> value) as well the wrprot flag.
> > >> >> 
> > >> >> Now the code snippet thats bothering me is this:
> > >> >> '
> > >> >>   86        ptepage = virt_to_page(ptep);
> > >> >>   87        mm = (struct mm_struct *) ptepage->mapping;
> > >> >>   88        addr = ptepage->index +
> > >> >>   89                (((unsigned long)ptep & ~PAGE_MASK) *
> > >> PTRS_PER_PTE);
> > >> >> '
> > >> >> 
> > >> >> On line 86, we get the page structure for a given PTE but we pass
> > the
> > >> >> pointer to PTE not the PTE itself whereas virt_to_page is a macro
> > >> defined
> > >> >> as:
> > >> > 
> > >> > I don't remember why we did that in 2.6.10 however...
> > >> > 
> > >> >> #define virt_to_page(kaddr)   pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
> > >> >> 
> > >> >> Why are passing the POINTER to pte here? I mean are we looking for
> > the
> > >> >> PAGE
> > >> >> that is described by the PTE or are we looking for the PAGE which
> > >> >> contains
> > >> >> the pointer to PTE? Me things it is the later since the former is
> > >> given
> > >> >> by
> > >> >> the VALUE of the PTE not its POINTER. Right?
> > >> > 
> > >> > Ben: The above gets the page that contains the PTEs indeed, in order
> > to
> > >> > get
> > >> > the associated mapping pointer which points to the struct mm_struct,
> > >> and
> > >> > the index, which together are used to re-constitute the virtual
> > >> address,
> > >> > probably in order to perform the actual invalidation. Nowadays, we
> > just
> > >> > pass the virtual address down from the call site.
> > >> > Peg: Re-constitute the virtual address of what exactly? The virtual
> > >> > address that led us to the PTE is the most natural thought that comes
> > >> to
> > >> > mind.
> > > 
> > > Yes.
> > > 
> > >>  However, the page which contains all these PTEs, would be typically
> > >> > categorized as a page directory right? So are we trying to get the
> > page
> > >> > directory here...Sorry for sounding a bit hazy on this one...but I
> > >> really
> > >> > am on this...:confused:
> > > 
> > > The struct page corresponding to the page directory page contains some
> > > information about the context which allows us to re-constitute the
> > > virtual address. It's nasty and awkward and we don't do it that way
> > > anymore in recent kernels, the vaddr is passed all the way down as
> > > argument.
> > > 
> > > That vaddr is necessary to locate the corresponding hash entries and to
> > > perform TLB invalidations if needed.
> > > 
> > >> >> So if it indeed the later, what trickery are we here after? Perhaps
> > >> >> following the snippet will make us understand? As I see from above,
> > >> after
> > >> >> that we get the 'address space object' associated with this page. 
> > >> >> 
> > >> >> What I don't understand is the following line:
> > >> >>  addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) *
> > >> >> PTRS_PER_PTE);
> > >> >> 
> > >> >> First we get the index of the page in the file i.e. the number of
> > >> pages
> > >> >> preceding the page which holds the address of PTEP. Then we get the
> > >> lower
> > >> >> 12
> > >> >> bits of this page. Then we shift that these bits to the left by 12
> > >> again
> > >> >> and
> > >> >> to it we add the above index. What is this doing?
> > >> >> 
> > >> >> There are other things in this function that I do not understand.
> > I'd
> > >> be
> > >> >> glad if someone could give me a heads up on this.
> > >> > 
> > >> > Ben: It's gross, the point is to rebuild the virtual address. You
> > >> should
> > >> > *REALLY* update to a more recent kernel, that ancient code is broken
> > in
> > >> > many ways as far as I can tell.
> > >> > Peg: Well Ben, if I could I would..but you do know the higher
> > ups..and
> > >> the
> > >> > way those baldies think now don't u? Its hard as such to work with
> > >> > them..helping them to a platter of such goodies would only mean that
> > >> one
> > >> > is trying to undermine them (or so they'll think)...So Im between a
> > >> rock
> > >> > and a hard place here....hence..i'd rather go with the hard
> > place..and
> > >> > hope nice folks like yourself would help me make my life just a lil
> > bit
> > >> > easier...:handshake:
> > > 
> > > Are you aware of how old 2.6.10 is ? I know higher ups and I know they
> > > are capable of getting it sometimes ... :-)
> > > 
> > > Cheers,
> > > Ben.
> > > 
> > >> > Thanks again.
> > >> > 
> > >> > Pegasus
> > >> > 
> > >> > Cheers,
> > >> > Ben.
> > >> > 
> > >> > 
> > >> > _______________________________________________
> > >> > Linuxppc-dev mailing list
> > >> > Linuxppc-dev@lists.ozlabs.org
> > >> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > >> > 
> > >> > 
> > >> 
> > > 
> > > 
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > > 
> > > 
> > 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
> 
