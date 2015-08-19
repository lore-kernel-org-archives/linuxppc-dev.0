Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BD6E1A0586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:16 +1000 (AEST)
In-Reply-To: <1438919154-6179-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: move dma_get_required_mask from pnv_phb to
 pci_controller_ops
Message-Id: <20150819231415.CB00E140789@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-08 at 03:45:54 UTC, Andrew Donnellan wrote:
> Simplify the dma_get_required_mask call chain by moving it from pnv_phb to
> pci_controller_ops, similar to commit 763d2d8df1ee2b92ff09c
> ("powerpc/powernv: Move dma_set_mask from pnv_phb to pci_controller_ops").
> 
> Previous call chain:
> 
>   0) call dma_get_required_mask() (kernel/dma.c)
>   1) call ppc_md.dma_get_required_mask, if it exists. On powernv, that
>      points to pnv_dma_get_required_mask() (platforms/powernv/setup.c)
>   2) device is PCI, therefore call pnv_pci_dma_get_required_mask()
>      (platforms/powernv/pci.c)
>   3) call phb->dma_get_required_mask if it exists
>   4) it only exists in the ioda case, where it points to
>        pnv_pci_ioda_dma_get_required_mask() (platforms/powernv/pci-ioda.c)
> 
> New call chain:
> 
>   0) call dma_get_required_mask() (kernel/dma.c)
>   1) device is PCI, therefore call pci_controller_ops.dma_get_required_mask
>      if it exists
>   2) in the ioda case, that points to pnv_pci_ioda_dma_get_required_mask()
>      (platforms/powernv/pci-ioda.c)
> 
> In the p5ioc2 case, the call chain remains the same -
> dma_get_required_mask() does not find either a ppc_md call or
> pci_controller_ops call, so it calls __dma_get_required_mask().
> 
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/53522982fc3c254bb444

cheers
