Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqN190r2QzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:24:29 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 10:24:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A7C092CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:24:22 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K0OEa266060424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:24:22 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K0Nn4Y026888
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:23:50 +1000
Date: Wed, 20 Apr 2016 10:22:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 13/45] powerpc/powernv/ioda1: M64 support on P7IOC
Message-ID: <20160420002254.GA13506@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-14-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DF9AF.6020104@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570DF9AF.6020104@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 05:47:59PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>This enables M64 window on P7IOC, which has been enabled on PHB3.
>>Different from PHB3 where 16 M64 BARs are supported and each of
>>them can be owned by one particular PE# exclusively or divided
>>evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
>>of them are divided to 8 segments. So every P7IOC PHB supports
>>128 M64 segments in total. P7IOC has M64DT, which helps mapping
>>one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>M64DT, indicating that one M64 segment can only be pinned to the
>>fixed PE#. In order to have same code to support M64 on P7IOC and
>>PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
>>of them is pinned to the fixed PE# by bypassing the function of
>>M64DT. In turn, we just need different phb->init_m64() for P7IOC
>>and PHB3 to support M64.
>
>The comment is not quite correct - in addition to pnv_ioda1_init_m64(), you
>also need to hack pnv_ioda_pick_m64_pe().
>

Right, will talk about the changes to pnv_ioda_pick_m64_pe() in the
commit log of next revision.

>
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 86 +++++++++++++++++++++++++++++--
>>  arch/powerpc/platforms/powernv/pci.h      |  3 ++
>>  2 files changed, 86 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 1dc663a..8488238 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -246,6 +246,64 @@ static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
>>  	}
>>  }
>>
>>+static int pnv_ioda1_init_m64(struct pnv_phb *phb)
>>+{
>>+	struct resource *r;
>>+	int index;
>>+
>>+	/*
>>+	 * There are 16 M64 BARs, each of which has 8 segments. So
>>+	 * there are as many M64 segments as the maximum number of
>>+	 * PEs, which is 128.
>>+	 */
>>+	for (index = 0; index < PNV_IODA1_M64_NUM; index++) {
>>+		unsigned long base, segsz = phb->ioda.m64_segsize;
>>+		int64_t rc;
>>+
>>+		base = phb->ioda.m64_base +
>>+		       index * PNV_IODA1_M64_SEGS * segsz;
>>+		rc = opal_pci_set_phb_mem_window(phb->opal_id,
>>+				OPAL_M64_WINDOW_TYPE, index, base, 0,
>>+				PNV_IODA1_M64_SEGS * segsz);
>>+		if (rc != OPAL_SUCCESS) {
>>+			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
>>+				rc, phb->hose->global_number, index);
>>+			goto fail;
>>+		}
>>+
>>+		rc = opal_pci_phb_mmio_enable(phb->opal_id,
>>+				OPAL_M64_WINDOW_TYPE, index,
>>+				OPAL_ENABLE_M64_SPLIT);
>>+		if (rc != OPAL_SUCCESS) {
>>+			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
>>+				rc, phb->hose->global_number, index);
>>+			goto fail;
>>+		}
>>+	}
>>+
>>+	/*
>>+	 * Exclude the segment used by the reserved PE, which
>>+	 * is expected to be 0 or last supported PE#.
>>+	 */
>>+	r = &phb->hose->mem_resources[1];
>>+	if (phb->ioda.reserved_pe_idx == 0)
>>+		r->start += phb->ioda.m64_segsize;
>>+	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
>>+		r->end -= phb->ioda.m64_segsize;
>>+	else
>>+		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
>>+			phb->ioda.reserved_pe_idx);
>>+
>>+	return 0;
>>+
>>+fail:
>>+	for ( ; index >= 0; index--)
>>+		opal_pci_phb_mmio_enable(phb->opal_id,
>>+			OPAL_M64_WINDOW_TYPE, index, OPAL_DISABLE_M64);
>>+
>>+	return -EIO;
>>+}
>>+
>>  static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
>>  				    unsigned long *pe_bitmap,
>>  				    bool all)
>>@@ -315,6 +373,26 @@ static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>  			pe->master = master_pe;
>>  			list_add_tail(&pe->list, &master_pe->slaves);
>>  		}
>>+
>>+		/*
>>+		 * P7IOC supports M64DT, which helps mapping M64 segment
>>+		 * to one particular PE#. However, PHB3 has fixed mapping
>>+		 * between M64 segment and PE#. In order to have same logic
>>+		 * for P7IOC and PHB3, we enforce fixed mapping between M64
>>+		 * segment and PE# on P7IOC.
>>+		 */
>>+		if (phb->type == PNV_PHB_IODA1) {
>>+			int64_t rc;
>>+
>>+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>+					pe->pe_number, OPAL_M64_WINDOW_TYPE,
>>+					pe->pe_number / PNV_IODA1_M64_SEGS,
>>+					pe->pe_number % PNV_IODA1_M64_SEGS);
>>+			if (rc != OPAL_SUCCESS)
>>+				pr_warn("%s: Error %lld mapping M64 for PHB#%d-PE#%d\n",
>>+					__func__, rc, phb->hose->global_number,
>>+					pe->pe_number);
>>+		}
>
>
>Cannot this go to pnv_ioda1_init_m64()? From the commit log I understood that
>this setup is supposed to be static so it can be done once. Or it is sort of
>enable/disable PE? Then make is a helper and call it ioda1_pe_enable() or
>something.
>

No, we cannot. This associates the M64 segments with the PE# and it can be
done in pnv_ioda1_init_m64() where PE# is unknown. I don't understand what
you meant by "sort of enable/disable PE". PE starts the jurney when PELTM
has the corresponding mapping and it doesn't depend on M64 mapping necessarily.

>
>>  	}
>>
>>  	kfree(pe_alloc);
>>@@ -329,8 +407,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>  	const u32 *r;
>>  	u64 pci_addr;
>>
>>-	/* FIXME: Support M64 for P7IOC */
>>-	if (phb->type != PNV_PHB_IODA2) {
>>+	if (phb->type != PNV_PHB_IODA1 && phb->type != PNV_PHB_IODA2) {
>>  		pr_info("  Not support M64 window\n");
>>  		return;
>>  	}
>>@@ -364,7 +441,10 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>
>>  	/* Use last M64 BAR to cover M64 window */
>>  	phb->ioda.m64_bar_idx = 15;
>>-	phb->init_m64 = pnv_ioda2_init_m64;
>>+	if (phb->type == PNV_PHB_IODA1)
>>+		phb->init_m64 = pnv_ioda1_init_m64;
>>+	else
>>+		phb->init_m64 = pnv_ioda2_init_m64;
>>  	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
>>  	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
>>  }
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 866a5ea..00539ff 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -82,6 +82,9 @@ struct pnv_ioda_pe {
>>  	struct list_head	list;
>>  };
>>
>>+#define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs   */
>>+#define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR */
>>+
>
>Why here, not in the beginning of arch/powerpc/platforms/powernv/pci-ioda.c ?
>It exposes symbols but nothing is using them (except pci-ioda.c) and code
>browsing gets bit more inconvenient.
>

It would be personal taste: those macros is tied with the definition
of "struct pnv_ioda_pe" or "struct pnv_ioda_phb". On the other hand,
those macros have to be in the header file once we split pci-ioda.c
to multiple source files some day. However, I can move them to
pci-ioda.c if you really want see them there. Let me know anyway.

>
>>  #define PNV_PHB_FLAG_EEH	(1 << 0)
>>
>>  struct pnv_phb {
>>
>
>
>-- 
>Alexey
>
