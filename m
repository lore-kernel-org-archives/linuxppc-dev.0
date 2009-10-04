Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8A6FB7BB4
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Oct 2009 19:39:18 +1100 (EST)
In-Reply-To: <1254567448.7122.8.camel@pasglop>
References: <OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>	
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>	
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>	
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
	<1254350159.5699.21.camel@pasglop>	
	<20091002214949.GA20514@b07421-ec1.am.freescale.net>
	<OF4175DD8E.796930EB-ONC1257644.002A7135-C1257644.002C7929@transmode.se>
	<1254558678.7122.7.camel@pasglop>	 <OF0216D5A
	<1254567448.7122.8.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF1CF373A5.3E3C833B-ONC1257645.002E46F1-C1257645.002F3070@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 4 Oct 2009 10:35:25 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 03/10/2009 12:57:28:
>
> On Sat, 2009-10-03 at 11:24 +0200, Joakim Tjernlund wrote:
> >
> > So yes, there is a missing _tlbil_va() missing for 8xx somewhere
> > but there is something more too.
> > Maybe your new filter functions and my
> >  powerpc, 8xx: DTLB Error must check for more errors.
> > will do the trick?
>
> Well, if we can't tell between a load and a store on a TLB miss, then
> we should probably let it create an unpopulated entry in all cases,
> so that we do take a proper DSI/ISI the second time around, which
> would then tell us where we come from...

While looking closer on 8xx TLB handling I noticed we were taking
an extra TLB Error when making a page dirty. Tracked it down to:
static inline pte_t pte_mkdirty(pte_t pte) {
	pte_val(pte) |= _PAGE_DIRTY; return pte; }
pte_mkdirty does not set HWWRITE thus forcing a new
TLB error to clear it. Adding HWWRITE to pte_mkdirty fixes the
problem.

Looking at (especially pte_mkclean):
static inline pte_t pte_wrprotect(pte_t pte) {
	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE); return pte; }
static inline pte_t pte_mkclean(pte_t pte) {
	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_HWWRITE); return pte; }

it looks like a mistake not to include HWWRITE in pte_mkdirty(),
what do you think?

 Jocke
