Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B04CB7BBE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 10:38:46 +1100 (EST)
In-Reply-To: <1254784539.7122.52.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254773824.7122.33.camel@pasglop>	
	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>	
	<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>	
	<OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
	<1254784539.7122.52.camel@pasglop>
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Oct 2009 01:35:45 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 01:15:39:
>
> On Tue, 2009-10-06 at 00:55 +0200, Joakim Tjernlund wrote:
> > > Sure but if dirty is cleared by the kernel, then you also need to
> > remove
> > > write permission in the TLB or it will miss setting dirty on the
> > next
> > > store to the page.
> >
> > Dirty map to HW changed bit so if kernel clears it, the next
> > store will trap to DTLB error. There I will check RW and clear it
> > again
> > without trapping to C. Is that OK? Not if I read you correcly below ..
>
> Well, if the HW has the ability to enforce trap when store with !DIRTY,

Yes, provided that the kernel invalidates the TLB too so the next access
will provoke a TLB Miss, which will then provoke a TLB error. The TLB
error routine checks VALID, RW and USER(if not a kernel access), then sets
ACCESSED & DIRTY and writes the TLB(RPN reg).

Perhaps the missing invalidate is haunting us here?

> then that's fine, just map it that way, but you shouldn't have to handle
> it in the DTLB error neither, the kernel will fix it up for you in
> handle_pte_fault().

Does not all ppc have the Changed bit?

>
> I think I need to get myself an 8xx manual and figure out what that damn
> MMU actually does :-)

Please do, get the mpc862 users manual :)

>
> > No it's really !(RW _AND_ DIRTY) -> no store permitted, and
> >
> > ..  hmm, I don't do that. I should do a
> >     if ( store && !(pte & (RW | DIRTY))
> >        goto DSI
> >  in DTLB error?
>
> Well, if the HW does the test of DIRTY, then it's fine, as you seem to
> suggest above. _something_ needs to do it, either SW or HW, ie, we need
> to catch any attempt to store to a non-dirty page to set dirty.

Yes, I think I do this.

>
> > > !(PRESENT _AND_ ACCESSED) -> no access permitted.
> >
> > Yes, how about those pinned kernel ptes. Do they have ACCESSED from
> > start?
>
> They should.
>
> Cheers,
> Ben.
>
>
>
>
