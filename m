Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1510B7B84
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 17:20:55 +1100 (EST)
In-Reply-To: <1255049611.2355.20.camel@pasglop>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255008298-19949-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255008298-19949-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255035843.2146.39.camel@pasglop>
	<OF0E7CD530.5EA71A5E-ONC1257649.00797FD2-C1257649.007CEF55@transmode.se>
	<1255049611.2355.20.camel@pasglop>
Subject: Re: [PATCH 2/6] 8xx: Update TLB asm so it behaves as linux mm expects.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF6A111C97.D8A7A6A3-ONC125764A.00210BB5-C125764A.002271AC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 9 Oct 2009 08:16:13 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 09/10/2009 02:53:31:
>
> Subject:
>
> Re: [PATCH 2/6] 8xx: Update TLB asm so it behaves as linux mm expects.
>
> On Fri, 2009-10-09 at 00:44 +0200, Joakim Tjernlund wrote:
>
> > accessed == 1 and present = 0 is impossible, right?
> > So basically just copy over accessed to present and
> > linux mm set both when trapping to C.
>
> No, when present = 0, then the rest of the PTE can contain unrelated
> things, you can't trust ACCESSED.

Ah, OK.

>
> > What about the execute perms in Level 2 descriptor, page 247?
>
> Not useful, not fine grained enough.
>
> > > You still need to massage the PP bits into place. I don't see that
> > > happening.
> >
> > Not at the moment, later.
> >
> > >
> > > As it is, your PTE contains for bit 20 and 21, which translates to:
> > >
> > >    PTE:                 Translates to PP bits:
> > > RW: 0   USER: 0          00  supervisor RW (ok)
> > > RW: 0   USER: 1          01  supervisor RW user RO (WRONG)
> > > RW: 1   USER: 0          10  supervisor RW user RW (WRONG)
> > > RW: 1   USER: 1          11  supervisor RO user RO (WRONG)
> >
> > You got USER and RW swapped and the table is different
> > for exec.
>
> Hrm, let me see... yes. You are right, I mixed RW and USER. However,
> I don't think the PP bits change do they ? IE. Basically, Read == Exec
> at the page level. So the table isn't really different between I and D.
>
> However, indeed, since you don't have a unified TLB, the case can be
> made that we can ignore R vs. W in the iTLB case. In which case, you get
> for iTLB:
>
>
>     PTE:                 Translates to PP bits:
>  RW: 0   USER: 0          00  supervisor X only (ok)
>  RW: 0   USER: 1          10  supervisor X user X (ok)
>  RW: 1   USER: 0          01  supervisor X user X (WRONG)
>  RW: 1   USER: 1          11  supervisor X user X (ok)
>
> So a page with _PAGE_RW and not _PAGE_USER would still be executable
> from user... oops :-)

Yes, it is not perfect, but should work for now.

>
> I think what you want for iTLB is just basically have a base of 00
> and or-in _PAGE_USER only (ie, keep _PAGE_RW clear with a rlwinm)
> so that you basically get supervisor X only if _PAGE_USER is 0 and
> both X if _PAGE_USER is 1
>
> For the dTLB, the table becomes (including your inversion of _PAGE_RW)
>
>     PTE:                 Translates to PP bits:
>  RW: 0   USER: 0          01  supervisor RW user RO (WRONG)
>  RW: 0   USER: 1          11  supervisor RO user RO (ok)
>  RW: 1   USER: 0          00  supervisor RW only (ok)
>  RW: 1   USER: 1          10  supervisor RW user RW (ok)
>
> So it's -almost- right :-) You still got the RW:0 USER:0 case wrong,
> ie a read-only kernel page would be user readable.

Which will be fixed once I activate:
#if 0 /* Not yet */
	/* Honour kernel RO, User NA */
	andi.	r11, r10, _PAGE_USER | _PAGE_RW
	bne-	cr0, 5f
	ori	r10,r10, 0x200 /* Extended encoding, bit 22 */
#endif

>
> You can work around that by never setting kernel pages read-only (which
> we do mostly), but in the grand scheme of things, my trick I proposed
> initially would sort it out all including support for kernel RO :-)

Not convinced that your trick will be a win. The other
bits will need to move around too. Maybe I misunderstand
something?
