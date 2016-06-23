Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZx110B8HzDqks
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:26:29 +1000 (AEST)
In-Reply-To: <1466505379-15597-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kda@linux-powerpc.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc: Fix faults caused by radix patching of SLB miss handler
Message-Id: <3rZx105w9nz9t1K@ozlabs.org>
Date: Thu, 23 Jun 2016 19:26:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-21-06 at 10:36:19 UTC, Michael Ellerman wrote:
> As part of the Radix MMU support we added some feature sections in the
> SLB miss handler. These are intended to catch the case that we
> incorrectly take an SLB miss when Radix is enabled, and instead of
> crashing weirdly they bail out to a well defined exit path and trigger
> an oops.
> 
> However the way they were written meant the bailout case was enabled by
> default until we did CPU feature patching.
> 
> On powermacs the early debug prints in setup_system() can cause an SLB
> miss, which happens before code patching, and so the SLB miss handler
> would incorrectly bailout and crash during boot.
> 
> Fix it by inverting the sense of the feature section, so that the code
> which is in place at boot is correct for the hash case. Once we
> determine we are using Radix - which will never happen on a powermac -
> only then do we patch in the bailout case which unconditionally jumps.
> 
> Fixes: caca285e5ab4 ("powerpc/mm/radix: Use STD_MMU_64 to properly isolate hash related code")
> Reported-by: Denis Kirjanov <kda@linux-powerpc.org>
> Tested-by: Denis Kirjanov <kda@linux-powerpc.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/6e914ee629c411d9c6d160399c

cheers
