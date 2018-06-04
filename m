Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgf32fzzF0jn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:26 +1000 (AEST)
In-Reply-To: <20180530092250.28981-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [kernel] powerpc/powernv/ioda2: Remove redundand free of TCE pages
Message-Id: <40zxgf0h8yz9s5c@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 09:22:50 UTC, Alexey Kardashevskiy wrote:
> When IODA2 creates a PE, it creates an IOMMU table with it_ops::free
> set to pnv_ioda2_table_free() which calls pnv_pci_ioda2_table_free_pages().
> 
> Since iommu_tce_table_put() calls it_ops::free when the last reference
> to the table is released, explicit call to pnv_pci_ioda2_table_free_pages()
> is not needed so let's remove it.
> 
> This should fix double free in the case of PCI hotuplug as
> pnv_pci_ioda2_table_free_pages() does not reset neither
> iommu_table::it_base nor ::it_size.
> 
> This was not exposed by SRIOV as it uses different code path via
> pnv_pcibios_sriov_disable().
> 
> IODA1 does not inialize it_ops::free so it does not have this issue.
> 
> Fixes: c5f7700bb "powerpc/powernv: Dynamically release PE"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/98fd72fe82527fd26618062b60cfd3

cheers
