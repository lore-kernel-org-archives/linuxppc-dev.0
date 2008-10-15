Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 1B753DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 14:38:34 +1100 (EST)
Date: Wed, 15 Oct 2008 14:37:36 +1100
From: Simon Horman <horms@verge.net.au>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
Message-ID: <20081015033735.GG27243@verge.net.au>
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
	<20081008030325.GD22396@verge.net.au>
	<20081012133955.GA7536@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081012133955.GA7536@Chamillionaire.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 12, 2008 at 03:39:55PM +0200, Sebastian Andrzej Siewior wrote:
> * Simon Horman | 2008-10-08 14:03:26 [+1100]:
> 
> >> +#ifdef WITH_GAMECUBE
> >> +static int go_purgatory = 0;
> >> +#else
> >> +static int go_purgatory = 1;
> >> +#endif
> >
> >Can you just use WITH_GAMECUBE inside elf_ppc_load() and remove
> >the need for go_purgatory, or do you plan to make go_purgatory
> >switchable at run-time at some point in the future?

> For the first shot I would prefer to use WITH_GAMECUBE inside of
> elf_ppc_load(). In longterm I don't see any reason why GameCube can't
> use the purgatory code like the other archs and get the memory maps from
> the device tree. However I'm not sure if GameCube still runs on a recent
> kernel: now that arc/ppc isn't available anymore GameCube has to pass a
> dtb somehow and this isn't the case. So therefore I would like the keep
> #ifdef and the exisiting behavior until someone clears this up.

Ok, in this case I would like to request that you remove
go_purgatory (for now) and just use #ifdef WITH_GAMECUBE instead.
I think that it will make things cleaner (for now).

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en
