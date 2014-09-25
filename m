Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CB4C1A004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:39:49 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 25 Sep 2014 16:39:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0E689357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:39:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P6fMdu32506060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P6dc1j002821
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:39:39 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH v3] powerpc/iommu/ddw: Fix endianness
Date: Thu, 25 Sep 2014 16:39:18 +1000
Message-Id: <1411627167-22927-1-git-send-email-aik@ozlabs.ru>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

rtas_call() accepts and returns values in CPU endianness.
The ddw_query_response and ddw_create_response structs members are
defined and treated as BE but as they are passed to rtas_call() as
(u32 *) and they get byteswapped automatically, the data is CPU-endian.
This fixes ddw_query_response and ddw_create_response definitions and use.

of_read_number() is designed to work with device tree cells - it assumes
the input is big-endian and returns data in CPU-endian. However due
to the ddw_create_response struct fix, create.addr_hi/lo are already
CPU-endian so do not byteswap them.

ddw_avail is a pointer to the "ibm,ddw-applicable" property which contains
3 cells which are big-endian as it is a device tree. rtas_call() accepts
a RTAS token in CPU-endian. This makes use of of_property_read_u32_array
to byte swap and avoid the need for a number of be32_to_cpu calls.

Cc: stable@vger.kernel.org # v3.13
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Anton Blanchard <anton@samba.org>
[aik: folded Anton's patch with of_property_read_u32_array]
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* of_property_read_u32_array() is used for ddw_avail[]

v2:
* updated commit log
* fixed definition of ddw_query_response and ddw_create_response
---
 arch/powerpc/platforms/pseries/iommu.c | 51 +++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4642d6a..de1ec54 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -329,16 +329,16 @@ struct direct_window {
 
 /* Dynamic DMA Window support */
 struct ddw_query_response {
-	__be32 windows_available;
-	__be32 largest_available_block;
-	__be32 page_size;
-	__be32 migration_capable;
+	u32 windows_available;
+	u32 largest_available_block;
+	u32 page_size;
+	u32 migration_capable;
 };
 
 struct ddw_create_response {
-	__be32 liobn;
-	__be32 addr_hi;
-	__be32 addr_lo;
+	u32 liobn;
+	u32 addr_hi;
+	u32 addr_lo;
 };
 
 static LIST_HEAD(direct_window_list);
@@ -725,16 +725,18 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 {
 	struct dynamic_dma_window_prop *dwp;
 	struct property *win64;
-	const u32 *ddw_avail;
+	u32 ddw_avail[3];
 	u64 liobn;
-	int len, ret = 0;
+	int ret = 0;
+
+	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
+					 &ddw_avail[0], 3);
 
-	ddw_avail = of_get_property(np, "ibm,ddw-applicable", &len);
 	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
 	if (!win64)
 		return;
 
-	if (!ddw_avail || len < 3 * sizeof(u32) || win64->length < sizeof(*dwp))
+	if (ret || win64->length < sizeof(*dwp))
 		goto delprop;
 
 	dwp = win64->value;
@@ -872,8 +874,9 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 
 	do {
 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
-		ret = rtas_call(ddw_avail[1], 5, 4, (u32 *)create, cfg_addr,
-				BUID_HI(buid), BUID_LO(buid), page_shift, window_shift);
+		ret = rtas_call(ddw_avail[1], 5, 4, (u32 *)create,
+				cfg_addr, BUID_HI(buid), BUID_LO(buid),
+				page_shift, window_shift);
 	} while (rtas_busy_delay(ret));
 	dev_info(&dev->dev,
 		"ibm,create-pe-dma-window(%x) %x %x %x %x %x returned %d "
@@ -910,7 +913,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	int page_shift;
 	u64 dma_addr, max_addr;
 	struct device_node *dn;
-	const u32 *uninitialized_var(ddw_avail);
+	u32 ddw_avail[3];
 	struct direct_window *window;
 	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
@@ -942,8 +945,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * for the given node in that order.
 	 * the property is actually in the parent, not the PE
 	 */
-	ddw_avail = of_get_property(pdn, "ibm,ddw-applicable", &len);
-	if (!ddw_avail || len < 3 * sizeof(u32))
+	ret = of_property_read_u32_array(pdn, "ibm,ddw-applicable",
+					 &ddw_avail[0], 3);
+	if (ret)
 		goto out_failed;
 
        /*
@@ -966,11 +970,11 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		dev_dbg(&dev->dev, "no free dynamic windows");
 		goto out_failed;
 	}
-	if (be32_to_cpu(query.page_size) & 4) {
+	if (query.page_size & 4) {
 		page_shift = 24; /* 16MB */
-	} else if (be32_to_cpu(query.page_size) & 2) {
+	} else if (query.page_size & 2) {
 		page_shift = 16; /* 64kB */
-	} else if (be32_to_cpu(query.page_size) & 1) {
+	} else if (query.page_size & 1) {
 		page_shift = 12; /* 4kB */
 	} else {
 		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
@@ -980,7 +984,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
 	max_addr = memory_hotplug_max();
-	if (be32_to_cpu(query.largest_available_block) < (max_addr >> page_shift)) {
+	if (query.largest_available_block < (max_addr >> page_shift)) {
 		dev_dbg(&dev->dev, "can't map partiton max 0x%llx with %u "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
 			  1ULL << page_shift);
@@ -1006,8 +1010,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (ret != 0)
 		goto out_free_prop;
 
-	ddwprop->liobn = create.liobn;
-	ddwprop->dma_base = cpu_to_be64(of_read_number(&create.addr_hi, 2));
+	ddwprop->liobn = cpu_to_be32(create.liobn);
+	ddwprop->dma_base = cpu_to_be64(((u64)create.addr_hi << 32) |
+			create.addr_lo);
 	ddwprop->tce_shift = cpu_to_be32(page_shift);
 	ddwprop->window_shift = cpu_to_be32(len);
 
@@ -1039,7 +1044,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dma_addr = of_read_number(&create.addr_hi, 2);
+	dma_addr = be64_to_cpu(ddwprop->dma_base);
 	goto out_unlock;
 
 out_free_window:
-- 
2.0.0
