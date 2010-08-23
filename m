Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BF40B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 08:02:16 +1000 (EST)
Subject: Re: 64-bit ppc rwsem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <201008231544.16422.arnd@arndb.de>
References: <1282107803.22370.173.camel@pasglop>
	<1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
	<201008231544.16422.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 08:01:25 +1000
Message-ID: <1282600885.22370.453.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-08-23 at 15:44 +0200, Arnd Bergmann wrote:
> 
> * Alpha has an optimization for the uniprocessor case, where the atomic
> instructions get turned into nonatomic additions. The spinlock based
> version uses no locks on UP but disables interrupts for reasons I don't
> understand (nothing running at interrupt time should try to access an rwsem).
> Should the generic version do the same as Alpha?

I've seen drivers in the past do trylocks at interrupt time ... tho I
agree it sucks.

> * Is there any architecture that would still benefit from having a separate
> rwsem implementation? AFAICT all the remaining ones are just variations of
> the same concept of using cmpxchg (or xadd in case of x86), which is what
> atomics typically end up doing anyway.

It depends how sensitive rwsems are. 

The "generic" variant based on atomic's and cmpxchg on powerpc is
sub-optimal in the sense that it has stronger memory barriers that would
be necessary (atomic_inc_return for example has both acquire and
release).

But that vs. one more pile of inline asm, we decided it wasn't hot
enough a spot for us to care back then.

Cheers,
Ben.
