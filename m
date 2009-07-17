Return-Path: <Catalin.Marinas@arm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D12E7B7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 18:41:56 +1000 (EST)
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[193.131.176.58]) by ozlabs.org (Postfix) with ESMTP id 1CB30DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 18:41:55 +1000 (EST)
Subject: Re: [PATCH] kmemleak: Allow kmemleak to be built on powerpc
From: Catalin Marinas <catalin.marinas@arm.com>
To: michael@ellerman.id.au
In-Reply-To: <1247819536.19156.13.camel@concordia>
References: <f18967360113efe4354a9ad0d71ead9a0f7579ea.1247707485.git.michael@ellerman.id.au>
	<1247730230.18228.5.camel@concordia>
	<1247766739.27689.63.camel@pc1117.cambridge.arm.com>
	<1247790558.16836.4.camel@concordia>
	<1247819195.32760.7.camel@pc1117.cambridge.arm.com>
	<1247819536.19156.13.camel@concordia>
Content-Type: text/plain
Date: Fri, 17 Jul 2009 09:41:50 +0100
Message-Id: <1247820110.32760.11.camel@pc1117.cambridge.arm.com>
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

On Fri, 2009-07-17 at 18:32 +1000, Michael Ellerman wrote:
> On Fri, 2009-07-17 at 09:26 +0100, Catalin Marinas wrote:
> > On Fri, 2009-07-17 at 10:29 +1000, Michael Ellerman wrote:
> > > The wrinkle is that lmb never frees, so by definition it can't leak :)
> > 
> > You can pass min_count = 0 to kmemleak_alloc() so that it would never
> > report such blocks as leaks (see the alloc_bootmem hooks).
> 
> OK. I couldn't see any description of what min_count meant anywhere,

There isn't any, indeed. I'll try to add some description to the
kmemleak api. But it basically means the minimum number a pointer value
should be found during scanning so that it is not reported as a leak. If
this value is 0, it would never be reported. The
kmalloc/kmem_cache_alloc have this value 1 and vmalloc is higher because
of other structures like vm_area holding pointers o the same block.

-- 
Catalin
