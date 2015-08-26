Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 360471A077B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 11:13:18 +1000 (AEST)
Message-ID: <1440551597.20743.1.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 14/17] powerpc/book3e-64/kexec: Enable SMP release
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Tiejun Chen <tiejun.chen@intel.com>,
 kexec@lists.infradead.org
Date: Wed, 26 Aug 2015 11:13:17 +1000
In-Reply-To: <1440546042.16577.74.camel@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
 <1437250134-307-15-git-send-email-scottwood@freescale.com>
 <1440046447.13406.15.camel@ellerman.id.au>
 <1440447948.30043.36.camel@freescale.com>
 <1440467874.16933.1.camel@ellerman.id.au>
 <1440546042.16577.74.camel@freescale.com>
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

On Tue, 2015-08-25 at 18:40 -0500, Scott Wood wrote:
> On Tue, 2015-08-25 at 11:57 +1000, Michael Ellerman wrote:
> > I guess it's arguable whether that's more or less horrible than adding an
> > #ifdef'ed booted_from_kexec check, but I think I'd prefer the
> > spinning_secondaries solution.
> 
> We'd still need the device tree property regardless of whether we keep 
> use_spinloop() or set spinning_secondaries to zero.

Yep.

> use_spinloop() (with a device tree property rather than booted_from_kexec) 
> seems cleaner:
>  - Avoids depending on the fact that some piece of platform code executes 
> after spinning_secondaries is initialized but before smp_release_cpus().

True, that is a bit fragile.

>  - Doesn't put a different requirement on platform code based on 32 versus 64 
> bit (we have too many 32 versus 64 bit differences as is).

Yeah I didn't think of that.

>  - Doesn't require the change in all relevant platform code files (we have 
> both corenet_generic and qemu_e500, both of which support both 32 and 64 bit, 
> and custom boards might not all use corenet_generic), whether the platform 
> supports kexec or not.

Yep, though they could all call a common implementation of init_early().

So I guess do it with use_spinloop(). I was just hoping to avoid more platform
specific ifdefs in the "generic" code.

> I doesn't look like there's any non-Freescale book3e-64 left in the kernel[1]
...
> [1] If this is true, and won't likely change, can the non-fsl book3e-64 TLB 
> miss handlers and such come out?

It is true, see fb5a515704d7 ("powerpc: Remove platforms/wsp and associated
pieces").

It will not change as far as I'm aware, and all the code's in the git history
anyway, so if there's unused code in there please rip it out.

cheers
