Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A0791A0727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 14:44:35 +1000 (AEST)
Message-ID: <1437108275.29389.8.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Use hardware RNG for arch_get_random_seed_*
 not arch_get_random_*
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
Date: Fri, 17 Jul 2015 14:44:35 +1000
In-Reply-To: <20150716121259.GA18219@iris.ozlabs.ibm.com>
References: <20150716121259.GA18219@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-16 at 22:12 +1000, Paul Mackerras wrote:
> The hardware RNG on POWER8 and POWER7+ can be relatively slow, since
> it can only supply one 64-bit value per microsecond.  Currently we
> read it in arch_get_random_long(), but that slows down reading from
> /dev/urandom since the code in random.c calls arch_get_random_long()
> for every longword read from /dev/urandom.
> 
> Since the hardware RNG supplies high-quality entropy on every read, it
> matches the semantics of arch_get_random_seed_long() better than those
> of arch_get_random_long().  Therefore this commit makes the code use
> the hardware RNG only for arch_get_random_seed_{long,int} and not for
> arch_get_random_{long,int}.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Yep seems sensible.

Can you resend and CC some of the random folks, just in case they care.

eg: tytso@mit.edu, keescook@chromium.org, hpa@linux.intel.com.

cheers
