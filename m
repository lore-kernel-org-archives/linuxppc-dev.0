Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdn2B8pzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:53 +1000 (AEST)
In-Reply-To: <20170413070527.16989-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel] powerpc/powernv: Fix iommu table size calculation hook
 for small tables
Message-Id: <3wGTdn0hdzz9sNK@ozlabs.org>
Date: Mon,  1 May 2017 12:58:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-13 at 07:05:27 UTC, Alexey Kardashevskiy wrote:
> When the userspace requests a small TCE table (which takes less than
> the system page size) and more than 1 TCE level, the existing code
> returns a single page size which is a bug as each additional TCE level
> requires at least one page and this is what
> pnv_pci_ioda2_table_alloc_pages() does. And we end up seeing
> WARN_ON(!ret && ((*ptbl)->it_allocated_size != table_size))
> in drivers/vfio/vfio_iommu_spapr_tce.c.
> 
> This replaces incorrect _ALIGN_UP() (which aligns zero up to zero) with
> max_t() to fix the bug.
> 
> Besides removing WARN_ON(), there should be no other changes in
> behaviour.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e49a6a2173346d316c0e65d054a3cd

cheers
