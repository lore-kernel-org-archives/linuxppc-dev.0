Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2E39B7B95
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 18:49:07 +1100 (EST)
In-Reply-To: <1254877655.6035.82.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254773824.7122.33.camel@pasglop>
	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>	
	<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>	
	<OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
	<1254784539.7122.52.camel@pasglop>	
	<OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
	<1254789255.7122.95.camel@pasglop>	
	<OFC64CFB37.E5E17F42-ONC1257647.0068299A-C1257647.00795ECE
	<1254877655.6035.82.camel@pasglop>
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF26D4EA84.9F0A4900-ONC1257648.0022D827-C1257648.002ACE4A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 7 Oct 2009 09:47:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 07/10/2009 03:07:35:
>
> Allright, did a bit of reading of doco and code..

hey, this is a super, thanks!

>
> Doco isn't totally clear though. At some stage, it -hints- that in case
> of a TLB "error" (match on EA/ASID but incorrect
> protection/valid/changed/...) the offending TLB entry is automatically
> invalidated. Do you know if that is correct ?

Nope, I don't know.

>
> I would hope so since we never do anything to remove the "invalid"
> entries we write to the TLB when hitting non-present PTEs but then, that
> may also explain some of our problems...

hmm, then a tlbil_va() in do_page_fault for "no translation" errors
would help I guess.

>
> Now, a few comments from what I read in the code:
>
>  - The whole writeback could be avoided in Instruction/Data TLB miss,
> but for that, you need to make sure that the TLB entry we create has
> valid set only if -both- present and accessed are set. That would save
> in the case of CONFIG_SWAP, a store and a read back of TWC I suppose,
> but you do need to find a way to do that ANDing of ACCESSED and PRESENT.

So far I have mapped !ACCESSED pages as No Access instead, maybe that
was wrong? I thought it was easier but I will have a look at this too.

>
>  - I think we can get rid of HWWRITE. We can make CHANGED be the current
> HWWRITE value, I agree with you, which matches the HW changed bit. We
> need to be a bit careful of how we setup the PP bits tho. At this stage,
> I see several approaches:
>
>    * One is to basically "generate" the right PP bits based on a
> combination of _PAGE_USER and _PAGE_RW. That's the simpler approach but
> probably uses more code in the TLB miss handler. It would look like
> that, with MxCTR:PPCS=0
>
>   _PAGE_USER    _PAGE_RW      PP (bits 20..27)
>       0            0               011C1111    (C is _PAGE_DIRTY)
>       0            1               000C1111
>       1            0               110C1111
>       1            1               100C1111
>
> One easy way to do that is to have _PAGE_USER and _PAGE_RW sit next to
> each other in bit position 28 and 29 (0xc). Load a GPR with something
> like 0110000011001000 and rotate it left by PTE & 0xc, then move the
> resulting 3 bits into position, or something along those lines. You can
> also give up on kernel read-only support and go down to 2 PP bits and
> never use the extended encoding.

yes, I do think the extended encoding is too much work and not worth it.
One concern I have is if a user RO mapping also can be a kernel RO
mapping? That is, do kernel require RW to a user page mapped RO?

>
>   * Another one is to use MxCTR:PPCS=1 a mask of 100C1U00 (U is
> _PAGE_USER) and or in ^_PAGE_RW (it could actually be made
> reverse-polarity in the PTE but that would mean some changes to non-8xx
> specific headers, so let's avoid it for now at least).

hmm, interesting.
Then I will also have set ACCESSED manually in TLB Miss I think.

>
> At least that's the best options I can see from my reading of the doco,
> though it's not totally clear to me what really happens when doing the
> PPCS trick, will it generate a TLB error on a non-match or will it try
> to TLB miss, which could be bad.

Yes, I don't think anybody has tested this.

>
>   * Last but not least, it wouldn't be hard to use either of the above
> encodings, and have the PTE actually contain the right bit combination
> already. You don't need to have a _PAGE_RW, you don't need to have a
> _PAGE_USER  :-) Look at how I do things for book3e, where I layout the
> 6 BookE protection bit directly in the PTE. That's a bit harder and maybe
> will need subtle changes to pte-common.h and such to accomodate it, and
> so probably something to experiment with as a second step, but it's the
> most efficient approach in the long run for obvious reasons.
>
>  - I think we could have more bits pre-set to the right values in the
> PTE, look how we play with defining some of the constants in
> pte-common.h, might be worth having a look, but -after- we have
> something that works :-)
>
>  - Possible bug: I'm very disturbed by the fact that DataTLBError sets
> HWWRITE and DIRTY on a non-present PTE. It should not. Just like
> ACCESSED. That's going to cause trouble and swap corruption, even more
> as we move DIRTY around.

