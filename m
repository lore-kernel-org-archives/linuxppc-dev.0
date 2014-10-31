Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FCE1A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 18:00:13 +1100 (AEDT)
Message-ID: <1414738812.21815.5.camel@concordia>
Subject: Re: [PATCH] hwrng: pseries - port to new read API and fix stack
 corruption
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Fri, 31 Oct 2014 18:00:12 +1100
In-Reply-To: <20141031063233.1884.86309.stgit@bahia.local>
References: <20141031063233.1884.86309.stgit@bahia.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-31 at 07:50 +0100, Greg Kurz wrote:
> The add_early_randomness() function in drivers/char/hw_random/core.c passes
> a 16-byte buffer to pseries_rng_data_read(). Unfortunately, plpar_hcall()
> returns four 64-bit values and trashes 16 bytes on the stack.

Hmm, thanks. I thought I'd fixed that, but I guess I never sent the patch :}

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

Well probably, can you do a before and after test of dd if=/dev/hwrng ?

> Cc'ing stable as I could reproduce back to 3.15.10

The right way to CC stable for a patch that isn't yet in upstream is to add:

CC: stable@vger.kernel.org

Before your Signed-off-by. They will then pick it up once it's merged into
Linus' tree. See Documentation/stable_kernel_rules.txt

cheers
