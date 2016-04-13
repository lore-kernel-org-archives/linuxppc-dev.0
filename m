Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlGJs5v7SzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 17:53:49 +1000 (AEST)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 13 Apr 2016 13:23:44 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3D7rgqu55640092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 13:23:42 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3D7ruOo002330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 13:24:01 +0530
Date: Wed, 13 Apr 2016 17:53:24 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 08/45] powerpc/powernv: Fix initial IO and M32 segmap
Message-ID: <20160413075324.GA31320@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-9-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DE553.80708@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570DE553.80708@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 04:21:07PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>There are two arrays for IO and M32 segment maps on every PHB.
>>The index of the arrays are segment number and the value stored
>>in the corresponding element is PE number, indicating the segment
>>is assigned to the PE. Initially, all elements in those two arrays
>>are zeroes, meaning all segments are assigned to PE#0. It's wrong.
>>
>>This fixes the initial values in the elements of those two arrays
>>to IODA_INVALID_PE, meaning all segments aren't assigned to any
>>PE.
>
>This is ok.
>
>>In order to use IODA_INVALID_PE (-1) to represent invalid PE
>>number, the types of those two arrays are changed from "unsigned int"
>>to "int".
>
>"unsigned" can carry (-1) perfectly fine, just add a type cast to
>IODA_INVALID_PE:
>
>#define IODA_INVALID_PE    (unsigned int)(-1)
>
>Using "signed" type for indexes which cannot be negative does not make much
>sense - instead of checking for the upper boundary, you have to check for "<
>0" too.
>
>OPAL uses unsigned type for PE (uint64_t or uint32_t or uint16_t - this is
>quite funny).
>
>pnv_ioda_pe::pe_number is "unsigned" and this pe_number is the same thing as
>I can see in pnv_ioda_setup_dev_PE().
>
>Some printk() print the PE number as "%x" (which implies "unsigned").
>

Yes, I can simply have something like below when PE number as well as
segment index are represented by "unsigned int" values, right?

#define IODA_INVALID_PE		0xffffffff

>
>I suggest changing the pci_dn::pe_number type from "int" to "unsigned int" to
>match pnv_ioda_pe::pe_number, in a separate patch. Or do not touch types for
>now.
>

Yes, I will have a separate patch right before this one to address it.

>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++++++--
>>  arch/powerpc/platforms/powernv/pci.h      | 4 ++--
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 1d2514f..44cc5f3 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -3239,7 +3239,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
>>  	const __be64 *prop64;
>>  	const __be32 *prop32;
>>-	int len;
>>+	int i, len;
>>  	u64 phb_id;
>>  	void *aux;
>>  	long rc;
>>@@ -3334,8 +3334,13 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	aux = memblock_virt_alloc(size, 0);
>>  	phb->ioda.pe_alloc = aux;
>>  	phb->ioda.m32_segmap = aux + m32map_off;
>>-	if (phb->type == PNV_PHB_IODA1)
>>+	for (i = 0; i < phb->ioda.total_pe_num; i++)
>>+		phb->ioda.m32_segmap[i] = IODA_INVALID_PE;
>>+	if (phb->type == PNV_PHB_IODA1) {
>>  		phb->ioda.io_segmap = aux + iomap_off;
>>+		for (i = 0; i < phb->ioda.total_pe_num; i++)
>>+			phb->ioda.io_segmap[i] = IODA_INVALID_PE;
>>+	}
>>  	phb->ioda.pe_array = aux + pemap_off;
>>  	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 784882a..36c4965 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -146,8 +146,8 @@ struct pnv_phb {
>>  		struct pnv_ioda_pe	*pe_array;
>>
>>  		/* M32 & IO segment maps */
>>-		unsigned int		*m32_segmap;
>>-		unsigned int		*io_segmap;
>>+		int			*m32_segmap;
>>+		int			*io_segmap;
>>
>>  		/* IRQ chip */
>>  		int			irq_chip_init;
>>
>
>
>-- 
>Alexey
>
