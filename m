Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FEE5B7BC2
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 07:50:09 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n92LnooP024680
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Oct 2009 14:50:01 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n92Lpw2I003764
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Oct 2009 16:51:59 -0500 (CDT)
Date: Fri, 2 Oct 2009 16:49:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
Message-ID: <20091002214949.GA20514@b07421-ec1.am.freescale.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254350159.5699.21.camel@pasglop>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2009 at 08:35:59AM +1000, Benjamin Herrenschmidt wrote:
> >From what I can see, the TLB miss code will check _PAGE_PRESENT, and
> when not set, it will -still- insert something into the TLB (unlike
> all other CPU types that go straight to data access faults from there).
> 
> So we end up populating with those unpopulated entries that will then
> cause us to take a DSI (or ISI) instead of a TLB miss the next time
> around ... and so we need to remove them once we do that, no ? IE. Once
> we have actually put a valid PTE in.
> 
> At least that's my understanding and why I believe we should always have
> tlbil_va() in set_pte() and ptep_set_access_flags(), which boils down
> in putting it into the 2 "filter" functions in the new code.
> 
> Well.. actually, the ptep_set_access_flags() will already do a
> flush_tlb_page_nohash() when the PTE is changed. So I suppose all we
> really need here would be in set_pte_filter(), to do the same if we are
> writing a PTE that has _PAGE_PRESENT, at least on 8xx.
> 
> But just unconditionally doing a tlbil_va() in both the filter functions
> shouldn't harm and also fix the problem, though Rex seems to indicate
> that is not the case.

Adding a tlbil_va to do_page_fault makes the problem go away for me (on
top of your "merge" branch) -- none of the other changes in this thread
do (assuming I didn't miss any).  FWIW, when it gets stuck on a fault,
DSISR is 0xc0000000, and handle_mm_fault returns zero.

-Scott
