Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AAEC2DDF86
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 07:55:37 +1100 (EST)
Date: Wed, 12 Dec 2007 23:58:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071212205838.GA16425@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071212164035.GB4329@loki.buserror.net>
	<20071212165513.GA30981@localhost.localdomain>
	<47601245.2090907@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47601245.2090907@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 10:54:29AM -0600, Scott Wood wrote:
> Anton Vorontsov wrote:
> >On Wed, Dec 12, 2007 at 10:40:35AM -0600, Scott Wood wrote:
> >>Not enough to be worth the complexity compared to the overhead of NAND
> >>access -- especially in the likely case of a non-SMP build.
> >
> >I'm allowing UPM access from the IRQ handlers (because nothing prevents
> >this, so why deny?). Thus locks are needed even on non-SMP build,
> 
> No, it just needs to disable interrupts.
> Which is what locks do on non-SMP.
> The overhead of this is not worth 30 lines of code to avoid.

Well, speaking of overhead. There could be a lot of fsl_upm_run_pattern
calls between _start and _end. In NAND case it's maximum 3, plus
they're indirect (i.e. NAND layer calls them via pointers to cmdfunc,
and cmdfunc calls run_patterns). Each out_X is another sync, and all
that time we're holding a lock with local IRQs disabled.

fsl upm infrastructure isn't only for NAND though, so I might imagine
use cases when there might be more run_patterns between start and end.

As the compromise I might suggest this: forbid pattern_start/pattern_end
from the ISRs (by marking them as might_sleep()), and replace _irqsave
spinlock with simple spinlock.

That way on UP we don't lose anything, but on SMP we still have an
overhead in case of single used UPM. :-/

Given that, personally I'd want to lockless variant to stay.

So, you still want to get rid of it?


Much thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
