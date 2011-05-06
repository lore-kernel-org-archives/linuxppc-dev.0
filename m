Return-Path: <nacc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A2621007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 May 2011 09:27:38 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p46N7smY029720
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2011 19:07:54 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p46NRW8e090558
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2011 19:27:33 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p46NRWgR026083
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2011 19:27:32 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix kexec with dynamic dma windows
Date: Fri,  6 May 2011 16:27:30 -0700
Message-Id: <1304724450-27754-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we kexec we look for a particular property added by the first
kernel, "linux,direct64-ddr-window-info", per-device where we already
have set up dynamic dma windows. The current code, though, wasn't
initializing the size of this property and thus when we kexec'd, we
would find the property but read uninitialized memory resulting in
garbage ddw values for the kexec'd kernel and panics. Fix this by
setting the size at enable_ddw() time and ensuring that the size of the
found property is valid at dupe_ddw_if_kexec() time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/iommu.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 6d5412a..019009b 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -730,16 +730,20 @@ static u64 dupe_ddw_if_kexec(struct pci_dev *dev, struct device_node *pdn)
 	pcidn = PCI_DN(dn);
 	direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
 	if (direct64) {
-		window = kzalloc(sizeof(*window), GFP_KERNEL);
-		if (!window) {
+		if (len < sizeof(struct dynamic_dma_window_prop)) {
 			remove_ddw(pdn);
 		} else {
-			window->device = pdn;
-			window->prop = direct64;
-			spin_lock(&direct_window_list_lock);
-			list_add(&window->list, &direct_window_list);
-			spin_unlock(&direct_window_list_lock);
-			dma_addr = direct64->dma_base;
+			window = kzalloc(sizeof(*window), GFP_KERNEL);
+			if (!window) {
+				remove_ddw(pdn);
+			} else {
+				window->device = pdn;
+				window->prop = direct64;
+				spin_lock(&direct_window_list_lock);
+				list_add(&window->list, &direct_window_list);
+				spin_unlock(&direct_window_list_lock);
+				dma_addr = direct64->dma_base;
+			}
 		}
 	}
 
@@ -833,7 +837,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct device_node *dn;
 	const u32 *uninitialized_var(ddr_avail);
 	struct direct_window *window;
-	struct property *uninitialized_var(win64);
+	struct property *win64;
 	struct dynamic_dma_window_prop *ddwprop;
 
 	mutex_lock(&direct_window_init_mutex);
@@ -907,6 +911,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	}
 	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
 	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
+	win64->length = sizeof(*ddwprop);
 	if (!win64->name || !win64->value) {
 		dev_info(&dev->dev,
 			"couldn't allocate property name and value\n");
-- 
1.7.4.1
