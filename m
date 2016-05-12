Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59p30593zDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:32:43 +1000 (AEST)
In-Reply-To: <1463032030-38974-2-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [kernel,1/2] powerpc/powernv: Fix insufficient memory allocation
Message-Id: <3r59p252j6z9t7V@ozlabs.org>
Date: Thu, 12 May 2016 21:32:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-05 at 05:47:09 UTC, Alexey Kardashevskiy wrote:
> The pnv_pci_init_ioda_phb() helper allocates a blob to store auxilary
> data such PE and M32/M64 segment allocation maps; this single blob has few
> partitions, size of each is derived from the PE number -
> phb->ioda.total_pe_num.
> 
> It was assumed that the minimum PE number is 8, however it is 4 for NPU
> so the pe_alloc part was missing in the allocated blob.
> It was invisible till recently as we were not tracking used M64 segments
> and NPUs do not use M32 segments so the phb->ioda.m32_segmap
> (which was pointing to the same address as phb->ioda.pe_alloc)
> has never been written to leaving the pe_alloc memory intact.
> 
> After 401203ac2d "powerpc/powernv: Track M64 segment consumption"
> the pe_alloc gets corrupted and PE allocation cannot work.
> This fixes the issue by enforcing the minimum PE number to 8.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/92a86756904b127a3450262b33

cheers
