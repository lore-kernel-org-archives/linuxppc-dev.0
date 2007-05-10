Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A162DDF09
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 17:21:30 +1000 (EST)
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Satyam Sharma <satyam.sharma@gmail.com>
In-Reply-To: <a781481a0705092345rf9fdc9cs8495516299a28fae@mail.gmail.com>
References: <20070510052622.3E8D5DDF4B@ozlabs.org>
	<20070509224113.cca81a24.akpm@linux-foundation.org>
	<a781481a0705092345rf9fdc9cs8495516299a28fae@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 May 2007 17:21:17 +1000
Message-Id: <1178781677.14928.221.camel@localhost.localdomain>
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


> So you're saying that this mechanism forces the arch (that really
> wants hard_irq_disable) to _#define_ hard_irq_disable (as a macro),
> and if it implements it as an inline function, for example, then we're
> screwed?

No. The idea is to do like we did for a few other things already
(according to Linus request in fact), which is to write

static inline void hard_irq_disable(void)
{
	.../...
}
#define hard_irq_disable hard_irq_disable

This is nicer than having an ARCH_HAS_xxx

> 1. Introduce some CONFIG_WANTS_HARD_IRQ_DISABLE that is #defined (or
> left undefined) by the arch/.../defconfig (depending upon whether or
> not that arch implements a hard_irq_disable() for itself or not)
>
> 2. Then pull-in that code into include/linux/interrupt.h somehow
> (through some known / fixed header file, or through asm/system.h, or
> anyhow -- it doesn't really matter)
> 
> 3. And:
> 
> #ifndef CONFIG_WANTS_HARD_IRQ_DISABLE
> #define hard_irq_disable() do { } while(0)
> #endif

Well, last time I tried that, Linus NACKed it in favor of what I
described above.

> We don't need to standardize on some particular arch-specific header
> filename in this case.

True, that's my main problem here. Though really only the archs who
actually implement something special here need to be careful.

Ben.
