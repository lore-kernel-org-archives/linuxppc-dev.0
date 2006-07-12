Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 02/16] [powerpc,pseries] Constify & voidify get_property()
Message-ID: <1152678686.20160.02@pokey>
Date: Wed, 12 Jul 2006 15:39:43 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

pseries platform changes.

Built for pseries_defconfig

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 arch/powerpc/platforms/pseries/eeh.c        |   12 ++++-----
 arch/powerpc/platforms/pseries/eeh_driver.c |    4 +--
 arch/powerpc/platforms/pseries/eeh_event.c  |    4 +--
 arch/powerpc/platforms/pseries/firmware.c   |    2 -
 arch/powerpc/platforms/pseries/iommu.c      |   13 ++++------
 arch/powerpc/platforms/pseries/lpar.c       |   10 +++----
 arch/powerpc/platforms/pseries/nvram.c      |    5 ++-
 arch/powerpc/platforms/pseries/pci.c        |    2 -
 arch/powerpc/platforms/pseries/ras.c        |    4 +--
 arch/powerpc/platforms/pseries/rtasd.c      |    4 +--
 arch/powerpc/platforms/pseries/setup.c      |   12 ++++-----
 arch/powerpc/platforms/pseries/smp.c        |    8 +++---
 arch/powerpc/platforms/pseries/xics.c       |   22 ++++++++---------
 drivers/char/hvc_vio.c                      |    4 +--
 drivers/char/hvsi.c                         |    7 ++---
 drivers/pci/hotplug/rpaphp_core.c           |   36 ++++++++++++++--------------
 16 files changed, 74 insertions(+), 75 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/eeh.c
