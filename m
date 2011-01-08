Return-Path: <nacc@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62104B7157
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Jan 2011 13:53:54 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p082mmew005129
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jan 2011 19:48:48 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p082rbhv067748
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jan 2011 19:53:37 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p082radl014766
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jan 2011 19:53:37 -0700
Date: Fri, 7 Jan 2011 18:53:34 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: sonnyrao@us.ibm.com, miltonm@bga.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ppc: update dynamic dma support
Message-ID: <20110108025334.GA13468@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
	<1288150518-4026-8-git-send-email-nacc@us.ibm.com>
	<20101209190920.GB25003@us.ibm.com>
	<20101211000744.GA12355@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101211000744.GA12355@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10.12.2010 [16:07:44 -0800], Nishanth Aravamudan wrote:
> On 09.12.2010 [11:09:20 -0800], Nishanth Aravamudan wrote:
> > On 26.10.2010 [20:35:17 -0700], Nishanth Aravamudan wrote:
> > > If firmware allows us to map all of a partition's memory for DMA on a
> > > particular bridge, create a 1:1 mapping of that memory. Add hooks for
> > > dealing with hotplug events. Dyanmic DMA windows can use larger than the
> > > default page size, and we use the largest one possible.
> > > 
> > > Not-yet-signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > > 
> > > ---
> > > 
> > > I've tested this briefly on a machine with suitable firmware/hardware.
> > > Things seem to work well, but I want to do more exhaustive I/O testing
> > > before asking for upstream merging. I would really appreciate any
> > > feedback on the updated approach.
> > > 
> > > Specific questions:
> > > 
> > > Ben, did I hook into the dma_set_mask() platform callback as you
> > > expected? Anything I can do better or which perhaps might lead to
> > > gotchas later?
> > > 
> > > I've added a disable_ddw option, but perhaps it would be better to
> > > just disable the feature if iommu=force?
> > 
> > So for the final version, I probably should document this option in
> > kernel-parameters.txt w/ the patch, right?
> 
> Here's an updated version. Ben, think you can pick this up to your tree?

Hi Ben,

I have a small follow-on patch that tidies up the code a bit and deals
with an error condition on dlpar remove of ddw slots. I'm putting it
below as a follow-on patch, but I can roll it into the v3 patch and post
a v4 if you'd prefer?

Thanks,
Nish


pseries: ddw cleanups
    
Use symbolic constants to access RTAS responses.
    
Disable reconfig notifier's clearing of TCEs and removal of DMA window.
This is handled by firmware currently. If the kernel were to do it, we'd
need a new callback action before the isolation of the slot in question,
or else we'd always get permission errors (firmware revokes the window
automatically).
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 43268f1..c17adf7 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -47,6 +47,20 @@ extern int rtas_setup_phb(struct pci_controller *phb);
 
 extern unsigned long pci_probe_only;
 
+/* Dynamic DMA Window support */
+struct ddw_query_response {
+        u32 windows_available;
+        u32 largest_available_block;
+        u32 page_size;
+        u32 migration_capable;
+};
+
+struct ddw_create_response {
+        u32 liobn;
+        u32 addr_hi;
+        u32 addr_lo;
+};
+
 /* ---- EEH internal-use-only related routines ---- */
 #ifdef CONFIG_EEH
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4ba2338..b6f73c6 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -323,7 +323,7 @@ static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 		dma_offset = next + be64_to_cpu(maprange->dma_base);
 
 		rc = plpar_tce_stuff((u64)be32_to_cpu(maprange->liobn),
-					    (u64)dma_offset,
+					     dma_offset,
 					     0, limit);
 		num_tce -= limit;
 	} while (num_tce > 0 && !rc);
@@ -383,7 +383,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 		}
 
 		rc = plpar_tce_put_indirect(liobn,
-					    (u64)dma_offset,
+					    dma_offset,
 					    (u64)virt_to_abs(tcep),
 					    limit);
 
@@ -731,7 +731,8 @@ static u64 dupe_ddw_if_kexec(struct pci_dev *dev, struct device_node *pdn)
 	return dma_addr;
 }
 
-static int query_ddw(struct pci_dev *dev, const u32 *ddr_avail, u32 *query)
+static int query_ddw(struct pci_dev *dev, const u32 *ddr_avail,
+			struct ddw_query_response *query)
 {
 	struct device_node *dn;
 	struct pci_dn *pcidn;
@@ -751,7 +752,7 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddr_avail, u32 *query)
 	if (pcidn->eeh_pe_config_addr)
 		cfg_addr = pcidn->eeh_pe_config_addr;
 	buid = pcidn->phb->buid;
-	ret = rtas_call(ddr_avail[0], 3, 5, query,
+	ret = rtas_call(ddr_avail[0], 3, 5, (u32 *)query,
 		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
 	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
 		" returned %d\n", ddr_avail[0], cfg_addr, BUID_HI(buid),
@@ -759,7 +760,9 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddr_avail, u32 *query)
 	return ret;
 }
 
