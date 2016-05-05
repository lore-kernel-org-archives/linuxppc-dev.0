Return-Path: <alistair@popple.id.au>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
 [150.101.137.143])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r0c9q1x7gzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 11:03:59 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 aik@ozlabs.ru
Subject: Re: [PATCH v9 12/26] powerpc/powernv/ioda1: M64 support on P7IOC
Date: Thu, 05 May 2016 11:03:28 +1000
Message-ID: <1763008.6yEqpfAAz1@new-mexico>
In-Reply-To: <20160505004032.GA12563@gwshan>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <2553049.lQAGOjRB9a@new-mexico> <20160505004032.GA12563@gwshan>
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

Thanks for the clarifications Gavin. Aside from the WARN_ON() (which is not a
major thing) everything looks good.

Reviewed-By: Alistair Popple <alistair@popple.id.au>

On Thu, 5 May 2016 10:40:33 Gavin Shan wrote:
> On Thu, May 05, 2016 at 09:53:51AM +1000, Alistair Popple wrote:
> >On Wed, 4 May 2016 16:48:53 Gavin Shan wrote:
> >> On Wed, May 04, 2016 at 03:17:51PM +1000, Alistair Popple wrote:
> >> >On Tue, 3 May 2016 15:41:31 Gavin Shan wrote:
> >> >> This enables M64 window on P7IOC, which has been enabled on PHB3.
> >> >
> >> >Have we tested that this works with an adaptor? This looks to be enabling 
> >> >support for something that didn't previously work (64-bit BARs on P7IOC)?
> >> >
> >> 
> >> The M64 isn't supported on P7IOC before, meaning the PCI device's M64
> >> BAR is covered by PHB's M32 window. With the patch applied, the PCI
> >> device's M64 BAR is covered by PHB's M64 window as below log I got
> >> from vpl4. The kernel including the series of patches boots successfully
> >> on vpl4 and all looks normal.
> >
> >So you're changing the way 64-bit BARs work on P7IOC to use a different bit of
> >the hardware/firmware? This means it could break older systems if there is
> >an issue with the M64 support. Other than the comments below the code looks
> >reasonable. However I am assuming you've tested that cards with 64-bit BARs
> >still function on P7 after this change as I'm not familiar enough to comment on
> >the specific hardware details, although your comments make sense and match the
> >code.
> >
> 
> Nope, it doesn't rely on changes in firmware. The old firmware enables and
> exposes PHB M64 window. The kernel doesn't use it on P7IOC until this patch.
> On VPL4, there is a IPR adapter (0000:60:00.0) as below kernel log indicates.
> Its BAR#2 is M64 (64-bits prefetchable) BAR. The BAR#2 is covered by PHB's M64
> window with this patch. The PHB's M64 window is [0x00003da800000000..0x00003dafffffffff].
> After it's applied, the IPR and root filesystem resident in the disk drive out
> of it work fine.
> 
> >> [    0.246110] pci 0000:60:00.0: BAR 2: assigned [mem 0x3da810000000-0x3da810ffffff 64bit pref]
> >> [    0.246218] pci 0000:60:00.0: BAR 0: assigned [mem 0x3da081000000-0x3da08103ffff 64bit]
> >> [    0.246306] pci 0000:60:00.0: BAR 6: assigned [mem 0x3da081040000-0x3da08105ffff pref]
> >> [    0.246392] pci 0000:60     : [PE# 001] Secondary bus 96 associated with PE#1
> >> [    0.246484] pci 0000:60     : [PE# 001] DMA weight 15 (64), assigned (0) 1 DMA32 segments
> >> [    0.246552] pci 0000:60     : [PE# 001]  Setting up 32-bit TCE table at 00000000..0fffffff
> >> 
> >> >> Different from PHB3 where 16 M64 BARs are supported and each of
> >> >> them can be owned by one particular PE# exclusively or divided
> >> >> evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
> >> >> of them are divided to 8 segments. So every P7IOC PHB supports
> >> >> 128 M64 segments in total. P7IOC has M64DT, which helps mapping
> >> >> one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
> >> >> M64DT, indicating that one M64 segment can only be pinned to the
> >> >> fixed PE#.
> >> >> 
> >> >> In order to unified M64 support M64 on P7IOC and PHB3, we just
> >> >> provide 128 M64 segments on every P7IOC PHB and each of them is
> >> >> pinned to the fixed PE# by bypassing the function of M64DT. In
> >> >> turn, we just need different phb->init_m64() for P7IOC and PHB3
> >> >> and maps M64 segment in pnv_ioda_reserve_m64_pe() for P7IOC, most
> >> >> of the code are shared by them.
> >> >> 
> >> >> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >> >> ---
> >> >>  arch/powerpc/platforms/powernv/pci-ioda.c | 89 
> >> >+++++++++++++++++++++++++++++--
> >> >>  1 file changed, 86 insertions(+), 3 deletions(-)
> >> >> 
> >> >> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c 
> >> >b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> >> index 37f22b0..a1b74ec 100644
> >> >> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >> >> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> >> @@ -48,6 +48,9 @@
> >> >>  #include "powernv.h"
> >> >>  #include "pci.h"
> >> >>  
> >> >> +#define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs	*/
> >> >> +#define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR	*/
> >> >> +
> >> >>  /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
> >> >>  #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
> >> >>  
> >> >> @@ -246,6 +249,64 @@ static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev 
> >> >*pdev,
> >> >>  	}
> >> >>  }
> >> >>  
> >> >> +static int pnv_ioda1_init_m64(struct pnv_phb *phb)
> >> >> +{
> >> >> +	struct resource *r;
> >> >> +	int index;
> >> >> +
> >> >> +	/*
> >> >> +	 * There are 16 M64 BARs, each of which has 8 segments. So
> >> >> +	 * there are as many M64 segments as the maximum number of
> >> >> +	 * PEs, which is 128.
> >> >> +	 */
> >> >> +	for (index = 0; index < PNV_IODA1_M64_NUM; index++) {
> >> >> +		unsigned long base, segsz = phb->ioda.m64_segsize;
> >> >> +		int64_t rc;
> >> >> +
> >> >> +		base = phb->ioda.m64_base +
> >> >> +		       index * PNV_IODA1_M64_SEGS * segsz;
> >> >> +		rc = opal_pci_set_phb_mem_window(phb->opal_id,
> >> >> +				OPAL_M64_WINDOW_TYPE, index, base, 0,
> >> >> +				PNV_IODA1_M64_SEGS * segsz);
> >
> >Has firmware always supported OPAL_M64_WINDOW_TYPE for P7IOC? If older versions
> >don't support it what happens? Do we gracefully fall back to the old mode of
> >allocating all BARs from the M32 window or does it break?
> >
> 
> Old firmware enables and exposes M64 window (OPAL_M64_WINDOW_TYPE), but kernel
> doesn't use it until this patch. If the OPAL call fails, errcode is returned.
> The caller, pnv_pci_init_ioda_phb(), disables the window. It means the PCI
> device M64 BARs will fail back to be covered by M32 window. The path is same
> on PHB3 and P7IOC.
> 
> >> >> +		if (rc != OPAL_SUCCESS) {
> >> >> +			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
> >> >> +				rc, phb->hose->global_number, index);
> >> >> +			goto fail;
> >> >> +		}
> >> >> +
> >> >> +		rc = opal_pci_phb_mmio_enable(phb->opal_id,
> >> >> +				OPAL_M64_WINDOW_TYPE, index,
> >> >> +				OPAL_ENABLE_M64_SPLIT);
> >> >> +		if (rc != OPAL_SUCCESS) {
> >> >> +			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
> >> >> +				rc, phb->hose->global_number, index);
> >> >> +			goto fail;
> >> >> +		}
> >> >> +	}
> >> >> +
> >> >> +	/*
> >> >> +	 * Exclude the segment used by the reserved PE, which
> >> >> +	 * is expected to be 0 or last supported PE#.
> >> >> +	 */
> >> >> +	r = &phb->hose->mem_resources[1];
> >> >> +	if (phb->ioda.reserved_pe_idx == 0)
> >> >> +		r->start += phb->ioda.m64_segsize;
> >> >> +	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
> >> >> +		r->end -= phb->ioda.m64_segsize;
> >> >> +	else
> >> >> +		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
> >> >> +			phb->ioda.reserved_pe_idx);
> >
> >Should this be a WARN_ON()? If this condition can only exist because a future
> >programmer changes the reserved_pe_idx then I think it should be a WARN_ON()
> >as the above message would be too easy to miss.
> >
> 
> Yeah, a WARN_ON() should be better.
> 
> Thanks,
> Gavin
> 
> >> >> +
> >> >> +	return 0;
> >> >> +
> >> >> +fail:
> >> >> +	for ( ; index >= 0; index--)
> >> >> +		opal_pci_phb_mmio_enable(phb->opal_id,
> >> >> +			OPAL_M64_WINDOW_TYPE, index, OPAL_DISABLE_M64);
> >> >> +
> >> >> +	return -EIO;
> >> >> +}
> >> >> +
> >> >>  static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
> >> >>  				    unsigned long *pe_bitmap,
> >> >>  				    bool all)
> >> >> @@ -315,6 +376,26 @@ static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus 
> >> >*bus, bool all)
> >> >>  			pe->master = master_pe;
> >> >>  			list_add_tail(&pe->list, &master_pe->slaves);
> >> >>  		}
> >> >> +
> >> >> +		/*
> >> >> +		 * P7IOC supports M64DT, which helps mapping M64 segment
> >> >> +		 * to one particular PE#. However, PHB3 has fixed mapping
> >> >> +		 * between M64 segment and PE#. In order to have same logic
> >> >> +		 * for P7IOC and PHB3, we enforce fixed mapping between M64
> >> >> +		 * segment and PE# on P7IOC.
> >> >> +		 */
> >> >> +		if (phb->type == PNV_PHB_IODA1) {
> >> >> +			int64_t rc;
> >> >> +
> >> >> +			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
> >> >> +					pe->pe_number, OPAL_M64_WINDOW_TYPE,
> >> >> +					pe->pe_number / PNV_IODA1_M64_SEGS,
> >> >> +					pe->pe_number % PNV_IODA1_M64_SEGS);
> >> >> +			if (rc != OPAL_SUCCESS)
> >> >> +				pr_warn("%s: Error %lld mapping M64 for 
> >> >PHB#%d-PE#%d\n",
> >> >> +					__func__, rc, phb->hose-
> >> >>global_number,
> >> >> +					pe->pe_number);
> >> >> +		}
> >> >>  	}
> >> >>  
> >> >>  	kfree(pe_alloc);
> >> >> @@ -329,8 +410,7 @@ static void __init pnv_ioda_parse_m64_window(struct 
> >> >pnv_phb *phb)
> >> >>  	const u32 *r;
> >> >>  	u64 pci_addr;
> >> >>  
> >> >> -	/* FIXME: Support M64 for P7IOC */
> >> >> -	if (phb->type != PNV_PHB_IODA2) {
> >> >> +	if (phb->type != PNV_PHB_IODA1 && phb->type != PNV_PHB_IODA2) {
> >> >>  		pr_info("  Not support M64 window\n");
> >> >>  		return;
> >> >>  	}
> >> >> @@ -364,7 +444,10 @@ static void __init pnv_ioda_parse_m64_window(struct 
> >> >pnv_phb *phb)
> >> >>  
> >> >>  	/* Use last M64 BAR to cover M64 window */
> >> >>  	phb->ioda.m64_bar_idx = 15;
> >> >> -	phb->init_m64 = pnv_ioda2_init_m64;
> >> >> +	if (phb->type == PNV_PHB_IODA1)
> >> >> +		phb->init_m64 = pnv_ioda1_init_m64;
> >> >> +	else
> >> >> +		phb->init_m64 = pnv_ioda2_init_m64;
> >> >>  	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
> >> >>  	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
> >> >>  }
> >> >> 
> >> >
> >> 
> >
> 
