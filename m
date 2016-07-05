Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkQkp16MgzDqs1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 00:10:10 +1000 (AEST)
In-Reply-To: <1457046400-29276-2-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/2] selftests/powerpc: benchmarks/context_switch.c use vector
 instructions/types
Message-Id: <3rkQkn73Lyz9t0T@ozlabs.org>
Date: Wed,  6 Jul 2016 00:10:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-03 at 23:06:40 UTC, Cyril Bur wrote:
> Currently it doesn't appear the resulting binary actually uses any Altivec
> or VSX instructions the solution is to explicitly tell GCC to use vector
> instructions and use vector types in the code.
> 
> Part of this this issue can be GCC version specific:
> 
> GCC 4.9.x is happy to use Altivec and VSX instructions if altivec.h is
> includedi (and possibly if vector types are used), this also means that
> 4.9.x will use VSX instructions even if only -maltivec is passed. It is
> also possible that Altivec instructions will be used even without -maltivec
> or -mabi=altivec.
> 
> GCC 5.2.x complains about the lack of -maltivec parameter if altivec.h is
> included and will not use VSX unless -mvsx is present on commandline.
> 
> GCC 5.3.0 has a regression that means __attribute__((__target__("no-vsx"))
> fails to build. A fix is targeted for 5.4.
> 
> Furthermore LTO (Link Time Optimisation) doesn't play well with
> __attribute__((__target__("no-vsx")), LTO can cause GCC to forget about the
> attribute and compile with VSX instructions regardless. Be weary when
> enabling -flfo for this test.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2418ae8a81760b4dec8d5e3e7

cheers
