Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ABD31A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 21:02:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Aug 2015 16:32:40 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E0DAA1258069
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:35:51 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7CB2FMh65732770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:32:17 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7CB2GWn014378
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:32:18 +0530
Date: Wed, 12 Aug 2015 20:28:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
Subject: Re: [PATCH v6 03/42] powerpc/powernv: Enable M64 on P7IOC
Message-ID: <20150812102858.GA7690@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C844F1.6060404@ozlabs.ru> <20150810234549.GA10753@gwshan>
 <55C958A2.5060708@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C958A2.5060708@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 11, 2015 at 12:06:26PM +1000, Alexey Kardashevskiy wrote:
>On 08/11/2015 09:45 AM, Gavin Shan wrote:
>>On Mon, Aug 10, 2015 at 04:30:09PM +1000, Alexey Kardashevskiy wrote:
>>>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>>>The patch enables M64 window on P7IOC, which has been enabled on
>>>>PHB3. Different from PHB3 where 16 M64 BARs are supported and each
>>>>of them can be owned by one particular PE# exclusively or divided
>>>>evenly to 256 segments, each P7IOC PHB has 16 M64 BARs and each
>>>>of them are divided into 8 segments.
>>>
>>>Is this a limitation of POWER7 chip or it is from IODA1?
>>>
>>
>> From IODA1.
>>
>>>>So each P7IOC PHB can support
>>>>128 M64 segments only. Also, P7IOC has M64DT, which helps mapping
>>>>one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>>>M64DT, indicating that one M64 segment can only be pinned to the
>>>>fixed PE#. In order to have similar logic to support M64 for PHB3
>>>>and P7IOC, we just provide 128 M64 (16 BARs) segments and fixed
>>>>mapping between PE# and M64 segment# on P7IOC. In turn, we just
>>>>need different phb->init_m64() hooks for P7IOC and PHB3 to support
>>>>M64.
>>>>
>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>---
>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 116 ++++++++++++++++++++++++++----
>>>>  1 file changed, 104 insertions(+), 12 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 38b5405..e4ac703 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -172,6 +172,69 @@ static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
>>>>  	clear_bit(pe, phb->ioda.pe_alloc);
>>>>  }
>>>>
>>>>+static int pnv_ioda1_init_m64(struct pnv_phb *phb)
>>>>+{
>>>>+	struct resource *r;
>>>>+	int seg;
>>>>+
>>>>+	/* There are as many M64 segments as the maximum number
>>>>+	 * of PEs, which is 128.
>>>>+	 */
>>>>+	for (seg = 0; seg < phb->ioda.total_pe; seg += 8) {
>>>
>>>
>>>This "8" is used a lot across the patch, please make it a macro
>>>(PNV_PHB_P7IOC_SEGNUM or PNV_PHB_IODA1_SEGNUM or whatever you think it is)
>>>with a short comment why it is "8". Or a pnv_phb member.
>>>
>>
>>I would like to use "8". When having a macro, you have to check
>>the definition of the macro to get the real value of that.
>
>Give it a good name then.
>
>
>>However,
>>it makes sense to add more comments explaining why it's 8 here.
>
>You cannot comment it everywhere and everywhere is exact place when you'll
>have to comment it as I believe sometime it is segments-per-M64 and sometime
>it is number of bits in a byte (or not? anyway, this is will always distract
>unless you use macro for segments-per-M64).
>

Ok. I will use PNV_PHB_IODA1_SEGNUM then.

>>
>>>
>>>>+		unsigned long base;
>>>>+		int64_t rc;
>>>>+
>>>>+		base = phb->ioda.m64_base + seg * phb->ioda.m64_segsize;
>>>>+		rc = opal_pci_set_phb_mem_window(phb->opal_id,
>>>>+						 OPAL_M64_WINDOW_TYPE,
>>>>+						 seg / 8,
>>>>+						 base,
>>>>+						 0, /* unused */
>>>>+						 8 * phb->ioda.m64_segsize);
>>>>+		if (rc != OPAL_SUCCESS) {
>>>>+			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
>>>>+				rc, phb->hose->global_number, seg / 8);
>>>>+			goto fail;
>>>>+		}
>>>>+
>>>>+		rc = opal_pci_phb_mmio_enable(phb->opal_id,
>>>>+					      OPAL_M64_WINDOW_TYPE,
>>>>+					      seg / 8,
>>>>+					      OPAL_ENABLE_M64_SPLIT);
>>>>+		if (rc != OPAL_SUCCESS) {
>>>>+			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
>>>>+				rc, phb->hose->global_number, seg / 8);
>>>>+			goto fail;
>>>>+		}
>>>>+	}
>>>>+
>>>>+	/* Strip off the segment used by the reserved PE, which
>>>
>>>What is this reserved PE on P7IOC? "Strip off" means "exclude" here?
>>>
>>
>>127 that was exported from skiboot. "Strip off" means "exclude".
>
>I like "exclude" lot better.
>

Ok. Will use it.

>>
>>>
>>>>+	 * is expected to be 0 or last supported PE#. The PHB's
>>>>+	 * first memory window traces the 32-bits MMIO range
>>>
>>>s/traces/filters/ ? Or I did not understand this comment...
>>>
>>
>>It seems you didn't understand it: there are two memory windows
>>in every PHB. The first one is tracing M32 resource and the
>>second one is tracing M64 resource.
>
>
>Tracing means logging, pretty much. Is this what you mean here?
>

No, it means "recording", not "logging". So it would be appropriate
to replace it with "track"?

>>
>>>
>>>>+	 * while the second one traces the 64-bits prefetchable
>>>>+	 * MMIO range that the PHB supports.
>>>
>>>32/64 ranges comment seems irrelevant here.
>>>
>>
>>Maybe it's not so relevant, but still.
>
>Not relevant -> remove it. Put this text to the commit log.
>

Ok.

>>We're stripping off the
>>M64 segment from the 2nd resource (as above), not first one.
>
>
>2nd window (not _resource_), you mean?
>

I mean struct pci_controller::mem_resources[1].


>
>>
>>>
>>>>+	 */
>>>>+	r = &phb->hose->mem_resources[1];
>>>>+	if (phb->ioda.reserved_pe == 0)
>>>>+		r->start += phb->ioda.m64_segsize;
>>>>+	else if (phb->ioda.reserved_pe == (phb->ioda.total_pe - 1))
>>>>+		r->end -= phb->ioda.m64_segsize;
>>>>+	else
>>>>+		pr_warn("  Cannot strip M64 segment for reserved PE#%d\n",
>>>>+			phb->ioda.reserved_pe);
>>>>+
>>>>+	return 0;
>>>>+
>>>>+fail:
>>>>+	for ( ; seg >= 0; seg -= 8)
>>>>+		opal_pci_phb_mmio_enable(phb->opal_id,
>>>>+					 OPAL_M64_WINDOW_TYPE,
>>>>+					 seg / 8,
>>>>+					 OPAL_DISABLE_M64);
>>>>+
>>>>+	return -EIO;
>>>>+}
>>>>+
>>>>  /* The default M64 BAR is shared by all PEs */
>>>>  static int pnv_ioda2_init_m64(struct pnv_phb *phb)
>>>>  {
>>>>@@ -256,9 +319,9 @@ static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
>>>>  	}
>>>>  }
>>>>
>>>>-static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
>>>>-				     unsigned long *pe_bitmap,
>>>>-				     bool all)
>>>>+static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
>>>>+				    unsigned long *pe_bitmap,
>>>>+				    bool all)
>>>>  {
>>>>  	struct pci_dev *pdev;
>>>>
>>>>@@ -266,12 +329,12 @@ static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
>>>>  		pnv_ioda2_reserve_dev_m64_pe(pdev, pe_bitmap);
>>>>
>>>>  		if (all && pdev->subordinate)
>>>>-			pnv_ioda2_reserve_m64_pe(pdev->subordinate,
>>>>-						 pe_bitmap, all);
>>>>+			pnv_ioda_reserve_m64_pe(pdev->subordinate,
>>>>+						pe_bitmap, all);
>>>>  	}
>>>>  }
>>>>
>>>>-static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>>>>+static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>>>>  {
>>>>  	struct pci_controller *hose = pci_bus_to_host(bus);
>>>>  	struct pnv_phb *phb = hose->private_data;
>>>>@@ -293,7 +356,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>>>>  	}
>>>>
>>>>  	/* Figure out reserved PE numbers by the PE */
>>>>-	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
>>>>+	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
>>>>
>>>>  	/*
>>>>  	 * the current bus might not own M64 window and that's all
>>>>@@ -324,6 +387,26 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>>>>  			pe->master = master_pe;
>>>>  			list_add_tail(&pe->list, &master_pe->slaves);
>>>>  		}
>>>>+
>>>>+		/* P7IOC supports M64DT, which helps mapping M64 segment
>>>>+		 * to one particular PE#. However, PHB3 has fixed mapping
>>>>+		 * between M64 segment and PE#. In order to have same logic
>>>>+		 * for P7IOC and PHB3, we enforce fixed mapping between M64
>>>>+		 * segment and PE# on P7IOC.
>>>>+		 */
>>>>+		if (phb->type == PNV_PHB_IODA1) {
>>>>+			int64_t rc;
>>>>+
>>>>+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>>>+							 pe->pe_number,
>>>>+							 OPAL_M64_WINDOW_TYPE,
>>>>+							 pe->pe_number / 8,
>>>>+							 pe->pe_number % 8);
>>>>+			if (rc != OPAL_SUCCESS)
>>>>+				pr_warn("%s: Error %lld mapping M64 for PHB#%d-PE#%d\n",
>>>>+					__func__, rc, phb->hose->global_number,
>>>>+					pe->pe_number);
>>>>+		}
>>>>  	}
>>>>
>>>>  	kfree(pe_alloc);
>>>>@@ -338,8 +421,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>>>  	const u32 *r;
>>>>  	u64 pci_addr;
>>>>
>>>>-	/* FIXME: Support M64 for P7IOC */
>>>>-	if (phb->type != PNV_PHB_IODA2) {
>>>>+	if (phb->type != PNV_PHB_IODA1 &&
>>>>+	    phb->type != PNV_PHB_IODA2) {
>>>>  		pr_info("  Not support M64 window\n");
>>>>  		return;
>>>
>>>
>>>You are adding P7IOC support so at least "fixme" should go. Also,
>>>pnv_ioda_parse_m64_window() is only called from pnv_pci_init_ioda_phb() which
>>>is called only with PNV_PHB_IODA1 and PNV_PHB_IODA2 (no other value is passed
>>>there a type) so the check above will never succeed, just remove it.
>>>
>>
>>The "fixme" is removed, isn't it?
>
>Ah, my bad.
>
>
>>As I explained last time, there will have another new type PHB and the function
>>will be called on the new type of PHB.
>
>Then a new patch adding new PHB should take care of this check too. This is
>not something which can possibly happen on a real machine, we support one of
>2 (later - 3) PHBs and if a machine got something else, we won't get that far
>anyway and we cannot gracefully fallback to some "generic PHB" (like 440fx on
>x86) as we do not have one.
>
>At least make it BUG_ON() to document it.
>

ok. I'll change accordingly.

>>The code has been there and it's not
>>in upstream yet. So it's reasonable to keep it, instead of removing it.
>
>No, not really.
>
>>
>>>>  	}
>>>>@@ -372,9 +455,18 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>>>
>>>>  	/* Use last M64 BAR to cover M64 window */
>>>>  	phb->ioda.m64_bar_idx = 15;
>>>>-	phb->init_m64 = pnv_ioda2_init_m64;
>>>>-	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
>>>>-	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
>>>>+	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
>>>>+	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
>>>>+	switch (phb->type) {
>>>>+	case PNV_PHB_IODA1:
>>>>+		phb->init_m64 = pnv_ioda1_init_m64;
>>>>+		break;
>>>>+	case PNV_PHB_IODA2:
>>>>+		phb->init_m64 = pnv_ioda2_init_m64;
>>>>+		break;
>>>>+	default:
>>>>+		pr_debug("   M64 not supported\n");
>>>>+	}
>>>>  }
>>>>
>>>>  static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
>>>>

Thanks,
Gavin
