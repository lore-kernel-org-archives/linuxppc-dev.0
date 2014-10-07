Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F2801A179F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 09:59:05 +1100 (EST)
In-Reply-To: <1412678902-18672-9-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,
 08/16] powerpc/powerpc: Add new PCIe functions for allocating cxl
 interrupts
Message-Id: <20141007225905.0F85514011E@ozlabs.org>
Date: Wed,  8 Oct 2014 09:59:04 +1100 (EST)
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anton@samba.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-10 at 10:48:14 UTC, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This adds a number of functions for allocating IRQs under powernv PCIe for cxl.
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index baf3de6..3b67010b 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -38,6 +38,8 @@
>  #include <asm/debug.h>
>  #include <asm/firmware.h>
>  
> +#include <misc/cxl.h>

You should be including pnv-pci.h here.

Otherwise the header and the implementation could get out of sync, it will also
fix these:

  arch/powerpc/platforms/powernv/pci-ioda.c:1365:5: warning: symbol 'pnv_phb_to_cxl' was not declared. Should it be static?
  arch/powerpc/platforms/powernv/pci-ioda.c:1389:5: warning: symbol 'pnv_cxl_alloc_hwirqs' was not declared. Should it be static?
  arch/powerpc/platforms/powernv/pci-ioda.c:1404:6: warning: symbol 'pnv_cxl_release_hwirqs' was not declared. Should it be static?
  arch/powerpc/platforms/powernv/pci-ioda.c:1413:6: warning: symbol 'pnv_cxl_release_hwirq_ranges' was not declared. Should it be static?
  arch/powerpc/platforms/powernv/pci-ioda.c:1433:5: warning: symbol 'pnv_cxl_alloc_hwirq_ranges' was not declared. Should it be static?
  arch/powerpc/platforms/powernv/pci-ioda.c:1470:5: warning: symbol 'pnv_cxl_get_irq_count' was not declared. Should it be static?
  arch/powerpc/platforms/powernv/pci-ioda.c:1479:5: warning: symbol 'pnv_cxl_ioda_msi_setup' was not declared. Should it be static?

cheers
