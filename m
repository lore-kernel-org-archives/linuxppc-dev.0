Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpsTn1hlyzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 14:29:01 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id c20so2438643pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:29:01 -0700 (PDT)
Subject: Re: [PATCH v8 22/45] powerpc/powernv/ioda1: Support releasing IODA1
 TCE table
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-23-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715B403.7050408@ozlabs.ru>
Date: Tue, 19 Apr 2016 14:28:51 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-23-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> pnv_pci_ioda_table_free_pages() can be reused to release the IODA1
> TCE table when releasing IODA1 PE in subsequent patches.
>
> This renames the following functions to support releasing IODA1 TCE
> table: pnv_pci_ioda2_table_free_pages() to pnv_pci_ioda_table_free_pages(),
> pnv_pci_ioda2_table_do_free_pages() to pnv_pci_ioda_table_do_free_pages().
> No logical changes introduced.

I can only see renaming here but it seems (from 
IODA_architecture_04-14-2008.pdf) that IODA1 does not support multi-level 
TCE tables in the way IODA2 does.


>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index d360607..077f9db 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -51,7 +51,7 @@
>   #define POWERNV_IOMMU_DEFAULT_LEVELS	1
>   #define POWERNV_IOMMU_MAX_LEVELS	5
>
> -static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
> +static void pnv_pci_ioda_table_free_pages(struct iommu_table *tbl);
>
>   static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>   			    const char *fmt, ...)
> @@ -1352,7 +1352,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
>   		iommu_group_put(pe->table_group.group);
>   		BUG_ON(pe->table_group.group);
>   	}
> -	pnv_pci_ioda2_table_free_pages(tbl);
> +	pnv_pci_ioda_table_free_pages(tbl);
>   	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>   }
>
> @@ -1946,7 +1946,7 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
>
>   static void pnv_ioda2_table_free(struct iommu_table *tbl)
>   {
> -	pnv_pci_ioda2_table_free_pages(tbl);
> +	pnv_pci_ioda_table_free_pages(tbl);
>   	iommu_free_table(tbl, "pnv");
>   }
>
> @@ -2448,7 +2448,7 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift,
>   	return addr;
>   }
>
> -static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
> +static void pnv_pci_ioda_table_do_free_pages(__be64 *addr,
>   		unsigned long size, unsigned level);
>
>   static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
> @@ -2487,7 +2487,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>   	 * release partially allocated table.
>   	 */
>   	if (offset < tce_table_size) {
> -		pnv_pci_ioda2_table_do_free_pages(addr,
> +		pnv_pci_ioda_table_do_free_pages(addr,
>   				1ULL << (level_shift - 3), levels - 1);
>   		return -ENOMEM;
>   	}
> @@ -2505,7 +2505,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>   	return 0;
>   }
>
> -static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
> +static void pnv_pci_ioda_table_do_free_pages(__be64 *addr,
>   		unsigned long size, unsigned level)
>   {
>   	const unsigned long addr_ul = (unsigned long) addr &
> @@ -2521,7 +2521,7 @@ static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
>   			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
>   				continue;
>
> -			pnv_pci_ioda2_table_do_free_pages(__va(hpa), size,
> +			pnv_pci_ioda_table_do_free_pages(__va(hpa), size,
>   					level - 1);
>   		}
>   	}
> @@ -2529,7 +2529,7 @@ static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
>   	free_pages(addr_ul, get_order(size << 3));
>   }
>
> -static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
> +static void pnv_pci_ioda_table_free_pages(struct iommu_table *tbl)
>   {
>   	const unsigned long size = tbl->it_indirect_levels ?
>   			tbl->it_level_size : tbl->it_size;
> @@ -2537,7 +2537,7 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
>   	if (!tbl->it_size)
>   		return;
>
> -	pnv_pci_ioda2_table_do_free_pages((__be64 *)tbl->it_base, size,
> +	pnv_pci_ioda_table_do_free_pages((__be64 *)tbl->it_base, size,
>   			tbl->it_indirect_levels);
>   }
>
>


-- 
Alexey
