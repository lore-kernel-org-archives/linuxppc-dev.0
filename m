Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tChRB2vfnzDt1D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 18:54:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v4 0/4] powerpc/spapr/vfio: Put pages on VFIO
 container shutdown
In-Reply-To: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
Date: Tue, 08 Nov 2016 18:54:28 +1100
Message-ID: <871syml83v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> These patches are to fix a bug when pages stay pinned hours
> after QEMU which requested pinning exited.
>
> Please comment. Thanks.
>
> Alexey Kardashevskiy (4):
>   powerpc/iommu: Pass mm_struct to init/cleanup helpers
>   powerpc/iommu: Stop using @current in mm_iommu_xxx
>   vfio/spapr: Reference mm in tce_container
>   powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown
>
>  arch/powerpc/include/asm/mmu_context.h |  20 ++--
>  arch/powerpc/kernel/setup-common.c     |   2 +-
>  arch/powerpc/mm/mmu_context_book3s64.c |   6 +-
>  arch/powerpc/mm/mmu_context_iommu.c    |  60 ++++-------
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 181 ++++++++++++++++++++++-----------
>  5 files changed, 154 insertions(+), 115 deletions(-)


Alex, given the diffstat how do you want to merge this? (for 4.10)

Should I merge it, you merge it, or I can put it in a topic branch?

cheers
