Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81550B7B8B
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 09:20:26 +1100 (EST)
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950092.2409.7.camel@pasglop>
	<OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Oct 2009 09:20:17 +1100
Message-Id: <1254954017.2409.14.camel@pasglop>
Mime-Version: 1.0
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

On Thu, 2009-10-08 at 00:08 +0200, Joakim Tjernlund wrote:
> 
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 07/10/2009 23:14:52:
> >
> > On Wed, 2009-10-07 at 22:46 +0200, Joakim Tjernlund wrote:
> >
> > > +   andi.   r11, r10, _PAGE_USER | _PAGE_ACCESSED
> > > +   cmpwi   cr0, r11, _PAGE_USER | _PAGE_ACCESSED
> > > +   bne-   cr0, 2f
> >
> > Did you mean _PAGE_PRESENT | _PAGE_ACCESSED ?
> >
> > > +2:
> > > +   mfspr   r11, SRR1
> > > +   rlwinm   r11, r11, 0, 5, 3 /* clear guarded */
> > > +   mtspr   SRR1, r11
> >
> > What is the above for ?
> 
> TLB Miss will set that bit unconditionally and that is
> the same bit as protection error in TLB error.

And ? Big deal :-) IE. Once you get to InstructionAccess, it doesn't
matter if that bit is set, does it ?

> Lets start simple, shall we? :)
> Anyhow, I looked some more at that and I don't the best thing is
> to use shifts. All bits are correct if you invert RW and add an exception
> for extended coding.

Right, as long as you avoid doing a conditional branch :-)

> Because if you go to C with a protection fault, you are in trouble.

Why ?

> So deal with it here. Now, I got another idea too that will make this go away
> if it work out

I don't understand your point about protection faults.

You should be able to go straight to C with -anything-, that's what I do
for all other platforms.

Ben.
