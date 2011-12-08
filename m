Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BE4C11008BC
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 18:23:36 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl-pci: Allow 64-bit PCIe devices to DMA to any
 memory address
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322719394-24586-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 8 Dec 2011 01:23:47 -0600
Message-Id: <28D7114D-EF6C-4BAD-8198-0A82A012B1C1@kernel.crashing.org>
References: <1322719394-24586-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2011, at 12:03 AM, Kumar Gala wrote:

> There is an issue on FSL-BookE 64-bit devices (P5020) in which PCIe
> devices that are capable of doing 64-bit DMAs (like an Intel e1000) do
> not function and crash the kernel if we have >4G of memory in the =
system.
>=20
> The reason is that the existing code only sets up one inbound window =
for
> access to system memory across PCIe.  That window is limited to a =
32-bit
> address space.  So on systems we'll end up utilizing SWIOTLB for dma
> mappings.  However SWIOTLB dma ops implement dma_alloc_coherent() as
> dma_direct_alloc_coherent().  Thus we can end up with dma addresses =
that
> are not accessible because of the inbound window limitation.
>=20
> We could possibly set the SWIOTLB alloc_coherent op to
> swiotlb_alloc_coherent() however that does not address the issue since
> the swiotlb_alloc_coherent() will behave almost identical to
> dma_direct_alloc_coherent() since the devices coherent_dma_mask will =
be
> greater than any address allocated by swiotlb_alloc_coherent() and =
thus
> we'll never bounce buffer it into a range that would be dma-able.
>=20
> The easiest and best solution is to just make it so that a 64-bit
> capable device is able to DMA to any internal system address.
>=20
> We accomplish this by opening up a second inbound window that maps all
> of memory above the internal SoC address width so we can set it up to
> access all of the internal SoC address space if needed.
>=20
> We than fixup the dma_ops and dma_offset for PCIe devices with a dma
> mask greater than the maximum internal SoC address.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/sysdev/fsl_pci.c |   55 =
+++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 55 insertions(+), 0 deletions(-)

applied to merge

- k=
