Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2672FB7BA2
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 08:36:09 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
References: <1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
	<1254208057.5771.7.camel@pasglop>
	<OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Oct 2009 08:35:59 +1000
Message-Id: <1254350159.5699.21.camel@pasglop>
Mime-Version: 1.0
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


> > Had a look at linus tree and there is something I don't understand.
> > Your fix, e0908085fc2391c85b85fb814ae1df377c8e0dcb, fixes a problem
> > that was introduced by 8d30c14cab30d405a05f2aaceda1e9ad57800f36 but
> > 8d30c14cab30d405a05f2aaceda1e9ad57800f36 was included in .31 and .31
> > works and top of tree does not, how can that be?
> >
> > To me it seems more likely that some mm change introduced between .31 and
> > top of tree is the culprit.
> > My patch addresses the problem described in the comment:
> > /* On 8xx, cache control instructions (particularly
> >  * "dcbst" from flush_dcache_icache) fault as write
> >  * operation if there is an unpopulated TLB entry
> >  * for the address in question. To workaround that,
> >  * we invalidate the TLB here, thus avoiding dcbst
> >  * misbehaviour.
> >  */
> > Now you are using this old fix to paper over some other bug or so I think.
> 
> There is something fishy with the TLB status, looking into the mpc862 manual I
> don't see how it can work reliably. Need to dwell some more.
> Anyhow, I have incorporated some of my findings into a new patch,
> perhaps this will be the golden one?

Well, I still wonder about what whole unpopulated entry business.

>From what I can see, the TLB miss code will check _PAGE_PRESENT, and
when not set, it will -still- insert something into the TLB (unlike
all other CPU types that go straight to data access faults from there).

So we end up populating with those unpopulated entries that will then
cause us to take a DSI (or ISI) instead of a TLB miss the next time
around ... and so we need to remove them once we do that, no ? IE. Once
we have actually put a valid PTE in.

At least that's my understanding and why I believe we should always have
tlbil_va() in set_pte() and ptep_set_access_flags(), which boils down
in putting it into the 2 "filter" functions in the new code.

Well.. actually, the ptep_set_access_flags() will already do a
flush_tlb_page_nohash() when the PTE is changed. So I suppose all we
really need here would be in set_pte_filter(), to do the same if we are
writing a PTE that has _PAGE_PRESENT, at least on 8xx.

But just unconditionally doing a tlbil_va() in both the filter functions
shouldn't harm and also fix the problem, though Rex seems to indicate
that is not the case.

Now, we -might- have something else broken on 8xx, hard to tell. You may
want to try to bisect, adding back the removed tlbil_va() as you go
backward, between .31 and upstream... 

Cheers,
Ben.
