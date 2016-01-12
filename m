Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9BD41A0EBB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:50 +1100 (AEDT)
In-Reply-To: <1452213309-27592-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 gwshan@linux.vnet.ibm.com
Subject: Re: platforms/powernv: Fix update of NVLink DMA mask
Message-Id: <20160112123250.61E0E140779@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-08-01 at 00:35:09 UTC, Alistair Popple wrote:
> The emulated NVLink PCI devices share the same IODA2 TCE tables but
> only support a single TVT (instead of the normal two for PCI
> devices). This requires the kernel to manually replace windows with
> either the bypass or non-bypass window depending on what the driver
> has requested.
> 
> Unfortunately an incorrect optimisation was made in
> pnv_pci_ioda_dma_set_mask() which caused updating of some NPU device
> PEs to be skipped in certain configurations due to an incorrect
> assumption that a NULL peer PE in the array indicated there were no
> more peers present. This patch fixes the problem by ensuring all peer
> PEs are updated.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/419dbd5e1ff0e45a6e1d28c1f7

cheers
