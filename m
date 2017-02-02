Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDZxm0bsYzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 20:50:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: alex.williamson@redhat.com
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] vfio: Fix build break when SPAPR_TCE_IOMMU=n
In-Reply-To: <1478238521-32203-1-git-send-email-mpe@ellerman.id.au>
References: <1478238521-32203-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 02 Feb 2017 20:50:48 +1100
Message-ID: <87shnwc45j.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> Currently the kconfig logic for VFIO_IOMMU_SPAPR_TCE and VFIO_SPAPR_EEH
> is broken when SPAPR_TCE_IOMMU=n. Leading to:
>
>     warning: (VFIO) selects VFIO_IOMMU_SPAPR_TCE which has unmet direct dependencies (VFIO && SPAPR_TCE_IOMMU)
>     warning: (VFIO) selects VFIO_IOMMU_SPAPR_TCE which has unmet direct dependencies (VFIO && SPAPR_TCE_IOMMU)
>     drivers/vfio/vfio_iommu_spapr_tce.c:113:8: error: implicit declaration of function 'mm_iommu_find'
>
> This stems from the fact that VFIO selects VFIO_IOMMU_SPAPR_TCE, and
> although it has an if clause, the condition is not correct.
>
> We could fix it by doing select VFIO_IOMMU_SPAPR_TCE if SPAPR_TCE_IOMMU,
> but the cleaner fix is to drop the selects and tie VFIO_IOMMU_SPAPR_TCE
> to the value of VFIO, and express the dependencies in only once place.
>
> Do the same for VFIO_SPAPR_EEH.
>
> The end result is that the values of VFIO_IOMMU_SPAPR_TCE and
> VFIO_SPAPR_EEH follow the value of VFIO, except when SPAPR_TCE_IOMMU=n
> and/or EEH=n. Which is exactly what we want to happen.

Ping?

There was a bit of discussion on this patch but I think we decided it
was correct in the end.

cheers
