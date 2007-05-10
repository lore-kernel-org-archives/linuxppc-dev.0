Return-Path: <satyam.sharma@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id AE304DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 17:54:50 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so502160wra
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 00:54:49 -0700 (PDT)
Message-ID: <a781481a0705100054r45c373a0lfd35b8b31b0e6032@mail.gmail.com>
Date: Thu, 10 May 2007 13:24:48 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
In-Reply-To: <1178781677.14928.221.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070510052622.3E8D5DDF4B@ozlabs.org>
	<20070509224113.cca81a24.akpm@linux-foundation.org>
	<a781481a0705092345rf9fdc9cs8495516299a28fae@mail.gmail.com>
	<1178781677.14928.221.camel@localhost.localdomain>
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

On 5/10/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > So you're saying that this mechanism forces the arch (that really
> > wants hard_irq_disable) to _#define_ hard_irq_disable (as a macro),
> > and if it implements it as an inline function, for example, then we're
> > screwed?
>
> No. The idea is to do like we did for a few other things already
> (according to Linus request in fact), which is to write
>
> static inline void hard_irq_disable(void)
> {
>         .../...
> }
> #define hard_irq_disable hard_irq_disable
>
> This is nicer than having an ARCH_HAS_xxx

Ok, that's reasonable, we don't want to end up with zillions of
ARCH_HAS_THIS and ARCH_HAS_THAT.

But then, what _is_ the problem with your approach above? An arch that
wants (and implements) hard_irq_disable will also #define that dummy
macro, so we just need to pull in the appropriate header (directly,
indirectly, anyhow -- we don't really care) into
include/linux/interrupt.h and then just do the exact same "#ifndef
hard_irq_disable" check that you're doing right now. I must be missing
something trivial (either that or I need to go and have a coffee :-)
because I don't see the possibility of hitting multiple _different_
definitions with the approach you mentioned just now.
