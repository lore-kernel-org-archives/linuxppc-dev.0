Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqMdW1MsxzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:07:27 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 10:07:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A803B2BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:07:19 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K0764G8323314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:07:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K06eMY002619
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:06:41 +1000
Date: Wed, 20 Apr 2016 10:05:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 11/45] powerpc/powernv: Track M64 segment consumption
Message-ID: <20160420000545.GC11304@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-12-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DF0B9.5030102@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570DF0B9.5030102@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 05:09:45PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>When unplugging PCI devices, their parent PEs might be offline.
>>The consumed M64 resource by the PEs should be released at that
>>time. As we track M32 segment consumption, this introduces an
>>array to the PHB to track the mapping between M64 segment and
>>PE number.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>
>Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>but it would not hurt to mention in the commit log why M64 segment is not
>tracked/setup by the existing (at this point, at least)
>pnv_ioda_setup_one_res().
>

Right, I'll add something for it to the commit log in next revision, thanks!

>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++--
>>  arch/powerpc/platforms/powernv/pci.h      |  1 +
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 7330a73..fc0374a 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -305,6 +305,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>>  		phb->ioda.total_pe_num) {
>>  		pe = &phb->ioda.pe_array[i];
>>
>>+		phb->ioda.m64_segmap[pe->pe_number] = pe->pe_number;
>>  		if (!master_pe) {
>>  			pe->flags |= PNV_IODA_PE_MASTER;
>>  			INIT_LIST_HEAD(&pe->slaves);
>>@@ -3245,7 +3246,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  {
>>  	struct pci_controller *hose;
>>  	struct pnv_phb *phb;
>>-	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
>>+	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off = 0;
>>  	const __be64 *prop64;
>>  	const __be32 *prop32;
>>  	int i, len;
>>@@ -3332,6 +3333,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>
>>  	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>>  	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>>+	m64map_off = size;
>>+	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m64_segmap[0]);
>>  	m32map_off = size;
>>  	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m32_segmap[0]);
>>  	if (phb->type == PNV_PHB_IODA1) {
>>@@ -3342,9 +3345,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	size += phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
>>  	aux = memblock_virt_alloc(size, 0);
>>  	phb->ioda.pe_alloc = aux;
>>+	phb->ioda.m64_segmap = aux + m64map_off;
>>  	phb->ioda.m32_segmap = aux + m32map_off;
>>-	for (i = 0; i < phb->ioda.total_pe_num; i++)
>>+	for (i = 0; i < phb->ioda.total_pe_num; i++) {
>>+		phb->ioda.m64_segmap[i] = IODA_INVALID_PE;
>>  		phb->ioda.m32_segmap[i] = IODA_INVALID_PE;
>>+	}
>>  	if (phb->type == PNV_PHB_IODA1) {
>>  		phb->ioda.io_segmap = aux + iomap_off;
>>  		for (i = 0; i < phb->ioda.total_pe_num; i++)
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 36c4965..866a5ea 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -146,6 +146,7 @@ struct pnv_phb {
>>  		struct pnv_ioda_pe	*pe_array;
>>
>>  		/* M32 & IO segment maps */
>>+		int			*m64_segmap;
>>  		int			*m32_segmap;
>>  		int			*io_segmap;
>>
>>
>
>
>-- 
>Alexey
>
