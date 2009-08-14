Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EAE07B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Aug 2009 17:57:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58D50DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 17:57:04 +1000 (EST)
Subject: Re: [PATCH] Add kmemleak annotations to lmb.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <1250178041.14019.34.camel@pc1117.cambridge.arm.com>
References: <e846103b117cc36798b1f352ed526d600fd88e16.1250132460.git.michael@ellerman.id.au>
	<1250178041.14019.34.camel@pc1117.cambridge.arm.com>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 17:56:40 +1000
Message-Id: <1250236600.24143.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-13 at 16:40 +0100, Catalin Marinas wrote:
> On Thu, 2009-08-13 at 13:01 +1000, Michael Ellerman wrote:
> > We don't actually want kmemleak to track the lmb allocations, so we
> > pass min_count as 0. However telling kmemleak about lmb allocations
> > allows it to scan that memory for pointers to other memory that is
> > tracked by kmemleak, ie. slab allocations etc.
> 
> Looks alright to me (though I haven't tested it). You can add a
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Actually, Milton pointed to me that we may not want to allow all
LMB chunks to be scanned by kmemleaks, things like the DART hole
that's taken out of the linear mapping for example may need to
be avoided, though I'm not sure what would be the right way to
do it.

Cheers,
Ben.
