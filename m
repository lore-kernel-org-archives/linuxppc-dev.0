Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 01/16] [powerpc core] Constify & voidify get_property()
Message-ID: <1152678686.20160.01@pokey>
Date: Wed, 12 Jul 2006 15:35:54 +1000 (EST)
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

powerpc core changes.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 arch/powerpc/kernel/btext.c            |   24 +++++------
 arch/powerpc/kernel/ibmebus.c          |    6 +-
 arch/powerpc/kernel/legacy_serial.c    |   35 ++++++++--------
 arch/powerpc/kernel/lparcfg.c          |   11 ++---
 arch/powerpc/kernel/machine_kexec_64.c |   10 +---
 arch/powerpc/kernel/pci_32.c           |   39 ++++++++++--------
 arch/powerpc/kernel/pci_64.c           |   28 +++++++------
 arch/powerpc/kernel/pci_dn.c           |   13 +++---
 arch/powerpc/kernel/prom.c             |   23 +++++------
 arch/powerpc/kernel/prom_parse.c       |   68 ++++++++++++++++-----------------
 arch/powerpc/kernel/rtas-proc.c        |   25 ++++++------
 arch/powerpc/kernel/rtas.c             |   28 +++++++------
 arch/powerpc/kernel/rtas_pci.c         |   22 +++++-----
 arch/powerpc/kernel/setup-common.c     |   19 +++------
 arch/powerpc/kernel/setup_64.c         |   14 +++---
 arch/powerpc/kernel/sysfs.c            |    5 --
 arch/powerpc/kernel/time.c             |    4 -
 arch/powerpc/kernel/vio.c              |   16 +++----
 arch/powerpc/mm/numa.c                 |   31 ++++++---------
 arch/powerpc/sysdev/fsl_soc.c          |   30 +++++++-------
 arch/powerpc/sysdev/mmio_nvram.c       |    4 -
 include/asm-powerpc/ibmebus.h          |    2 
 include/asm-powerpc/prom.h             |   16 +++----
 include/asm-powerpc/vio.h              |    4 -
 24 files changed, 239 insertions(+), 238 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6/arch/powerpc/kernel/prom.c
