Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A3FCB7043
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 19:29:14 +1000 (EST)
In-Reply-To: <1254558678.7122.7.camel@pasglop>
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
	<OF4175DD8E.796930EB-ONC1257644.002A7135-C1257644.002C7929@transmode.se>
	<1254558678.7122.7.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF0216D5A2.8B77DD30-ONC1257644.0031FDC4-C1257644.0033A760@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 3 Oct 2009 11:24:11 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 03/10/2009 10:31:18:
>
> On Sat, 2009-10-03 at 10:05 +0200, Joakim Tjernlund wrote:
> > Cannot shake the feeling that it this snip of code that causes it
> >         lwz     r11, 0(r10)     /* Get the level 1 entry */
> >         rlwinm. r10, r11,0,0,19 /* Extract page descriptor page
> > address */
> >         beq     2f              /* If zero, don't try to find a pte */
> > Perhaps we can do something better? I still feel that we need to
> > force a TLB Error as the TLBMiss does not set DSISR so we have no way
> > of
> > knowing if it is an load or store.
>
> Can't we manufacture a DSISR and branch to the right function ?

Not if we want know if it is a load or store. There is no info to manufacture
a DSISR from. The best we can do here is try getting the RPN physical page
number correct. Perhaps something like this will do:
	/* Copy 20 msb from MD_EPN to r20 to get the correct page
	 * number. Do not rely on DAR since the dcxx instructions fails
	 * to update DAR when they cause a DTLB Miss
	 */
	mfspr	r21, MD_EPN
	li	r20, 0x0
	rlwimi	r20, r21, 0, 0, 19
Then go back and set the RPN accordingly.

The 8xx is different as as it will force a TLB error every time
it needs to deal with a page fault.
I suspect adding
if (!ret)
   _tlbil_va(address);
in do_page_fault() will do the trick too.

So yes, there is a missing _tlbil_va() missing for 8xx somewhere
but there is something more too.
Maybe your new filter functions and my
 powerpc, 8xx: DTLB Error must check for more errors.
will do the trick?

 Jocke
