Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shXkH12XZzDrQ9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 13:33:27 +1000 (AEST)
In-Reply-To: <20160914063717.2673-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aik@ozlabs.ru, Russell Currey <ruscur@russell.cc>
Subject: Re: powernv/pci: Fix m64 checks for SR-IOV and window alignment
Message-Id: <3shXkH00dPz9srZ@ozlabs.org>
Date: Sun, 25 Sep 2016 13:33:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-14-09 at 06:37:17 UTC, Russell Currey wrote:
> Commit 5958d19a143e checks for prefetchable m64 BARs by comparing the
> addresses instead of using resource flags.  This broke SR-IOV as the m64
> check in pnv_pci_ioda_fixup_iov_resources() fails.
> 
> The condition in pnv_pci_window_alignment() also changed to checking
> only IORESOURCE_MEM_64 instead of both IORESOURCE_MEM_64 and
> IORESOURCE_PREFETCH.
> 
> Revert these cases to the previous behaviour, adding a new helper function
> to do so.  This is named pnv_pci_is_m64_flags() to make it clear this
> function is only looking at resource flags and should not be relied on for
> non-SRIOV resources.
> 
> Fixes: 5958d19a143e ("Fix incorrect PE reservation attempt on some 64-bit BARs")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b79331a5eb9f96e4dfd2169745

cheers
