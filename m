Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ln4V0BCnzF1R7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:49:30 +1000 (AEST)
In-Reply-To: <20180405124913.12001-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: leitao@debian.org, mauricfo@linux.vnet.ibm.com, linuxram@us.ibm.com
Subject: Re: powerpc/64s: Fix section mismatch warnings from setup_rfi_flush()
Message-Id: <40Ln4T5mK0z9s3D@ozlabs.org>
Date: Thu, 12 Apr 2018 00:49:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-05 at 12:49:13 UTC, Michael Ellerman wrote:
> The recent LPM changes to setup_rfi_flush() are causing some section
> mismatch warnings because we removed the __init annotation on
> setup_rfi_flush():
> 
>   The function setup_rfi_flush() references
>   the function __init ppc64_bolted_size().
>   the function __init memblock_alloc_base().
> 
> The references are actually in init_fallback_flush(), but that is
> inlined into setup_rfi_flush().
> 
> These references are safe because:
>  - only pseries calls setup_rfi_flush() at runtime
>  - pseries always passes L1D_FLUSH_FALLBACK at boot
>  - so the fallback flush area will always be allocated
>  - so the check in init_fallback_flush() will always return early:
>    /* Only allocate the fallback flush area once (at boot time). */
>    if (l1d_flush_fallback_area)
>    	return;
> 
>  - and therefore we won't actually call the freed init routines.
> 
> We should rework the code to make it safer by default rather than
> relying on the above, but for now as a quick-fix just add a __ref
> annotation to squash the warning.
> 
> Fixes: abf110f3e1ce ("powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/501a78cbc17c329fabf8e9750a1e9a

cheers
