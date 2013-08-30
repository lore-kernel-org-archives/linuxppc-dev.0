Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f46.google.com (mail-pb0-f46.google.com
 [209.85.160.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5F172C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 20:27:04 +1000 (EST)
Received: by mail-pb0-f46.google.com with SMTP id rq2so1702385pbb.19
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 03:27:02 -0700 (PDT)
Message-ID: <5220736E.5050503@ozlabs.ru>
Date: Fri, 30 Aug 2013 20:26:54 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Gleb Natapov <gleb@redhat.com>
Subject: Re: [PATCH v9 00/13] KVM: PPC: IOMMU in-kernel handling of VFIO
References: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/28/2013 06:37 PM, Alexey Kardashevskiy wrote:
> This accelerates VFIO DMA operations on POWER by moving them
> into kernel.
> 
> This depends on VFIO external API patch which is on its way to upstream.
> 
> Changes:
> v9:
> * replaced the "link logical bus number to IOMMU group" ioctl to KVM
> with a KVM device doing the same thing, i.e. the actual changes are in
> these 3 patches:
>   KVM: PPC: reserve a capability and KVM device type for realmode VFIO
>   KVM: PPC: remove warning from kvmppc_core_destroy_vm
>   KVM: PPC: Add support for IOMMU in-kernel handling
> 
> * moved some VFIO external API bits to a separate patch to reduce the size
> of the "KVM: PPC: Add support for IOMMU in-kernel handling" patch
> 
> * fixed code style problems reported by checkpatch.pl.
> 
> v8:
> * fixed comments about capabilities numbers
> 
> v7:
> * rebased on v3.11-rc3.
> * VFIO external user API will go through VFIO tree so it is
> excluded from this series.
> * As nobody ever reacted on "hashtable: add hash_for_each_possible_rcu_notrace()",
> Ben suggested to push it via his tree so I included it to the series.
> * realmode_(get|put)_page is reworked.
> 
> More details in the individual patch comments.
> 
> Alexey Kardashevskiy (13):
>   KVM: PPC: POWERNV: move iommu_add_device earlier
>   hashtable: add hash_for_each_possible_rcu_notrace()
>   KVM: PPC: reserve a capability number for multitce support
>   KVM: PPC: reserve a capability and KVM device type for realmode VFIO


Hi Gleb!

Could you please review and pick (if they are ok) the two "capability"
patches from above?

It would be cool if you also looked at "KVM: PPC: Add support for IOMMU
in-kernel handling", the part about KVM device for SPAPR TCE IOMMU table.

Thanks!



>   powerpc: Prepare to support kernel handling of IOMMU map/unmap
>   powerpc: add real mode support for dma operations on powernv
>   KVM: PPC: enable IOMMU_API for KVM_BOOK3S_64 permanently
>   KVM: PPC: Add support for multiple-TCE hcalls
>   powerpc/iommu: rework to support realmode
>   KVM: PPC: remove warning from kvmppc_core_destroy_vm
>   KVM: PPC: add trampolines for VFIO external API
>   KVM: PPC: Add support for IOMMU in-kernel handling
>   KVM: PPC: Add hugepage support for IOMMU in-kernel handling
> 
>  Documentation/virtual/kvm/api.txt                  |  26 +
>  .../virtual/kvm/devices/spapr_tce_iommu.txt        |  37 ++
>  arch/powerpc/include/asm/iommu.h                   |  18 +-
>  arch/powerpc/include/asm/kvm_host.h                |  38 ++
>  arch/powerpc/include/asm/kvm_ppc.h                 |  16 +-
>  arch/powerpc/include/asm/machdep.h                 |  12 +
>  arch/powerpc/include/asm/pgtable-ppc64.h           |   2 +
>  arch/powerpc/include/uapi/asm/kvm.h                |   8 +
>  arch/powerpc/kernel/iommu.c                        | 243 +++++----
>  arch/powerpc/kvm/Kconfig                           |   1 +
>  arch/powerpc/kvm/book3s_64_vio.c                   | 597 ++++++++++++++++++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c                | 408 +++++++++++++-
>  arch/powerpc/kvm/book3s_hv.c                       |  42 +-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   8 +-
>  arch/powerpc/kvm/book3s_pr_papr.c                  |  35 ++
>  arch/powerpc/kvm/powerpc.c                         |   4 +
>  arch/powerpc/mm/init_64.c                          |  50 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c          |  57 +-
>  arch/powerpc/platforms/powernv/pci-p5ioc2.c        |   2 +-
>  arch/powerpc/platforms/powernv/pci.c               |  75 ++-
>  arch/powerpc/platforms/powernv/pci.h               |   3 +-
>  arch/powerpc/platforms/pseries/iommu.c             |   8 +-
>  include/linux/hashtable.h                          |  15 +
>  include/linux/kvm_host.h                           |   1 +
>  include/linux/mm.h                                 |  14 +
>  include/linux/page-flags.h                         |   4 +-
>  include/uapi/linux/kvm.h                           |   3 +
>  virt/kvm/kvm_main.c                                |   5 +
>  28 files changed, 1564 insertions(+), 168 deletions(-)
>  create mode 100644 Documentation/virtual/kvm/devices/spapr_tce_iommu.txt
> 


-- 
Alexey
