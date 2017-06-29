Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz9fg4ssyzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 06:06:51 +1000 (AEST)
Date: Thu, 29 Jun 2017 14:06:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yongji Xie
 <elohimes@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 0/3 REPOST] vfio-pci: Add support for mmapping
 MSI-X table
Message-ID: <20170629140648.160adabf@w520.home>
In-Reply-To: <49060a05-bbdb-8a38-909a-f9615693501e@ozlabs.ru>
References: <20170615054845.8428-1-aik@ozlabs.ru>
 <20170622151118.0006c3d3@w520.home>
 <82b2e63c-0a39-303c-f255-b857764fc412@ozlabs.ru>
 <20170623091723.1f122800@w520.home>
 <49060a05-bbdb-8a38-909a-f9615693501e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Jun 2017 17:27:32 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 24/06/17 01:17, Alex Williamson wrote:
> > On Fri, 23 Jun 2017 15:06:37 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> >> On 23/06/17 07:11, Alex Williamson wrote:  
> >>> On Thu, 15 Jun 2017 15:48:42 +1000
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>     
> >>>> Here is a patchset which Yongji was working on before
> >>>> leaving IBM LTC. Since we still want to have this functionality
> >>>> in the kernel (DPDK is the first user), here is a rebase
> >>>> on the current upstream.
> >>>>
> >>>>
> >>>> Current vfio-pci implementation disallows to mmap the page
> >>>> containing MSI-X table in case that users can write directly
> >>>> to MSI-X table and generate an incorrect MSIs.
> >>>>
> >>>> However, this will cause some performance issue when there
> >>>> are some critical device registers in the same page as the
> >>>> MSI-X table. We have to handle the mmio access to these
> >>>> registers in QEMU emulation rather than in guest.
> >>>>
> >>>> To solve this issue, this series allows to expose MSI-X table
> >>>> to userspace when hardware enables the capability of interrupt
> >>>> remapping which can ensure that a given PCI device can only
> >>>> shoot the MSIs assigned for it. And we introduce a new bus_flags
> >>>> PCI_BUS_FLAGS_MSI_REMAP to test this capability on PCI side
> >>>> for different archs.
> >>>>
> >>>> The patch 3 are based on the proposed patchset[1].
> >>>>
> >>>> Changelog
> >>>> v3:
> >>>> - rebased on the current upstream    
> >>>
> >>> There's something not forthcoming here, the last version I see from
> >>> Yongji is this one:
> >>>
> >>> https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017245.html
> >>>
> >>> Which was a 6-patch series where patches 2-4 tried to apply
> >>> PCI_BUS_FLAGS_MSI_REMAP for cases that supported other platforms.  That
> >>> doesn't exist here, so it's not simply a rebase.  Patch 1/ seems to
> >>> equate this new flag to the IOMMU capability IOMMU_CAP_INTR_REMAP, but
> >>> nothing is done here to match them together.  That patch also mentions
> >>> the work Eric has done for similar features on ARM, but again those
> >>> patches are dropped.  It seems like an incomplete feature now.  Thanks,    
> >>
> >>
> >> Thanks! I suspected this is not the latest but could not find anything
> >> better than we use internally for tests, and I could not reach Yongji for
> >> comments whether this was the latest update.
> >>
> >> As I am reading the patches, I notice that the "msi remap" term is used all
> >> over the place. While this remapping capability may be the case for x86/arm
> >> (and therefore the IOMMU_CAP_INTR_REMAP flag makes sense), powernv does not
> >> do remapping but provides hardware isolation. When we are allowing MSIX BAR
> >> mapping to the userspace - the isolation is what we really care about. Will
> >> it make sense to rename PCI_BUS_FLAGS_MSI_REMAP to
> >> PCI_BUS_FLAGS_MSI_ISOLATED ?  
> > 
> > I don't have a strong opinion either way, so long as it's fully
> > described what the flag indicates.
> >   
> >> Another thing - the patchset enables PCI_BUS_FLAGS_MSI_REMAP when IOMMU
> >> just advertises IOMMU_CAP_INTR_REMAP, not necessarily uses it, should the
> >> patchset actually look at something like irq_remapping_enabled in
> >> drivers/iommu/amd_iommu.c instead?  
> > 
> > Interrupt remapping being enabled is implicit in IOMMU_CAP_INTR_REMAP,
> > neither intel or amd iommu export the capability unless enabled.
> > Nobody cares if it's supported but not enabled.  Thanks,  
> 
> 
> As I am reading the current drivers/vfio/vfio_iommu_type1.c, it feels like
> MSIX BAR mappings can always be allowed for the type1 IOMMU as
> vfio_iommu_type1_attach_group() performs this check:
> 
> msi_remap = resv_msi ? irq_domain_check_msi_remap() :
>     iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
> 
> and simply does not proceed if MSI remap is not supported. Is that correct
> or I miss something here? Thanks.

The MSI code in type1 has absolutely nothing to do with BAR mappings.
That's looking at how MSI is handled by the IOMMU, whether it needs a
reserved mapping area and whether MSI writes have source ID
validation.  Thanks,

Alex
