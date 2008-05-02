Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 9E7C7DDF11
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 09:38:56 +1000 (EST)
Date: Fri, 02 May 2008 16:38:55 -0700 (PDT)
Message-Id: <20080502.163855.96423898.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
From: David Miller <davem@davemloft.net>
In-Reply-To: <1209770875.26383.14.camel@pasglop>
References: <3B083683-CB6E-4F1D-87EF-BBFA7D491271@kernel.crashing.org>
	<20080502.144009.147804001.davem@davemloft.net>
	<1209770875.26383.14.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 03 May 2008 09:27:55 +1000

> That is, it would be fairly non-sensical for module code to go through
> the trampoline to call those stubs in the kernel (and having to
> EXPORT_SYMBOL them).

Oh, I forgot about how far function calls are done on powerpc.
Yes, that will suck.

Is there some way to map all of the modules in the low 32-bits and
thus aovid the trampolines?  The powerpc call instruction can cover
4GB like on sparc right?

Actually, I remember there is some linkage register that has
to be setup on powerpc with the code model you guys use, is
that the problem?
