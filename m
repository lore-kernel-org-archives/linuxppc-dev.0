Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DB693DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 05:35:13 +1000 (EST)
Date: Tue, 11 Sep 2007 14:36:07 -0500
From: Olof Johansson <olof@lixom.net>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575
	on FSL boards
Message-ID: <20070911193607.GA13105@lixom.net>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
	<20070911172000.GC10743@lixom.net>
	<9C9F1918-1B55-4426-8138-842B9AAA5BD5@kernel.crashing.org>
	<20070911182234.GA12802@lixom.net>
	<424B650B-C272-45FC-BBC6-F090A9474082@kernel.crashing.org>
	<24F46474-1425-4C8B-A400-4D18D28932F2@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24F46474-1425-4C8B-A400-4D18D28932F2@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2007 at 01:43:59PM -0500, Becky Bruce wrote:

> >> Maybe it would make more sense for you guys to slice the platforms
> >> differently, and have a common platform for the eval boards you have
> >> with ULi on them instead of grouping it by core used by the processor
> >> on the board.
> >>
> >> (In other words, move 86xx over under 85xx, since there wouldn't be
> >> much
> >> left over anyway).
> >
> > Moving 86xx (classic 74xx core) under 85xx (book e500 core) makes
> > even less sense to me.
> 
> Yeah, that makes *no* sense to me either.  It's an unfortunate  
> artifact of the naming of boards to include the core name.  While the  
> devices and boards may be similar, once you have bookE vs non-bookE  
> cores, they become quite different.

It doesn't make sense if you move 86xx under 85xx right now, no.

What I meant (but didn't write) was more along the lines of forking off
a new platform (I don't know if you have a common code name for the SoC
side, but fsl-whatever) that contains the SoC and board support for the
parts and boards that share much (looks like the latest gen 85xx and
8641 would be candidates).

Looks like the CPM2-based stuff could be candidates for something similar
as well, but there's less activity there so there's less reason to rework
those, I suppose.

Of course, down the road I'm sure there'll be a part that contains 75%
of the current SoC, plus something new. And the next gen after that only
contains the 25% non-shared plus 75% brand new stuff and it all falls
apart. Not knowing your roadmap I have a hard time judging if that's
likely though. :-)


-Olof
