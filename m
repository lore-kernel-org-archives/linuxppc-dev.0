Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB13F1A037B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 20:07:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 19:07:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 645FB2CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 20:07:44 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH97bwb33423418
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 20:07:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH97AhE014194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 20:07:11 +1100
Date: Tue, 17 Nov 2015 20:06:53 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 25/50] powerpc/powernv: Reserve PE for root bus
Message-ID: <20151117090653.GA20134@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-26-git-send-email-gwshan@linux.vnet.ibm.com>
 <564AC37A.2060701@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <564AC37A.2060701@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2015 at 05:04:42PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>We're going to reserve/assign PEs when pcibios_setup_bridge() is
>>called. The function won't be called for root bus as it doesn't
>>have parent bridge. However, the root bus still needs a PE to be
>>covered.
>>
>>This reserves PE numbers that are adjacent to the reserved one
>>for root buses.
>
>
>Somewhere in the patchset you need to describe why you need a separate PE for
>a root bus and why reserved_pe_idx is not enough for this.
>

Please confirm if it's fine to add the descrption in this patch's chagelog.

>
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 33 ++++++++++++++++++++++---------
>>  arch/powerpc/platforms/powernv/pci.h      |  1 +
>>  2 files changed, 25 insertions(+), 9 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index eea1c96..5e6745f 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -207,14 +207,14 @@ static int pnv_ioda2_init_m64(struct pnv_phb *phb)
>>  	set_bit(phb->ioda.m64_bar_idx, &phb->ioda.m64_bar_alloc);
>>
>>  	/*
>>-	 * Strip off the segment used by the reserved PE, which is
>>-	 * expected to be 0 or last one of PE capabicity.
>>+	 * Exclude the segments for reserved and root bus PE, which
>>+	 * are first or last two PEs.
>>  	 */
>>  	r = &phb->hose->mem_resources[1];
>>  	if (phb->ioda.reserved_pe_idx == 0)
>>-		r->start += phb->ioda.m64_segsize;
>>+		r->start += (2 * phb->ioda.m64_segsize);
>>  	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
>>-		r->end -= phb->ioda.m64_segsize;
>>+		r->end -= (2 * phb->ioda.m64_segsize);
>>  	else
>>  		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
>>  			phb->ioda.reserved_pe_idx);
>>@@ -294,14 +294,14 @@ static int pnv_ioda1_init_m64(struct pnv_phb *phb)
>>  	}
>>
>>  	/*
>>-	 * Exclude the segment used by the reserved PE, which
>>-	 * is expected to be 0 or last supported PE#.
>>+	 * Exclude the segments for reserved and root bus PE, which
>>+	 * are first or last two PEs.
>>  	 */
>>  	r = &phb->hose->mem_resources[1];
>>  	if (phb->ioda.reserved_pe_idx == 0)
>>-		r->start += phb->ioda.m64_segsize;
>>+		r->start += (2 * phb->ioda.m64_segsize);
>>  	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
>>-		r->end -= phb->ioda.m64_segsize;
>>+		r->end -= (2 * phb->ioda.m64_segsize);
>>  	else
>>  		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
>>  			phb->ioda.reserved_pe_idx);
>>@@ -3231,7 +3231,22 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  			phb->ioda.dma32_segmap[i] = IODA_INVALID_PE;
>>  	}
>>  	phb->ioda.pe_array = aux + pemap_off;
>>-	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>>+
>>+	/*
>>+	 * Choose PE number for root bus, which shouldn't have
>>+	 * M64 resources consumed by its child devices. To pick
>>+	 * the PE number adjacent to the reserved one if possible.
>>+	 */
>>+	pnv_ioda_reserve_pe(phb, phb->ioda.reserved_pe_idx);
>>+	if (phb->ioda.reserved_pe_idx == 0) {
>>+		phb->ioda.root_pe_idx = 1;
>>+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
>>+	} else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1)) {
>>+		phb->ioda.root_pe_idx = phb->ioda.reserved_pe_idx - 1;
>>+		pnv_ioda_reserve_pe(phb, phb->ioda.root_pe_idx);
>>+	} else {
>>+		phb->ioda.root_pe_idx = IODA_INVALID_PE;
>>+	}
>>
>>  	INIT_LIST_HEAD(&phb->ioda.pe_list);
>>  	mutex_init(&phb->ioda.pe_list_mutex);
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index e55ab0e..a8ba97f 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -120,6 +120,7 @@ struct pnv_phb {
>>  			/* Global bridge info */
>>  			unsigned int		total_pe_num;
>>  			unsigned int		reserved_pe_idx;
>>+			unsigned int		root_pe_idx;
>>
>>  			/* 32-bit MMIO window */
>>  			unsigned int		m32_size;
>>

Thanks,
Gavin
