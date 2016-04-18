Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qpB4D1d4czDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 11:53:00 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel v3 9/9] powerpc/powernv/npu: Enable NVLink pass
 through
Date: Mon, 18 Apr 2016 11:52:55 +1000
Message-ID: <14207424.6AAakbByxl@new-mexico>
In-Reply-To: <20160415044020.GK18218@voom.redhat.com>
References: <1460450270-42354-1-git-send-email-aik@ozlabs.ru>
 <1460450270-42354-10-git-send-email-aik@ozlabs.ru>
 <20160415044020.GK18218@voom.redhat.com>
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

Hi David,

On Fri, 15 Apr 2016 14:40:20 David Gibson wrote:
> On Tue, Apr 12, 2016 at 06:37:50PM +1000, Alexey Kardashevskiy wrote:
> > IBM POWER8 NVlink systems come with Tesla K40-ish GPUs each of which
> > also has a couple of fast speed links (NVLink). The interface to links
> > is exposed as an emulated PCI bridge which is included into the same
> > IOMMU group as the corresponding GPU.
> > 
> > In the kernel, NPUs get a separate PHB of the PNV_PHB_NPU type and a PE.
> > 
> > In order to make these links work when GPU is passed to the guest,
> > these bridges need to be passed as well; otherwise performance will
> > degrade.
> > 
> > This implements and exports API to manage NPU state in regard to VFIO;
> > it replicates iommu_table_group_ops.
> > 
> > This defines a new pnv_pci_ioda2_npu_ops which is assigned to
> > the IODA2 bridge if there are NPUs for a GPU on the bridge.
> > The new callbacks call the default IODA2 callbacks plus new NPU API.
> > This adds a gpe_table_group_to_npe() helper to find NPU PE for the IODA2
> > table_group, it is not expected to fail as the helper is only called
> > from the pnv_pci_ioda2_npu_ops.
> > 
> > This adds a pnv_pci_npu_setup_iommu() helper which adds NPUs to
> > the GPU group if any found. The helper uses helpers to look for
> > the "ibm,gpu" property in the device tree which is a phandle of
> > the corresponding GPU.
> > 
> > This adds an additional loop over PEs in pnv_ioda_setup_dma() as the main
> > loop skips NPU PEs as they do not have 32bit DMA segments.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v3:
> > * moved NPU-to-GPU IOMMU grouping later after all PHBs are discovered
> > * removed hack to make iommu_add_device() work, iommu_group_add_device()
> > is used instead
> > * cleanup in gpe_table_group_to_npe_cb()
> > 
> > v2:
> > * reimplemented to support NPU + GPU in the same group
> > * merged "powerpc/powernv/npu: Add NPU devices to IOMMU group" and
> > "powerpc/powernv/npu: Enable passing through via VFIO" into this patch
> > ---
> >  arch/powerpc/platforms/powernv/npu-dma.c  | 126 ++++++++++++++++++++++++++++++
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 105 +++++++++++++++++++++++++
> >  arch/powerpc/platforms/powernv/pci.h      |   6 ++
> >  3 files changed, 237 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> > index 8e70221..7cb9f6a 100644
> > --- a/arch/powerpc/platforms/powernv/npu-dma.c
> > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/export.h>
> >  #include <linux/pci.h>
> >  #include <linux/memblock.h>
> > +#include <linux/iommu.h>
> >  
> >  #include <asm/iommu.h>
> >  #include <asm/pnv-pci.h>
> > @@ -262,3 +263,128 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
> >  		}
> >  	}
> >  }
> > +
> > +long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
> > +		struct iommu_table *tbl)
> > +{
> > +	struct pnv_phb *phb = npe->phb;
> > +	int64_t rc;
> > +	const unsigned long size = tbl->it_indirect_levels ?
> > +		tbl->it_level_size : tbl->it_size;
> > +	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
> > +	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
> > +
> > +	pe_info(npe, "Setting up window#%d %llx..%llx pg=%lx\n", num,
> > +			start_addr, start_addr + win_size - 1,
> > +			IOMMU_PAGE_SIZE(tbl));
> > +
> > +	/* Ignore @num as there is just one window per NPU */
> > +	rc = opal_pci_map_pe_dma_window(phb->opal_id,
> > +			npe->pe_number,
> > +			npe->pe_number,
> > +			tbl->it_indirect_levels + 1,
> > +			__pa(tbl->it_base),
> > +			size << 3,
> > +			IOMMU_PAGE_SIZE(tbl));
> > +	if (rc) {
> > +		pe_err(npe, "Failed to configure TCE table, err %lld\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	pnv_pci_link_table_and_group(phb->hose->node, num,
> > +			tbl, &npe->table_group);
> > +	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
> > +
> > +	return rc;
> > +}
> > +
> > +long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
> > +{
> > +	struct pnv_phb *phb = npe->phb;
> > +	long ret;
> > +
> > +	pe_info(npe, "Removing DMA window #%d\n", num);
> > +
> > +	/* Ignore @num as there is just one window per NPU */
> > +	ret = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> > +			npe->pe_number,
> > +			0/* levels */, 0/* table address */,
> > +			0/* table size */, 0/* page size */);
> > +	if (ret)
> > +		pe_warn(npe, "Unmapping failed, ret = %ld\n", ret);
> > +	else
> > +		pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
> > +
> > +	pnv_pci_unlink_table_and_group(npe->table_group.tables[num],
> > +			&npe->table_group);
> > +
> > +	return ret;
> > +}
> > +
> > +/* Switch ownership from platform code to external user (e.g. VFIO) */
> > +void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
> > +{
> > +	struct pnv_phb *phb = npe->phb;
> > +	int64_t ret;
> > +
> > +	if (npe->table_group.tables[0]) {
> > +		/* Disable 32bit window */
> > +		pnv_pci_unlink_table_and_group(npe->table_group.tables[0],
> > +				&npe->table_group);
> > +		npe->table_group.tables[0] = NULL;
> > +		ret = opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> > +				npe->pe_number,
> > +				0/* levels */, 0/* table address */,
> > +				0/* table size */, 0/* page size */);
> > +	} else {
> > +		/* Disable bypass */
> > +		ret = opal_pci_map_pe_dma_window_real(phb->opal_id,
> > +				npe->pe_number, npe->pe_number,
> > +				0 /* bypass base */, 0);
> > +	}
> 
> It's not immediately obvious to me why this is an if/else.  I'm
> assuming that the way the kernel uses the NPE IOMMU it always either
> has a 32-bit DMA window, or it's in bypass mode.  Is that inherent to
> the way the hardware works, or just the way Linux uses it?

Unlike the IODA2 the NPU only has a single TVE/window meaning the NPU IOMMU is
either disabled, in bypass or has a 32-bit DMA window. Alexey can comment on
the if/else but I agree that it isn't strictly necessary - calling either 
map_pe_dma_window() or map_pe_dma_window_real() with the arguments in both the
if and else cases will zero the TVE effectively disabling DMA.

> I'm just worrying if this could open an exploitable hole if the host
> kernel ever changes so that it could have bypass windows and TCE
> windows simultaneously active.  Is there any way to unconditionally
> disable bypass *and* disable any existing DMA window.

I'm not a VFIO expert, but from the perspective of the NPU HW this situation 
couldn't exist for the reasons described above. Calling
opal_pci_map_pe_dma_window/_real() with either a zero table size or PCI memory
size will unconditionally disable all DMA windows for that PE# on the NPU.

- Alistair
 
> Apart from that nit,
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> 
