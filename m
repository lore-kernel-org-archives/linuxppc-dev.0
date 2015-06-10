Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C1CF1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:19:30 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 16:19:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 44D732BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:19:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A6JGTD59179022
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:19:24 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A6Io8m003935
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:18:51 +1000
Date: Wed, 10 Jun 2015 16:18:25 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org
Subject: Re: [PATCH v5 11/42] powerpc/powernv: Increase PE# capacity
Message-ID: <20150610061825.GF5664@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-12-git-send-email-gwshan@linux.vnet.ibm.com>
 <5577BFE9.2040601@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5577BFE9.2040601@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2015 at 02:41:13PM +1000, Alexey Kardashevskiy wrote:
>On 06/04/2015 04:41 PM, Gavin Shan wrote:
>>Each PHB maintains an array helping to translate RID (Request
>>ID) to PE# with the assumption that PE# takes 8 bits, indicating
>>that we can't have more than 256 PEs. However, pci_dn->pe_number
>>already had 4-bytes for the PE#.
>>
>>The patch extends the PE# capacity so that each of them will be
>>4-bytes long. Then we can use IODA_INVALID_PE to check one entry
>>in phb->pe_rmap[] is valid or not.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>v5:
>>   * Split from [PATCH v5 v4 06/21]
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 5 ++++-
>>  arch/powerpc/platforms/powernv/pci.h      | 5 ++---
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 2087c5c..d8b0ef5 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -840,7 +840,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>
>>  	/* Clear the reverse map */
>>  	for (rid = pe->rid; rid < rid_end; rid++)
>>-		phb->ioda.pe_rmap[rid] = 0;
>>+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>>
>>  	/* Release from all parents PELT-V */
>>  	while (parent) {
>>@@ -3303,6 +3303,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	if (prop32)
>>  		phb->ioda.reserved_pe = be32_to_cpup(prop32);
>>
>>+	/* Invalidate RID to PE# mapping */
>>+	memset(phb->ioda.pe_rmap, 0xff, sizeof(phb->ioda.pe_rmap));
>
>
>Above you assign IODA_INVALID_PE in a loop and here you just do 0xff for the
>entire array. Have a loop here too and assign IODA_INVALID_PE to every entry:
>for (i = 0; i < ARRAY_SIZE(phb->ioda.pe_rmap); ++i)
>	phb->ioda.pe_rmap[i] = IODA_INVALID_PE;
>

Yeah, will change accordingly.

>>+
>>  	/* Parse 64-bit MMIO range */
>>  	pnv_ioda_parse_m64_window(phb);
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 94ef1df..590f778 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -175,11 +175,10 @@ struct pnv_phb {
>>  			struct list_head	pe_list;
>>  			struct mutex            pe_list_mutex;
>>
>>-			/* Reverse map of PEs, will have to extend if
>>-			 * we are to support more than 256 PEs, indexed
>>+			/* Reverse map of PEs, indexed by
>>  			 * bus { bus, devfn }
>>  			 */
>>-			unsigned char		pe_rmap[0x10000];
>>+			int			pe_rmap[0x10000];
>
>
>Most time most of the array will be empty and it is 256K per PHB... I
>understand we have quite a lot of RAM but still.
>

Indeed, I'll think about how to save memory here, but not in this
patchset.

>>
>>  			/* Number of 32-bit DMA segments */
>>  			unsigned long		dma32_segcount;
>>

Thanks,
Gavin
