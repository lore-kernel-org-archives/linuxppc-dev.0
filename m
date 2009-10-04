Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7BEBB7BC8
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 07:50:18 +1100 (EST)
In-Reply-To: <1254688118.7122.30.camel@pasglop>
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
	<OF7C895670.A7F16A1A-ONC1257645.00620A4D-C1257645.006ED40F@transmode.se>
	<1254688118.7122.30.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFC4FF22E6.2B736FAD-ONC1257645.00715E8C-C1257645.00720E57@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 4 Oct 2009 22:45:47 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 04/10/2009 22:28:38:
>
> > I have managed to update the TLB code to make proper use of dirty and accessed states.
> > Advantages are:
> >  - I/D TLB Miss never needs to write to the linux pte, saving a few cycles
>
> That's good, that leaves us with only 40x to fix now. Also we can remove
> atomic updates of PTEs for all non-hash. It's pointless on those CPUs
> anyway.
>
> >  - Accessed is only set by I/D TLB Error, should be a plus when SWAP is used.
>
> No need for that neither.

Since 8xx lacks HW support for ACCESSED, the only way is map
the page NoAccess and take a TLB Error on first access that sets
access bit (or bails to do_page_fault)

>
> ISI/DSI shouldn't touch the PTE. They should just fall back to C code
> which takes care of it all.l

Yes, that is what I do now(i.e I only read the pte). ISI and DSI is the
TLB Miss handlers on 8xx.

>
> >  - _PAGE_DIRTY is mapped to 0x100, the changed bit, and is set directly
> >     and there will be no extra DTLB Error to actually set the changed bit
> >     when a page has been made dirty.
> > - Proper RO/RW mapping of user space.
> >
> > Cons:
> >  - 4 more insn in TLB Miss handlers, but the since the linux pte isn't
> >    written it should still be a win.
> >
> > However, I did this on my 2.4 tree but I can port it to 2.6 if you guys
> > can test it for me.
>
> Why don't you use and test 2.6 ? :-)

Because porting my 8xx board to 2.6 isn't going to be easy so
I havn't yet. One day I might when we can't get away with 2.4 on our
old boards.
