Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93C331A0631
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 11:35:03 +1000 (AEST)
In-Reply-To: <20150717101143.GD5916@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: tytso@mit.edu, herbert@gondor.apana.org.au, mpm@selenic.com,
 hpa@linux.intel.com, keescook@chromium.org
Subject: Re: [v2] powerpc: Use hardware RNG for arch_get_random_seed_* not
 arch_get_random_*
Message-Id: <20150803013503.7A0E61402D7@ozlabs.org>
Date: Mon,  3 Aug 2015 11:35:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-17-07 at 10:11:43 UTC, Paul Mackerras wrote:
> The hardware RNG on POWER8 and POWER7+ can be relatively slow, since
> it can only supply one 64-bit value per microsecond.  Currently we
> read it in arch_get_random_long(), but that slows down reading from
> /dev/urandom since the code in random.c calls arch_get_random_long()
> for every longword read from /dev/urandom.
> 
> Since the hardware RNG supplies high-quality entropy on every read, it
> matches the semantics of arch_get_random_seed_long() better than those
> of arch_get_random_long().  Therefore this commit makes the code use
> the POWER8/7+ hardware RNG only for arch_get_random_seed_{long,int}
> and not for arch_get_random_{long,int}.
> 
> This won't affect any other PowerPC-based platforms because none of
> them currently support a hardware RNG.  To make it clear that the
> ppc_md function pointer is used for arch_get_random_seed_*, we rename
> it from get_random_long to get_random_seed.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/01c9348c7620ec650aae

cheers
