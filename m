Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8064C1A023F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:34:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:34:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EF7863578047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:34:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1YDS228442692
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:34:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1XktC016050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:33:47 +1100
Date: Tue, 17 Nov 2015 12:33:21 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
 robherring2@gmail.com, panto@antoniou-consulting.com,
 frowand.list@gmail.com
Subject: Re: [PATCH v7 11/50] powerpc/powernv: IO and M32 mapping based on
 PCI device resources
Message-ID: <20151117013321.GA30246@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-12-git-send-email-gwshan@linux.vnet.ibm.com>
 <87lha3j3n0.fsf@gamma.ozlabs.ibm.com>
 <20151112045525.GA6174@gwshan> <56498D67.1090600@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56498D67.1090600@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2015 at 07:01:43PM +1100, Alexey Kardashevskiy wrote:
>On 11/12/2015 03:55 PM, Gavin Shan wrote:
>>On Thu, Nov 12, 2015 at 02:30:27PM +1100, Daniel Axtens wrote:
>>>Hi Gavin,
>>>
>>>Sorry to have taken so long to resume these reviews!
>>>
>>
>>Thanks for your review, Daniel!
>>
>>>>Currently, the IO and M32 segments are mapped to the corresponding
>>>>PE based on the windows of the parent bridge of PE's primary bus.
>>>>It's not going to work when the windows of root port or upstream
>>>>port of the PCIe switch behind root port are extended to PHB's
>>>>aperatuses in order to support hotplug in subsequent patch.
>>>I'm not _entirely_ sure I understand this.
>>>
>>>I *think* you mean PHB's apertures (i.e. s/aperatuses/apertures/)?
>>>
>>
>>I'll fix the typo in next revision.
>>
>>>>This fixes the issue by mapping IO and M32 segments based on the
>>>>resources of the PCI devices included in the PE, instead of the
>>>>windows of the parent bridge of the PE's primary bus.
>>>
>>>This solution seems to make a lot of sense, but I don't have a very good
>>>understanding of PCI yet: why was it done that way and not this way
>>>originally? Looking at the code, it looks like the old way was simple
>>>but didn't support SR-IOV?
>>>
>>
>>It's not related to SRIOV. Originally, the IO or M32 segments are mapped
>>according to the bridge's windows.
>
>
>Sorry, I do not understand what this means...
>

Before this patchset, the IO or M32 segments consumed by one PE are mapped
according to the windows of PCI bridge of the PE's primary bus if the PE
isn't including all subordinate PCI buses orginated from the bridge. Otherwise,
the bridge's windows should be taken into account as well.

>
>>The bridge windows on root port or the
>>upstream port of the switch behind that will be extended to PHB's apertures.
>
>What does "extended" mean here and why would the windows be extended anyway?
>

It's reserving IO or memory resource for possible plugged adapters in the future.

>>If we still use bridge's windows, all IO and M32 resources are mapped/assigned
>>to the PE corresponding to PCI bus#1 or PCI bus#2. That's not correct any more.
>>So the correct way is to do the mapping based on IO or M32 BARs of the devices
>>included in the PE.
>
>In this patch I see quite a lot of code movements and I fail to spot the
>actual change here...
>
>
>It used to be a single loop:
>
>pci_bus_for_each_resource(pe->pbus, res, i) {
>	/* do stuff for each @res */
>}
>
>and now it is 2 loops inside another loop:
>
>list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
>	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>		res = &pdev->resource[i];
>		/* do stuff for each @res */
>	}
>
>	for (i = 0; i <= PCI_BRIDGE_RESOURCE_NUM; i++) {
>	        res = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
>		/* do stuff for each @res */
>	}
>}
>
>
>Is that correct? If yes, why is not the patch as simple as this? If no, what
>did I miss?
>

That's correct. The resource tracked by the PCI bridge windows can belonged
to another PE instead the one tracked by @pe in the code.

>
>
>>
>>>There are a few comments inline as well.
>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 553d3f3..4ab93f8 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -2741,71 +2741,90 @@ truncate_iov:
>>>>  }
>>>>  #endif /* CONFIG_PCI_IOV */
>>>>
>>>>-/*
>>>>- * This function is supposed to be called on basis of PE from top
>>>>- * to bottom style. So the the I/O or MMIO segment assigned to
>>>>- * parent PE could be overrided by its child PEs if necessary.
>>>>- */
>>>>-static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>>>-				  struct pnv_ioda_pe *pe)
>>>>+static int pnv_ioda_setup_one_res(struct pnv_ioda_pe *pe,
>>>>+				  struct resource *res)
>>>>  {
>>>>-	struct pnv_phb *phb = hose->private_data;
>>>>+	struct pnv_phb *phb = pe->phb;
>>>>  	struct pci_bus_region region;
>>>>-	struct resource *res;
>>>>-	unsigned int segsize;
>>>>-	int *segmap, index, i;
>>>>+	unsigned int index, segsize;
>>>>+	int *segmap;
>>>>  	uint16_t win;
>>>>  	int64_t rc;
>>>
>>>s/int64_t/s64/;
>>>I think we might also want to change the uint16_t as well.
>>>
>>
>>As I explained before, I changed it from s64 to int64_t and I won't change it
>>back since both of them are fine. Same situation to uint16 here. If we really
>>want to clean it all at once, I can do that later, but not in this patchset.
>>
>>>>-	/*
>>>>-	 * NOTE: We only care PCI bus based PE for now. For PCI
>>>>-	 * device based PE, for example SRIOV sensitive VF should
>>>>-	 * be figured out later.
>>>>-	 */
>>>>-	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
>>>>+	if (!res->parent || !res->flags || res->start > res->end)
>>>>+		return 0;
>>>>
>>>>-	pci_bus_for_each_resource(pe->pbus, res, i) {
>>>>-		if (!res || !res->flags ||
>>>>-		    res->start > res->end)
>>>>-			continue;
>>>>+	if (res->flags & IORESOURCE_IO) {
>>>>+		region.start = res->start - phb->ioda.io_pci_base;
>>>>+		region.end   = res->end - phb->ioda.io_pci_base;
>>>>+		segsize      = phb->ioda.io_segsize;
>>>>+		segmap       = phb->ioda.io_segmap;
>>>>+		win          = OPAL_IO_WINDOW_TYPE;
>>>>+	} else if ((res->flags & IORESOURCE_MEM) &&
>>>>+		   !pnv_pci_is_mem_pref_64(res->flags)) {
>>>>+		region.start = res->start -
>>>>+			       phb->hose->mem_offset[0] -
>>>>+			       phb->ioda.m32_pci_base;
>>>>+		region.end   = res->end -
>>>>+			       phb->hose->mem_offset[0] -
>>>>+			       phb->ioda.m32_pci_base;
>>>>+		segsize      = phb->ioda.m32_segsize;
>>>>+		segmap       = phb->ioda.m32_segmap;
>>>>+		win          = OPAL_M32_WINDOW_TYPE;
>
>
>
>This code asks for a helper function
>
>pnv_ioda_do_setup_one_res(start, end, segsize, segmap, win)
>
>and then you won't need many local variables (region, segsize, segmap, win) ;)
>

Sounds like a good idea. I'll change accordingly in next revision.

Thanks,
Gavin
