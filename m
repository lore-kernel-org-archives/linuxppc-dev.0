Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4ADDBDDEFE
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:44:34 +1000 (EST)
Subject: Re: [PATCH 1/3] powerpc: Fixup hard_irq_disable semantics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0705100942590.32241@pademelon.sonytel.be>
References: <20070510052620.EC36DDDF92@ozlabs.org>
	<Pine.LNX.4.62.0705100942590.32241@pademelon.sonytel.be>
Content-Type: text/plain
Date: Thu, 10 May 2007 18:44:22 +1000
Message-Id: <1178786662.14928.229.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-10 at 09:44 +0200, Geert Uytterhoeven wrote:
> On Thu, 10 May 2007, Benjamin Herrenschmidt wrote:
> > This patch renames the raw hard_irq_{enable,disable} into
> > __hard_irq_{enable,disable} and introduces a higher level
> > hard_irq_disable() function that can be used by any code
> > to enforce that IRQs are fully disabled, not only lazy
> > disabled.
> 
> Why did you rename hard_irq_enable() too?
> 
> Isn't it more logical to have high-level hard_irq_disable() and
> hard_irq_enable(), and a special low-level __hard_irq_disable()?

Not really. If you see my subsequent patch, the idea is to introduce a
single generic hard_irq_disable() which is meant to be called with
irqs already disabled (that is within a local_irq_disable section) to
enforce that if the arch does lazy disabling, it gets hard disabled
at this point.

If we start adding hard_irq_enable() we end up in a can of worms:

 - Do we want all the full set of save/restore etc... ?
 - What if somebody does hard_enable while we are soft-disabled
   -and- have been hard disabled because of a pending interrupt ?
 - What's the point ? :-)

So overall, I want to keep the semantics as simple as they can be. Maybe
I can even add some WARN_ON() to make sure we are in a
local_irq_disable'd section even in the generic one instead of just a
NOP to enfore that.

Cheers,
Ben.
