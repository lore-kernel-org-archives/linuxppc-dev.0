Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6t2wkPzDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:58 +1100 (AEDT)
In-Reply-To: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Avoid panic during boot due to divide by zero in
 init_cache_info()
Message-Id: <3vdQ6t1n1Fz9sNX@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-03-04 at 23:54:34 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> I see a panic in early boot when building with a recent gcc toolchain.
> The issue is a divide by zero, which is undefined. Older toolchains
> let us get away with it:
> 
> int foo(int a) { return a / 0; }
> 
> foo:
> 	li 9,0
> 	divw 3,3,9
> 	extsw 3,3
> 	blr
> 
> But newer ones catch it:
> 
> foo:
> 	trap
> 
> Add a check to avoid the divide by zero.
> 
> Fixes: bd067f83b084 ("powerpc/64: Fix naming of cache block vs. cache line")
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6ba422c75facb1b1e0e206c464ee12

cheers
