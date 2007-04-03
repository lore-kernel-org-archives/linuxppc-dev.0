Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 006D8DDEEE
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:31 +1000 (EST)
Date: Tue, 3 Apr 2007 22:31:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 05/17] [POWERPC] Rename get_property to of_get_property:
	arch/powerpc/platforms/pseries
Message-Id: <20070403223136.6ecdabbd.sfr@canb.auug.org.au>
In-Reply-To: <20070403223000.5d44b2f1.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/eeh.c         |   10 +++++-----
 arch/powerpc/platforms/pseries/eeh_driver.c  |    4 ++--
 arch/powerpc/platforms/pseries/eeh_event.c   |    2 +-
 arch/powerpc/platforms/pseries/firmware.c    |    2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    4 ++--
 arch/powerpc/platforms/pseries/iommu.c       |   12 ++++++------
 arch/powerpc/platforms/pseries/lpar.c        |    6 +++---
 arch/powerpc/platforms/pseries/nvram.c       |    2 +-
 arch/powerpc/platforms/pseries/pci.c         |    2 +-
 arch/powerpc/platforms/pseries/ras.c         |    2 +-
 arch/powerpc/platforms/pseries/rtasd.c       |    2 +-
 arch/powerpc/platforms/pseries/setup.c       |    8 ++++----
 arch/powerpc/platforms/pseries/xics.c        |   15 ++++++++-------
 13 files changed, 36 insertions(+), 35 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index a56be71..48fbd44 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -789,10 +789,10 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 	unsigned int rets[3];
 	struct eeh_early_enable_info *info = data;
 	int ret;
-	const char *status = get_property(dn, "status", NULL);
-	const u32 *class_code = get_property(dn, "class-code", NULL);
-	const u32 *vendor_id = get_property(dn, "vendor-id", NULL);
-	const u32 *device_id = get_property(dn, "device-id", NULL);
+	const char *status = of_get_property(dn, "status", NULL);
+	const u32 *class_code = of_get_property(dn, "class-code", NULL);
+	const u32 *vendor_id = of_get_property(dn, "vendor-id", NULL);
+	const u32 *device_id = of_get_property(dn, "device-id", NULL);
 	const u32 *regs;
 	int enable;
 	struct pci_dn *pdn = PCI_DN(dn);
@@ -835,7 +835,7 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 
 	/* Ok... see if this device supports EEH.  Some do, some don't,
 	 * and the only way to find out is to check each and every one. */
-	regs = get_property(dn, "reg", NULL);
+	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
 		/* Try to enable eeh */
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 8cc331e..3170e00 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -314,14 +314,14 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 
 	if (!frozen_dn) {
 
-		location = get_property(event->dn, "ibm,loc-code", NULL);
+		location = of_get_property(event->dn, "ibm,loc-code", NULL);
 		location = location ? location : "unknown";
 		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
 		                "for location=%s pci addr=%s\n",
 		        location, pci_name(event->dev));
 		return NULL;
 	}
-	location = get_property(frozen_dn, "ibm,loc-code", NULL);
+	location = of_get_property(frozen_dn, "ibm,loc-code", NULL);
 	location = location ? location : "unknown";
 
 	/* There are two different styles for coming up with the PE.
diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
index 221dec8..ddb80f5 100644
--- a/arch/powerpc/platforms/pseries/eeh_event.c
+++ b/arch/powerpc/platforms/pseries/eeh_event.c
@@ -126,7 +126,7 @@ int eeh_send_failure_event (struct device_node *dn,
 
 	if (!mem_init_done) {
 		printk(KERN_ERR "EEH: event during early boot not handled\n");
-		location = get_property(dn, "ibm,loc-code", NULL);
+		location = of_get_property(dn, "ibm,loc-code", NULL);
 		printk(KERN_ERR "EEH: device node = %s\n", dn->full_name);
 		printk(KERN_ERR "EEH: PCI location = %s\n", location);
 		return 1;
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 90522e3..29bf83b 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -80,7 +80,7 @@ void __init fw_feature_init(void)
 		goto out;
 	}
 
-	hypertas = get_property(dn, "ibm,hypertas-functions", &len);
+	hypertas = of_get_property(dn, "ibm,hypertas-functions", &len);
 	if (hypertas == NULL)
 		goto out;
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index f460b9c..9711eb0 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -143,7 +143,7 @@ static int pseries_add_processor(struct device_node *np)
 	int err = -ENOSPC, len, nthreads, i;
 	const u32 *intserv;
 
-	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
 		return 0;
 
@@ -203,7 +203,7 @@ static void pseries_remove_processor(struct device_node *np)
 	int len, nthreads, i;
 	const u32 *intserv;
 
-	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
 		return;
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index f9510a5..66665c8 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -253,8 +253,8 @@ static void iommu_table_setparms(struct pci_controller *phb,
 
 	node = (struct device_node *)phb->arch_data;
 
-	basep = get_property(node, "linux,tce-base", NULL);
-	sizep = get_property(node, "linux,tce-size", NULL);
+	basep = of_get_property(node, "linux,tce-base", NULL);
+	sizep = of_get_property(node, "linux,tce-size", NULL);
 	if (basep == NULL || sizep == NULL) {
 		printk(KERN_ERR "PCI_DMA: iommu_table_setparms: %s has "
 				"missing tce entries !\n", dn->full_name);
@@ -404,7 +404,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 
 	/* Find nearest ibm,dma-window, walking up the device tree */
 	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
