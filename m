Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00387B7BDC
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 04:12:36 +1000 (EST)
In-Reply-To: <OF2FCFEA43.75290607-ONC1257643.0047C81F-C1257643.0048036B@transmode.se>
References: <1253843480.7103.492.camel@pasglop>	<1254208057.5771.7.camel@pasglop>		<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>		<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>		<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>	<1254350159.5699.21.camel@pasglop>
	<OF2FCFEA43.75290607-ONC1257643.0047C81F-C1257643.0048036B@transmode.se>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
Message-ID: <OF02C0B1C1.7E373A8E-ONC1257643.006377F9-C1257643.0063E1CF@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 2 Oct 2009 20:10:58 +0200
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

>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 01/10/2009 00:35:59:
> >
> >
> > > > Had a look at linus tree and there is something I don't understand.
> > > > Your fix, e0908085fc2391c85b85fb814ae1df377c8e0dcb, fixes a problem
> > > > that was introduced by 8d30c14cab30d405a05f2aaceda1e9ad57800f36 but
> > > > 8d30c14cab30d405a05f2aaceda1e9ad57800f36 was included in .31 and .31
> > > > works and top of tree does not, how can that be?
> > > >
> > > > To me it seems more likely that some mm change introduced between .31 and
> > > > top of tree is the culprit.
> > > > My patch addresses the problem described in the comment:
> > > > /* On 8xx, cache control instructions (particularly
> > > >  * "dcbst" from flush_dcache_icache) fault as write
> > > >  * operation if there is an unpopulated TLB entry
> > > >  * for the address in question. To workaround that,
> > > >  * we invalidate the TLB here, thus avoiding dcbst
> > > >  * misbehaviour.
> > > >  */
> > > > Now you are using this old fix to paper over some other bug or so I think.
> > >
> > > There is something fishy with the TLB status, looking into the mpc862 manual I
> > > don't see how it can work reliably. Need to dwell some more.
> > > Anyhow, I have incorporated some of my findings into a new patch,
> > > perhaps this will be the golden one?
> >
> > Well, I still wonder about what whole unpopulated entry business.
> >
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
> >
> > Now, we -might- have something else broken on 8xx, hard to tell. You may
> > want to try to bisect, adding back the removed tlbil_va() as you go
> > backward, between .31 and upstream...
>
> Found something odd, perhaps Rex can test?
> I tested this on my old 2.4 and it worked well.

That was not quite correct, sorry.
Try this instead:

>From c5f1a70561730b8a443f7081fbd9c5b023147043 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 2 Oct 2009 14:59:21 +0200
Subject: [PATCH] powerpc, 8xx: DTLB Error must check for more errors.

DataTLBError currently does:
 if ((err & 0x02000000) == 0)
    DSI();
This won't handle a store with no valid translation.
Change this to
 if ((err & 0x48000000) != 0)
    DSI();
that is, branch to DSI if either !permission or
!translation.
---
 arch/powerpc/kernel/head_8xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 52ff8c5..118bb05 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -472,8 +472,8 @@ DataTLBError:
 	/* First, make sure this was a store operation.
 	*/
 	mfspr	r10, SPRN_DSISR
-	andis.	r11, r10, 0x0200	/* If set, indicates store op */
-	beq	2f
+	andis.	r11, r10, 0x4800 /* no translation, no permission. */
+	bne	2f	/* branch if either is set */

 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
 	 * register.  The EA of a data TLB error is automatically stored in
--
1.6.4.4
