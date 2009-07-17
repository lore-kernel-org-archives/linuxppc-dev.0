Return-Path: <Catalin.Marinas@arm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 05F65B708A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 18:26:47 +1000 (EST)
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[193.131.176.58]) by ozlabs.org (Postfix) with ESMTP id 3211FDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 18:26:44 +1000 (EST)
Subject: Re: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
From: Catalin Marinas <catalin.marinas@arm.com>
To: michael@ellerman.id.au
In-Reply-To: <1247790558.16836.4.camel@concordia>
References: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
	<1247730230.18228.5.camel@concordia>
	<1247766739.27689.63.camel@pc1117.cambridge.arm.com>
	<1247790558.16836.4.camel@concordia>
Content-Type: text/plain
Date: Fri, 17 Jul 2009 09:26:35 +0100
Message-Id: <1247819195.32760.7.camel@pc1117.cambridge.arm.com>
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

On Fri, 2009-07-17 at 10:29 +1000, Michael Ellerman wrote:
> On Thu, 2009-07-16 at 18:52 +0100, Catalin Marinas wrote:
> > On Thu, 2009-07-16 at 17:43 +1000, Michael Ellerman wrote:
> > > On Thu, 2009-07-16 at 11:25 +1000, Michael Ellerman wrote:
> > > > Very lightly tested, doesn't crash the kernel.
> > > > 
> > > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > > > ---
> > > > 
> > > > It doesn't look like we actually need to add any support in the
> > > > arch code - or is there something I'm missing?
> > > 
> > > Hmm, I think we want to add annotations in lib/lmb.c don't we? That's
> > > our low-level pre-bootmem allocator.
> > 
> > Yes, I think so (I'm not using this on ARM or x86 so I can't really test
> > it). Without these hooks, there kmemleak reports aren't that useful
> > (probably too many).
> 
> The wrinkle is that lmb never frees, so by definition it can't leak :)

You can pass min_count = 0 to kmemleak_alloc() so that it would never
report such blocks as leaks (see the alloc_bootmem hooks).

> But we could have memory allocated with lmb that has pointers to other
> objects allocated later, and we want kmemleak to scan the lmb allocated
> blocks to find those references.
> 
> So the question is do we need to annotate lmb so that will happen, or
> does kmemleak scan all kernel memory, regardless of where it's
> allocated?

Apart from the data and bss sections, it only scans the memory which was
explicitly allocated. So, you need these hooks in the lmb code.

The mainline kernel scans for the task stacks by going through the full
tasks list. However, traversing this list requires a lock which
increases the latency quite a lot. For the next merging window, I added
hooks to the alloc_thread_info/free_thread_info functions. If the ppc
code has __HAVE_ARCH_THREAD_INFO_ALLOCATOR defined, you may need to add
some hooks in there as well (but note that kmallloc/kmem_cache_alloc are
tracked by kmemleak already, so you only need the hooks if the
thread_info allocator uses __get_free_pages).

-- 
Catalin