-		dma_window = get_property(pdn, "ibm,dma-window", NULL);
+		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window != NULL)
 			break;
 	}
@@ -499,7 +499,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 
 	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
 	     pdn = pdn->parent) {
-		dma_window = get_property(pdn, "ibm,dma-window", NULL);
+		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window)
 			break;
 	}
@@ -548,7 +548,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 	switch (action) {
 	case PSERIES_RECONFIG_REMOVE:
 		if (pci && pci->iommu_table &&
-		    get_property(np, "ibm,dma-window", NULL))
+		    of_get_property(np, "ibm,dma-window", NULL))
 			iommu_free_table(np);
 		break;
 	default:
@@ -565,7 +565,7 @@ static struct notifier_block iommu_reconfig_nb = {
 /* These are called very early. */
 void iommu_init_early_pSeries(void)
 {
-	if (of_chosen && get_property(of_chosen, "linux,iommu-off", NULL)) {
+	if (of_chosen && of_get_property(of_chosen, "linux,iommu-off", NULL)) {
 		/* Direct I/O, IOMMU off */
 		ppc_md.pci_dma_dev_setup = NULL;
 		ppc_md.pci_dma_bus_setup = NULL;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 843ee96..3a70e8a 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -209,13 +209,13 @@ void __init find_udbg_vterm(void)
 	/* find the boot console from /chosen/stdout */
 	if (!of_chosen)
 		return;
-	name = get_property(of_chosen, "linux,stdout-path", NULL);
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name == NULL)
 		return;
 	stdout_node = of_find_node_by_path(name);
 	if (!stdout_node)
 		return;
-	name = get_property(stdout_node, "name", NULL);
+	name = of_get_property(stdout_node, "name", NULL);
 	if (!name) {
 		printk(KERN_WARNING "stdout node missing 'name' property!\n");
 		goto out;
@@ -226,7 +226,7 @@ void __init find_udbg_vterm(void)
 	/* Check if it's a virtual terminal */
 	if (strncmp(name, "vty", 3) != 0)
 		goto out;
-	termno = get_property(stdout_node, "reg", NULL);
+	termno = of_get_property(stdout_node, "reg", NULL);
 	if (termno == NULL)
 		goto out;
 	vtermno = termno[0];
diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 64163ce..f68903e 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -130,7 +130,7 @@ int __init pSeries_nvram_init(void)
 	if (nvram == NULL)
 		return -ENODEV;
 
-	nbytes_p = get_property(nvram, "#bytes", &proplen);
+	nbytes_p = of_get_property(nvram, "#bytes", &proplen);
 	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
 		return -EIO;
 
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index fa59124..ccaaa98 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -39,7 +39,7 @@ void pcibios_name_device(struct pci_dev *dev)
 	 */
 	dn = pci_device_to_OF_node(dev);
 	if (dn) {
-		char *loc_code = get_property(dn, "ibm,loc-code", 0);
+		const char *loc_code = of_get_property(dn, "ibm,loc-code", 0);
 		if (loc_code) {
 			int loc_len = strlen(loc_code);
 			if (loc_len < sizeof(dev->dev.name)) {
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index edc0388..53aa041 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -85,7 +85,7 @@ static void request_ras_irqs(struct device_node *np,
 	 * map those interrupts using the default interrupt host and default
 	 * trigger
 	 */
-	opicprop = get_property(np, "open-pic-interrupt", &opicplen);
+	opicprop = of_get_property(np, "open-pic-interrupt", &opicplen);
 	if (opicprop) {
 		opicplen /= sizeof(u32);
 		for (i = 0; i < opicplen; i++) {
diff --git a/arch/powerpc/platforms/pseries/rtasd.c b/arch/powerpc/platforms/pseries/rtasd.c
index 77d0937..9797b10 100644
--- a/arch/powerpc/platforms/pseries/rtasd.c
+++ b/arch/powerpc/platforms/pseries/rtasd.c
@@ -363,7 +363,7 @@ static int get_eventscan_parms(void)
 
 	node = of_find_node_by_path("/rtas");
 
-	ip = get_property(node, "rtas-event-scan-rate", NULL);
+	ip = of_get_property(node, "rtas-event-scan-rate", NULL);
 	if (ip == NULL) {
 		printk(KERN_ERR "rtasd: no rtas-event-scan-rate\n");
 		of_node_put(node);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 54e93eb..e2fcd23 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -93,7 +93,7 @@ static void pSeries_show_cpuinfo(struct seq_file *m)
 
 	root = of_find_node_by_path("/");
 	if (root)
-		model = get_property(root, "model", NULL);
+		model = of_get_property(root, "model", NULL);
 	seq_printf(m, "machine\t\t: CHRP %s\n", model);
 	of_node_put(root);
 }
@@ -140,7 +140,7 @@ static void __init pseries_mpic_init_IRQ(void)
 
 	np = of_find_node_by_path("/");
 	naddr = of_n_addr_cells(np);
-	opprop = get_property(np, "platform-open-pic", &opplen);
+	opprop = of_get_property(np, "platform-open-pic", &opplen);
 	if (opprop != 0) {
 		openpic_addr = of_read_number(opprop, naddr);
 		printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
@@ -189,7 +189,7 @@ static void __init pseries_mpic_init_IRQ(void)
 			break;
 		if (strcmp(np->name, "pci") != 0)
 			continue;
-		addrp = get_property(np, "8259-interrupt-acknowledge",
+		addrp = of_get_property(np, "8259-interrupt-acknowledge",
 					    NULL);
 		if (addrp == NULL)
 			continue;
@@ -226,7 +226,7 @@ static void __init pseries_discover_pic(void)
 
 	for (np = NULL; (np = of_find_node_by_name(np,
 						   "interrupt-controller"));) {
-		typep = get_property(np, "compatible", NULL);
+		typep = of_get_property(np, "compatible", NULL);
 		if (strstr(typep, "open-pic")) {
 			pSeries_mpic_node = of_node_get(np);
 			ppc_md.init_IRQ       = pseries_mpic_init_IRQ;
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index f0795fa..896cbf3 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -576,7 +576,7 @@ static void __init xics_init_one_node(struct device_node *np,
 	 * This happens to be the case so far but we are playing with fire...
 	 * should be fixed one of these days. -BenH.
 	 */
-	ireg = get_property(np, "ibm,interrupt-server-ranges", NULL);
+	ireg = of_get_property(np, "ibm,interrupt-server-ranges", NULL);
 
 	/* Do that ever happen ? we'll know soon enough... but even good'old
 	 * f80 does have that property ..
@@ -588,7 +588,7 @@ static void __init xics_init_one_node(struct device_node *np,
 		 */
 		*indx = *ireg;
 	}
-	ireg = get_property(np, "reg", &ilen);
+	ireg = of_get_property(np, "reg", &ilen);
 	if (!ireg)
 		panic("xics_init_IRQ: can't find interrupt reg property");
 
@@ -640,7 +640,7 @@ static void __init xics_setup_8259_cascade(void)
 			break;
 		if (strcmp(np->name, "pci") != 0)
 			continue;
-		addrp = get_property(np, "8259-interrupt-acknowledge", NULL);
+		addrp = of_get_property(np, "8259-interrupt-acknowledge", NULL);
 		if (addrp == NULL)
 			continue;
 		naddr = of_n_addr_cells(np);
@@ -664,10 +664,11 @@ static struct device_node *cpuid_to_of_node(int cpu)
 		int i, len;
 		const u32 *intserv;
 
-		intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
+		intserv = of_get_property(np, "ibm,ppc-interrupt-server#s",
+					&len);
 
 		if (!intserv)
-			intserv = get_property(np, "reg", &len);
+			intserv = of_get_property(np, "reg", &len);
 
 		i = len / sizeof(u32);
 
@@ -709,7 +710,7 @@ void __init xics_init_IRQ(void)
 	/* Find the server numbers for the boot cpu. */
 	np = cpuid_to_of_node(boot_cpuid);
 	BUG_ON(!np);
-	ireg = get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
+	ireg = of_get_property(np, "ibm,ppc-interrupt-gserver#s", &ilen);
 	if (!ireg)
 		goto skip_gserver_check;
 	i = ilen / sizeof(int);
@@ -725,7 +726,7 @@ void __init xics_init_IRQ(void)
 			default_server = hcpuid;
 			default_distrib_server = ireg[j+1];
 
-			isize = get_property(np,
+			isize = of_get_property(np,
 					"ibm,interrupt-server#-size", NULL);
 			if (isize)
 				interrupt_server_size = *isize;
-- 
1.5.0.3
