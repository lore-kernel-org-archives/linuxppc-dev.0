Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1C1C1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 21:58:53 +1100 (AEDT)
In-Reply-To: <1456922671-31676-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, cyrilbur@gmail.com,
 sjitindarsingh@gmail.com
Subject: Re: selftests/powerpc: Fix out of bounds access in TM signal test
Message-Id: <20160303105853.811CA140C3C@ozlabs.org>
Date: Thu,  3 Mar 2016 21:58:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-03 at 12:44:31 UTC, Michael Ellerman wrote:
> Gcc helpfully points out that we're accessing past the end of the gprs
> array:
> 
>   tm-signal-msr-resv.c: In function 'signal_usr1':
>   tm-signal-msr-resv.c:43:37: error: array subscript is above array bounds [-Werror=array-bounds]
>     ucp->uc_mcontext.regs->gpr[PT_MSR] |= (7ULL);
> 
> We haven't noticed previously because -flto was hiding it somehow.
> 
> The code is confused, PT_MSR isn't a gpr, instead it's in
> uc_regs->gregs, so fix it.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/501e279c231bd8d5eed4ecea5a

cheers
