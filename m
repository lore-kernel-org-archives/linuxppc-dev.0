Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FC6AB7BB9
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 06:27:44 +1100 (EST)
Date: Mon, 5 Oct 2009 14:28:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
Message-ID: <20091005192806.GC3576@loki.buserror.net>
References: <OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
	<1254350159.5699.21.camel@pasglop>
	<20091002214949.GA20514@b07421-ec1.am.freescale.net>
	<1254521073.7122.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1254521073.7122.5.camel@pasglop>
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

On Sat, Oct 03, 2009 at 08:04:33AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2009-10-02 at 16:49 -0500, Scott Wood wrote:
> > Adding a tlbil_va to do_page_fault makes the problem go away for me (on
> > top of your "merge" branch) -- none of the other changes in this thread
> > do (assuming I didn't miss any).  FWIW, when it gets stuck on a fault,
> > DSISR is 0xc0000000, and handle_mm_fault returns zero. 
> 
> But in that case, it should hit ptep_set_access_flags() (via
> handle_mm_fault) and from there call tlbil_va (provided we add a call to
> it in the relevant filter function which I proposed initially), no ?

Yes, it hits ptep_set_access_flags() and adding _tlbil_va there helps (I
didn't put it in the filter function, because that doesn't take address as a
parameter).  I'd misread your suggestion as referring to the various changes
to set_pte_filter() that were posted.

As for unconditionally invalidating in set_pte_filter(), that doesn't boot
for me unless I check for kernel addresses -- I guess we populate page
tables that overlap the pinned large page region? 

-Scott
