Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B0161A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:38:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 11 May 2015 14:38:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6C2B92CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:38:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B4cVsD17301730
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:38:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B4c7VJ004501
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:38:07 +1000
Date: Mon, 11 May 2015 14:37:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v4 02/21] powerpc/powernv: Enable M64 on P7IOC
Message-ID: <20150511043742.GA24743@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <554D5262.2030109@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <554D5262.2030109@ozlabs.ru>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 09, 2015 at 10:18:42AM +1000, Alexey Kardashevskiy wrote:
>On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>The patch enables M64 window on P7IOC, which has been enabled on
>>PHB3. Comparing to PHB3, there are 16 M64 BARs and each of them
>>are divided to 8 segments.
>
>"compared to something" means you will tell about PHB3 too :)
>

Ok. I'll add something about PHB3 in next revision.

>Do I understand correctly that IODA==IODA1==P7IOC  and P7IOC != IODA2? The
>code does not use "PHB3" or "P7IOC" acronym so it is a bit confusing.
>
>

Your understanding is correct.

>>So each PHB can support 128 M64 segments.
>>Also, P7IOC has M64DT, which helps mapping one particular M64
>>segment# to arbitrary PE#. However, we just provide 128 M64 (16 BARs)
>>segments and fixed mapping between PE# and M64 segment# in order
>>to keep same logic to support M64 for PHB3 and P7IOC. In turn, we
>>just need different phb->init_m64() hooks for P7IOC and PHB3.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 115 ++++++++++++++++++++++++++----
>>  1 file changed, 103 insertions(+), 12 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index f8bc950..646962f 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -165,6 +165,67 @@ static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
>>  	clear_bit(pe, phb->ioda.pe_alloc);
>>  }
>>
>>+static int pnv_ioda1_init_m64(struct pnv_phb *phb)
>>+{
>>+	struct resource *r;
>>+	int seg;
>>+	s64 rc;
>
>Here @rc is of the "s64" type.
>

Ok. I'll have "int64_t rc" as you pointed in the following replies.

>>+
>>+	/* Each PHB supports 16 separate M64 BARs, each of which are
>>+	 * divided into 8 segments. So there are number of M64 segments
>>+	 * as total PE#, which is 128.
>>+	 */
>
>"there are as many M64 segments as a maximum number of PEs which is 128"?
>

Thanks, your description is obviously more clear. I will have it in
next revision.

>>+	for (seg = 0; seg < phb->ioda.total_pe; seg += 8) {
>>+		unsigned long base;
>>+
>>+		base = phb->ioda.m64_base + seg * phb->ioda.m64_segsize;
>>+		rc = opal_pci_set_phb_mem_window(phb->opal_id,
>>+						 OPAL_M64_WINDOW_TYPE,
>>+						 seg / 8,
>>+						 base,
>>+						 0, /* unused */
>>+						 8 * phb->ioda.m64_segsize);
>>+		if (rc != OPAL_SUCCESS) {
>>+			pr_warn("  Failure %lld configuring M64 BAR#%d on PHB#%d\n",
>>+				rc, seg / 8, phb->hose->global_number);
>>+			goto fail;
>>+		}
>>+
>>+		rc = opal_pci_phb_mmio_enable(phb->opal_id,
>>+					      OPAL_M64_WINDOW_TYPE,
>>+					      seg / 8,
>>+					      OPAL_ENABLE_M64_SPLIT);
>>+		if (rc != OPAL_SUCCESS) {
>>+			pr_warn("  Failure %lld enabling M64 BAR#%d on PHB#%d\n",
>>+				rc, seg / 8, phb->hose->global_number);
>>+			goto fail;
>>+		}
>>+	}
>>+
>>+	/* Strip of the segment used by the reserved PE, which
>>+	 * is expected to be 0 or last supported PE#
>>+	 */
>>+	r = &phb->hose->mem_resources[1];
>
>mem_resources[0] is IO, mem_resources[1] is MMIO, mem_resources[2] is for
>what? Would be nice to have this commented somewhere.
>

The fixed layout is determined by skiboot firmware. mem_resource[2] is for
64-bits prefetchable MMIO. I'll see if I can put some comments about them
somewhere in next revision.

>>+	if (phb->ioda.reserved_pe == 0)
>>+		r->start += phb->ioda.m64_segsize;
>>+	else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1))
>>+		r->end -= phb->ioda.m64_segsize;
>>+	else
>>+		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
>>+			phb->ioda.reserved_pe);
>>+
>>+	return 0;
>>+
>>+fail:
>>+	for ( ; seg >= 0; seg -= 8)
>>+		opal_pci_phb_mmio_enable(phb->opal_id,
>>+					 OPAL_M64_WINDOW_TYPE,
>>+					 seg / 8,
>>+					 OPAL_DISABLE_M64);
>
>Out of curiosity - is not there a counterpart for
>opal_pci_set_phb_mem_window() for cleanup?
>
>

No.

