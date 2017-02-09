Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzG13hjQzDqMJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:20:09 +1100 (AEDT)
In-Reply-To: <1486102228.4850.52.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Fix spurrious segfaults on radix with Autonuma
Message-Id: <3vJzG135Khz9s7R@ozlabs.org>
Date: Fri, 10 Feb 2017 00:20:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-03 at 06:10:28 UTC, Benjamin Herrenschmidt wrote:
> When autonuma marks a PTE inaccessible it clears all the protection
> bits but leave the PTE valid.
> 
> With the Radix MMU, an attempt at executing from such a PTE will
> take a fault with bit 35 of SRR1 set "SRR1_ISI_N_OR_G".
> 
> It is thus incorrect to treat all such faults as errors. We should
> pass them to handle_mm_fault() for autonuma to deal with. The case
> of pages that are really not executable is handled by the existing
> test for VM_EXEC further down.
> 
> That leaves us with catching the kernel attempts at executing user
> pages. We can catch that earlier, even before we do find_vma.
> 
> It is never valid on powerpc for the kernel to take an exec fault
> to begin with. So fold that test with the existing test for the
> kernel faulting on kernel addresses to bail out early.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 1d18ad0 ("powerpc/mm: Detect instruction fetch denied and report")
> Fixes: 0ab5171 ("powerpc/mm: Fix no execute fault handling on pre-POWER5")
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d7df2443cd5f67fc6ee7c05a88e499

cheers
