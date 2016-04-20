Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqP8z3X9mzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:16:19 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 11:16:19 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B75823578066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:16:16 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K1G82i8716784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:16:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K1FgmG032274
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 11:15:43 +1000
Date: Wed, 20 Apr 2016 11:15:17 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 22/45] powerpc/powernv/ioda1: Support releasing IODA1
 TCE table
Message-ID: <20160420011517.GB21871@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-23-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715B403.7050408@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715B403.7050408@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 19, 2016 at 02:28:51PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>pnv_pci_ioda_table_free_pages() can be reused to release the IODA1
>>TCE table when releasing IODA1 PE in subsequent patches.
>>
>>This renames the following functions to support releasing IODA1 TCE
>>table: pnv_pci_ioda2_table_free_pages() to pnv_pci_ioda_table_free_pages(),
>>pnv_pci_ioda2_table_do_free_pages() to pnv_pci_ioda_table_do_free_pages().
>>No logical changes introduced.
>
>I can only see renaming here but it seems (from
>IODA_architecture_04-14-2008.pdf) that IODA1 does not support multi-level TCE
>tables in the way IODA2 does.
>

Note that the change was proposed by you in last round. Yes, TVE on P7IOC
doesn't support multiple levels of TCE tables. In this case, we will always
have "tbl->it_indirect_levels" to 1, right?

>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index d360607..077f9db 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -51,7 +51,7 @@
>>  #define POWERNV_IOMMU_DEFAULT_LEVELS	1
>>  #define POWERNV_IOMMU_MAX_LEVELS	5
>>
>>-static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
>>+static void pnv_pci_ioda_table_free_pages(struct iommu_table *tbl);
>>
>>  static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>>  			    const char *fmt, ...)
>>@@ -1352,7 +1352,7 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
>>  		iommu_group_put(pe->table_group.group);
>>  		BUG_ON(pe->table_group.group);
>>  	}
>>-	pnv_pci_ioda2_table_free_pages(tbl);
>>+	pnv_pci_ioda_table_free_pages(tbl);
>>  	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>>  }
>>
>>@@ -1946,7 +1946,7 @@ static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
>>
>>  static void pnv_ioda2_table_free(struct iommu_table *tbl)
>>  {
>>-	pnv_pci_ioda2_table_free_pages(tbl);
>>+	pnv_pci_ioda_table_free_pages(tbl);
>>  	iommu_free_table(tbl, "pnv");
>>  }
>>
>>@@ -2448,7 +2448,7 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift,
>>  	return addr;
>>  }
>>
>>-static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
>>+static void pnv_pci_ioda_table_do_free_pages(__be64 *addr,
>>  		unsigned long size, unsigned level);
>>
>>  static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>>@@ -2487,7 +2487,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>>  	 * release partially allocated table.
>>  	 */
>>  	if (offset < tce_table_size) {
>>-		pnv_pci_ioda2_table_do_free_pages(addr,
>>+		pnv_pci_ioda_table_do_free_pages(addr,
>>  				1ULL << (level_shift - 3), levels - 1);
>>  		return -ENOMEM;
>>  	}
>>@@ -2505,7 +2505,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>>  	return 0;
>>  }
>>
>>-static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
>>+static void pnv_pci_ioda_table_do_free_pages(__be64 *addr,
>>  		unsigned long size, unsigned level)
>>  {
>>  	const unsigned long addr_ul = (unsigned long) addr &
>>@@ -2521,7 +2521,7 @@ static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
>>  			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
>>  				continue;
>>
>>-			pnv_pci_ioda2_table_do_free_pages(__va(hpa), size,
>>+			pnv_pci_ioda_table_do_free_pages(__va(hpa), size,
>>  					level - 1);
>>  		}
>>  	}
>>@@ -2529,7 +2529,7 @@ static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
>>  	free_pages(addr_ul, get_order(size << 3));
>>  }
>>
>>-static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
>>+static void pnv_pci_ioda_table_free_pages(struct iommu_table *tbl)
>>  {
>>  	const unsigned long size = tbl->it_indirect_levels ?
>>  			tbl->it_level_size : tbl->it_size;
>>@@ -2537,7 +2537,7 @@ static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
>>  	if (!tbl->it_size)
>>  		return;
>>
>>-	pnv_pci_ioda2_table_do_free_pages((__be64 *)tbl->it_base, size,
>>+	pnv_pci_ioda_table_do_free_pages((__be64 *)tbl->it_base, size,
>>  			tbl->it_indirect_levels);
>>  }
>>
>>
>
>
>-- 
>Alexey
>