-static int create_ddw(struct pci_dev *dev, const u32 *ddr_avail, u32 *create, int page_shift, int window_shift)
+static int create_ddw(struct pci_dev *dev, const u32 *ddr_avail,
+			struct ddw_create_response *create, int page_shift,
+		       	int window_shift)
 {
 	struct device_node *dn;
 	struct pci_dn *pcidn;
@@ -782,14 +785,14 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddr_avail, u32 *create, in
 
 	do {
 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
-		ret = rtas_call(ddr_avail[1], 5, 4, &create[0], cfg_addr,
+		ret = rtas_call(ddr_avail[1], 5, 4, (u32 *)create, cfg_addr,
 				BUID_HI(buid), BUID_LO(buid), page_shift, window_shift);
 	} while(rtas_busy_delay(ret));
 	dev_info(&dev->dev,
 		"ibm,create-pe-dma-window(%x) %x %x %x %x %x returned %d "
 		"(liobn = 0x%x starting addr = %x %x)\n", ddr_avail[1],
 		 cfg_addr, BUID_HI(buid), BUID_LO(buid), page_shift,
-		 window_shift, ret, create[0], create[1], create[2]);
+		 window_shift, ret, create->liobn, create->addr_hi, create->addr_lo);
 	
 	return ret;
 }
@@ -808,7 +811,8 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddr_avail, u32 *create, in
 static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 {
 	int len, ret;
-	u32 query[4], create[3];
+        struct ddw_query_response query;
+        struct ddw_create_response create;
 	int page_shift;
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
@@ -846,11 +850,11 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * of page sizes: supported and supported for migrate-dma.
 	 */
 	dn = pci_device_to_OF_node(dev);
-	ret = query_ddw(dev, ddr_avail, &query[0]);
+	ret = query_ddw(dev, ddr_avail, &query);
 	if (ret != 0)
 		goto out_unlock;
 
-	if (!query[0]) {
+	if (query.windows_available == 0) {
 		/*
 		 * no additional windows are available for this device.
 		 * We might be able to reallocate the existing window,
@@ -859,23 +863,23 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		dev_dbg(&dev->dev, "no free dynamic windows");
 		goto out_unlock;
 	}
-	if (query[2] & 4) {
+	if (query.page_size & 4) {
 		page_shift = 24; /* 16MB */
-	} else if (query[2] & 2) {
+	} else if (query.page_size & 2) {
 		page_shift = 16; /* 64kB */
-	} else if (query[2] & 1) {
+	} else if (query.page_size & 1) {
 		page_shift = 12; /* 4kB */
 	} else {
 		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
-			  query[2]);
+			  query.page_size);
 		goto out_unlock;
 	}
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
 	max_addr = memory_hotplug_max();
-	if (query[1] < (max_addr >> page_shift)) {
+	if (query.largest_available_block < (max_addr >> page_shift)) {
 		dev_dbg(&dev->dev, "can't map partiton max 0x%llx with %u "
-			  "%llu-sized pages\n", max_addr,  query[1],
+			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
 			  1ULL << page_shift);
 		goto out_unlock;
 	}
@@ -894,19 +898,17 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_free_prop;
 	}
 
-	ret = create_ddw(dev, ddr_avail, &create[0], page_shift, len);
+	ret = create_ddw(dev, ddr_avail, &create, page_shift, len);
 	if (ret != 0)
 		goto out_free_prop;
 
-	*ddwprop = (struct dynamic_dma_window_prop) {
-		.liobn = cpu_to_be32(create[0]),
-		.dma_base = cpu_to_be64(((u64)create[1] << 32) + (u64)create[2]),
-		.tce_shift = cpu_to_be32(page_shift),
-		.window_shift = cpu_to_be32(len)
-	};
+	ddwprop->liobn = cpu_to_be32(create.liobn);
+	ddwprop->dma_base = cpu_to_be64(of_read_number(&create.addr_hi, 2));
+	ddwprop->tce_shift = cpu_to_be32(page_shift);
+	ddwprop->window_shift = cpu_to_be32(len);
 
 	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %s\n",
-		  create[0], dn->full_name);
+		  create.liobn, dn->full_name);
 
 	window = kzalloc(sizeof(*window), GFP_KERNEL);
 	if (!window)
@@ -933,7 +935,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dma_addr = of_read_number(&create[1], 2);
+	dma_addr = of_read_number(&create.addr_hi, 2);
 	set_dma_offset(&dev->dev, dma_addr);
 	goto out_unlock;
 
@@ -1118,7 +1120,15 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 		}
 		spin_unlock(&direct_window_list_lock);
 
-		remove_ddw(np);
+		/*
+		 * Because the notifier runs after isolation of the
+		 * slot, we are guaranteed any DMA window has already
+		 * been revoked and the TCEs have been marked invalid,
+		 * so we don't need a call to remove_ddw(np). However,
+		 * if an additional notifier action is added before the
+		 * isolate call, we should update this code for
+		 * completeness with such a call.
+		 */
 		break;
 	default:
 		err = NOTIFY_DONE;

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
