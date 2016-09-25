Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shX002qgxzDrPS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:00:16 +1000 (AEST)
In-Reply-To: <1473162804-6802-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Remove all usages of NO_IRQ
Message-Id: <3shX000hWqz9t0P@ozlabs.org>
Date: Sun, 25 Sep 2016 13:00:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 11:53:24 UTC, Michael Ellerman wrote:
> NO_IRQ has been == 0 on powerpc for just over ten years (since commit
> 0ebfff1491ef ("[POWERPC] Add new interrupt mapping core and change
> platforms to use it")). It's also 0 on most other arches.
> 
> Although it's fairly harmless, every now and then it causes confusion
> when a driver is built on powerpc and another arch which doesn't define
> NO_IRQ. There's at least 6 definitions of NO_IRQ in drivers/, at least
> some of which are to work around that problem.
> 
> So we'd like to remove it. This is fairly trivial in the arch code, we
> just convert:
> 
>     if (irq == NO_IRQ)	to	if (!irq)
>     if (irq != NO_IRQ)	to	if (irq)
>     irq = NO_IRQ;	to	irq = 0;
>     return NO_IRQ;	to	return 0;
> 
> And a few other odd cases as well.
> 
> At least for now we need to continue to #define NO_IRQ, because there is
> driver code that builds on powerpc and may build on arm (and possibly
> other arches), where NO_IRQ is *not* == 0. Hopefully they can be fixed
> in the medium term and we can drop the definition entirely.
> 
> Note we also change some occurrences in PPC sound drivers, drivers/ps3,
> and drivers/macintosh.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/ef24ba7091517d2bbf9ba2cb42

cheers
