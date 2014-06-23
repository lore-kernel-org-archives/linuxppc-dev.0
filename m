Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D65701A0155
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 19:07:28 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 14:37:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D0BD8E0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 14:38:32 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N97bIn8651156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 14:37:37 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N97KsK006106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 14:37:21 +0530
Date: Mon, 23 Jun 2014 17:07:18 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 07/17] ppc/pnv: Add function to deconfig a PE
Message-ID: <20140623090718.GA7669@richard>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1402365399-5121-8-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140623052721.GB7223@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140623052721.GB7223@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linux-pci@vger.kernel.org, yan@linux.vnet.ibm.com, bhelgaas@google.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2014 at 03:27:21PM +1000, Gavin Shan wrote:
>On Tue, Jun 10, 2014 at 09:56:29AM +0800, Wei Yang wrote:
>>On PowerNV platform, it will support dynamic PE allocation and deallocation.
>>
>>This patch adds a function to release those resources related to a PE.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/platforms/powernv/pci-ioda.c |   77 +++++++++++++++++++++++++++++
>> 1 file changed, 77 insertions(+)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 8ca3926..87cb3089 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -330,6 +330,83 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
>> }
>> #endif /* CONFIG_PCI_MSI */
>>
>>+static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>+{
>
>Richard, it seems that the deconfiguration is incomplete. Something seems
>missed: DMA, IO and MMIO, MSI. If I understand correctly, pnv_ioda_deconfigure_pe()
>won't tear down DMA, IO and MMIO, MSI properly. For MSI/MSIx, it wouldn't
>be a problem as the VF driver should disable them before calling this function.
>

Hmm... the deconfiguration function is the counterpart of the configuration
function, so it will release the resource which are allocated in
configuration. The DMA, IO/MMIO, MSI is not assigned in the configuration
function, so it would not proper to release those resources by this function.

>>+	struct pci_dev *parent;
>>+	uint8_t bcomp, dcomp, fcomp;
>>+	int64_t rc;
>>+	long rid_end, rid;
>
>Blank line needed here to separate variable declaration and logic. And I think
>we won't run into case "if (pe->pbus)" for now. So it's worthy to have some
>comments to explain it for a bit :-)

Ok.

>
>>+	if (pe->pbus) {
>>+		int count;
>>+
>>+		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
>>+		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
>>+		parent = pe->pbus->self;
>>+		if (pe->flags & PNV_IODA_PE_BUS_ALL)
>>+			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
>>+		else
>>+			count = 1;
>>+
>>+		switch(count) {
>>+		case  1: bcomp = OpalPciBusAll;         break;
>>+		case  2: bcomp = OpalPciBus7Bits;       break;
>>+		case  4: bcomp = OpalPciBus6Bits;       break;
>>+		case  8: bcomp = OpalPciBus5Bits;       break;
>>+		case 16: bcomp = OpalPciBus4Bits;       break;
>>+		case 32: bcomp = OpalPciBus3Bits;       break;
>>+		default:
>>+			pr_err("%s: Number of subordinate busses %d"
>>+			       " unsupported\n",
>>+			       pci_name(pe->pbus->self), count);
>
>I guess it's not safe to do "pci_name(pe->pbus->self)" root root bus.
>

Ok, so there is a bug in the original code, will fix this.

>>+			/* Do an exact match only */
>>+			bcomp = OpalPciBusAll;
>>+		}
>>+		rid_end = pe->rid + (count << 8);
>>+	}else {
>
>	} else {
>
>>+		parent = pe->pdev->bus->self;
>>+		bcomp = OpalPciBusAll;
>>+		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
>>+		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
>>+		rid_end = pe->rid + 1;
>>+	}
>>+
>>+	/* Disable MVT on IODA1 */
>>+	if (phb->type == PNV_PHB_IODA1) {
>>+		rc = opal_pci_set_mve_enable(phb->opal_id,
>>+					     pe->mve_number, OPAL_DISABLE_MVE);
>>+		if (rc) {
>>+			pe_err(pe, "OPAL error %ld enabling MVE %d\n",
>>+			       rc, pe->mve_number);
>>+			pe->mve_number = -1;
>>+		}
>>+	}
>>+	/* Clear the reverse map */
>>+	for (rid = pe->rid; rid < rid_end; rid++)
>>+		phb->ioda.pe_rmap[rid] = 0;
>>+
>>+	/* Release from all parents PELT-V */
>>+	while (parent) {
>>+		struct pci_dn *pdn = pci_get_pdn(parent);
>>+		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
>>+			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
>>+						pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
>>+			/* XXX What to do in case of error ? */
>>+		}
>>+		parent = parent->bus->self;
>>+	}
>
>It seems that you missed removing the PE from its own PELTV, which was
>introduced by commit 631ad69 ("powerpc/powernv: Add PE to its own PELTV").
>

Sounds correct, this is missed.

>>+
>>+	/* Dissociate PE in PELT */
>>+	rc = opal_pci_set_pe(phb->opal_id, pe->pe_number, pe->rid,
>>+			     bcomp, dcomp, fcomp, OPAL_UNMAP_PE);
>>+	if (rc)
>>+		pe_err(pe, "OPAL error %ld trying to setup PELT table\n", rc);
>>+
>>+	pe->pbus = NULL;
>>+	pe->pdev = NULL;
>>+
>>+	return 0;
>>+}
>>+
>> static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>> {
>> 	struct pci_dev *parent;
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me
