Return-Path: <paolo.bonzini@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9HRK0vjqzDvQZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 21:01:17 +1100 (AEDT)
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t9HRJ1V4Gz9vFx
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2016 21:01:16 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id c17so3071175wmc.3
 for <linuxppc-dev@ozlabs.org>; Fri, 04 Nov 2016 03:01:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] vfio: Fix build break when SPAPR_TCE_IOMMU=n
To: Michael Ellerman <mpe@ellerman.id.au>, alex.williamson@redhat.com
References: <1478238521-32203-1-git-send-email-mpe@ellerman.id.au>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, aik@ozlabs.ru, gwshan@linux.vnet.ibm.com
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81900126-f1aa-b480-c2fa-f0fa04d625c1@redhat.com>
Date: Fri, 4 Nov 2016 11:01:10 +0100
MIME-Version: 1.0
In-Reply-To: <1478238521-32203-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/11/2016 06:48, Michael Ellerman wrote:
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
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/vfio/Kconfig | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index da6e2ce77495..6b51a4ebed8a 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -6,12 +6,12 @@ config VFIO_IOMMU_TYPE1
>  config VFIO_IOMMU_SPAPR_TCE
>  	tristate
>  	depends on VFIO && SPAPR_TCE_IOMMU
> -	default n
> +	default VFIO

No need to depend on VFIO since you already have it in "default".  (I
assume you cannot use "default y" because "depends on" doesn't downgrade
"y" to "m" when VFIO is a module.

A shorthand is

	def_tristate VFIO && SPAPR_TCE_IOMMU

>  config VFIO_SPAPR_EEH
>  	tristate
>  	depends on EEH && VFIO_IOMMU_SPAPR_TCE
> -	default n
> +	default VFIO

Likewise:

	def_tristate VFIO_IOMMU_SPAPR_TCE && EEH

Thanks,

Paolo

>  config VFIO_VIRQFD
>  	tristate
> @@ -22,8 +22,6 @@ menuconfig VFIO
>  	tristate "VFIO Non-Privileged userspace driver framework"
>  	depends on IOMMU_API
>  	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
> -	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
> -	select VFIO_SPAPR_EEH if (PPC_POWERNV || PPC_PSERIES)
>  	select ANON_INODES
>  	help
>  	  VFIO provides a framework for secure userspace device drivers.
> 
