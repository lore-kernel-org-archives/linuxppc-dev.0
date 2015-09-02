Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E38531A1E3C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 01:39:38 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 2 Sep 2015 11:39:35 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DAC9BC90041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 11:30:35 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t82FdVdt62914770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 15:39:31 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t82FdU4e012217
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 11:39:31 -0400
Date: Wed, 2 Sep 2015 08:39:28 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/powernv/pci-ioda: fix 32-bit TCE table init in
 kdump kernel
Message-ID: <20150902153928.GB47557@linux.vnet.ibm.com>
References: <20150902011123.GA47557@linux.vnet.ibm.com>
 <55E6BAAF.9090502@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55E6BAAF.9090502@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02.09.2015 [19:00:31 +1000], Alexey Kardashevskiy wrote:
> On 09/02/2015 11:11 AM, Nishanth Aravamudan wrote:
> >When attempting to kdump with the 4.2 kernel, we see for each PCI
> >device:
> >
> >  pci 0003:01     : [PE# 000] Assign DMA32 space
> >  pci 0003:01     : [PE# 000] Setting up 32-bit TCE table at 0..80000000
> >  pci 0003:01     : [PE# 000] Failed to create 32-bit TCE table, err -22
> >  PCI: Domain 0004 has 8 available 32-bit DMA segments
> >  PCI: 4 PE# for a total weight of 70
> >  pci 0004:01     : [PE# 002] Assign DMA32 space
> >  pci 0004:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
> >  pci 0004:01     : [PE# 002] Failed to create 32-bit TCE table, err -22
> >  pci 0004:0d     : [PE# 005] Assign DMA32 space
> >  pci 0004:0d     : [PE# 005] Setting up 32-bit TCE table at 0..80000000
> >  pci 0004:0d     : [PE# 005] Failed to create 32-bit TCE table, err -22
> >  pci 0004:0e     : [PE# 006] Assign DMA32 space
> >  pci 0004:0e     : [PE# 006] Setting up 32-bit TCE table at 0..80000000
> >  pci 0004:0e     : [PE# 006] Failed to create 32-bit TCE table, err -22
> >  pci 0004:10     : [PE# 008] Assign DMA32 space
> >  pci 0004:10     : [PE# 008] Setting up 32-bit TCE table at 0..80000000
> >  pci 0004:10     : [PE# 008] Failed to create 32-bit TCE table, err -22
> >
> >and eventually the kdump kernel fails to boot as none of the PCI devices
> >(including the disk controller) are successfully initialized.
> >
> >The EINVAL response is because the DMA window (the 2GB base window) is
> >larger than the kdump kernel's reserved memory (crashkernel=, in this
> >case specified to be 1024M). The check in question,
> >
> >  if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
> >
> >is a valid sanity check for pnv_pci_ioda2_table_alloc_pages(), so adjust
> >the caller to pass in a smaller window size if our maximum memory value
> >is smaller than the DMA window.
> >
> >After this change, the PCI devices successfully set up the 32-bit TCE
> >table and kdump succeeds.
> >
> >The problem was seen on a Firestone machine originally.
> >
> >Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
> >Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> >
> >diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> >index 85cbc96eff6c..0d7967e31169 100644
> >--- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >@@ -2077,10 +2077,17 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
> >  {
> >  	struct iommu_table *tbl = NULL;
> >  	long rc;
> >+	/*
> >+	 * In memory constrained environments, e.g. kdump kernel, the
> >+	 * DMA window can be larger than available memory, which will
> >+	 * cause errors later.
> >+	 */
> >+	__u64 window_size =
> 
> I asked for "const __u64" ;)

I knew I'd forget something!

When attempting to kdump with the 4.2 kernel, we see for each PCI
device:

 pci 0003:01     : [PE# 000] Assign DMA32 space
 pci 0003:01     : [PE# 000] Setting up 32-bit TCE table at 0..80000000
 pci 0003:01     : [PE# 000] Failed to create 32-bit TCE table, err -22
 PCI: Domain 0004 has 8 available 32-bit DMA segments
 PCI: 4 PE# for a total weight of 70
 pci 0004:01     : [PE# 002] Assign DMA32 space
 pci 0004:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
 pci 0004:01     : [PE# 002] Failed to create 32-bit TCE table, err -22
 pci 0004:0d     : [PE# 005] Assign DMA32 space
 pci 0004:0d     : [PE# 005] Setting up 32-bit TCE table at 0..80000000
 pci 0004:0d     : [PE# 005] Failed to create 32-bit TCE table, err -22
 pci 0004:0e     : [PE# 006] Assign DMA32 space
 pci 0004:0e     : [PE# 006] Setting up 32-bit TCE table at 0..80000000
 pci 0004:0e     : [PE# 006] Failed to create 32-bit TCE table, err -22
 pci 0004:10     : [PE# 008] Assign DMA32 space
 pci 0004:10     : [PE# 008] Setting up 32-bit TCE table at 0..80000000
 pci 0004:10     : [PE# 008] Failed to create 32-bit TCE table, err -22

and eventually the kdump kernel fails to boot as none of the PCI devices
(including the disk controller) are successfully initialized.

The EINVAL response is because the DMA window (the 2GB base window) is
larger than the kdump kernel's reserved memory (crashkernel=, in this
case specified to be 1024M). The check in question,

 if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))

is a valid sanity check for pnv_pci_ioda2_table_alloc_pages(), so adjust
the caller to pass in a smaller window size if our maximum memory value
is smaller than the DMA window.

After this change, the PCI devices successfully set up the 32-bit TCE
table and kdump succeeds.

The problem was seen on a Firestone machine originally.
    
Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>	

---
v1 -> v2:
  Mark window_size as const.

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 85cbc96eff6c..e51aff01a218 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2077,10 +2077,17 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 {
 	struct iommu_table *tbl = NULL;
 	long rc;
+	/*
+	 * In memory constrained environments, e.g. kdump kernel, the
+	 * DMA window can be larger than available memory, which will
+	 * cause errors later.
+	 */
+	const __u64 window_size =
+		min((u64)pe->table_group.tce32_size, memory_hotplug_max());
 
 	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
 			IOMMU_PAGE_SHIFT_4K,
-			pe->table_group.tce32_size,
+			window_size,
 			POWERNV_IOMMU_DEFAULT_LEVELS, &tbl);
 	if (rc) {
 		pe_err(pe, "Failed to create 32-bit TCE table, err %ld",