@@ -942,11 +942,11 @@ void __init early_init_devtree(void *par
 int
 prom_n_addr_cells(struct device_node* np)
 {
-	int* ip;
+	const int *ip;
 	do {
 		if (np->parent)
 			np = np->parent;
-		ip = (int *) get_property(np, "#address-cells", NULL);
+		ip = get_property(np, "#address-cells", NULL);
 		if (ip != NULL)
 			return *ip;
 	} while (np->parent);
@@ -958,11 +958,11 @@ EXPORT_SYMBOL(prom_n_addr_cells);
 int
 prom_n_size_cells(struct device_node* np)
 {
-	int* ip;
+	const int* ip;
 	do {
 		if (np->parent)
 			np = np->parent;
-		ip = (int *) get_property(np, "#size-cells", NULL);
+		ip = get_property(np, "#size-cells", NULL);
 		if (ip != NULL)
 			return *ip;
 	} while (np->parent);
@@ -1034,7 +1034,7 @@ int device_is_compatible(struct device_n
 	const char* cp;
 	int cplen, l;
 
-	cp = (char *) get_property(device, "compatible", &cplen);
+	cp = get_property(device, "compatible", &cplen);
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
@@ -1449,7 +1449,7 @@ static int of_finish_dynamic_node(struct
 {
 	struct device_node *parent = of_get_parent(node);
 	int err = 0;
-	phandle *ibm_phandle;
+	const phandle *ibm_phandle;
 
 	node->name = get_property(node, "name", NULL);
 	node->type = get_property(node, "device_type", NULL);
@@ -1466,8 +1466,7 @@ static int of_finish_dynamic_node(struct
 		return -ENODEV;
 
 	/* fix up new node's linux_phandle field */
-	if ((ibm_phandle = (unsigned int *)get_property(node,
-							"ibm,phandle", NULL)))
+	if ((ibm_phandle = get_property(node, "ibm,phandle", NULL)))
 		node->linux_phandle = *ibm_phandle;
 
 out:
@@ -1658,16 +1657,16 @@ struct device_node *of_get_cpu_node(int 
 	hardid = get_hard_smp_processor_id(cpu);
 
 	for_each_node_by_type(np, "cpu") {
-		u32 *intserv;
+		const u32 *intserv;
 		unsigned int plen, t;
 
 		/* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
 		 * fallback to "reg" property and assume no threads
 		 */
-		intserv = (u32 *)get_property(np, "ibm,ppc-interrupt-server#s",
-					      &plen);
+		intserv = get_property(np, "ibm,ppc-interrupt-server#s",
+				&plen);
 		if (intserv == NULL) {
-			u32 *reg = (u32 *)get_property(np, "reg", NULL);
+			const u32 *reg = get_property(np, "reg", NULL);
 			if (reg == NULL)
 				continue;
 			if (*reg == hardid) {
Index: linux-2.6/arch/powerpc/kernel/btext.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/btext.c
+++ linux-2.6/arch/powerpc/kernel/btext.c
@@ -158,35 +158,35 @@ int btext_initialize(struct device_node 
 {
 	unsigned int width, height, depth, pitch;
 	unsigned long address = 0;
-	u32 *prop;
+	const u32 *prop;
 
-	prop = (u32 *)get_property(np, "linux,bootx-width", NULL);
+	prop = get_property(np, "linux,bootx-width", NULL);
 	if (prop == NULL)
-		prop = (u32 *)get_property(np, "width", NULL);
+		prop = get_property(np, "width", NULL);
 	if (prop == NULL)
 		return -EINVAL;
 	width = *prop;
-	prop = (u32 *)get_property(np, "linux,bootx-height", NULL);
+	prop = get_property(np, "linux,bootx-height", NULL);
 	if (prop == NULL)
-		prop = (u32 *)get_property(np, "height", NULL);
+		prop = get_property(np, "height", NULL);
 	if (prop == NULL)
 		return -EINVAL;
 	height = *prop;
-	prop = (u32 *)get_property(np, "linux,bootx-depth", NULL);
+	prop = get_property(np, "linux,bootx-depth", NULL);
 	if (prop == NULL)
-		prop = (u32 *)get_property(np, "depth", NULL);
+		prop = get_property(np, "depth", NULL);
 	if (prop == NULL)
 		return -EINVAL;
 	depth = *prop;
 	pitch = width * ((depth + 7) / 8);
-	prop = (u32 *)get_property(np, "linux,bootx-linebytes", NULL);
+	prop = get_property(np, "linux,bootx-linebytes", NULL);
 	if (prop == NULL)
-		prop = (u32 *)get_property(np, "linebytes", NULL);
+		prop = get_property(np, "linebytes", NULL);
 	if (prop)
 		pitch = *prop;
 	if (pitch == 1)
 		pitch = 0x1000;
-	prop = (u32 *)get_property(np, "address", NULL);
+	prop = get_property(np, "address", NULL);
 	if (prop)
 		address = *prop;
 
@@ -214,11 +214,11 @@ int btext_initialize(struct device_node 
 
 int __init btext_find_display(int allow_nonstdout)
 {
-	char *name;
+	const char *name;
 	struct device_node *np = NULL; 
 	int rc = -ENODEV;
 
-	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
+	name = get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name != NULL) {
 		np = of_find_node_by_path(name);
 		if (np != NULL) {
Index: linux-2.6/arch/powerpc/kernel/ibmebus.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/ibmebus.c
+++ linux-2.6/arch/powerpc/kernel/ibmebus.c
@@ -167,7 +167,7 @@ static DEVICE_ATTR(name, S_IRUSR | S_IRG
 		   NULL);
 
 static struct ibmebus_dev* __devinit ibmebus_register_device_common(
-	struct ibmebus_dev *dev, char *name)
+	struct ibmebus_dev *dev, const char *name)
 {
 	int err = 0;
 
@@ -194,10 +194,10 @@ static struct ibmebus_dev* __devinit ibm
 	struct device_node *dn)
 {
 	struct ibmebus_dev *dev;
-	char *loc_code;
+	const char *loc_code;
 	int length;
 
-	loc_code = (char *)get_property(dn, "ibm,loc-code", NULL);
+	loc_code = get_property(dn, "ibm,loc-code", NULL);
 	if (!loc_code) {
                 printk(KERN_WARNING "%s: node %s missing 'ibm,loc-code'\n",
 		       __FUNCTION__, dn->name ? dn->name : "<unknown>");
Index: linux-2.6/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/legacy_serial.c
+++ linux-2.6/arch/powerpc/kernel/legacy_serial.c
@@ -39,16 +39,17 @@ static int __init add_legacy_port(struct
 				  phys_addr_t taddr, unsigned long irq,
 				  upf_t flags, int irq_check_parent)
 {
-	u32 *clk, *spd, clock = BASE_BAUD * 16;
+	const u32 *clk, *spd;
+	u32 clock = BASE_BAUD * 16;
 	int index;
 
 	/* get clock freq. if present */
-	clk = (u32 *)get_property(np, "clock-frequency", NULL);
+	clk = get_property(np, "clock-frequency", NULL);
 	if (clk && *clk)
 		clock = *clk;
 
 	/* get default speed if present */
-	spd = (u32 *)get_property(np, "current-speed", NULL);
+	spd = get_property(np, "current-speed", NULL);
 
 	/* If we have a location index, then try to use it */
 	if (want_index >= 0 && want_index < MAX_LEGACY_SERIAL_PORTS)
@@ -113,7 +114,7 @@ static int __init add_legacy_soc_port(st
 				      struct device_node *soc_dev)
 {
 	u64 addr;
-	u32 *addrp;
+	const u32 *addrp;
 	upf_t flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
 
 	/* We only support ports that have a clock frequency properly
@@ -140,15 +141,15 @@ static int __init add_legacy_soc_port(st
 static int __init add_legacy_isa_port(struct device_node *np,
 				      struct device_node *isa_brg)
 {
-	u32 *reg;
-	char *typep;
+	const u32 *reg;
+	const char *typep;
 	int index = -1;
 	u64 taddr;
 
 	DBG(" -> add_legacy_isa_port(%s)\n", np->full_name);
 
 	/* Get the ISA port number */
-	reg = (u32 *)get_property(np, "reg", NULL);
+	reg = get_property(np, "reg", NULL);
 	if (reg == NULL)
 		return -1;
 
@@ -159,7 +160,7 @@ static int __init add_legacy_isa_port(st
 	/* Now look for an "ibm,aix-loc" property that gives us ordering
 	 * if any...
 	 */
-	typep = (char *)get_property(np, "ibm,aix-loc", NULL);
+	typep = get_property(np, "ibm,aix-loc", NULL);
 
 	/* If we have a location index, then use it */
 	if (typep && *typep == 'S')
@@ -184,7 +185,7 @@ static int __init add_legacy_pci_port(st
 				      struct device_node *pci_dev)
 {
 	u64 addr, base;
-	u32 *addrp;
+	const u32 *addrp;
 	unsigned int flags;
 	int iotype, index = -1, lindex = 0;
 
@@ -223,7 +224,7 @@ static int __init add_legacy_pci_port(st
 	 * we get to their "reg" property
 	 */
 	if (np != pci_dev) {
-		u32 *reg = (u32 *)get_property(np, "reg", NULL);
+		const u32 *reg = get_property(np, "reg", NULL);
 		if (reg && (*reg < 4))
 			index = lindex = *reg;
 	}
@@ -281,13 +282,13 @@ static void __init setup_legacy_serial_c
 void __init find_legacy_serial_ports(void)
 {
 	struct device_node *np, *stdout = NULL;
-	char *path;
+	const char *path;
 	int index;
 
 	DBG(" -> find_legacy_serial_port()\n");
 
 	/* Now find out if one of these is out firmware console */
-	path = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
+	path = get_property(of_chosen, "linux,stdout-path", NULL);
 	if (path != NULL) {
 		stdout = of_find_node_by_path(path);
 		if (stdout)
@@ -487,8 +488,8 @@ static int __init check_legacy_serial_co
 {
 	struct device_node *prom_stdout = NULL;
 	int speed = 0, offset = 0;
-	char *name;
-	u32 *spd;
+	const char *name;
+	const u32 *spd;
 
 	DBG(" -> check_legacy_serial_console()\n");
 
@@ -509,7 +510,7 @@ static int __init check_legacy_serial_co
 	}
 	/* We are getting a weird phandle from OF ... */
 	/* ... So use the full path instead */
-	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
+	name = get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name == NULL) {
 		DBG(" no linux,stdout-path !\n");
 		return -ENODEV;
@@ -521,12 +522,12 @@ static int __init check_legacy_serial_co
 	}
 	DBG("stdout is %s\n", prom_stdout->full_name);
 
-	name = (char *)get_property(prom_stdout, "name", NULL);
+	name = get_property(prom_stdout, "name", NULL);
 	if (!name) {
 		DBG(" stdout package has no name !\n");
 		goto not_found;
 	}
-	spd = (u32 *)get_property(prom_stdout, "current-speed", NULL);
+	spd = get_property(prom_stdout, "current-speed", NULL);
 	if (spd)
 		speed = *spd;
 
Index: linux-2.6/arch/powerpc/kernel/lparcfg.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/lparcfg.c
+++ linux-2.6/arch/powerpc/kernel/lparcfg.c
@@ -310,12 +310,11 @@ static int pseries_lparcfg_data(struct s
 	int partition_potential_processors;
 	int partition_active_processors;
 	struct device_node *rtas_node;
-	int *lrdrp = NULL;
+	const int *lrdrp = NULL;
 
 	rtas_node = find_path_device("/rtas");
 	if (rtas_node)
-		lrdrp = (int *)get_property(rtas_node, "ibm,lrdr-capacity",
-		                            NULL);
+		lrdrp = get_property(rtas_node, "ibm,lrdr-capacity", NULL);
 
 	if (lrdrp == NULL) {
 		partition_potential_processors = vdso_data->processorCount;
@@ -520,7 +519,8 @@ static int lparcfg_data(struct seq_file 
 	const char *model = "";
 	const char *system_id = "";
 	const char *tmp;
-	unsigned int *lp_index_ptr, lp_index = 0;
+	const unsigned int *lp_index_ptr;
+	unsigned int lp_index = 0;
 
 	seq_printf(m, "%s %s \n", MODULE_NAME, MODULE_VERS);
 
@@ -540,8 +540,7 @@ static int lparcfg_data(struct seq_file 
 			if (firmware_has_feature(FW_FEATURE_ISERIES))
 				system_id += 4;
 		}
-		lp_index_ptr = (unsigned int *)
-			get_property(rootdn, "ibm,partition-no", NULL);
+		lp_index_ptr = get_property(rootdn, "ibm,partition-no", NULL);
 		if (lp_index_ptr)
 			lp_index = *lp_index_ptr;
 	}
Index: linux-2.6/arch/powerpc/kernel/machine_kexec_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/machine_kexec_64.c
+++ linux-2.6/arch/powerpc/kernel/machine_kexec_64.c
@@ -33,8 +33,8 @@ int default_machine_kexec_prepare(struct
 	unsigned long begin, end;	/* limits of segment */
 	unsigned long low, high;	/* limits of blocked memory range */
 	struct device_node *node;
-	unsigned long *basep;
-	unsigned int *sizep;
+	const unsigned long *basep;
+	const unsigned int *sizep;
 
 	if (!ppc_md.hpte_clear_all)
 		return -ENOENT;
@@ -74,10 +74,8 @@ int default_machine_kexec_prepare(struct
 	/* We also should not overwrite the tce tables */
 	for (node = of_find_node_by_type(NULL, "pci"); node != NULL;
 			node = of_find_node_by_type(node, "pci")) {
-		basep = (unsigned long *)get_property(node, "linux,tce-base",
-							NULL);
-		sizep = (unsigned int *)get_property(node, "linux,tce-size",
-							NULL);
+		basep = get_property(node, "linux,tce-base", NULL);
+		sizep = get_property(node, "linux,tce-size", NULL);
 		if (basep == NULL || sizep == NULL)
 			continue;
 
Index: linux-2.6/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci_64.c
+++ linux-2.6/arch/powerpc/kernel/pci_64.c
@@ -246,10 +246,10 @@ static void __init pcibios_claim_of_setu
 #ifdef CONFIG_PPC_MULTIPLATFORM
 static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
 {
-	u32 *prop;
+	const u32 *prop;
 	int len;
 
-	prop = (u32 *) get_property(np, name, &len);
+	prop = get_property(np, name, &len);
 	if (prop && len >= 4)
 		return *prop;
 	return def;
@@ -278,10 +278,11 @@ static void pci_parse_of_addrs(struct de
 	u64 base, size;
 	unsigned int flags;
 	struct resource *res;
-	u32 *addrs, i;
+	const u32 *addrs;
+	u32 i;
 	int proplen;
 
-	addrs = (u32 *) get_property(node, "assigned-addresses", &proplen);
+	addrs = get_property(node, "assigned-addresses", &proplen);
 	if (!addrs)
 		return;
 	DBG("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
@@ -381,7 +382,7 @@ void __devinit of_scan_bus(struct device
 				  struct pci_bus *bus)
 {
 	struct device_node *child = NULL;
-	u32 *reg;
+	const u32 *reg;
 	int reglen, devfn;
 	struct pci_dev *dev;
 
@@ -389,7 +390,7 @@ void __devinit of_scan_bus(struct device
 
 	while ((child = of_get_next_child(node, child)) != NULL) {
 		DBG("  * %s\n", child->full_name);
-		reg = (u32 *) get_property(child, "reg", &reglen);
+		reg = get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;
 		devfn = (reg[0] >> 8) & 0xff;
@@ -413,7 +414,7 @@ void __devinit of_scan_pci_bridge(struct
 			 	struct pci_dev *dev)
 {
 	struct pci_bus *bus;
-	u32 *busrange, *ranges;
+	const u32 *busrange, *ranges;
 	int len, i, mode;
 	struct resource *res;
 	unsigned int flags;
@@ -422,13 +423,13 @@ void __devinit of_scan_pci_bridge(struct
 	DBG("of_scan_pci_bridge(%s)\n", node->full_name);
 
 	/* parse bus-range property */
-	busrange = (u32 *) get_property(node, "bus-range", &len);
+	busrange = get_property(node, "bus-range", &len);
 	if (busrange == NULL || len != 8) {
 		printk(KERN_DEBUG "Can't get bus-range for PCI-PCI bridge %s\n",
 		       node->full_name);
 		return;
 	}
-	ranges = (u32 *) get_property(node, "ranges", &len);
+	ranges = get_property(node, "ranges", &len);
 	if (ranges == NULL) {
 		printk(KERN_DEBUG "Can't get ranges for PCI-PCI bridge %s\n",
 		       node->full_name);
@@ -892,13 +893,13 @@ static void __devinit pci_process_ISA_OF
 		unsigned int size;
 	};
 
-	struct isa_range *range;
+	const struct isa_range *range;
 	unsigned long pci_addr;
 	unsigned int isa_addr;
 	unsigned int size;
 	int rlen = 0;
 
-	range = (struct isa_range *) get_property(isa_node, "ranges", &rlen);
+	range = get_property(isa_node, "ranges", &rlen);
 	if (range == NULL || (rlen < sizeof(struct isa_range))) {
 		printk(KERN_ERR "no ISA ranges or unexpected isa range size,"
 		       "mapping 64k\n");
@@ -939,7 +940,8 @@ static void __devinit pci_process_ISA_OF
 void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
 					    struct device_node *dev, int prim)
 {
-	unsigned int *ranges, pci_space;
+	const unsigned int *ranges;
+	unsigned int pci_space;
 	unsigned long size;
 	int rlen = 0;
 	int memno = 0;
@@ -957,7 +959,7 @@ void __devinit pci_process_bridge_OF_ran
 	 *			(size depending on dev->n_addr_cells)
 	 *   cells 4+5 or 5+6:	the size of the range
 	 */
-	ranges = (unsigned int *) get_property(dev, "ranges", &rlen);
+	ranges = get_property(dev, "ranges", &rlen);
 	if (ranges == NULL)
 		return;
 	hose->io_base_phys = 0;
Index: linux-2.6/arch/powerpc/kernel/pci_dn.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci_dn.c
+++ linux-2.6/arch/powerpc/kernel/pci_dn.c
@@ -40,8 +40,8 @@
 static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
-	int *type = (int *)get_property(dn, "ibm,pci-config-space-type", NULL);
-	u32 *regs;
+	const int *type = get_property(dn, "ibm,pci-config-space-type", NULL);
+	const u32 *regs;
 	struct pci_dn *pdn;
 
 	if (mem_init_done)
@@ -54,14 +54,14 @@ static void * __devinit update_dn_pci_in
 	dn->data = pdn;
 	pdn->node = dn;
 	pdn->phb = phb;
-	regs = (u32 *)get_property(dn, "reg", NULL);
+	regs = get_property(dn, "reg", NULL);
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
 		pdn->busno = (regs[0] >> 16) & 0xff;
 		pdn->devfn = (regs[0] >> 8) & 0xff;
 	}
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		u32 *busp = (u32 *)get_property(dn, "linux,subbus", NULL);
+		const u32 *busp = get_property(dn, "linux,subbus", NULL);
 		if (busp)
 			pdn->bussubno = *busp;
 	}
@@ -96,10 +96,11 @@ void *traverse_pci_devices(struct device
 
 	/* We started with a phb, iterate all childs */
 	for (dn = start->child; dn; dn = nextdn) {
-		u32 *classp, class;
+		const u32 *classp;
+		u32 class;
 
 		nextdn = NULL;
-		classp = (u32 *)get_property(dn, "class-code", NULL);
+		classp = get_property(dn, "class-code", NULL);
 		class = classp ? *classp : 0;
 
 		if (pre && ((ret = pre(dn, data)) != NULL))
Index: linux-2.6/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom_parse.c
+++ linux-2.6/arch/powerpc/kernel/prom_parse.c
@@ -270,7 +270,7 @@ static int of_translate_one(struct devic
 			    struct of_bus *pbus, u32 *addr,
 			    int na, int ns, int pna)
 {
-	u32 *ranges;
+	const u32 *ranges;
 	unsigned int rlen;
 	int rone;
 	u64 offset = OF_BAD_ADDR;
@@ -287,7 +287,7 @@ static int of_translate_one(struct devic
 	 * to translate addresses that aren't supposed to be translated in
 	 * the first place. --BenH.
 	 */
-	ranges = (u32 *)get_property(parent, "ranges", &rlen);
+	ranges = get_property(parent, "ranges", &rlen);
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
 		memset(addr, 0, pna * 4);
@@ -330,7 +330,7 @@ static int of_translate_one(struct devic
  * that can be mapped to a cpu physical address). This is not really specified
  * that way, but this is traditionally the way IBM at least do things
  */
-u64 of_translate_address(struct device_node *dev, u32 *in_addr)
+u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
 {
 	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
@@ -407,10 +407,10 @@ u64 of_translate_address(struct device_n
 }
 EXPORT_SYMBOL(of_translate_address);
 
-u32 *of_get_address(struct device_node *dev, int index, u64 *size,
+const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
 		    unsigned int *flags)
 {
-	u32 *prop;
+	const u32 *prop;
 	unsigned int psize;
 	struct device_node *parent;
 	struct of_bus *bus;
@@ -427,7 +427,7 @@ u32 *of_get_address(struct device_node *
 		return NULL;
 
 	/* Get "reg" or "assigned-addresses" property */
-	prop = (u32 *)get_property(dev, bus->addresses, &psize);
+	prop = get_property(dev, bus->addresses, &psize);
 	if (prop == NULL)
 		return NULL;
 	psize /= 4;
@@ -445,10 +445,10 @@ u32 *of_get_address(struct device_node *
 }
 EXPORT_SYMBOL(of_get_address);
 
-u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
+const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
 			unsigned int *flags)
 {
-	u32 *prop;
+	const u32 *prop;
 	unsigned int psize;
 	struct device_node *parent;
 	struct of_bus *bus;
@@ -469,7 +469,7 @@ u32 *of_get_pci_address(struct device_no
 		return NULL;
 
 	/* Get "reg" or "assigned-addresses" property */
-	prop = (u32 *)get_property(dev, bus->addresses, &psize);
+	prop = get_property(dev, bus->addresses, &psize);
 	if (prop == NULL)
 		return NULL;
 	psize /= 4;
@@ -487,7 +487,7 @@ u32 *of_get_pci_address(struct device_no
 }
 EXPORT_SYMBOL(of_get_pci_address);
 
-static int __of_address_to_resource(struct device_node *dev, u32 *addrp,
+static int __of_address_to_resource(struct device_node *dev, const u32 *addrp,
 				    u64 size, unsigned int flags,
 				    struct resource *r)
 {
@@ -518,7 +518,7 @@ static int __of_address_to_resource(stru
 int of_address_to_resource(struct device_node *dev, int index,
 			   struct resource *r)
 {
-	u32		*addrp;
+	const u32	*addrp;
 	u64		size;
 	unsigned int	flags;
 
@@ -532,7 +532,7 @@ EXPORT_SYMBOL_GPL(of_address_to_resource
 int of_pci_address_to_resource(struct device_node *dev, int bar,
 			       struct resource *r)
 {
-	u32		*addrp;
+	const u32	*addrp;
 	u64		size;
 	unsigned int	flags;
 
@@ -543,13 +543,14 @@ int of_pci_address_to_resource(struct de
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 
-void of_parse_dma_window(struct device_node *dn, unsigned char *dma_window_prop,
+void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 		unsigned long *busno, unsigned long *phys, unsigned long *size)
 {
-	u32 *dma_window, cells;
-	unsigned char *prop;
+	const u32 *dma_window;
+	u32 cells;
+	const unsigned char *prop;
 
-	dma_window = (u32 *)dma_window_prop;
+	dma_window = dma_window_prop;
 
 	/* busno is always one cell */
 	*busno = *(dma_window++);
@@ -578,13 +579,13 @@ static struct device_node *of_irq_dflt_p
 static struct device_node *of_irq_find_parent(struct device_node *child)
 {
 	struct device_node *p;
-	phandle *parp;
+	const phandle *parp;
 
 	if (!of_node_get(child))
 		return NULL;
 
 	do {
-		parp = (phandle *)get_property(child, "interrupt-parent", NULL);
+		parp = get_property(child, "interrupt-parent", NULL);
 		if (parp == NULL)
 			p = of_get_parent(child);
 		else {
@@ -646,11 +647,11 @@ void of_irq_map_init(unsigned int flags)
 
 }
 
-int of_irq_map_raw(struct device_node *parent, u32 *intspec, u32 *addr,
-		   struct of_irq *out_irq)
+int of_irq_map_raw(struct device_node *parent, const u32 *intspec,
+		const u32 *addr, struct of_irq *out_irq)
 {
 	struct device_node *ipar, *tnode, *old = NULL, *newpar = NULL;
-	u32 *tmp, *imap, *imask;
+	const u32 *tmp, *imap, *imask;
 	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
 	int imaplen, match, i;
 
@@ -661,7 +662,7 @@ int of_irq_map_raw(struct device_node *p
 	 * is none, we are nice and just walk up the tree
 	 */
 	do {
-		tmp = (u32 *)get_property(ipar, "#interrupt-cells", NULL);
+		tmp = get_property(ipar, "#interrupt-cells", NULL);
 		if (tmp != NULL) {
 			intsize = *tmp;
 			break;
@@ -682,7 +683,7 @@ int of_irq_map_raw(struct device_node *p
 	 */
 	old = of_node_get(ipar);
 	do {
-		tmp = (u32 *)get_property(old, "#address-cells", NULL);
+		tmp = get_property(old, "#address-cells", NULL);
 		tnode = of_get_parent(old);
 		of_node_put(old);
 		old = tnode;
@@ -709,7 +710,7 @@ int of_irq_map_raw(struct device_node *p
 		}
 
 		/* Now look for an interrupt-map */
-		imap = (u32 *)get_property(ipar, "interrupt-map", &imaplen);
+		imap = get_property(ipar, "interrupt-map", &imaplen);
 		/* No interrupt map, check for an interrupt parent */
 		if (imap == NULL) {
 			DBG(" -> no map, getting parent\n");
@@ -719,7 +720,7 @@ int of_irq_map_raw(struct device_node *p
 		imaplen /= sizeof(u32);
 
 		/* Look for a mask */
-		imask = (u32 *)get_property(ipar, "interrupt-map-mask", NULL);
+		imask = get_property(ipar, "interrupt-map-mask", NULL);
 
 		/* If we were passed no "reg" property and we attempt to parse
 		 * an interrupt-map, then #address-cells must be 0.
@@ -766,14 +767,14 @@ int of_irq_map_raw(struct device_node *p
 			/* Get #interrupt-cells and #address-cells of new
 			 * parent
 			 */
-			tmp = (u32 *)get_property(newpar, "#interrupt-cells",
+			tmp = get_property(newpar, "#interrupt-cells",
 						  NULL);
 			if (tmp == NULL) {
 				DBG(" -> parent lacks #interrupt-cells !\n");
 				goto fail;
 			}
 			newintsize = *tmp;
-			tmp = (u32 *)get_property(newpar, "#address-cells",
+			tmp = get_property(newpar, "#address-cells",
 						  NULL);
 			newaddrsize = (tmp == NULL) ? 0 : *tmp;
 
@@ -819,14 +820,14 @@ EXPORT_SYMBOL_GPL(of_irq_map_raw);
 static int of_irq_map_oldworld(struct device_node *device, int index,
 			       struct of_irq *out_irq)
 {
-	u32 *ints;
+	const u32 *ints;
 	int intlen;
 
 	/*
 	 * Old machines just have a list of interrupt numbers
 	 * and no interrupt-controller nodes.
 	 */
-	ints = (u32 *) get_property(device, "AAPL,interrupts", &intlen);
+	ints = get_property(device, "AAPL,interrupts", &intlen);
 	if (ints == NULL)
 		return -EINVAL;
 	intlen /= sizeof(u32);
@@ -851,7 +852,8 @@ static int of_irq_map_oldworld(struct de
 int of_irq_map_one(struct device_node *device, int index, struct of_irq *out_irq)
 {
 	struct device_node *p;
-	u32 *intspec, *tmp, intsize, intlen, *addr;
+	const u32 *intspec, *tmp, *addr;
+	u32 intsize, intlen;
 	int res;
 
 	DBG("of_irq_map_one: dev=%s, index=%d\n", device->full_name, index);
@@ -861,13 +863,13 @@ int of_irq_map_one(struct device_node *d
 		return of_irq_map_oldworld(device, index, out_irq);
 
 	/* Get the interrupts property */
-	intspec = (u32 *)get_property(device, "interrupts", &intlen);
+	intspec = get_property(device, "interrupts", &intlen);
 	if (intspec == NULL)
 		return -EINVAL;
 	intlen /= sizeof(u32);
 
 	/* Get the reg property (if any) */
-	addr = (u32 *)get_property(device, "reg", NULL);
+	addr = get_property(device, "reg", NULL);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -875,7 +877,7 @@ int of_irq_map_one(struct device_node *d
 		return -EINVAL;
 
 	/* Get size of interrupt specifier */
-	tmp = (u32 *)get_property(p, "#interrupt-cells", NULL);
+	tmp = get_property(p, "#interrupt-cells", NULL);
 	if (tmp == NULL) {
 		of_node_put(p);
 		return -EINVAL;
Index: linux-2.6/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas-proc.c
+++ linux-2.6/arch/powerpc/kernel/rtas-proc.c
@@ -246,12 +246,12 @@ struct file_operations ppc_rtas_rmo_buf_
 
 static int ppc_rtas_find_all_sensors(void);
 static void ppc_rtas_process_sensor(struct seq_file *m,
-	struct individual_sensor *s, int state, int error, char *loc);
+	struct individual_sensor *s, int state, int error, const char *loc);
 static char *ppc_rtas_process_error(int error);
 static void get_location_code(struct seq_file *m,
-	struct individual_sensor *s, char *loc);
-static void check_location_string(struct seq_file *m, char *c);
-static void check_location(struct seq_file *m, char *c);
+	struct individual_sensor *s, const char *loc);
+static void check_location_string(struct seq_file *m, const char *c);
+static void check_location(struct seq_file *m, const char *c);
 
 static int __init proc_rtas_init(void)
 {
@@ -446,11 +446,11 @@ static int ppc_rtas_sensors_show(struct 
 	for (i=0; i<sensors.quant; i++) {
 		struct individual_sensor *p = &sensors.sensor[i];
 		char rstr[64];
-		char *loc;
+		const char *loc;
 		int llen, offs;
 
 		sprintf (rstr, SENSOR_PREFIX"%04d", p->token);
-		loc = (char *) get_property(rtas_node, rstr, &llen);
+		loc = get_property(rtas_node, rstr, &llen);
 
 		/* A sensor may have multiple instances */
 		for (j = 0, offs = 0; j <= p->quant; j++) {
@@ -474,10 +474,10 @@ static int ppc_rtas_sensors_show(struct 
 
 static int ppc_rtas_find_all_sensors(void)
 {
-	unsigned int *utmp;
+	const unsigned int *utmp;
 	int len, i;
 
-	utmp = (unsigned int *) get_property(rtas_node, "rtas-sensors", &len);
+	utmp = get_property(rtas_node, "rtas-sensors", &len);
 	if (utmp == NULL) {
 		printk (KERN_ERR "error: could not get rtas-sensors\n");
 		return 1;
@@ -530,7 +530,7 @@ static char *ppc_rtas_process_error(int 
  */
 
 static void ppc_rtas_process_sensor(struct seq_file *m,
-	struct individual_sensor *s, int state, int error, char *loc)
+	struct individual_sensor *s, int state, int error, const char *loc)
 {
 	/* Defined return vales */
 	const char * key_switch[]        = { "Off\t", "Normal\t", "Secure\t", 
@@ -682,7 +682,7 @@ static void ppc_rtas_process_sensor(stru
 
 /* ****************************************************************** */
 
-static void check_location(struct seq_file *m, char *c)
+static void check_location(struct seq_file *m, const char *c)
 {
 	switch (c[0]) {
 		case LOC_PLANAR:
@@ -719,7 +719,7 @@ static void check_location(struct seq_fi
  * ${LETTER}${NUMBER}[[-/]${LETTER}${NUMBER} [ ... ] ]
  * the '.' may be an abbrevation
  */
-static void check_location_string(struct seq_file *m, char *c)
+static void check_location_string(struct seq_file *m, const char *c)
 {
 	while (*c) {
 		if (isalpha(*c) || *c == '.')
@@ -733,7 +733,8 @@ static void check_location_string(struct
 
 /* ****************************************************************** */
 
-static void get_location_code(struct seq_file *m, struct individual_sensor *s, char *loc)
+static void get_location_code(struct seq_file *m, struct individual_sensor *s,
+		const char *loc)
 {
 	if (!loc || !*loc) {
 		seq_printf(m, "---");/* does not have a location */
Index: linux-2.6/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas_pci.c
+++ linux-2.6/arch/powerpc/kernel/rtas_pci.c
@@ -57,7 +57,7 @@ static inline int config_access_valid(st
 
 static int of_device_available(struct device_node * dn)
 {
-        char * status;
+        const char *status;
 
         status = get_property(dn, "status", NULL);
 
@@ -178,7 +178,7 @@ struct pci_ops rtas_pci_ops = {
 
 int is_python(struct device_node *dev)
 {
-	char *model = (char *)get_property(dev, "model", NULL);
+	const char *model = get_property(dev, "model", NULL);
 
 	if (model && strstr(model, "Python"))
 		return 1;
@@ -234,7 +234,7 @@ void __init init_pci_config_tokens (void
 unsigned long __devinit get_phb_buid (struct device_node *phb)
 {
 	int addr_cells;
-	unsigned int *buid_vals;
+	const unsigned int *buid_vals;
 	unsigned int len;
 	unsigned long buid;
 
@@ -247,7 +247,7 @@ unsigned long __devinit get_phb_buid (st
 	if (phb->parent->parent)
 		return 0;
 
-	buid_vals = (unsigned int *) get_property(phb, "reg", &len);
+	buid_vals = get_property(phb, "reg", &len);
 	if (buid_vals == NULL)
 		return 0;
 
@@ -264,10 +264,10 @@ unsigned long __devinit get_phb_buid (st
 static int phb_set_bus_ranges(struct device_node *dev,
 			      struct pci_controller *phb)
 {
-	int *bus_range;
+	const int *bus_range;
 	unsigned int len;
 
-	bus_range = (int *) get_property(dev, "bus-range", &len);
+	bus_range = get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		return 1;
  	}
@@ -325,15 +325,15 @@ unsigned long __init find_and_init_phbs(
 	 * in chosen.
 	 */
 	if (of_chosen) {
-		int *prop;
+		const int *prop;
 
-		prop = (int *)get_property(of_chosen, "linux,pci-probe-only",
-					   NULL);
+		prop = get_property(of_chosen,
+				"linux,pci-probe-only", NULL);
 		if (prop)
 			pci_probe_only = *prop;
 
-		prop = (int *)get_property(of_chosen,
-					   "linux,pci-assign-all-buses", NULL);
+		prop = get_property(of_chosen,
+				"linux,pci-assign-all-buses", NULL);
 		if (prop)
 			pci_assign_all_buses = *prop;
 	}
Index: linux-2.6/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6/arch/powerpc/kernel/setup-common.c
@@ -304,16 +304,15 @@ struct seq_operations cpuinfo_op = {
 void __init check_for_initrd(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
-	unsigned long *prop;
+	const unsigned long *prop;
 
 	DBG(" -> check_for_initrd()\n");
 
 	if (of_chosen) {
-		prop = (unsigned long *)get_property(of_chosen,
-				"linux,initrd-start", NULL);
+		prop = get_property(of_chosen, "linux,initrd-start", NULL);
 		if (prop != NULL) {
 			initrd_start = (unsigned long)__va(*prop);
-			prop = (unsigned long *)get_property(of_chosen,
+			prop = get_property(of_chosen,
 					"linux,initrd-end", NULL);
 			if (prop != NULL) {
 				initrd_end = (unsigned long)__va(*prop);
@@ -366,15 +365,14 @@ void __init smp_setup_cpu_maps(void)
 	int cpu = 0;
 
 	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < NR_CPUS) {
-		int *intserv;
+		const int *intserv;
 		int j, len = sizeof(u32), nthreads = 1;
 
-		intserv = (int *)get_property(dn, "ibm,ppc-interrupt-server#s",
-					      &len);
+		intserv = get_property(dn, "ibm,ppc-interrupt-server#s", &len);
 		if (intserv)
 			nthreads = len / sizeof(int);
 		else {
-			intserv = (int *) get_property(dn, "reg", NULL);
+			intserv = get_property(dn, "reg", NULL);
 			if (!intserv)
 				intserv = &cpu;	/* assume logical == phys */
 		}
@@ -395,13 +393,12 @@ void __init smp_setup_cpu_maps(void)
 	if (machine_is(pseries) && firmware_has_feature(FW_FEATURE_LPAR) &&
 	    (dn = of_find_node_by_path("/rtas"))) {
 		int num_addr_cell, num_size_cell, maxcpus;
-		unsigned int *ireg;
+		const unsigned int *ireg;
 
 		num_addr_cell = prom_n_addr_cells(dn);
 		num_size_cell = prom_n_size_cells(dn);
 
-		ireg = (unsigned int *)
-			get_property(dn, "ibm,lrdr-capacity", NULL);
+		ireg = get_property(dn, "ibm,lrdr-capacity", NULL);
 
 		if (!ireg)
 			goto out;
Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c
+++ linux-2.6/arch/powerpc/kernel/time.c
@@ -859,14 +859,14 @@ EXPORT_SYMBOL(do_settimeofday);
 static int __init get_freq(char *name, int cells, unsigned long *val)
 {
 	struct device_node *cpu;
-	unsigned int *fp;
+	const unsigned int *fp;
 	int found = 0;
 
 	/* The cpu node should have timebase and clock frequency properties */
 	cpu = of_find_node_by_type(NULL, "cpu");
 
 	if (cpu) {
-		fp = (unsigned int *)get_property(cpu, name, NULL);
+		fp = get_property(cpu, name, NULL);
 		if (fp) {
 			found = 1;
 			*val = 0;
Index: linux-2.6/arch/powerpc/kernel/vio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/vio.c
+++ linux-2.6/arch/powerpc/kernel/vio.c
@@ -77,7 +77,7 @@ static struct iommu_table *vio_build_iom
 	} else
 #endif
 	{
-		unsigned char *dma_window;
+		const unsigned char *dma_window;
 		struct iommu_table *tbl;
 		unsigned long offset, size;
 
@@ -217,7 +217,7 @@ static void __devinit vio_dev_release(st
 struct vio_dev * __devinit vio_register_device_node(struct device_node *of_node)
 {
 	struct vio_dev *viodev;
-	unsigned int *unit_address;
+	const unsigned int *unit_address;
 
 	/* we need the 'device_type' property, in order to match with drivers */
 	if (of_node->type == NULL) {
@@ -227,7 +227,7 @@ struct vio_dev * __devinit vio_register_
 		return NULL;
 	}
 
-	unit_address = (unsigned int *)get_property(of_node, "reg", NULL);
+	unit_address = get_property(of_node, "reg", NULL);
 	if (unit_address == NULL) {
 		printk(KERN_WARNING "%s: node %s missing 'reg'\n",
 				__FUNCTION__,
@@ -249,7 +249,7 @@ struct vio_dev * __devinit vio_register_
 	viodev->type = of_node->type;
 	viodev->unit_address = *unit_address;
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		unit_address = (unsigned int *)get_property(of_node,
+		unit_address = get_property(of_node,
 				"linux,unit_address", NULL);
 		if (unit_address != NULL)
 			viodev->unit_address = *unit_address;
@@ -423,7 +423,7 @@ static int vio_hotplug(struct device *de
 {
 	const struct vio_dev *vio_dev = to_vio_dev(dev);
 	struct device_node *dn = dev->platform_data;
-	char *cp;
+	const char *cp;
 	int length;
 
 	if (!num_envp)
@@ -431,7 +431,7 @@ static int vio_hotplug(struct device *de
 
 	if (!dn)
 		return -ENODEV;
-	cp = (char *)get_property(dn, "compatible", &length);
+	cp = get_property(dn, "compatible", &length);
 	if (!cp)
 		return -ENODEV;
 
@@ -493,11 +493,11 @@ static struct vio_dev *vio_find_name(con
  */
 struct vio_dev *vio_find_node(struct device_node *vnode)
 {
-	uint32_t *unit_address;
+	const uint32_t *unit_address;
 	char kobj_name[BUS_ID_SIZE];
 
 	/* construct the kobject name from the device node */
-	unit_address = (uint32_t *)get_property(vnode, "reg", NULL);
+	unit_address = get_property(vnode, "reg", NULL);
 	if (!unit_address)
 		return NULL;
 	snprintf(kobj_name, BUS_ID_SIZE, "%x", *unit_address);
Index: linux-2.6/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/fsl_soc.c
+++ linux-2.6/arch/powerpc/sysdev/fsl_soc.c
@@ -41,7 +41,7 @@ phys_addr_t get_immrbase(void)
 	soc = of_find_node_by_type(NULL, "soc");
 	if (soc) {
 		unsigned int size;
-		void *prop = get_property(soc, "reg", &size);
+		const void *prop = get_property(soc, "reg", &size);
 		immrbase = of_translate_address(soc, prop);
 		of_node_put(soc);
 	};
@@ -86,8 +86,8 @@ static int __init gfar_mdio_of_init(void
 
 		while ((child = of_get_next_child(np, child)) != NULL) {
 			if (child->n_intrs) {
-				u32 *id =
-				    (u32 *) get_property(child, "reg", NULL);
+				const u32 *id =
+					get_property(child, "reg", NULL);
 				mdio_data.irq[*id] = child->intrs[0].line;
 			}
 		}
@@ -127,10 +127,10 @@ static int __init gfar_of_init(void)
 		struct resource r[4];
 		struct device_node *phy, *mdio;
 		struct gianfar_platform_data gfar_data;
-		unsigned int *id;
-		char *model;
-		void *mac_addr;
-		phandle *ph;
+		const unsigned int *id;
+		const char *model;
+		const void *mac_addr;
+		const phandle *ph;
 
 		memset(r, 0, sizeof(r));
 		memset(&gfar_data, 0, sizeof(gfar_data));
@@ -188,7 +188,7 @@ static int __init gfar_of_init(void)
 			    FSL_GIANFAR_DEV_HAS_VLAN |
 			    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
 
-		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		ph = get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
 
 		if (phy == NULL) {
@@ -198,7 +198,7 @@ static int __init gfar_of_init(void)
 
 		mdio = of_get_parent(phy);
 
-		id = (u32 *) get_property(phy, "reg", NULL);
+		id = get_property(phy, "reg", NULL);
 		ret = of_address_to_resource(mdio, 0, &res);
 		if (ret) {
 			of_node_put(phy);
@@ -242,7 +242,7 @@ static int __init fsl_i2c_of_init(void)
 	     i++) {
 		struct resource r[2];
 		struct fsl_i2c_platform_data i2c_data;
-		unsigned char *flags = NULL;
+		const unsigned char *flags = NULL;
 
 		memset(&r, 0, sizeof(r));
 		memset(&i2c_data, 0, sizeof(i2c_data));
@@ -294,7 +294,7 @@ static int __init mpc83xx_wdt_init(void)
 	struct resource r;
 	struct device_node *soc, *np;
 	struct platform_device *dev;
-	unsigned int *freq;
+	const unsigned int *freq;
 	int ret;
 
 	np = of_find_compatible_node(NULL, "watchdog", "mpc83xx_wdt");
@@ -311,7 +311,7 @@ static int __init mpc83xx_wdt_init(void)
 		goto nosoc;
 	}
 
-	freq = (unsigned int *)get_property(soc, "bus-frequency", NULL);
+	freq = get_property(soc, "bus-frequency", NULL);
 	if (!freq) {
 		ret = -ENODEV;
 		goto err;
@@ -351,7 +351,7 @@ nodev:
 arch_initcall(mpc83xx_wdt_init);
 #endif
 
-static enum fsl_usb2_phy_modes determine_usb_phy(char * phy_type)
+static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 {
 	if (!phy_type)
 		return FSL_USB2_PHY_NONE;
@@ -379,7 +379,7 @@ static int __init fsl_usb_of_init(void)
 	     i++) {
 		struct resource r[2];
 		struct fsl_usb2_platform_data usb_data;
-		unsigned char *prop = NULL;
+		const unsigned char *prop = NULL;
 
 		memset(&r, 0, sizeof(r));
 		memset(&usb_data, 0, sizeof(usb_data));
@@ -428,7 +428,7 @@ static int __init fsl_usb_of_init(void)
 	     i++) {
 		struct resource r[2];
 		struct fsl_usb2_platform_data usb_data;
-		unsigned char *prop = NULL;
+		const unsigned char *prop = NULL;
 
 		memset(&r, 0, sizeof(r));
 		memset(&usb_data, 0, sizeof(usb_data));
Index: linux-2.6/arch/powerpc/sysdev/mmio_nvram.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mmio_nvram.c
+++ linux-2.6/arch/powerpc/sysdev/mmio_nvram.c
@@ -80,7 +80,7 @@ static ssize_t mmio_nvram_get_size(void)
 int __init mmio_nvram_init(void)
 {
 	struct device_node *nvram_node;
-	unsigned long *buffer;
+	const unsigned long *buffer;
 	int proplen;
 	unsigned long nvram_addr;
 	int ret;
@@ -91,7 +91,7 @@ int __init mmio_nvram_init(void)
 		goto out;
 
 	ret = -EIO;
-	buffer = (unsigned long *)get_property(nvram_node, "reg", &proplen);
+	buffer = get_property(nvram_node, "reg", &proplen);
 	if (proplen != 2*sizeof(unsigned long))
 		goto out;
 
Index: linux-2.6/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6/arch/powerpc/kernel/rtas.c
@@ -177,10 +177,12 @@ void __init udbg_init_rtas_console(void)
 void rtas_progress(char *s, unsigned short hex)
 {
 	struct device_node *root;
-	int width, *p;
+	int width;
+	const int *p;
 	char *os;
 	static int display_character, set_indicator;
-	static int display_width, display_lines, *row_width, form_feed;
+	static int display_width, display_lines, form_feed;
+	const static int *row_width;
 	static DEFINE_SPINLOCK(progress_lock);
 	static int current_line;
 	static int pending_newline = 0;  /* did last write end with unprinted newline? */
@@ -191,16 +193,16 @@ void rtas_progress(char *s, unsigned sho
 	if (display_width == 0) {
 		display_width = 0x10;
 		if ((root = find_path_device("/rtas"))) {
-			if ((p = (unsigned int *)get_property(root,
+			if ((p = get_property(root,
 					"ibm,display-line-length", NULL)))
 				display_width = *p;
-			if ((p = (unsigned int *)get_property(root,
+			if ((p = get_property(root,
 					"ibm,form-feed", NULL)))
 				form_feed = *p;
-			if ((p = (unsigned int *)get_property(root,
+			if ((p = get_property(root,
 					"ibm,display-number-of-lines", NULL)))
 				display_lines = *p;
-			row_width = (unsigned int *)get_property(root,
+			row_width = get_property(root,
 					"ibm,display-truncation-length", NULL);
 		}
 		display_character = rtas_token("display-character");
@@ -293,10 +295,10 @@ EXPORT_SYMBOL(rtas_progress);		/* needed
 
 int rtas_token(const char *service)
 {
-	int *tokp;
+	const int *tokp;
 	if (rtas.dev == NULL)
 		return RTAS_UNKNOWN_SERVICE;
-	tokp = (int *) get_property(rtas.dev, service, NULL);
+	tokp = get_property(rtas.dev, service, NULL);
 	return tokp ? *tokp : RTAS_UNKNOWN_SERVICE;
 }
 EXPORT_SYMBOL(rtas_token);
@@ -824,15 +826,15 @@ void __init rtas_initialize(void)
 	 */
 	rtas.dev = of_find_node_by_name(NULL, "rtas");
 	if (rtas.dev) {
-		u32 *basep, *entryp;
-		u32 *sizep;
+		const u32 *basep, *entryp, *sizep;
 
-		basep = (u32 *)get_property(rtas.dev, "linux,rtas-base", NULL);
-		sizep = (u32 *)get_property(rtas.dev, "rtas-size", NULL);
+		basep = get_property(rtas.dev, "linux,rtas-base", NULL);
+		sizep = get_property(rtas.dev, "rtas-size", NULL);
 		if (basep != NULL && sizep != NULL) {
 			rtas.base = *basep;
 			rtas.size = *sizep;
-			entryp = (u32 *)get_property(rtas.dev, "linux,rtas-entry", NULL);
+			entryp = get_property(rtas.dev,
+					"linux,rtas-entry", NULL);
 			if (entryp == NULL) /* Ugh */
 				rtas.entry = rtas.base;
 			else
Index: linux-2.6/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6/arch/powerpc/kernel/setup_64.c
@@ -107,7 +107,7 @@ static int smt_enabled_cmdline;
 static void check_smt_enabled(void)
 {
 	struct device_node *dn;
-	char *smt_option;
+	const char *smt_option;
 
 	/* Allow the command line to overrule the OF option */
 	if (smt_enabled_cmdline)
@@ -116,7 +116,7 @@ static void check_smt_enabled(void)
 	dn = of_find_node_by_path("/options");
 
 	if (dn) {
-		smt_option = (char *)get_property(dn, "ibm,smt-enabled", NULL);
+		smt_option = get_property(dn, "ibm,smt-enabled", NULL);
 
                 if (smt_option) {
 			if (!strcmp(smt_option, "on"))
@@ -293,7 +293,7 @@ static void __init initialize_cache_info
 		 */
 
 		if ( num_cpus == 1 ) {
-			u32 *sizep, *lsizep;
+			const u32 *sizep, *lsizep;
 			u32 size, lsize;
 			const char *dc, *ic;
 
@@ -308,10 +308,10 @@ static void __init initialize_cache_info
 
 			size = 0;
 			lsize = cur_cpu_spec->dcache_bsize;
-			sizep = (u32 *)get_property(np, "d-cache-size", NULL);
+			sizep = get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = (u32 *) get_property(np, dc, NULL);
+			lsizep = get_property(np, dc, NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
@@ -325,10 +325,10 @@ static void __init initialize_cache_info
 
 			size = 0;
 			lsize = cur_cpu_spec->icache_bsize;
-			sizep = (u32 *)get_property(np, "i-cache-size", NULL);
+			sizep = get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = (u32 *)get_property(np, ic, NULL);
+			lsizep = get_property(np, ic, NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
Index: linux-2.6/include/asm-powerpc/prom.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/prom.h
+++ linux-2.6/include/asm-powerpc/prom.h
@@ -72,8 +72,8 @@ struct property {
 };
 
 struct device_node {
-	char	*name;
-	char	*type;
+	const char *name;
+	const char *type;
 	phandle	node;
 	phandle linux_phandle;
 	char	*full_name;
@@ -209,15 +209,15 @@ static inline u64 of_read_number(const u
 /* Translate an OF address block into a CPU physical address
  */
 #define OF_BAD_ADDR	((u64)-1)
-extern u64 of_translate_address(struct device_node *np, u32 *addr);
+extern u64 of_translate_address(struct device_node *np, const u32 *addr);
 
 /* Extract an address from a device, returns the region size and
  * the address space flags too. The PCI version uses a BAR number
  * instead of an absolute index
  */
-extern u32 *of_get_address(struct device_node *dev, int index,
+extern const u32 *of_get_address(struct device_node *dev, int index,
 			   u64 *size, unsigned int *flags);
-extern u32 *of_get_pci_address(struct device_node *dev, int bar_no,
+extern const u32 *of_get_pci_address(struct device_node *dev, int bar_no,
 			       u64 *size, unsigned int *flags);
 
 /* Get an address as a resource. Note that if your address is
@@ -234,7 +234,7 @@ extern int of_pci_address_to_resource(st
 /* Parse the ibm,dma-window property of an OF node into the busno, phys and
  * size parameters.
  */
-void of_parse_dma_window(struct device_node *dn, unsigned char *dma_window_prop,
+void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 		unsigned long *busno, unsigned long *phys, unsigned long *size);
 
 extern void kdump_move_device_tree(void);
@@ -288,8 +288,8 @@ extern void of_irq_map_init(unsigned int
  *
  */
 
-extern int of_irq_map_raw(struct device_node *parent, u32 *intspec, u32 *addr,
-			  struct of_irq *out_irq);
+extern int of_irq_map_raw(struct device_node *parent, const u32 *intspec,
+			  const u32 *addr, struct of_irq *out_irq);
 
 
 /***
Index: linux-2.6/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci_32.c
+++ linux-2.6/arch/powerpc/kernel/pci_32.c
@@ -633,12 +633,12 @@ pcibios_alloc_controller(void)
 static void
 make_one_node_map(struct device_node* node, u8 pci_bus)
 {
-	int *bus_range;
+	const int *bus_range;
 	int len;
 
 	if (pci_bus >= pci_bus_count)
 		return;
-	bus_range = (int *) get_property(node, "bus-range", &len);
+	bus_range = get_property(node, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, "
 		       "assuming it starts at 0\n", node->full_name);
@@ -648,13 +648,13 @@ make_one_node_map(struct device_node* no
 
 	for (node=node->child; node != 0;node = node->sibling) {
 		struct pci_dev* dev;
-		unsigned int *class_code, *reg;
+		const unsigned int *class_code, *reg;
 	
-		class_code = (unsigned int *) get_property(node, "class-code", NULL);
+		class_code = get_property(node, "class-code", NULL);
 		if (!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS))
 			continue;
-		reg = (unsigned int *)get_property(node, "reg", NULL);
+		reg = get_property(node, "reg", NULL);
 		if (!reg)
 			continue;
 		dev = pci_find_slot(pci_bus, ((reg[0] >> 8) & 0xff));
@@ -669,7 +669,7 @@ pcibios_make_OF_bus_map(void)
 {
 	int i;
 	struct pci_controller* hose;
-	u8* of_prop_map;
+	struct property *map_prop;
 
 	pci_to_OF_bus_map = (u8*)kmalloc(pci_bus_count, GFP_KERNEL);
 	if (!pci_to_OF_bus_map) {
@@ -691,9 +691,12 @@ pcibios_make_OF_bus_map(void)
 			continue;
 		make_one_node_map(node, hose->first_busno);
 	}
-	of_prop_map = get_property(find_path_device("/"), "pci-OF-bus-map", NULL);
-	if (of_prop_map)
-		memcpy(of_prop_map, pci_to_OF_bus_map, pci_bus_count);
+	map_prop = of_find_property(find_path_device("/"),
+			"pci-OF-bus-map", NULL);
+	if (map_prop) {
+		BUG_ON(pci_bus_count > map_prop->length);
+		memcpy(map_prop->value, pci_to_OF_bus_map, pci_bus_count);
+	}
 #ifdef DEBUG
 	printk("PCI->OF bus map:\n");
 	for (i=0; i<pci_bus_count; i++) {
@@ -712,7 +715,7 @@ scan_OF_pci_childs(struct device_node* n
 	struct device_node* sub_node;
 
 	for (; node != 0;node = node->sibling) {
-		unsigned int *class_code;
+		const unsigned int *class_code;
 	
 		if (filter(node, data))
 			return node;
@@ -722,7 +725,7 @@ scan_OF_pci_childs(struct device_node* n
 		 * a fake root for all functions of a multi-function device,
 		 * we go down them as well.
 		 */
-		class_code = (unsigned int *) get_property(node, "class-code", NULL);
+		class_code = get_property(node, "class-code", NULL);
 		if ((!class_code || ((*class_code >> 8) != PCI_CLASS_BRIDGE_PCI &&
 			(*class_code >> 8) != PCI_CLASS_BRIDGE_CARDBUS)) &&
 			strcmp(node->name, "multifunc-device"))
@@ -737,10 +740,10 @@ scan_OF_pci_childs(struct device_node* n
 static int
 scan_OF_pci_childs_iterator(struct device_node* node, void* data)
 {
-	unsigned int *reg;
+	const unsigned int *reg;
 	u8* fdata = (u8*)data;
 	
-	reg = (unsigned int *) get_property(node, "reg", NULL);
+	reg = get_property(node, "reg", NULL);
 	if (reg && ((reg[0] >> 8) & 0xff) == fdata[1]
 		&& ((reg[0] >> 16) & 0xff) == fdata[0])
 		return 1;
@@ -841,7 +844,7 @@ find_OF_pci_device_filter(struct device_
 int
 pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn)
 {
-	unsigned int *reg;
+	const unsigned int *reg;
 	struct pci_controller* hose;
 	struct pci_dev* dev = NULL;
 	
@@ -854,7 +857,7 @@ pci_device_from_OF_node(struct device_no
 	if (!scan_OF_pci_childs(((struct device_node*)hose->arch_data)->child,
 			find_OF_pci_device_filter, (void *)node))
 		return -ENODEV;
-	reg = (unsigned int *) get_property(node, "reg", NULL);
+	reg = get_property(node, "reg", NULL);
 	if (!reg)
 		return -ENODEV;
 	*bus = (reg[0] >> 16) & 0xff;
@@ -885,8 +888,8 @@ pci_process_bridge_OF_ranges(struct pci_
 			   struct device_node *dev, int primary)
 {
 	static unsigned int static_lc_ranges[256] __initdata;
-	unsigned int *dt_ranges, *lc_ranges, *ranges, *prev;
-	unsigned int size;
+	const unsigned int *dt_ranges;
+	unsigned int *lc_ranges, *ranges, *prev, size;
 	int rlen = 0, orig_rlen;
 	int memno = 0;
 	struct resource *res;
@@ -897,7 +900,7 @@ pci_process_bridge_OF_ranges(struct pci_
 	 * that can have more than 3 ranges, fortunately using contiguous
 	 * addresses -- BenH
 	 */
-	dt_ranges = (unsigned int *) get_property(dev, "ranges", &rlen);
+	dt_ranges = get_property(dev, "ranges", &rlen);
 	if (!dt_ranges)
 		return;
 	/* Sanity check, though hopefully that never happens */
Index: linux-2.6/include/asm-powerpc/ibmebus.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/ibmebus.h
+++ linux-2.6/include/asm-powerpc/ibmebus.h
@@ -48,7 +48,7 @@ extern struct dma_mapping_ops ibmebus_dm
 extern struct bus_type ibmebus_bus_type;
 
 struct ibmebus_dev {	
-	char *name;
+	const char *name;
 	struct of_device ofdev;
 };
 
Index: linux-2.6/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6/arch/powerpc/kernel/sysfs.c
@@ -60,7 +60,7 @@ static int smt_snooze_cmdline;
 static int __init smt_setup(void)
 {
 	struct device_node *options;
-	unsigned int *val;
+	const unsigned int *val;
 	unsigned int cpu;
 
 	if (!cpu_has_feature(CPU_FTR_SMT))
@@ -70,8 +70,7 @@ static int __init smt_setup(void)
 	if (!options)
 		return -ENODEV;
 
-	val = (unsigned int *)get_property(options, "ibm,smt-snooze-delay",
-					   NULL);
+	val = get_property(options, "ibm,smt-snooze-delay", NULL);
 	if (!smt_snooze_cmdline && val) {
 		for_each_possible_cpu(cpu)
 			per_cpu(smt_snooze_delay, cpu) = *val;
Index: linux-2.6/include/asm-powerpc/vio.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/vio.h
+++ linux-2.6/include/asm-powerpc/vio.h
@@ -46,8 +46,8 @@ struct iommu_table;
  */
 struct vio_dev {
 	struct iommu_table *iommu_table;     /* vio_map_* uses this */
-	char *name;
-	char *type;
+	const char *name;
+	const char *type;
 	uint32_t unit_address;
 	unsigned int irq;
 	struct device dev;
Index: linux-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/numa.c
+++ linux-2.6/arch/powerpc/mm/numa.c
@@ -159,12 +159,12 @@ static struct device_node * __cpuinit fi
 {
 	unsigned int hw_cpuid = get_hard_smp_processor_id(cpu);
 	struct device_node *cpu_node = NULL;
-	unsigned int *interrupt_server, *reg;
+	const unsigned int *interrupt_server, *reg;
 	int len;
 
 	while ((cpu_node = of_find_node_by_type(cpu_node, "cpu")) != NULL) {
 		/* Try interrupt server first */
-		interrupt_server = (unsigned int *)get_property(cpu_node,
+		interrupt_server = get_property(cpu_node,
 					"ibm,ppc-interrupt-server#s", &len);
 
 		len = len / sizeof(u32);
@@ -175,8 +175,7 @@ static struct device_node * __cpuinit fi
 					return cpu_node;
 			}
 		} else {
-			reg = (unsigned int *)get_property(cpu_node,
-							   "reg", &len);
+			reg = get_property(cpu_node, "reg", &len);
 			if (reg && (len > 0) && (reg[0] == hw_cpuid))
 				return cpu_node;
 		}
@@ -186,9 +185,9 @@ static struct device_node * __cpuinit fi
 }
 
 /* must hold reference to node during call */
-static int *of_get_associativity(struct device_node *dev)
+static const int *of_get_associativity(struct device_node *dev)
 {
-	return (unsigned int *)get_property(dev, "ibm,associativity", NULL);
+	return get_property(dev, "ibm,associativity", NULL);
 }
 
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
@@ -197,7 +196,7 @@ static int *of_get_associativity(struct 
 static int of_node_to_nid_single(struct device_node *device)
 {
 	int nid = -1;
-	unsigned int *tmp;
+	const unsigned int *tmp;
 
 	if (min_common_depth == -1)
 		goto out;
@@ -255,7 +254,7 @@ EXPORT_SYMBOL_GPL(of_node_to_nid);
 static int __init find_min_common_depth(void)
 {
 	int depth;
-	unsigned int *ref_points;
+	const unsigned int *ref_points;
 	struct device_node *rtas_root;
 	unsigned int len;
 
@@ -270,7 +269,7 @@ static int __init find_min_common_depth(
 	 * configuration (should be all 0's) and the second is for a normal
 	 * NUMA configuration.
 	 */
-	ref_points = (unsigned int *)get_property(rtas_root,
+	ref_points = get_property(rtas_root,
 			"ibm,associativity-reference-points", &len);
 
 	if ((len >= 1) && ref_points) {
@@ -297,7 +296,7 @@ static void __init get_n_mem_cells(int *
 	of_node_put(memory);
 }
 
-static unsigned long __devinit read_n_cells(int n, unsigned int **buf)
+static unsigned long __devinit read_n_cells(int n, const unsigned int **buf)
 {
 	unsigned long result = 0;
 
@@ -435,15 +434,13 @@ static int __init parse_numa_properties(
 		unsigned long size;
 		int nid;
 		int ranges;
-		unsigned int *memcell_buf;
+		const unsigned int *memcell_buf;
 		unsigned int len;
 
-		memcell_buf = (unsigned int *)get_property(memory,
+		memcell_buf = get_property(memory,
 			"linux,usable-memory", &len);
 		if (!memcell_buf || len <= 0)
-			memcell_buf =
-				(unsigned int *)get_property(memory, "reg",
-					&len);
+			memcell_buf = get_property(memory, "reg", &len);
 		if (!memcell_buf || len <= 0)
 			continue;
 
@@ -787,10 +784,10 @@ int hot_add_scn_to_nid(unsigned long scn
 	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
 		unsigned long start, size;
 		int ranges;
-		unsigned int *memcell_buf;
+		const unsigned int *memcell_buf;
 		unsigned int len;
 
-		memcell_buf = (unsigned int *)get_property(memory, "reg", &len);
+		memcell_buf = get_property(memory, "reg", &len);
 		if (!memcell_buf || len <= 0)
 			continue;
 
