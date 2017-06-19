Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrqv448NlzDr0w
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 22:25:36 +1000 (AEST)
In-Reply-To: <1496728137-19655-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/mm/radix: Only add X for pages overlapping kernel text
Message-Id: <3wrqv42DRXz9s89@ozlabs.org>
Date: Mon, 19 Jun 2017 22:25:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-06 at 05:48:57 UTC, Michael Ellerman wrote:
> Currently we map the whole linear mapping with PAGE_KERNEL_X. Instead we
> should check if the page overlaps the kernel text and only then add
> PAGE_KERNEL_X.
> 
> Note that we still use 1G pages if they're available, so this will
> typically still result in a 1G executable page at KERNELBASE. So this fix is
> primarily useful for catching stray branches to high linear mapping addresses.
> 
> Without this patch, we can execute at 1G in xmon using:
> 
>   0:mon> m c000000040000000
>   c000000040000000  00 l
>   c000000040000000  00000000 01006038
>   c000000040000004  00000000 2000804e
>   c000000040000008  00000000 x
>   0:mon> di c000000040000000
>   c000000040000000  38600001      li      r3,1
>   c000000040000004  4e800020      blr
>   0:mon> p c000000040000000
>   return value is 0x1
> 
> After we get a 400 as expected:
> 
>   0:mon> p c000000040000000
>   *** 400 exception occurred
> 
> Fixes: 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for early init routines")
> Cc: stable@vger.kernel.org # v4.7+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/9abcc981de9775659a0f6e4a52a344

cheers
