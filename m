Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3357ADDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 17:50:26 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Fix bootwrapper builds with newer gcc versions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080502.163855.96423898.davem@davemloft.net>
References: <3B083683-CB6E-4F1D-87EF-BBFA7D491271@kernel.crashing.org>
	<20080502.144009.147804001.davem@davemloft.net>
	<1209770875.26383.14.camel@pasglop>
	<20080502.163855.96423898.davem@davemloft.net>
Content-Type: text/plain
Date: Sat, 03 May 2008 17:50:17 +1000
Message-Id: <1209801017.26383.21.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-05-02 at 16:38 -0700, David Miller wrote:
> Oh, I forgot about how far function calls are done on powerpc.
> Yes, that will suck.
> 
> Is there some way to map all of the modules in the low 32-bits and
> thus aovid the trampolines?  The powerpc call instruction can cover
> 4GB like on sparc right?
> 
> Actually, I remember there is some linkage register that has
> to be setup on powerpc with the code model you guys use, is
> that the problem?

The TOC yes, so we end up doing cross-TOC calls, which we would want to
avoid to get to base runtime stuff such as the save/restore bits.

Especially useless since those runtime don't need a TOC at all :-)

Best would be if we could get those runtime bits linked in the module
itself, but I don't know enough about our toolchain to know if that's
easy (I suppose everything is always possible :-)

I can ask my local expert next week.

Ben.
