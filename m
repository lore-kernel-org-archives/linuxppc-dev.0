Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7182EB7B85
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 10:15:56 +1100 (EST)
In-Reply-To: <1254954017.2409.14.camel@pasglop>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254950092.2409.7.camel@pasglop>
	<OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
	<1254954017.2409.14.camel@pasglop>
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 01:11:23 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 08/10/2009 00:20:17:

>
> On Thu, 2009-10-08 at 00:08 +0200, Joakim Tjernlund wrote:
> >
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 07/10/2009 23:14:52:
> > >
> > > On Wed, 2009-10-07 at 22:46 +0200, Joakim Tjernlund wrote:
> > >
> > > > +   andi.   r11, r10, _PAGE_USER | _PAGE_ACCESSED
> > > > +   cmpwi   cr0, r11, _PAGE_USER | _PAGE_ACCESSED
> > > > +   bne-   cr0, 2f
> > >
> > > Did you mean _PAGE_PRESENT | _PAGE_ACCESSED ?

YES! cut and paste error, will send a new much improved patch
with my new idea.

> > >
> > > > +2:
> > > > +   mfspr   r11, SRR1
> > > > +   rlwinm   r11, r11, 0, 5, 3 /* clear guarded */
> > > > +   mtspr   SRR1, r11
> > >
> > > What is the above for ?
> >
> > TLB Miss will set that bit unconditionally and that is
> > the same bit as protection error in TLB error.
>
> And ? Big deal :-) IE. Once you get to InstructionAccess, it doesn't
> matter if that bit is set, does it ?

Yes it does. If one adds HWEXEC it will fail, right?
Also this count as a read and you could easily end up
in the protection case(in 2.4 you do)

>
> > Lets start simple, shall we? :)
> > Anyhow, I looked some more at that and I don't the best thing is
> > to use shifts. All bits are correct if you invert RW and add an exception
> > for extended coding.
>
> Right, as long as you avoid doing a conditional branch :-)

hey, I think you have to show how then :) I am not
good at ppc shift, mask, rotate insn.

>
> > Because if you go to C with a protection fault, you are in trouble.
>
> Why ?

In 2.4 you end up in read protection fault an get a SEGV back :)

>
> > So deal with it here. Now, I got another idea too that will make this go away
> > if it work out
>
> I don't understand your point about protection faults.
>
> You should be able to go straight to C with -anything-, that's what I do
> for all other platforms.

Well, you don't force a tlb error like I do, however my new version
handles this better.

Now I only handle DIRTY and the rest in C. Figured it is
much faster and really simplie now, stay tuned.
