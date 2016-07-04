Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjfMZ3hCKzDr3c
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:50:50 +1000 (AEST)
Message-ID: <1467618640.13965.3.camel@kernel.crashing.org>
Subject: Re: powerpc/opal: Wake up kopald polling thread before waiting for
 events
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Date: Mon, 04 Jul 2016 17:50:40 +1000
In-Reply-To: <3rjc8Z6nDPz9sXx@ozlabs.org>
References: <3rjc8Z6nDPz9sXx@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-07-04 at 16:11 +1000, Michael Ellerman wrote:
> On Mon, 2016-04-07 at 04:51:44 UTC, Benjamin Herrenschmidt wrote:
> > On some environments (prototype machines, some simulators, etc...)
> > there is no functional interrupt source to signal completion, so
> > we rely on the fairly slow OPAL heartbeat.
> > 
> > In a number of cases, the calls complete very quickly or even
> > immediately. We've observed that it helps a lot to wakeup the OPAL
> > heartbeat thread before waiting for event in those cases, it will
> > call OPAL immediately to collect completions for anything that
> > finished fast enough.
> 
> Any performance/jitter impact on normal systems?

Not that I can think of.

Cheers,
Ben.
