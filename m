Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C52D9B7BD4
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 17:08:53 +1000 (EST)
In-Reply-To: <1254350159.5699.21.camel@pasglop>
References: <1253843480.7103.492.camel@pasglop>	
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
	<1254350159.5699.21.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFD874AD75.94F084C6-ONC1257642.00210FCF-C1257642.0026FB28@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 1 Oct 2009 09:05:46 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 01/10/2009 00:35:59:
>
>
> > > Had a look at linus tree and there is something I don't understand.
> > > Your fix, e0908085fc2391c85b85fb814ae1df377c8e0dcb, fixes a problem
> > > that was introduced by 8d30c14cab30d405a05f2aaceda1e9ad57800f36 but
> > > 8d30c14cab30d405a05f2aaceda1e9ad57800f36 was included in .31 and .31
> > > works and top of tree does not, how can that be?
> > >
> > > To me it seems more likely that some mm change introduced between .31 and
> > > top of tree is the culprit.
> > > My patch addresses the problem described in the comment:
> > > /* On 8xx, cache control instructions (particularly
> > >  * "dcbst" from flush_dcache_icache) fault as write
> > >  * operation if there is an unpopulated TLB entry
> > >  * for the address in question. To workaround that,
> > >  * we invalidate the TLB here, thus avoiding dcbst
> > >  * misbehaviour.
> > >  */
> > > Now you are using this old fix to paper over some other bug or so I think.
> >
> > There is something fishy with the TLB status, looking into the mpc862 manual I
> > don't see how it can work reliably. Need to dwell some more.
> > Anyhow, I have incorporated some of my findings into a new patch,
> > perhaps this will be the golden one?
>
> Well, I still wonder about what whole unpopulated entry business.

Yes, is a odd compared to the other ppc arch. I know why it is there
and I also know that there is alternative way to work around the problem
it is supposed to fix. I went back to the old way in my patch but it didn't
help. although I don't see why there is such a benefit to branch to DataAccess
directly, is it so expensive to to a DTLB error and then go to DataAccess?

>
> >From what I can see, the TLB miss code will check _PAGE_PRESENT, and

No, it will branch to before that happens.

> when not set, it will -still- insert something into the TLB (unlike
> all other CPU types that go straight to data access faults from there).

Yes, a non valid pte so that you will trap to DTLB Error.
The other arch also muck around to get load/store bit etc. and
accroding to the 8xx user manual there are no such info available, not even DAR:

Table 6-14. Register Settings after a Data TLB Miss Exception
Register  Setting
SRR0      Set to the EA of the instruction that caused the exception.
SRR1      1–4     0
          10–15 0
          Others Loaded from MSR[16-31]. SRR1[30] is cleared only by loading a zero from MSR[RI].
MSR       IP      No change
          ME      No change
          LE      Copied from the ILE setting of the interrupted process
          Other 0

However from the past we know that DAR is avaliable (but not for dcbX insn though)

For a TLB Error there are:
Table 6-16. Register Settings after a Data TLB Error Exception
Register Setting
SRR0     Set to the EA of the instruction that caused the exception.
SRR1     1–4     0
         10–15 0
         Others—Loaded from MSR[16-31]. SRR1[30] is cleared only by loading a zero from MSR[RI].
MSR      IP      No change
         ME      No change
         LE      Copied from the ILE setting of the interrupted process
         Other   0
DSISR    0       0
         1       Set if the translation of an attempted access is not found in the translation tables. Otherwise, cleared
         2–3     0
         4       Set if the memory access is not permitted by the protection mechanism; otherwise cleared
         5       0
         6       1 for a store operation; 0 for a load operation.
         7–31    0
DAR      Set to the EA of the data access that caused the exception.

For completeness here are ITLB Miss/Error too:
Table 6-13. Register Settings after an Instruction TLB Miss Exception
Register  Setting
SRR0      Set to the EA of the instruction that caused the exception.
SRR1      0–3      0
          4       1
          10      1
          11–15   0
          Others  Loaded from MSR[16-31]. SRR1[30] is cleared only by loading a zero from MSR[RI].
MSR       IP      No change
          ME      No change
          LE      Copied from the ILE setting of the interrupted process
          Other 0

Table 6-15. Register Settings after an Instruction TLB Error Exception
Register Setting
SRR0     Set to the EA of the instruction that caused the exception.
SRR1     Note: Only one of bits 1, 3, and 4 will be set.
         1       1 if the translation of an attempted access is not in the translation tables. Otherwise 0
         2       0
         3       1 if the fetch access was to guarded memory when MSR[IR] = 1. Otherwise 0
         4       1 if the access is not permitted by the protection mechanism; otherwise 0.
         11–15 0
         Others Loaded from MSR[16-31]. SRR1[30] is cleared only by loading a zero from MSR[RI].
MSR      IP      No change
         ME      No change
         LE      Copied from the ILE setting of the interrupted process
         Other   0

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

I am pondering another idea. I suspect that this bit is set for non-valid ptes:
1       Set if the translation of an attempted access is not found in the translation tables. Otherwise, cleared
So perhaps we can test this bit in do_page_fault() and then do the
tlbil_va() directly?

>
> But just unconditionally doing a tlbil_va() in both the filter functions
> shouldn't harm and also fix the problem, though Rex seems to indicate
> that is not the case.
>
> Now, we -might- have something else broken on 8xx, hard to tell. You may
> want to try to bisect, adding back the removed tlbil_va() as you go
> backward, between .31 and upstream...
>
> Cheers,
> Ben.
>
>
>
>
