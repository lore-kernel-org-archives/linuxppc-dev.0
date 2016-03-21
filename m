Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qT2NV5R3ZzDrSf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 15:07:38 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 06/10] powerpc/powernv/npu: Simplify DMA setup
Date: Mon, 21 Mar 2016 14:59:50 +1100
Message-ID: <291708668.V4C2XJyMOf@new-mexico>
In-Reply-To: <20160316055550.GG9032@voom>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-7-git-send-email-aik@ozlabs.ru>
 <20160316055550.GG9032@voom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Mar 2016 16:55:50 David Gibson wrote:
> On Wed, Mar 09, 2016 at 05:29:02PM +1100, Alexey Kardashevskiy wrote:
> > NPU devices are quite specific, in fact they represent side DMA channel
> > of a GPU device. The GPU/NPU driver never actually configures DMA
> > for NPU devices, instead it relies on the platform code to propagate
> > DMA setup to NPU devices when a main GPU device is being configured.
> > When GPU is being set up, the same configuration - bypass or 32bit DMA -
> > is used for NPU. This makes DMA setup explicit.
> > 
> > pnv_npu_ioda_controller_ops::pnv_npu_dma_set_mask is moved to pci-ioda,
> > made static and prints warning as dma_set_mask() should never be called
> > on this function as in any case it will not configure GPU; so we make
> > this explicit.
> > 
> > Instead of using PNV_IODA_PE_PEER and peers[] (which next patch will
> > remove), we test every PCI device if there are corresponding NVLink
> > devices. If there are any, we propagate bypass mode to just found NPU
> > devices by calling the setup helper directly (which takes @bypass) and
> > avoid guessing (i.e. calculating from DMA mask) whether we need bypass
> > or not on NPU devices. Since DMA setup happens in very rare occasion,
> > this will not slow down booting or VFIO start/stop much.
> > 
> > This renames pnv_npu_disable_bypass to pnv_npu_dma_set_32 to make it
> > more clear what the function really does which is programming 32bit
> > table address to the TVT ("disabling bypass" means writing zeroes to
> > the TVT).
> > 
> > This removes pnv_npu_dma_set_bypass() from pnv_npu_ioda_fixup() as
> > the DMA configuration on NPU does not matter until dma_set_mask() is
> > called on GPU and that will do the NPU DMA configuration.
> > 
> > This removes phb->dma_dev_setup initialization for NPU as
> > pnv_pci_ioda_dma_dev_setup is no-op for it anyway.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> I'm having trouble making sense of the commit message, but the actual
> changes look fine as best I can tell.

For background the NPU NVLink PCI "devices" are actually emulated in firmware 
and are mainly used for link training. Their DMA/TCE setup must match the GPU 
which is connected via PCIe and NVLink so any changes to the DMA/TCE setup on 
the GPU PCIe device need to be propagated to the NVLink device as this is what 
device drivers expect and it doesn't make much sense to do anything else.

Originally we were going to propagate DMA/TCE changes the other way (NVLink 
device to PCI device) as well, but it proved unnecessary and unused. This 
patch cleans up the last bit of that behaviour and looks good to me as well.

> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Alistair Popple <alistair@popple.id.au>

> 
> 