Yes, this is what I fix with the first patch in my series:
   8xx: DTLB Error must check for more errors.

    DataTLBError currently does:
     if ((err & 0x02000000) == 0)
        DSI();
    This won't handle a store with no valid translation.
    Change this to
     if ((err & 0x48000000) != 0)
        DSI();
    that is, branch to DSI if either !permission or
    !translation.

>
>  - Maybe we can completely remove that mucking around with dirty,
> setting of accessed etc... from DataTLBError. Just make it go to C code
> just like InstructionAccess, as we discussed earlier, the generic code
> will fix it up and we'll speed up page faults. It should be fairly rare
> to take a fault due to a missing _PAGE_ACCESSED or _PAGE_DIRTY in any
> case, so all that fixup in those exceptions is just overhead.

That depends on if you set ACCESSED in TLB Miss or not I think.
if TLB Miss maps pages as NoAccess du to missing ACCESSED then the
first access is always going to trap to TLB Error and then to
C just to fix DIRTY and/or ACCESSED, feels a bit more expensive
fixing it in TLB error, no?

BTW, does 2.4 update ACCESSED and DIRTY in generic code the same way
as 2.6? It is still much easier for me to test thing in 2.4 and then
move it over to 2.6

>
>  - Later on, if it rocks your boat, you may want to look into removing
> the mucking around with swapper_pg_dir in the TLB miss. Instead, what
> you can do is lazily copy the kernel PMDs into the user PMDs. IE. On the
> first kernel access from a new user context, you fault, and from the
> do_page_fault() code, we can detect that and fixup the user PMD to point
> to the kernel page tables, thus avoiding that whole bunch of code in the
> TLB miss. When creating new user page tables, we can pre-fill the kernel
> PMDs too. I think x86 does that. We could do that for BookE too, though
> it's less of a win since we have to fixup the TID in MMUCR/MAS but for
> 8xx it would save a few instructions & conditionals in the TLB miss fast
> path.

That would be nice, I have had that idea but no clue as how to do it.

>
>  - I still have problems with the comment next to the "workaround"
> tlbil_va() we have in the icache/dcache flush. It doesn't make much
> sense to me since dcbst is going to be done by the kernel on a kernel
> address, not a user address, so I don't see how the thing we invalidate
> relates to the flush we do just below.... So that raises a few
> questions:

This workaround was added when we started to force TLB Errors in
TLB Miss for missing pmd entries so it may be some other bug in the
TLB code that makes this happen.
Here is a link:
 http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg07885.html
Seems to boil down to a missing tlbie()

>
>    * If this is to avoid write faults on kernel pages, then we may just
> want to have a fixup in do_page_fault() to ignore them when coming from
> flush_dcache_icache_* using the exception table mechanism instead ?
>
>    * I don't see how it works around user faults but maybe you have a
> clear scenario in mind
>
>    * It appears still reasonably obvious that we need that tlbil_va
> somewhere in that fault path, but I don't know what for, I'm not sure
> it's really what the comment says it's about. That raises back the whole
> question of when are those "invalid" TLB entries that we create when
> _PAGE_PRESENT is not set are going to be removed. The doc hints that
> they go a way on TLB error, but the doc really only says so for missing
> changed bit... so I'm tempted to say we need to basically stick a
> tlbil_va on 8xx on both set_pte_at() and ptep_set_access_flags() for any
> non-kernel page. What do you think ? That would be the safest.

Possibly just doing a tlbil_va in do_page_fault() for no translation
errors comes to mind.

>
>  - The "fake" DataAccess and InstructionAccess are useless... just a
> spurious jump for nothing. We could implement those straight in
> DataTLBError and InstructionTLBError, we just need to make sure that
> the trap numbers we put in the exception frame are 0x300 and 0x400, but
> that's just a matter of passing the right bits to EXC_XFER_EE_LITE().
>
>  - Finally, another boat-rocking optimisation to do is preload. You
> could hook in update_mmu_cache() for 8xx to go whack an entry in the TLB
> as well, which would avoid a TLB miss right after a page fault. But
> again, only when things work.
>
> None of the above of course address your DAR-not-updated concern. I
> think your approach of "clobbering" the DAR on every storage exception
> after it's been snapshotted and then testing for the clobber and
> emulating the instruction is the way to go, though your patch could use
> some cleaning there.

Yes, it is full of debug cruft now.

>
> I'll post comments on it separately.

Thanks, I still like the asm version for two reasons:
- It contains the problem to 8xx files
- fixing it up in do_page_fault() may lead to a never ending loop.
  This is mainly due to the current TLB code not using DIRTY correctly.

In any case it would be nice to keep the asm version in the file, should
we need it some day. It was rather painful to get it working so saving it
somewhere would be nice.

>
> At the end of the day, I can't help that much without HW access and/or a
> simulator, as you can guess, and no, I'm not asking for people to send
> me an 8xx board :-) (especially useless without a BDI imho). So I rely
> on Scott and yourself to sort this out. But thanks for showing up, and
> please, do port your board to 2.6 so you can test your stuff :-)

 :)
