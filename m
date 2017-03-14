Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjMv96GzdzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 04:59:33 +1100 (AEDT)
Date: Tue, 14 Mar 2017 11:59:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v8 00/10] powerpc/kvm/vfio: Enable in-kernel
 acceleration
Message-ID: <20170314115922.6f1fbdb8@t450s.home>
In-Reply-To: <20170314005533.GC12564@umbus.fritz.box>
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310044813.GB3167@umbus.fritz.box>
 <0c355414-253f-2ceb-b45e-90d8c01fafdf@ozlabs.ru>
 <20170314005533.GC12564@umbus.fritz.box>
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

On Tue, 14 Mar 2017 11:55:33 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Mar 14, 2017 at 11:54:03AM +1100, Alexey Kardashevskiy wrote:
> > On 10/03/17 15:48, David Gibson wrote:  
> > > On Fri, Mar 10, 2017 at 02:53:27PM +1100, Alexey Kardashevskiy wrote:  
> > >> This is my current queue of patches to add acceleration of TCE
> > >> updates in KVM.
> > >>
> > >> This is based on Linus'es tree sha1 c1aa905a304e.  

Hmm, sure about that?  03/10 doesn't apply.

> > > 
> > > I think we're finally there - I've now sent an R-b for all patches.  
> > 
> > Thanks for the patience.
> > 
> > 
> > I supposed in order to proceed now I need an ack from Alex, correct?  
> 
> That, or simply for him to merge it.

Given the diffstat, I'd guess you're looking for acks from me and maybe
Paolo, but it looks like it should be merged through ppc trees.  Thanks,

Alex

> > >>
> > >> Please comment. Thanks.
> > >>
> > >> Changes:
> > >> v8:
> > >> * kept fixing oddities with error handling in 10/10
> > >>
> > >> v7:
> > >> * added realmode's WARN_ON_ONCE_RM in arch/powerpc/kvm/book3s_64_vio_hv.c
> > >>
> > >> v6:
> > >> * reworked the last patch in terms of error handling and parameters checking
> > >>
> > >> v5:
> > >> * replaced "KVM: PPC: Separate TCE validation from update" with
> > >> "KVM: PPC: iommu: Unify TCE checking"
> > >> * changed already reviewed "powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal"
> > >> * reworked "KVM: PPC: VFIO: Add in-kernel acceleration for VFIO"
> > >> * more details in individual commit logs
> > >>
> > >> v4:
> > >> * addressed comments from v3
> > >> * updated subject lines with correct component names
> > >> * regrouped the patchset in order:
> > >> 	- powerpc fixes;
> > >> 	- vfio_spapr_tce driver fixes;
> > >> 	- KVM/PPC fixes;
> > >> 	- KVM+PPC+VFIO;
> > >> * everything except last 2 patches have "Reviewed-By: David"
> > >>
> > >> v3:
> > >> * there was no full repost, only last patch was posted
> > >>
> > >> v2:
> > >> * 11/11 reworked to use new notifiers, it is rather RFC as it still has
> > >> a issue;
> > >> * got 09/11, 10/11 to use notifiers in 11/11;
> > >> * added rb: David to most of patches and added a comment in 05/11.
> > >>
> > >> Alexey Kardashevskiy (10):
> > >>   powerpc/mmu: Add real mode support for IOMMU preregistered memory
> > >>   powerpc/powernv/iommu: Add real mode version of
> > >>     iommu_table_ops::exchange()
> > >>   powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal
> > >>   powerpc/vfio_spapr_tce: Add reference counting to iommu_table
> > >>   KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
> > >>   KVM: PPC: Enable IOMMU_API for KVM_BOOK3S_64 permanently
> > >>   KVM: PPC: Pass kvm* to kvmppc_find_table()
> > >>   KVM: PPC: Use preregistered memory API to access TCE list
> > >>   KVM: PPC: iommu: Unify TCE checking
> > >>   KVM: PPC: VFIO: Add in-kernel acceleration for VFIO
> > >>
> > >>  Documentation/virtual/kvm/devices/vfio.txt |  22 +-
> > >>  arch/powerpc/include/asm/iommu.h           |  32 ++-
> > >>  arch/powerpc/include/asm/kvm_host.h        |   8 +
> > >>  arch/powerpc/include/asm/kvm_ppc.h         |  12 +-
> > >>  arch/powerpc/include/asm/mmu_context.h     |   4 +
> > >>  include/uapi/linux/kvm.h                   |   9 +
> > >>  arch/powerpc/kernel/iommu.c                |  86 +++++---
> > >>  arch/powerpc/kvm/book3s_64_vio.c           | 330 ++++++++++++++++++++++++++++-
> > >>  arch/powerpc/kvm/book3s_64_vio_hv.c        | 303 ++++++++++++++++++++++----
> > >>  arch/powerpc/kvm/powerpc.c                 |   2 +
> > >>  arch/powerpc/mm/mmu_context_iommu.c        |  39 ++++
> > >>  arch/powerpc/platforms/powernv/pci-ioda.c  |  46 ++--
> > >>  arch/powerpc/platforms/powernv/pci.c       |   1 +
> > >>  arch/powerpc/platforms/pseries/iommu.c     |   3 +-
> > >>  arch/powerpc/platforms/pseries/vio.c       |   2 +-
> > >>  drivers/vfio/vfio_iommu_spapr_tce.c        |   2 +-
> > >>  virt/kvm/vfio.c                            |  60 ++++++
> > >>  arch/powerpc/kvm/Kconfig                   |   1 +
> > >>  18 files changed, 855 insertions(+), 107 deletions(-)
> > >>  
> > >   
> > 
> >   
> 
> 
> 
> 
