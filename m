Return-Path: <Catalin.Marinas@arm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 28B9AB707C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 23:34:05 +1000 (EST)
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[193.131.176.58]) by ozlabs.org (Postfix) with ESMTP id 5929FDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 23:34:03 +1000 (EST)
Subject: Re: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
From: Catalin Marinas <catalin.marinas@arm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090716113100.GB7102@zod.rchland.ibm.com>
References: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
	<1247730230.18228.5.camel@concordia>
	<20090716113100.GB7102@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 14:16:24 +0100
Message-Id: <1247750185.27689.4.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-16 at 07:31 -0400, Josh Boyer wrote:
> On Thu, Jul 16, 2009 at 05:43:50PM +1000, Michael Ellerman wrote:
> >On Thu, 2009-07-16 at 11:25 +1000, Michael Ellerman wrote:
> >> Very lightly tested, doesn't crash the kernel.
> >> 
> >> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> >> ---
> >> 
> >> It doesn't look like we actually need to add any support in the
> >> arch code - or is there something I'm missing?
> >
> >Hmm, I think we want to add annotations in lib/lmb.c don't we? That's
> >our low-level pre-bootmem allocator.
> >
> >And we have the same problem with _edata as x86.
> 
> I'll point out that the Fedora developers enabled this in the rawhide kernels
> for 3 days, and then turned it back off because most of the things found were
> false positives.

Yes, but with 2.6.31-rc3 the number of false positives dropped
considerably. I don't plan to push any new kmemleak patches for 2.6.31
(probably only a bug-fix).

Anyway, even when it reports real leaks, it is very time consuming to
investigate.

I don't have any PPC hardware but as long as someone sorts out things
like _edata or other PPC-specific allocators which aren't currently
tracked by kmemleak, I'm OK with the original patch:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
