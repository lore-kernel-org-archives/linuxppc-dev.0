Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B22D7B7B75
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 11:05:08 +1100 (EST)
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950092.2409.7.camel@pasglop>
	<OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
	<1254954017.2409.14.camel@pasglop>
	<OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Oct 2009 11:04:56 +1100
Message-Id: <1254960296.2733.3.camel@pasglop>
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


> Yes it does. If one adds HWEXEC it will fail, right?

Why ? We can just filter out DSISR, we don't really care why it failed
as long as we know whether it was a store or not.

> Also this count as a read and you could easily end up
> in the protection case(in 2.4 you do)

I'm not sure what you mean by "the protection case" Again, the C code
shouldn't care.

> hey, I think you have to show how then :) I am not
> good at ppc shift, mask, rotate insn.

They are so fun ! :-0

> >
> > > Because if you go to C with a protection fault, you are in trouble.
> >
> > Why ?
> 
> In 2.4 you end up in read protection fault an get a SEGV back :)

We probably should ignore the DSISR bits then. So it just goes to
generic C code which then fixes up ACCESSED etc... and returns.

> Now I only handle DIRTY and the rest in C. Figured it is
> much faster and really simplie now, stay tuned.

You should not even have to handle DIRTY at all in asm. At least in 2.6.
I can't vouch for what 2.4 generic code does... You should really port
your board over :-)

Cheers,
Ben.
