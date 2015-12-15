Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21D991A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 15:35:51 +1100 (AEDT)
Message-ID: <1450154150.16234.5.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Enable UBSAN support
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, andrew.donnellan@au1.ibm.com,
 akpm@linux-foundation.org, Andrey Ryabinin <aryabinin@virtuozzo.com>
Date: Tue, 15 Dec 2015 15:35:50 +1100
In-Reply-To: <1450151187-24041-1-git-send-email-dja@axtens.net>
References: <1450151187-24041-1-git-send-email-dja@axtens.net>
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

Hi Daniel,

Great work thanks for getting this going.

On Tue, 2015-12-15 at 14:46 +1100, Daniel Axtens wrote:

> This hooks up UBSAN support for PowerPC.
> 
> So far it's found some interesting cases where we don't properly sanitise
> input to shifts, including one in our futex handling. It's also found an
> out of bounds read in an array. Nothing critical, but worth fixing.
> 
> Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> CC: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
> 
> RFC -> v1:
>  - Update patch to use fixed spelling of SANITIZE.
>  - Include tested by tag from Andrew - Thanks!
> 
> This applies on top of next with Andrey's patches:
>  1) https://patchwork.kernel.org/patch/7761341/
>  2) https://patchwork.kernel.org/patch/7761351/
>  3) https://patchwork.kernel.org/patch/7761361/
>  4) https://patchwork.kernel.org/patch/7785791/
>  5) https://patchwork.kernel.org/patch/7819661/
> 
> -mm and therefore -next have these patches, and the RFC of this
> patch.
> 
> This has now been tested on LE and BE 64bit, on pseries, bml and
> PowerNV.


Have you tried running with KVM?

I'm wondering if we should be excluding some of the KVM code that runs in real mode, eg:

  arch/powerpc/kvm/book3s_hv_rm_mmu.c
  arch/powerpc/kvm/book3s_hv_rm_xics.c

And maybe some other bits.

Also the early setup code, a/p/k/setup*.c might be dicey.

In all of the above it's probably OK unless you actually hit a warning at the
wrong point, so testing will probably not find problems. Although I guess we
could add some deliberatly incorrect code at certain points and check we
survive the warning.

Is there an easy way to spot the calls to UBSAN in the generated code?

cheers
