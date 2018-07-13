Return-Path: <aik@ozlabs.ru>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RhBc0J9lzF35k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 15:27:02 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id p23-v6so4462181pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 22:27:02 -0700 (PDT)
Date: Fri, 13 Jul 2018 15:26:51 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel v3 0/6] powerpc/powernv/iommu: Optimize memory use
Message-ID: <20180713152651.678b457d@aik.ozlabs.ibm.com>
In-Reply-To: <20180704061349.20742-1-aik@ozlabs.ru>
References: <20180704061349.20742-1-aik@ozlabs.ru>
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

On Wed,  4 Jul 2018 16:13:43 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This patchset aims to reduce actual memory use for guests with
> sparse memory. The pseries guest uses dynamic DMA windows to map
> the entire guest RAM but it only actually maps onlined memory
> which may be not be contiguous. I hit this when tried passing
> through NVLink2-connected GPU RAM of NVIDIA V100 and trying to
> map this RAM at the same offset as in the real hardware
> forced me to rework I handle these windows.
> 
> This moves userspace-to-host-physical translation table
> (iommu_table::it_userspace) from VFIO TCE IOMMU subdriver to
> the platform code and reuses the already existing multilevel
> TCE table code which we have for the hardware tables.
> At last in 6/6 I switch to on-demand allocation so we do not
> allocate huge chunks of the table if we do not have to;
> there is some math in 6/6.
> 
> Changes:
> v3:
> * rebased on v4.18-rc3 and fixed compile error in 6/6
> 
> v2:
> * bugfix and error handling in 6/6
> 
> 
> This is based on sha1
> 021c917 Linus Torvalds "Linux 4.18-rc3".
> 
> Please comment. Thanks.


Ping?

> 
> 
> 
> Alexey Kardashevskiy (6):
>   powerpc/powernv: Remove useless wrapper
>   powerpc/powernv: Move TCE manupulation code to its own file
>   KVM: PPC: Make iommu_table::it_userspace big endian
>   powerpc/powernv: Add indirect levels to it_userspace
>   powerpc/powernv: Rework TCE level allocation
>   powerpc/powernv/ioda: Allocate indirect TCE levels on demand
> 
>  arch/powerpc/platforms/powernv/Makefile       |   2 +-
>  arch/powerpc/include/asm/iommu.h              |  11 +-
>  arch/powerpc/platforms/powernv/pci.h          |  44 ++-
>  arch/powerpc/kvm/book3s_64_vio.c              |  11 +-
>  arch/powerpc/kvm/book3s_64_vio_hv.c           |  18 +-
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 399 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c     | 184 ++----------
>  arch/powerpc/platforms/powernv/pci.c          | 158 ----------
>  drivers/vfio/vfio_iommu_spapr_tce.c           |  65 +----
>  9 files changed, 478 insertions(+), 414 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/pci-ioda-tce.c



--
Alexey