>>+
>>+	return -EIO;
>>+}
>>+
>>  /* The default M64 BAR is shared by all PEs */
>>  static int pnv_ioda2_init_m64(struct pnv_phb *phb)
>>  {
>>@@ -222,7 +283,7 @@ fail:
>>  	return -EIO;
>>  }
>>
>>-static void pnv_ioda2_reserve_m64_pe(struct pnv_phb *phb)
>>+static void pnv_ioda_reserve_m64_pe(struct pnv_phb *phb)
>>  {
>>  	resource_size_t sgsz = phb->ioda.m64_segsize;
>>  	struct pci_dev *pdev;
>>@@ -248,8 +309,8 @@ static void pnv_ioda2_reserve_m64_pe(struct pnv_phb *phb)
>>  	}
>>  }
>>
>>-static int pnv_ioda2_pick_m64_pe(struct pnv_phb *phb,
>>-				 struct pci_bus *bus, int all)
>>+static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
>>+				struct pci_bus *bus, int all)
>>  {
>>  	resource_size_t segsz = phb->ioda.m64_segsize;
>>  	struct pci_dev *pdev;
>>@@ -346,6 +407,28 @@ done:
>>  			pe->master = master_pe;
>>  			list_add_tail(&pe->list, &master_pe->slaves);
>>  		}
>>+
>>+		/* P7IOC supports M64DT, which helps mapping M64 segment
>>+		 * to one particular PE#. Unfortunately, PHB3 has fixed
>
>Why is it "Unfortunately"? This is just the way it is :)
>

It's true that PHB3 is designed without M64DT while P7IOC has. I think
it's a nice thing providing more flexibility: Arbitrary M64 segment
can be mapped to any one PE# with its help. So I said "unfortunately" :-)

>>+		 * mapping between M64 segment and PE#. In order for same
>>+		 * logic for P7IOC and PHB3, we enforce fixed mapping
>>+		 * between M64 segment and PE# on P7IOC.
>>+		 */
>>+		if (phb->type == PNV_PHB_IODA1) {
>>+			int64_t rc;
>
>Here @rc is of the "int64_t" type. And this one and the one above are used
>for return code from OPAL API. Make them the same (int64_t or long, up to
>you).
>

Yep. It will be "int64_t rc" as I said above.

>>+
>>+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>+							 pe->pe_number,
>>+							 OPAL_M64_WINDOW_TYPE,
>>+							 pe->pe_number / 8,
>>+							 pe->pe_number % 8);
>>+			if (rc != OPAL_SUCCESS)
>>+				pr_warn("%s: Failure %lld mapping "
>>+					"M64 for PHB#%d-PE#%d\n",
>>+					__func__, rc,
>>+					phb->hose->global_number,
>>+					pe->pe_number);
>>+		}
>>  	}
>>
>>  	kfree(pe_alloc);
>>@@ -360,12 +443,6 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>  	const u32 *r;
>>  	u64 pci_addr;
>>
>>-	/* FIXME: Support M64 for P7IOC */
>>-	if (phb->type != PNV_PHB_IODA2) {
>>-		pr_info("  Not support M64 window\n");
>>-		return;
>>-	}
>>-
>>  	if (!firmware_has_feature(FW_FEATURE_OPALv3)) {
>>  		pr_info("  Firmware too old to support M64 window\n");
>>  		return;
>>@@ -394,9 +471,23 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>
>>  	/* Use last M64 BAR to cover M64 window */
>>  	phb->ioda.m64_bar_idx = 15;
>>-	phb->init_m64 = pnv_ioda2_init_m64;
>>-	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
>>-	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
>>+	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
>
>
>reserve_m64_pe() is called once from pnv_pci_ioda_setup_PEs() so it is
>IODA-only and in this case reserve_m64_pe != NULL and
>pnv_ioda_reserve_m64_pe() will be called always.
>
>In general, it feels like pnv_phb has too many callbacks while they could be
>just direct calls.
>

We will have another type of IODA compatible PHB soon. I'm not sure if it's
legal to reveal its name now. The new PHB won't have M64 support. I do think
callbacks give us more flexibility (for supporting M64 or not). Lets keep it.

>>+	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
>>+	switch (phb->type) {
>>+	case PNV_PHB_IODA1:
>>+		phb->init_m64 = pnv_ioda1_init_m64;
>>+		break;
>>+	case PNV_PHB_IODA2:
>>+		phb->init_m64 = pnv_ioda2_init_m64;
>>+		break;
>>+	default:
>>+		phb->init_m64 = NULL;
>>+		phb->reserve_m64_pe = NULL;
>>+		phb->pick_m64_pe = NULL;
>>+		phb->ioda.m64_size = 0;
>>+		phb->ioda.m64_segsize = 0;
>>+		phb->ioda.m64_base = 0;
>
>There are just 2 PHB types - IODA1 and IODA2, right? And the fields you reset
>after "default" - they have to be zeroes already, no? And on what hardware
>would the default branch actuall work? None?
>

Yeah, you're right those piece of garbage can be removed in next revision.

Thanks,
Gavin

>
>>+	}
>>  }
>>
>>  static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
>>
>
>
>-- 
>Alexey
>
