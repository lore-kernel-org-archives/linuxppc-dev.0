Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7375C1A019D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 09:28:07 +1000 (AEST)
In-Reply-To: <1434947525.27935.27.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/3] powerpc/iommu: Cleanup setting of DMA base/offset
Message-Id: <20150623232807.64B64140319@ozlabs.org>
Date: Wed, 24 Jun 2015 09:28:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-22-06 at 04:32:05 UTC, Benjamin Herrenschmidt wrote:
> Now that the table and the offset can co-exist, we no longer need
> to flip/flop, we can just establish both once at boot time.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 50 +++++++++++--------------------
>  arch/powerpc/platforms/pseries/iommu.c    |  3 +-
>  arch/powerpc/sysdev/dart_iommu.c          | 16 ++--------


This doesn't apply to my next, since the VFIO changes went in:

  Applying patch #487103 to current directory
  Description: [2/3] powerpc/iommu: Cleanup setting of DMA base/offset
  patching file arch/powerpc/platforms/powernv/pci-ioda.c
  Hunk #1 FAILED at 1621.
  Hunk #2 FAILED at 1653.
  Hunk #3 FAILED at 1841.
  Hunk #4 FAILED at 1882.
  Hunk #5 FAILED at 1977.
  5 out of 5 hunks FAILED -- saving rejects to file arch/powerpc/platforms/powernv/pci-ioda.c.rej
  patching file arch/powerpc/platforms/pseries/iommu.c
  Hunk #1 succeeded at 1253 (offset 92 lines).
  patching file arch/powerpc/sysdev/dart_iommu.c
  Hunk #1 succeeded at 313 (offset 7 lines).
  Hunk #2 succeeded at 361 (offset 7 lines).


I could fix the conflicts but then the result wouldn't have been tested.

cheers
