Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 22196B7B8F
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 07:15:15 +1100 (EST)
In-Reply-To: <20091002214949.GA20514@b07421-ec1.am.freescale.net>
References: <OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
	<1254350159.5699.21.camel@pasglop>
	<20091002214949.GA20514@b07421-ec1.am.freescale.net>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Scott Wood <scottwood@freescale.com>,
	Rex Feany <RFeany@mrv.com>
Message-ID: <OF7C895670.A7F16A1A-ONC1257645.00620A4D-C1257645.006ED40F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 4 Oct 2009 22:10:32 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 02/10/2009 23:49:49:
>
> On Thu, Oct 01, 2009 at 08:35:59AM +1000, Benjamin Herrenschmidt wrote:
> > >From what I can see, the TLB miss code will check _PAGE_PRESENT, and
> > when not set, it will -still- insert something into the TLB (unlike
> > all other CPU types that go straight to data access faults from there).
> >
> > So we end up populating with those unpopulated entries that will then
> > cause us to take a DSI (or ISI) instead of a TLB miss the next time
> > around ... and so we need to remove them once we do that, no ? IE. Once
> > we have actually put a valid PTE in.
> >
> > At least that's my understanding and why I believe we should always have
> > tlbil_va() in set_pte() and ptep_set_access_flags(), which boils down
> > in putting it into the 2 "filter" functions in the new code.
> >
> > Well.. actually, the ptep_set_access_flags() will already do a
> > flush_tlb_page_nohash() when the PTE is changed. So I suppose all we
> > really need here would be in set_pte_filter(), to do the same if we are
> > writing a PTE that has _PAGE_PRESENT, at least on 8xx.
> >
> > But just unconditionally doing a tlbil_va() in both the filter functions
> > shouldn't harm and also fix the problem, though Rex seems to indicate
> > that is not the case.
>
> Adding a tlbil_va to do_page_fault makes the problem go away for me (on
> top of your "merge" branch) -- none of the other changes in this thread
> do (assuming I didn't miss any).  FWIW, when it gets stuck on a fault,
> DSISR is 0xc0000000, and handle_mm_fault returns zero.

Scott and Rex

I have managed to update the TLB code to make proper use of dirty and accessed states.
Advantages are:
 - I/D TLB Miss never needs to write to the linux pte, saving a few cycles
 - Accessed is only set by I/D TLB Error, should be a plus when SWAP is used.
 - _PAGE_DIRTY is mapped to 0x100, the changed bit, and is set directly
    and there will be no extra DTLB Error to actually set the changed bit
    when a page has been made dirty.
- Proper RO/RW mapping of user space.

Cons:
 - 4 more insn in TLB Miss handlers, but the since the linux pte isn't
   written it should still be a win.

However, I did this on my 2.4 tree but I can port it to 2.6 if you guys
can test it for me.

 Jocke
