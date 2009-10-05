Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D01FEB7BB6
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 09:58:33 +1100 (EST)
In-Reply-To: <1254780556.7122.47.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254744999-3158-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254744999-3158-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254773824.7122.33.camel@pasglop>	
	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>	
	<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Oct 2009 00:55:43 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 00:09:16:
>
> On Tue, 2009-10-06 at 00:00 +0200, Joakim Tjernlund wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/10/2009 23:37:23:
> > >
> > > On Mon, 2009-10-05 at 23:25 +0200, Joakim Tjernlund wrote:
> > > >
> > > > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/10/2009 22:17:04:
> > > > >
> > > > > On Mon, 2009-10-05 at 14:16 +0200, Joakim Tjernlund wrote:
> > > > > > Update the TLB asm to make proper use of _PAGE_DIRY and _PAGE_ACCESSED.
> > > > > > Pros:
> > > > > >  - I/D TLB Miss never needs to write to the linux pte.
> > > > > >  - _PAGE_ACCESSED is only set on I/D TLB Error fixing accounting
> > > > > >  - _PAGE_DIRTY is mapped to 0x100, the changed bit, and is set directly
> > > > > >     when a page has been made dirty.
> > > > >
> > > > > Not sure here. You seem to still set those from asm. Is that necessary ?
> > > >
> > > > Well, yes. head_32.S also sets ACCESSED and DIRTY from asm so why not me?
> > >
> > > Don't look at the hash 32 code :-)
> >
> > So what to look at then? :)
>
> head_440.S on a recent 2.6

OK, will look

>
> > > Most of the time you do anyways since the PTE isn't populated at all. At
> > > which point, Linux will populate a PTE with DIRTY and ACCESSED already
> > > set. It should be reasonably rare to actually fault because DIRTY and/or
> > > ACCESSED are missing.
> >
> > I tried to unconditionally trap to C in DTLB error but it just hung if I did
> > that so the asm has to do something.
>
> Sure, the question is what and how can we get away without it ? :-)

You tell me :)

>
> > > > > The approach I take on BookE is to simply not set these from asm, -and-
> > > > > (this is important) not set write permission if dirty is not set in
> >
> > Did you really mean "if dirty is not" ? I test RW for write permission.
> > Dirty is just set when the first write happens after the permission check.
>
> Sure but if dirty is cleared by the kernel, then you also need to remove
> write permission in the TLB or it will miss setting dirty on the next
> store to the page.

Dirty map to HW changed bit so if kernel clears it, the next
store will trap to DTLB error. There I will check RW and clear it again
without trapping to C. Is that OK? Not if I read you correcly below ..

>
> So dirty basically acts as a filter on RW, and accessed as a filter on
> valid if you want.
>
> > > Mostly only !ACCESSED -> no access permitted and !DIRTY -> no store
> > > permitted and don't write anything back if !VALID.
> >
> > That should be !RW and not !DIRTY I hope? Then trap
> > first store and set DIRTY (without trapping to C)
>
> No it's really !(RW _AND_ DIRTY) -> no store permitted, and

..  hmm, I don't do that. I should do a
    if ( store && !(pte & (RW | DIRTY))
       goto DSI
 in DTLB error?

> !(PRESENT _AND_ ACCESSED) -> no access permitted.

Yes, how about those pinned kernel ptes. Do they have ACCESSED from start?

>
> Cheers,
> Ben.
>
> > >
> > > Cheers,
> > > Ben.
> > >
> > > >  Jocke
> > > >
> > > > >
> > > > > Cheers,
> > > > > Ben.
> > > > >
> > > > > >  - Proper RO/RW mapping of user space.
> > > > > >  - Free up 2 SW TLB bits in the linux pte(add back _PAGE_WRITETHRU ?)
> > > > > > Cons:
> > > > > >  - 4 more instructions in I/D TLB Miss, but the since the linux pte is
> > > > > >    not written anymore, it should still be a win.
>
>
>
>
