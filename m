Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE28C1A0185
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 02:13:48 +1100 (AEDT)
Date: Thu, 6 Nov 2014 23:13:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] hwrng: pseries - port to new read API and fix stack
 corruption
Message-ID: <20141106151338.GB4446@gondor.apana.org.au>
References: <20141031063233.1884.86309.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141031063233.1884.86309.stgit@bahia.local>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2014 at 07:50:11AM +0100, Greg Kurz wrote:
> The add_early_randomness() function in drivers/char/hw_random/core.c passes
> a 16-byte buffer to pseries_rng_data_read(). Unfortunately, plpar_hcall()
> returns four 64-bit values and trashes 16 bytes on the stack.
> 
> This bug has been lying around for a long time. It got unveiled by:
> 
> commit d3cc7996473a7bdd33256029988ea690754e4e2a
> Author: Amit Shah <amit.shah@redhat.com>
> Date:   Thu Jul 10 15:42:34 2014 +0530
> 
>     hwrng: fetch randomness only after device init
> 
> It may trig a oops while loading or unloading the pseries-rng module for both
> PowerVM and PowerKVM guests.
> 
> This patch does two things:
> - pass an intermediate well sized buffer to plpar_hcall(). This is acceptalbe
>   since we're not on a hot path.
> - move to the new read API so that we know the return buffer size for sure.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>

Patch applied to crypto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
