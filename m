Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwfrg4cPPzDqYG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 15:50:43 +1000 (AEST)
In-Reply-To: <1468988811-49142-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, #@ozlabs.ru, 4.2+@ozlabs.ru,
 stable@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel] powerpc/powernv/ioda: Fix endianness when reading TCEs
Message-Id: <3rwfrg3pBPz9t0w@ozlabs.org>
Date: Fri, 22 Jul 2016 15:50:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-20-07 at 04:26:51 UTC, Alexey Kardashevskiy wrote:
> The iommu_table_ops::exchange() callback writes new TCE to the table
> and returns old value and permission mask. The old TCE value is
> correctly converted from BE to CPU endian; however permission mask
> was calculated from BE value and therefore always returned DMA_NONE
> which could cause memory leak on LE systems using VFIO SPAPR TCE IOMMU v1
> driver.
> 
> This fixes pnv_tce_xchg() to have @oldtce a CPU endian.
> 
> Fixes: 05c6cfb9dce0d13d37e9d007ee6a4af36f1c0a58
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/802a345183c0308aa64969cca6

cheers
