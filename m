Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49705DDEFF
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:46:13 +1000 (EST)
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Satyam Sharma <satyam.sharma@gmail.com>
In-Reply-To: <a781481a0705100054r45c373a0lfd35b8b31b0e6032@mail.gmail.com>
References: <20070510052622.3E8D5DDF4B@ozlabs.org>
	<20070509224113.cca81a24.akpm@linux-foundation.org>
	<a781481a0705092345rf9fdc9cs8495516299a28fae@mail.gmail.com>
	<1178781677.14928.221.camel@localhost.localdomain>
	<a781481a0705100054r45c373a0lfd35b8b31b0e6032@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 May 2007 18:46:01 +1000
Message-Id: <1178786761.14928.232.camel@localhost.localdomain>
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

On Thu, 2007-05-10 at 13:24 +0530, Satyam Sharma wrote:
> But then, what _is_ the problem with your approach above? An arch that
> wants (and implements) hard_irq_disable will also #define that dummy
> macro, so we just need to pull in the appropriate header (directly,
> indirectly, anyhow -- we don't really care) into
> include/linux/interrupt.h and then just do the exact same "#ifndef
> hard_irq_disable" check that you're doing right now. I must be missing
> something trivial (either that or I need to go and have a coffee :-)
> because I don't see the possibility of hitting multiple _different_
> definitions with the approach you mentioned just now.

Sure, the only problem is that I don't want to pull asm/hw_irq.h
directly from linux/interrupts.h unless all arch maintainers around
verify it's ok, because those headers are a bit of a can of worm at the
moment ...

So I'd rather say that if your arch has a custom version of
hard_irq_disable(), make sure that asm/system.h pulls it in a way or
another. And that's already included.

Ben.
