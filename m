Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BF66F2C009B
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2012 04:14:26 +1100 (EST)
Received: from telerig.nabble.com ([192.168.236.162])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <bounces@nabble.com>) id 1TgIYB-0007YR-GF
 for linuxppc-dev@ozlabs.org; Wed, 05 Dec 2012 09:14:23 -0800
Message-ID: <34762800.post@talk.nabble.com>
Date: Wed, 5 Dec 2012 09:14:23 -0800 (PST)
From: Pegasus11 <aijazbaig1.new@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Understanding how kernel updates MMU hash table
In-Reply-To: <1354695642.2351.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <34760537.post@talk.nabble.com> <1354695642.2351.8.camel@pasglop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben.

Thanks for your input. Please find my comments inline.


Benjamin Herrenschmidt wrote:
> 
> On Tue, 2012-12-04 at 21:56 -0800, Pegasus11 wrote:
>> Hello.
>> 
>> Ive been trying to understand how an hash PTE is updated. Im on a
>> PPC970MP
>> machine which using the IBM PowerPC 604e core. 
> 
> Ben: Ah no, the 970 is a ... 970 core :-) It's a derivative of POWER4+
> which
> is quite different from the old 32-bit 604e.
> 
> Peg: So the 970 is a 64bit core whereas the 604e is a 32 bit core. The
> former is used in the embedded segment whereas the latter for server
> market right?
> 
>> My Linux version is 2.6.10 (I
>> am sorry I cannot migrate at the moment. Management issues and I can't
>> help
>> :-(( )
>> 
>> Now onto the problem:
>> hpte_update is invoked to sync the on-chip MMU cache which Linux uses as
>> its
>> TLB.
> 
> Ben: It's actually in-memory cache. There's also an on-chip TLB.
> Peg: An in-memory cache of what? You mean the kernel caches the PTEs in
> its own software cache as well? And is this cache not related in anyway to
> the on-chip TLB? If that is indeed the case, then ive read a paper on some
> of the MMU tricks for the PPC by court dougan which says Linux uses (or
> perhaps used to when he wrote that) the MMU hardware cache as the hardware
> TLB. What is that all about? Its called : Optimizing the Idle Task and
> Other MMU Tricks - Usenix
> 
>>  So whenever a change is made to the PTE, it has to be propagated to the
>> corresponding TLB entry. And this uses hpte_update for the same. Am I
>> right
>> here?
> 
> Ben: hpte_update takes care of tracking whether a Linux PTE was also
> cached
> into the hash, in which case the hash is marked for invalidation. I
> don't remember precisely how we did it in 2.6.10 but it's possible that
> the actual invalidation of the hash and the corresponding TLB
> invalidations are delayed.
> Peg: But in 2.6.10, Ive seen the code first check for the existence of the
> HASHPTE flag in a given PTE and if it exists, only then is this
> hpte_update function being called. Could you for the love of tux elaborate
> a bit on how the hash and the underlying TLB entries are related? I'll
> then try to see how it was done back then..since it would probably be
> quite similar at least conceptually (if I am lucky :jumping:)
> 
>> Now  http://lxr.linux.no/linux-bk+*/+code=hpte_update hpte_update  is
>> declared as
>>  
>> ' void hpte_update(pte_t *ptep, unsigned long pte, int wrprot) '. 
>> The arguments to this function is a POINTER to the PTE entry (needed to
>> make
>> a change persistent across function call right?), the PTE entry (as in
>> the
>> value) as well the wrprot flag.
>> 
>> Now the code snippet thats bothering me is this:
>> '
>>   86        ptepage = virt_to_page(ptep);
>>   87        mm = (struct mm_struct *) ptepage->mapping;
>>   88        addr = ptepage->index +
>>   89                (((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
>> '
>> 
>> On line 86, we get the page structure for a given PTE but we pass the
>> pointer to PTE not the PTE itself whereas virt_to_page is a macro defined
>> as:
> 
> I don't remember why we did that in 2.6.10 however...
> 
>> #define virt_to_page(kaddr)   pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>> 
>> Why are passing the POINTER to pte here? I mean are we looking for the
>> PAGE
>> that is described by the PTE or are we looking for the PAGE which
>> contains
>> the pointer to PTE? Me things it is the later since the former is given
>> by
>> the VALUE of the PTE not its POINTER. Right?
> 
> Ben: The above gets the page that contains the PTEs indeed, in order to
> get
> the associated mapping pointer which points to the struct mm_struct, and
> the index, which together are used to re-constitute the virtual address,
> probably in order to perform the actual invalidation. Nowadays, we just
> pass the virtual address down from the call site.
> Peg: Re-constitute the virtual address of what exactly? The virtual
> address that led us to the PTE is the most natural thought that comes to
> mind. However, the page which contains all these PTEs, would be typically
> categorized as a page directory right? So are we trying to get the page
> directory here...Sorry for sounding a bit hazy on this one...but I really
> am on this...:confused:
> 
> 
>> So if it indeed the later, what trickery are we here after? Perhaps
>> following the snippet will make us understand? As I see from above, after
>> that we get the 'address space object' associated with this page. 
>> 
>> What I don't understand is the following line:
>>  addr = ptepage->index + (((unsigned long)ptep & ~PAGE_MASK) *
>> PTRS_PER_PTE);
>> 
>> First we get the index of the page in the file i.e. the number of pages
>> preceding the page which holds the address of PTEP. Then we get the lower
>> 12
>> bits of this page. Then we shift that these bits to the left by 12 again
>> and
>> to it we add the above index. What is this doing?
>> 
>> There are other things in this function that I do not understand. I'd be
>> glad if someone could give me a heads up on this.
> 
> Ben: It's gross, the point is to rebuild the virtual address. You should
> *REALLY* update to a more recent kernel, that ancient code is broken in
> many ways as far as I can tell.
> Peg: Well Ben, if I could I would..but you do know the higher ups..and the
> way those baldies think now don't u? Its hard as such to work with
> them..helping them to a platter of such goodies would only mean that one
> is trying to undermine them (or so they'll think)...So Im between a rock
> and a hard place here....hence..i'd rather go with the hard place..and
> hope nice folks like yourself would help me make my life just a lil bit
> easier...:handshake:
> 
> Thanks again.
> 
> Pegasus
> 
> Cheers,
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://old.nabble.com/Understanding-how-kernel-updates-MMU-hash-table-tp34760537p34762800.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