+++ linux-2.6/arch/powerpc/platforms/pseries/eeh.c
@@ -691,11 +691,11 @@ static void *early_enable_eeh(struct dev
 {
 	struct eeh_early_enable_info *info = data;
 	int ret;
-	char *status = get_property(dn, "status", NULL);
-	u32 *class_code = (u32 *)get_property(dn, "class-code", NULL);
-	u32 *vendor_id = (u32 *)get_property(dn, "vendor-id", NULL);
-	u32 *device_id = (u32 *)get_property(dn, "device-id", NULL);
-	u32 *regs;
+	const char *status = get_property(dn, "status", NULL);
+	const u32 *class_code = get_property(dn, "class-code", NULL);
+	const u32 *vendor_id = get_property(dn, "vendor-id", NULL);
+	const u32 *device_id = get_property(dn, "device-id", NULL);
+	const u32 *regs;
 	int enable;
 	struct pci_dn *pdn = PCI_DN(dn);
 
@@ -737,7 +737,7 @@ static void *early_enable_eeh(struct dev
 
 	/* Ok... see if this device supports EEH.  Some do, some don't,
 	 * and the only way to find out is to check each and every one. */
-	regs = (u32 *)get_property(dn, "reg", NULL);
+	regs = get_property(dn, "reg", NULL);
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
 		/* Try to enable eeh */
Index: linux-2.6/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/eeh_driver.c
+++ linux-2.6/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -268,14 +268,14 @@ struct pci_dn * handle_eeh_events (struc
 
 	if (!frozen_dn) {
 
-		location = (char *) get_property(event->dn, "ibm,loc-code", NULL);
+		location = get_property(event->dn, "ibm,loc-code", NULL);
 		location = location ? location : "unknown";
 		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
 		                "for location=%s pci addr=%s\n",
 		        location, pci_name(event->dev));
 		return NULL;
 	}
-	location = (char *) get_property(frozen_dn, "ibm,loc-code", NULL);
+	location = get_property(frozen_dn, "ibm,loc-code", NULL);
 	location = location ? location : "unknown";
 
 	/* There are two different styles for coming up with the PE.
Index: linux-2.6/arch/powerpc/platforms/pseries/eeh_event.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/eeh_event.c
+++ linux-2.6/arch/powerpc/platforms/pseries/eeh_event.c
@@ -124,11 +124,11 @@ int eeh_send_failure_event (struct devic
 {
 	unsigned long flags;
 	struct eeh_event *event;
-	char *location;
+	const char *location;
 
 	if (!mem_init_done) {
 		printk(KERN_ERR "EEH: event during early boot not handled\n");
-		location = (char *) get_property(dn, "ibm,loc-code", NULL);
+		location = get_property(dn, "ibm,loc-code", NULL);
 		printk(KERN_ERR "EEH: device node = %s\n", dn->full_name);
 		printk(KERN_ERR "EEH: PCI location = %s\n", location);
 		return 1;
Index: linux-2.6/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/iommu.c
+++ linux-2.6/arch/powerpc/platforms/pseries/iommu.c
@@ -267,13 +267,12 @@ static void iommu_table_setparms(struct 
 				 struct iommu_table *tbl)
 {
 	struct device_node *node;
-	unsigned long *basep;
-	unsigned int *sizep;
+	const unsigned long *basep, *sizep;
 
 	node = (struct device_node *)phb->arch_data;
 
-	basep = (unsigned long *)get_property(node, "linux,tce-base", NULL);
-	sizep = (unsigned int *)get_property(node, "linux,tce-size", NULL);
+	basep = get_property(node, "linux,tce-base", NULL);
+	sizep = get_property(node, "linux,tce-size", NULL);
 	if (basep == NULL || sizep == NULL) {
 		printk(KERN_ERR "PCI_DMA: iommu_table_setparms: %s has "
 				"missing tce entries !\n", dn->full_name);
@@ -315,7 +314,7 @@ static void iommu_table_setparms(struct 
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct device_node *dn,
 				      struct iommu_table *tbl,
-				      unsigned char *dma_window)
+				      const void *dma_window)
 {
 	unsigned long offset, size;
 
@@ -415,7 +414,7 @@ static void iommu_bus_setup_pSeriesLP(st
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	unsigned char *dma_window = NULL;
+	const void *dma_window = NULL;
 
 	DBG("iommu_bus_setup_pSeriesLP, bus %p, bus->self %p\n", bus, bus->self);
 
@@ -519,7 +518,7 @@ static void iommu_dev_setup_pSeriesLP(st
 {
 	struct device_node *pdn, *dn;
 	struct iommu_table *tbl;
-	unsigned char *dma_window = NULL;
+	const void *dma_window = NULL;
 	struct pci_dn *pci;
 
 	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, pci_name(dev));
Index: linux-2.6/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/lpar.c
+++ linux-2.6/arch/powerpc/platforms/pseries/lpar.c
@@ -204,20 +204,20 @@ void __init udbg_init_debug_lpar(void)
 void __init find_udbg_vterm(void)
 {
 	struct device_node *stdout_node;
-	u32 *termno;
-	char *name;
+	const u32 *termno;
+	const char *name;
 	int add_console;
 
 	/* find the boot console from /chosen/stdout */
 	if (!of_chosen)
 		return;
-	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
+	name = get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name == NULL)
 		return;
 	stdout_node = of_find_node_by_path(name);
 	if (!stdout_node)
 		return;
-	name = (char *)get_property(stdout_node, "name", NULL);
+	name = get_property(stdout_node, "name", NULL);
 	if (!name) {
 		printk(KERN_WARNING "stdout node missing 'name' property!\n");
 		goto out;
@@ -228,7 +228,7 @@ void __init find_udbg_vterm(void)
 	/* Check if it's a virtual terminal */
 	if (strncmp(name, "vty", 3) != 0)
 		goto out;
-	termno = (u32 *)get_property(stdout_node, "reg", NULL);
+	termno = get_property(stdout_node, "reg", NULL);
 	if (termno == NULL)
 		goto out;
 	vtermno = termno[0];
Index: linux-2.6/arch/powerpc/platforms/pseries/nvram.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/nvram.c
+++ linux-2.6/arch/powerpc/platforms/pseries/nvram.c
@@ -123,13 +123,14 @@ static ssize_t pSeries_nvram_get_size(vo
 int __init pSeries_nvram_init(void)
 {
 	struct device_node *nvram;
-	unsigned int *nbytes_p, proplen;
+	const unsigned int *nbytes_p;
+	unsigned int proplen;
 
 	nvram = of_find_node_by_type(NULL, "nvram");
 	if (nvram == NULL)
 		return -ENODEV;
 
-	nbytes_p = (unsigned int *)get_property(nvram, "#bytes", &proplen);
+	nbytes_p = get_property(nvram, "#bytes", &proplen);
 	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
 		return -EIO;
 
Index: linux-2.6/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/ras.c
+++ linux-2.6/arch/powerpc/platforms/pseries/ras.c
@@ -79,7 +79,7 @@ static void request_ras_irqs(struct devi
 {
 	int i, index, count = 0;
 	struct of_irq oirq;
-	u32 *opicprop;
+	const u32 *opicprop;
 	unsigned int opicplen;
 	unsigned int virqs[16];
 
@@ -87,7 +87,7 @@ static void request_ras_irqs(struct devi
 	 * map those interrupts using the default interrupt host and default
 	 * trigger
 	 */
-	opicprop = (u32 *)get_property(np, "open-pic-interrupt", &opicplen);
+	opicprop = get_property(np, "open-pic-interrupt", &opicplen);
 	if (opicprop) {
 		opicplen /= sizeof(u32);
 		for (i = 0; i < opicplen; i++) {
Index: linux-2.6/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/rtasd.c
+++ linux-2.6/arch/powerpc/platforms/pseries/rtasd.c
@@ -359,11 +359,11 @@ static int enable_surveillance(int timeo
 static int get_eventscan_parms(void)
 {
 	struct device_node *node;
-	int *ip;
+	const int *ip;
 
 	node = of_find_node_by_path("/rtas");
 
-	ip = (int *)get_property(node, "rtas-event-scan-rate", NULL);
+	ip = get_property(node, "rtas-event-scan-rate", NULL);
 	if (ip == NULL) {
 		printk(KERN_ERR "rtasd: no rtas-event-scan-rate\n");
 		of_node_put(node);
Index: linux-2.6/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux-2.6/arch/powerpc/platforms/pseries/setup.c
@@ -133,9 +133,9 @@ void pseries_8259_cascade(unsigned int i
 static void __init pseries_mpic_init_IRQ(void)
 {
 	struct device_node *np, *old, *cascade = NULL;
-        unsigned int *addrp;
+        const unsigned int *addrp;
 	unsigned long intack = 0;
-	unsigned int *opprop;
+	const unsigned int *opprop;
 	unsigned long openpic_addr = 0;
 	unsigned int cascade_irq;
 	int naddr, n, i, opplen;
@@ -143,7 +143,7 @@ static void __init pseries_mpic_init_IRQ
 
 	np = of_find_node_by_path("/");
 	naddr = prom_n_addr_cells(np);
-	opprop = (unsigned int *) get_property(np, "platform-open-pic", &opplen);
+	opprop = get_property(np, "platform-open-pic", &opplen);
 	if (opprop != 0) {
 		openpic_addr = of_read_number(opprop, naddr);
 		printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
@@ -192,7 +192,7 @@ static void __init pseries_mpic_init_IRQ
 			break;
 		if (strcmp(np->name, "pci") != 0)
 			continue;
-		addrp = (u32 *)get_property(np, "8259-interrupt-acknowledge",
+		addrp = get_property(np, "8259-interrupt-acknowledge",
 					    NULL);
 		if (addrp == NULL)
 			continue;
@@ -249,11 +249,11 @@ static void pseries_kexec_cpu_down_xics(
 static void __init pseries_discover_pic(void)
 {
 	struct device_node *np;
-	char *typep;
+	const char *typep;
 
 	for (np = NULL; (np = of_find_node_by_name(np,
 						   "interrupt-controller"));) {
-		typep = (char *)get_property(np, "compatible", NULL);
+		typep = get_property(np, "compatible", NULL);
 		if (strstr(typep, "open-pic")) {
 			pSeries_mpic_node = of_node_get(np);
 			ppc_md.init_IRQ       = pseries_mpic_init_IRQ;
Index: linux-2.6/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/smp.c
+++ linux-2.6/arch/powerpc/platforms/pseries/smp.c
@@ -145,9 +145,9 @@ static int pSeries_add_processor(struct 
 	unsigned int cpu;
 	cpumask_t candidate_map, tmp = CPU_MASK_NONE;
 	int err = -ENOSPC, len, nthreads, i;
-	u32 *intserv;
+	const u32 *intserv;
 
-	intserv = (u32 *)get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
 		return 0;
 
@@ -205,9 +205,9 @@ static void pSeries_remove_processor(str
 {
 	unsigned int cpu;
 	int len, nthreads, i;
-	u32 *intserv;
+	const u32 *intserv;
 
-	intserv = (u32 *)get_property(np, "ibm,ppc-interrupt-server#s", &len);
+	intserv = get_property(np, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
 		return;
 
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c
@@ -604,14 +604,14 @@ static void __init xics_init_one_node(st
 				      unsigned int *indx)
 {
 	unsigned int ilen;
-	u32 *ireg;
+	const u32 *ireg;
 
 	/* This code does the theorically broken assumption that the interrupt
 	 * server numbers are the same as the hard CPU numbers.
 	 * This happens to be the case so far but we are playing with fire...
 	 * should be fixed one of these days. -BenH.
 	 */
-	ireg = (u32 *)get_property(np, "ibm,interrupt-server-ranges", NULL);
+	ireg = get_property(np, "ibm,interrupt-server-ranges", NULL);
 
 	/* Do that ever happen ? we'll know soon enough... but even good'old
 	 * f80 does have that property ..
@@ -623,7 +623,7 @@ static void __init xics_init_one_node(st
 		 */
 		*indx = *ireg;
 	}
-	ireg = (u32 *)get_property(np, "reg", &ilen);
+	ireg = get_property(np, "reg", &ilen);
 	if (!ireg)
 		panic("xics_init_IRQ: can't find interrupt reg property");
 
@@ -649,7 +649,7 @@ static void __init xics_setup_8259_casca
 {
 	struct device_node *np, *old, *found = NULL;
 	int cascade, naddr;
-	u32 *addrp;
+	const u32 *addrp;
 	unsigned long intack = 0;
 
 	for_each_node_by_type(np, "interrupt-controller")
@@ -675,7 +675,7 @@ static void __init xics_setup_8259_casca
 			break;
 		if (strcmp(np->name, "pci") != 0)
 			continue;
-		addrp = (u32 *)get_property(np, "8259-interrupt-acknowledge", NULL);
+		addrp = get_property(np, "8259-interrupt-acknowledge", NULL);
 		if (addrp == NULL)
 			continue;
 		naddr = prom_n_addr_cells(np);
@@ -694,7 +694,8 @@ void __init xics_init_IRQ(void)
 {
 	int i;
 	struct device_node *np;
-	u32 *ireg, ilen, indx = 0;
+	u32 ilen, indx = 0;
+	const u32 *ireg;
 	int found = 0;
 
 	ppc64_boot_msg(0x20, "XICS Init");
@@ -719,18 +720,17 @@ void __init xics_init_IRQ(void)
 	for (np = of_find_node_by_type(NULL, "cpu");
 	     np;
 	     np = of_find_node_by_type(np, "cpu")) {
-		ireg = (u32 *)get_property(np, "reg", &ilen);
+		ireg = get_property(np, "reg", &ilen);
 		if (ireg && ireg[0] == get_hard_smp_processor_id(boot_cpuid)) {
-			ireg = (u32 *)get_property(np,
-						  "ibm,ppc-interrupt-gserver#s",
-						   &ilen);
+			ireg = get_property(np,
+					"ibm,ppc-interrupt-gserver#s", &ilen);
 			i = ilen / sizeof(int);
 			if (ireg && i > 0) {
 				default_server = ireg[0];
 				/* take last element */
 				default_distrib_server = ireg[i-1];
 			}
-			ireg = (u32 *)get_property(np,
+			ireg = get_property(np,
 					"ibm,interrupt-server#-size", NULL);
 			if (ireg)
 				interrupt_server_size = *ireg;
Index: linux-2.6/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/rpaphp_core.c
+++ linux-2.6/drivers/pci/hotplug/rpaphp_core.c
@@ -176,16 +176,16 @@ static int get_max_bus_speed(struct hotp
 	return 0;
 }
 
-static int get_children_props(struct device_node *dn, int **drc_indexes,
-		int **drc_names, int **drc_types, int **drc_power_domains)
-{
-	int *indexes, *names;
-	int *types, *domains;
-
-	indexes = (int *) get_property(dn, "ibm,drc-indexes", NULL);
-	names = (int *) get_property(dn, "ibm,drc-names", NULL);
-	types = (int *) get_property(dn, "ibm,drc-types", NULL);
-	domains = (int *) get_property(dn, "ibm,drc-power-domains", NULL);
+static int get_children_props(struct device_node *dn, const int **drc_indexes,
+		const int **drc_names, const int **drc_types,
+		const int **drc_power_domains)
+{
+	const int *indexes, *names, *types, *domains;
+
+	indexes = get_property(dn, "ibm,drc-indexes", NULL);
+	names = get_property(dn, "ibm,drc-names", NULL);
+	types = get_property(dn, "ibm,drc-types", NULL);
+	domains = get_property(dn, "ibm,drc-power-domains", NULL);
 
 	if (!indexes || !names || !types || !domains) {
 		/* Slot does not have dynamically-removable children */
@@ -212,13 +212,13 @@ static int get_children_props(struct dev
 int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 		char **drc_name, char **drc_type, int *drc_power_domain)
 {
-	int *indexes, *names;
-	int *types, *domains;
-	unsigned int *my_index;
+	const int *indexes, *names;
+	const int *types, *domains;
+	const unsigned int *my_index;
 	char *name_tmp, *type_tmp;
 	int i, rc;
 
-	my_index = (int *) get_property(dn, "ibm,my-drc-index", NULL);
+	my_index = get_property(dn, "ibm,my-drc-index", NULL);
 	if (!my_index) {
 		/* Node isn't DLPAR/hotplug capable */
 		return -EINVAL;
@@ -265,10 +265,10 @@ static int is_php_type(char *drc_type)
 	return 1;
 }
 
-static int is_php_dn(struct device_node *dn, int **indexes, int **names,
-		int **types, int **power_domains)
+static int is_php_dn(struct device_node *dn, const int **indexes,
+		const int **names, const int **types, const int **power_domains)
 {
-	int *drc_types;
+	const int *drc_types;
 	int rc;
 
 	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
@@ -296,7 +296,7 @@ int rpaphp_add_slot(struct device_node *
 	struct slot *slot;
 	int retval = 0;
 	int i;
-	int *indexes, *names, *types, *power_domains;
+	const int *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
 	dbg("Entry %s: dn->full_name=%s\n", __FUNCTION__, dn->full_name);
Index: linux-2.6/arch/powerpc/platforms/pseries/firmware.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/firmware.c
+++ linux-2.6/arch/powerpc/platforms/pseries/firmware.c
@@ -68,7 +68,7 @@ firmware_features_table[FIRMWARE_MAX_FEA
 void __init fw_feature_init(void)
 {
 	struct device_node *dn;
-	char *hypertas, *s;
+	const char *hypertas, *s;
 	int len, i;
 
 	DBG(" -> fw_feature_init()\n");
Index: linux-2.6/arch/powerpc/platforms/pseries/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/pci.c
+++ linux-2.6/arch/powerpc/platforms/pseries/pci.c
@@ -60,7 +60,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI
 static void __devinit check_s7a(void)
 {
 	struct device_node *root;
-	char *model;
+	const char *model;
 
 	s7a_workaround = 0;
 	root = of_find_node_by_path("/");
Index: linux-2.6/drivers/char/hvc_vio.c
===================================================================
--- linux-2.6.orig/drivers/char/hvc_vio.c
+++ linux-2.6/drivers/char/hvc_vio.c
@@ -140,7 +140,7 @@ static int hvc_find_vtys(void)
 
 	for (vty = of_find_node_by_name(NULL, "vty"); vty != NULL;
 			vty = of_find_node_by_name(vty, "vty")) {
-		uint32_t *vtermno;
+		const uint32_t *vtermno;
 
 		/* We have statically defined space for only a certain number
 		 * of console adapters.
@@ -148,7 +148,7 @@ static int hvc_find_vtys(void)
 		if (num_found >= MAX_NR_HVC_CONSOLES)
 			break;
 
-		vtermno = (uint32_t *)get_property(vty, "reg", NULL);
+		vtermno = get_property(vty, "reg", NULL);
 		if (!vtermno)
 			continue;
 
Index: linux-2.6/drivers/char/hvsi.c
===================================================================
--- linux-2.6.orig/drivers/char/hvsi.c
+++ linux-2.6/drivers/char/hvsi.c
@@ -1276,11 +1276,10 @@ static int __init hvsi_console_init(void
 			vty != NULL;
 			vty = of_find_compatible_node(vty, "serial", "hvterm-protocol")) {
 		struct hvsi_struct *hp;
-		uint32_t *vtermno;
-		uint32_t *irq;
+		const uint32_t *vtermno, *irq;
 
-		vtermno = (uint32_t *)get_property(vty, "reg", NULL);
-		irq = (uint32_t *)get_property(vty, "interrupts", NULL);
+		vtermno = get_property(vty, "reg", NULL);
+		irq = get_property(vty, "interrupts", NULL);
 		if (!vtermno || !irq)
 			continue;
 
