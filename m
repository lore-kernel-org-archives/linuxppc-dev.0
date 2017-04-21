Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8LqL3cW2zDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 13:30:54 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3L3UKck094975
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 23:30:51 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29xucapp25-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 23:30:51 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 21 Apr 2017 13:30:48 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3L3Ubh162717960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 13:30:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3L3UC8j016190
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 13:30:12 +1000
Date: Fri, 21 Apr 2017 13:29:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/pci: Reduce spam when dumping PEST
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170410055328.11727-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170410055328.11727-1-ruscur@russell.cc>
Message-Id: <20170421032948.GA10949@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 10, 2017 at 03:53:28PM +1000, Russell Currey wrote:
>Dumping the PE State Tables (PEST) can be highly verbose if a number of PEs
>are affected, especially in the case where the whole PHB is frozen and 255
>lines get printed.  Check for duplicates when dumping the PEST to reduce
>useless output.
>
>For example:
>
>    PE[f8] A/B: 9700002600000000 80000080d00000f8
>    PE[f9] A/B: 8000000000000000 0000000000000000
>    PE[..fe] A/B: as above
>    PE[ff] A/B: 8440002b00000000 0000000000000000
>
>instead of:
>
>    PE[f8] A/B: 9700002600000000 80000080d00000f8
>    PE[f9] A/B: 8000000000000000 0000000000000000
>    PE[fa] A/B: 8000000000000000 0000000000000000
>    PE[fb] A/B: 8000000000000000 0000000000000000
>    PE[fc] A/B: 8000000000000000 0000000000000000
>    PE[fd] A/B: 8000000000000000 0000000000000000
>    PE[fe] A/B: 8000000000000000 0000000000000000
>    PE[ff] A/B: 8440002b00000000 0000000000000000
>
>and you can imagine how much worse it can get for 255 PEs.
>

Russell, PHB3 does have 256 PEs while P7IOC has 128 PEs. None of them
has 255 PEs :) It really depends on the possibility (how often) all
PESTA/B are dumped. I think it should be very very rare because only
one error case (link-down-freeze-all) can cause this. So it's fine to
keep current implementation and code. However, it's nice to make the
code smart though. 

With below comments resolved:

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>Signed-off-by: Russell Currey <ruscur@russell.cc>
>---
> arch/powerpc/platforms/powernv/pci.c | 52 ++++++++++++++++++++++--------------
> 1 file changed, 32 insertions(+), 20 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>index eb835e977e33..303c9d84d3d4 100644
>--- a/arch/powerpc/platforms/powernv/pci.c
>+++ b/arch/powerpc/platforms/powernv/pci.c
>@@ -227,11 +227,40 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
> }
> #endif /* CONFIG_PCI_MSI */
>
>+/* Nicely print the contents of the PE State Tables (PEST). */
>+static void pnv_pci_dump_pest(__be64 pestA[], __be64 pestB[], int pest_size)
>+{
>+	int i;
>+	__be64 prevA, prevB;
>+	bool dup = false;
>+	prevA = prevB = ~0;

@prevA and @prevB can be initialized while they're declared. Also,
it would be nicer to have UL suffix as they are 64-bits in width.

	__be64 prevA = ULONG_MAX, prevB = ULONG_MAX;

>+
>+	for (i = 0; i < pest_size; i++) {
>+		__be64 peA = be64_to_cpu(pestA[i]);
>+		__be64 peB = be64_to_cpu(pestB[i]);
>+
>+		if (peA != prevA || peB != prevB) {
>+			if (dup) {
>+				pr_info("PE[..%x] A/B: as above\n", i-1);
>+				dup = false;
>+			}
>+			prevA = peA;
>+			prevB = peB;
>+			if (peA || peB)

This condition isn't match with original implementation where the Bit#63
are check on PESTA/B and the corresponding entry is skipped if none of
them is set.

>+				pr_info("PE[%2x] A/B: %016llx %016llx\n",
>+					i, peA, peB);
>+		} else {
>+			/* Don't need to track zeroes */
>+			if (!dup && (peA || peB))

Same as above. Also, the else/if can be combined to be "else if" to
avoid nested the extra ifdef.

>+				dup = true;
>+		}
>+	}
>+}
>+
> static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
> 					 struct OpalIoPhbErrorCommon *common)
> {
> 	struct OpalIoP7IOCPhbErrorData *data;
>-	int i;
>
> 	data = (struct OpalIoP7IOCPhbErrorData *)common;
> 	pr_info("P7IOC PHB#%x Diag-data (Version: %d)\n",
>@@ -308,22 +337,13 @@ static void pnv_pci_dump_p7ioc_diag_data(struct pci_controller *hose,
> 			be64_to_cpu(data->dma1ErrorLog0),
> 			be64_to_cpu(data->dma1ErrorLog1));
>
>-	for (i = 0; i < OPAL_P7IOC_NUM_PEST_REGS; i++) {
>-		if ((be64_to_cpu(data->pestA[i]) >> 63) == 0 &&
>-		    (be64_to_cpu(data->pestB[i]) >> 63) == 0)
>-			continue;
>-
>-		pr_info("PE[%3d] A/B: %016llx %016llx\n",
>-			i, be64_to_cpu(data->pestA[i]),
>-			be64_to_cpu(data->pestB[i]));
>-	}
>+	pnv_pci_dump_pest(data->pestA, data->pestB, OPAL_P7IOC_NUM_PEST_REGS);
> }
>
> static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
> 					struct OpalIoPhbErrorCommon *common)
> {
> 	struct OpalIoPhb3ErrorData *data;
>-	int i;
>
> 	data = (struct OpalIoPhb3ErrorData*)common;
> 	pr_info("PHB3 PHB#%x Diag-data (Version: %d)\n",
>@@ -404,15 +424,7 @@ static void pnv_pci_dump_phb3_diag_data(struct pci_controller *hose,
> 			be64_to_cpu(data->dma1ErrorLog0),
> 			be64_to_cpu(data->dma1ErrorLog1));
>
>-	for (i = 0; i < OPAL_PHB3_NUM_PEST_REGS; i++) {
>-		if ((be64_to_cpu(data->pestA[i]) >> 63) == 0 &&
>-		    (be64_to_cpu(data->pestB[i]) >> 63) == 0)
>-			continue;
>-
>-		pr_info("PE[%3d] A/B: %016llx %016llx\n",
>-				i, be64_to_cpu(data->pestA[i]),
>-				be64_to_cpu(data->pestB[i]));
>-	}
>+	pnv_pci_dump_pest(data->pestA, data->pestB, OPAL_PHB3_NUM_PEST_REGS);
> }
>
> void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
>-- 
>2.12.2
>
