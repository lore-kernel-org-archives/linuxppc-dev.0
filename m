Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E590B7B9F
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 21:52:25 +1000 (EST)
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
Message-ID: <OF42B949AE.6BBE8054-ONC1257644.003EACD0-C1257644.0040CC01@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 3 Oct 2009 13:47:45 +0200
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

Not quite sure what you mean here?
Always branch to DSI at TLB Miss and create a unpopulated
entry? That does not feel right.

The current method is better. The only odd thing is
the null pmd entry and what to load into RPN. I am not convinced
that it is a problem but I would like to see a generic impl. of
a null pmd and use that instead. A 8xx impl. of that
looks like this(tested on 2.4, works fine)

	lwz	r11, 0(r10)	/* Get the level 1 entry */
	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
	bne+	4f		/* If zero, use a null pmd */
	lis	r11, null_pmd_dir@h
	ori	r11, r11, null_pmd_dir@l
4:	tophys(r11,r11)

...
	.data
	.globl	null_pmd_dir
null_pmd_dir:
	.space	4096

If the pmd_none() and friends are updated to test for a null_pmd_dir
we can loose the test above and save 4 insn :)

Anyhow did you post a patch(can't find one) about your suggested
filter functions for 8xx? I sure would like to see one :)
