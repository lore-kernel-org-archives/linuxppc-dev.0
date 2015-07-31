Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FB31A18E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 14:13:32 +1000 (AEST)
In-Reply-To: <1437389151-4042-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel] powerpc/powernv/ioda2: Fix calculation for memory
 allocated for TCE table
Message-Id: <20150731041332.25C1D140321@ozlabs.org>
Date: Fri, 31 Jul 2015 14:13:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-20-07 at 10:45:51 UTC, Alexey Kardashevskiy wrote:
> The existing code stores the amount of memory allocated for a TCE table.
> At the moment it uses @offset which is a virtual offset in the TCE table
> which is only correct for a one level tables and it does not include
> memory allocated for intermediate levels. When multilevel TCE table is
> requested, WARN_ON in tce_iommu_create_table() prints a warning.
> 
> This adds an additional counter to pnv_pci_ioda2_table_do_alloc_pages()
> to count actually allocated memory.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3ba3a73e9f204ce7904c

cheers
