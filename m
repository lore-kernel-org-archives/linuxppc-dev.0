Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 18:01:21 +1100
Message-Id: <1134457283.6989.185.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove device_node addrs/n_addr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The pre-parsed addrs/n_addrs fields in struct device_node are finally
gone. Remove the dodgy heuristics that did that parsing at boot and
remove the fields themselves since we now have a good replacement with
the new OF parsing code. This patch also fixes a bunch of drivers to use
the new code instead, so that at least pmac32, pseries, iseries and g5
defconfigs build.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/prom.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom.c	2005-12-13 17:51:20.000000000 +1100
@@ -57,21 +57,6 @@
 #define DBG(fmt...)
 #endif
 
-struct pci_reg_property {
-	struct pci_address addr;
-	u32 size_hi;
-	u32 size_lo;
-};
-
-struct isa_reg_property {
-	u32 space;
-	u32 address;
-	u32 size;
-};
-
-
-typedef int interpret_func(struct device_node *, unsigned long *,
-			   int, int, int);
 
 static int __initdata dt_root_addr_cells;
 static int __initdata dt_root_size_cells;
@@ -410,237 +395,19 @@ static int __devinit finish_node_interru
 	return 0;
 }
 
-static int __devinit interpret_pci_props(struct device_node *np,
-					 unsigned long *mem_start,
-					 int naddrc, int nsizec,
-					 int measure_only)
-{
-	struct address_range *adr;
-	struct pci_reg_property *pci_addrs;
-	int i, l, n_addrs;
-
-	pci_addrs = (struct pci_reg_property *)
-		get_property(np, "assigned-addresses", &l);
-	if (!pci_addrs)
-		return 0;
-
-	n_addrs = l / sizeof(*pci_addrs);
-
-	adr = prom_alloc(n_addrs * sizeof(*adr), mem_start);
-	if (!adr)
-		return -ENOMEM;
-
- 	if (measure_only)
- 		return 0;
-
- 	np->addrs = adr;
- 	np->n_addrs = n_addrs;
-
- 	for (i = 0; i < n_addrs; i++) {
- 		adr[i].space = pci_addrs[i].addr.a_hi;
- 		adr[i].address = pci_addrs[i].addr.a_lo |
-			((u64)pci_addrs[i].addr.a_mid << 32);
- 		adr[i].size = pci_addrs[i].size_lo;
-	}
-
-	return 0;
-}
-
-static int __init interpret_dbdma_props(struct device_node *np,
-					unsigned long *mem_start,
-					int naddrc, int nsizec,
-					int measure_only)
-{
-	struct reg_property32 *rp;
-	struct address_range *adr;
-	unsigned long base_address;
-	int i, l;
-	struct device_node *db;
-
-	base_address = 0;
-	if (!measure_only) {
-		for (db = np->parent; db != NULL; db = db->parent) {
-			if (!strcmp(db->type, "dbdma") && db->n_addrs != 0) {
-				base_address = db->addrs[0].address;
-				break;
-			}
-		}
-	}
-
-	rp = (struct reg_property32 *) get_property(np, "reg", &l);
-	if (rp != 0 && l >= sizeof(struct reg_property32)) {
-		i = 0;
-		adr = (struct address_range *) (*mem_start);
-		while ((l -= sizeof(struct reg_property32)) >= 0) {
-			if (!measure_only) {
-				adr[i].space = 2;
-				adr[i].address = rp[i].address + base_address;
-				adr[i].size = rp[i].size;
-			}
-			++i;
-		}
-		np->addrs = adr;
-		np->n_addrs = i;
-		(*mem_start) += i * sizeof(struct address_range);
-	}
-
-	return 0;
-}
-
-static int __init interpret_macio_props(struct device_node *np,
-					unsigned long *mem_start,
-					int naddrc, int nsizec,
-					int measure_only)
-{
-	struct reg_property32 *rp;
-	struct address_range *adr;
-	unsigned long base_address;
-	int i, l;
-	struct device_node *db;
-
-	base_address = 0;
-	if (!measure_only) {
-		for (db = np->parent; db != NULL; db = db->parent) {
-			if (!strcmp(db->type, "mac-io") && db->n_addrs != 0) {
-				base_address = db->addrs[0].address;
-				break;
-			}
-		}
-	}
-
-	rp = (struct reg_property32 *) get_property(np, "reg", &l);
-	if (rp != 0 && l >= sizeof(struct reg_property32)) {
-		i = 0;
-		adr = (struct address_range *) (*mem_start);
-		while ((l -= sizeof(struct reg_property32)) >= 0) {
-			if (!measure_only) {
-				adr[i].space = 2;
-				adr[i].address = rp[i].address + base_address;
-				adr[i].size = rp[i].size;
-			}
-			++i;
-		}
-		np->addrs = adr;
-		np->n_addrs = i;
-		(*mem_start) += i * sizeof(struct address_range);
-	}
-
-	return 0;
-}
-
-static int __init interpret_isa_props(struct device_node *np,
-				      unsigned long *mem_start,
-				      int naddrc, int nsizec,
-				      int measure_only)
-{
-	struct isa_reg_property *rp;
-	struct address_range *adr;
-	int i, l;
-
-	rp = (struct isa_reg_property *) get_property(np, "reg", &l);
-	if (rp != 0 && l >= sizeof(struct isa_reg_property)) {
-		i = 0;
-		adr = (struct address_range *) (*mem_start);
-		while ((l -= sizeof(struct isa_reg_property)) >= 0) {
-			if (!measure_only) {
-				adr[i].space = rp[i].space;
-				adr[i].address = rp[i].address;
-				adr[i].size = rp[i].size;
-			}
-			++i;
-		}
-		np->addrs = adr;
-		np->n_addrs = i;
-		(*mem_start) += i * sizeof(struct address_range);
-	}
-
-	return 0;
-}
-
-static int __init interpret_root_props(struct device_node *np,
-				       unsigned long *mem_start,
-				       int naddrc, int nsizec,
-				       int measure_only)
-{
-	struct address_range *adr;
-	int i, l;
-	unsigned int *rp;
-	int rpsize = (naddrc + nsizec) * sizeof(unsigned int);
-
-	rp = (unsigned int *) get_property(np, "linux,usable-memory", &l);
-	if (rp == NULL)
-		rp = (unsigned int *) get_property(np, "reg", &l);
-
-	if (rp != 0 && l >= rpsize) {
-		i = 0;
-		adr = (struct address_range *) (*mem_start);
-		while ((l -= rpsize) >= 0) {
-			if (!measure_only) {
-				adr[i].space = 0;
-				adr[i].address = rp[naddrc - 1];
-				adr[i].size = rp[naddrc + nsizec - 1];
-			}
-			++i;
-			rp += naddrc + nsizec;
-		}
-		np->addrs = adr;
-		np->n_addrs = i;
-		(*mem_start) += i * sizeof(struct address_range);
-	}
-
-	return 0;
-}
-
 static int __devinit finish_node(struct device_node *np,
 				 unsigned long *mem_start,
-				 interpret_func *ifunc,
-				 int naddrc, int nsizec,
 				 int measure_only)
 {
 	struct device_node *child;
-	int *ip, rc = 0;
-
-	/* get the device addresses and interrupts */
-	if (ifunc != NULL)
-		rc = ifunc(np, mem_start, naddrc, nsizec, measure_only);
-	if (rc)
-		goto out;
+	int rc = 0;
 
 	rc = finish_node_interrupts(np, mem_start, measure_only);
 	if (rc)
 		goto out;
 
-	/* Look for #address-cells and #size-cells properties. */
-	ip = (int *) get_property(np, "#address-cells", NULL);
-	if (ip != NULL)
-		naddrc = *ip;
-	ip = (int *) get_property(np, "#size-cells", NULL);
-	if (ip != NULL)
-		nsizec = *ip;
-
-	if (!strcmp(np->name, "device-tree") || np->parent == NULL)
-		ifunc = interpret_root_props;
-	else if (np->type == 0)
-		ifunc = NULL;
-	else if (!strcmp(np->type, "pci") || !strcmp(np->type, "vci"))
-		ifunc = interpret_pci_props;
-	else if (!strcmp(np->type, "dbdma"))
-		ifunc = interpret_dbdma_props;
-	else if (!strcmp(np->type, "mac-io") || ifunc == interpret_macio_props)
-		ifunc = interpret_macio_props;
-	else if (!strcmp(np->type, "isa"))
-		ifunc = interpret_isa_props;
-	else if (!strcmp(np->name, "uni-n") || !strcmp(np->name, "u3"))
-		ifunc = interpret_root_props;
-	else if (!((ifunc == interpret_dbdma_props
-		    || ifunc == interpret_macio_props)
-		   && (!strcmp(np->type, "escc")
-		       || !strcmp(np->type, "media-bay"))))
-		ifunc = NULL;
-
 	for (child = np->child; child != NULL; child = child->sibling) {
-		rc = finish_node(child, mem_start, ifunc,
-				 naddrc, nsizec, measure_only);
+		rc = finish_node(child, mem_start, measure_only);
 		if (rc)
 			goto out;
 	}
@@ -702,10 +469,10 @@ void __init finish_device_tree(void)
 	 * reason and then remove those additional 16 bytes
 	 */
 	size = 16;
-	finish_node(allnodes, &size, NULL, 0, 0, 1);
+	finish_node(allnodes, &size, 1);
 	size -= 16;
 	end = start = (unsigned long) __va(lmb_alloc(size, 128));
-	finish_node(allnodes, &end, NULL, 0, 0, 0);
+	finish_node(allnodes, &end, 0);
 	BUG_ON(end != start + size);
 
 	DBG(" <- finish_device_tree\n");
@@ -1822,7 +1589,6 @@ static void of_node_release(struct kref 
 		prop = next;
 	}
 	kfree(node->intrs);
-	kfree(node->addrs);
 	kfree(node->full_name);
 	kfree(node->data);
 	kfree(node);
@@ -1904,9 +1670,7 @@ void of_detach_node(const struct device_
  * This should probably be split up into smaller chunks.
  */
 
-static int of_finish_dynamic_node(struct device_node *node,
-				  unsigned long *unused1, int unused2,
-				  int unused3, int unused4)
+static int of_finish_dynamic_node(struct device_node *node)
 {
 	struct device_node *parent = of_get_parent(node);
 	int err = 0;
@@ -1927,7 +1691,8 @@ static int of_finish_dynamic_node(struct
 		return -ENODEV;
 
 	/* fix up new node's linux_phandle field */
-	if ((ibm_phandle = (unsigned int *)get_property(node, "ibm,phandle", NULL)))
+	if ((ibm_phandle = (unsigned int *)get_property(node,
+							"ibm,phandle", NULL)))
 		node->linux_phandle = *ibm_phandle;
 
 out:
@@ -1942,7 +1707,9 @@ static int prom_reconfig_notifier(struct
 
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
-		err = finish_node(node, NULL, of_finish_dynamic_node, 0, 0, 0);
+		err = of_finish_dynamic_node(node);
+		if (!err)
+			finish_node(node, NULL, 0);
 		if (err < 0) {
 			printk(KERN_ERR "finish_node returned %d\n", err);
 			err = NOTIFY_BAD;
@@ -2016,175 +1783,4 @@ int prom_add_property(struct device_node
 	return 0;
 }
 
-/* I quickly hacked that one, check against spec ! */
-static inline unsigned long
-bus_space_to_resource_flags(unsigned int bus_space)
-{
-	u8 space = (bus_space >> 24) & 0xf;
-	if (space == 0)
-		space = 0x02;
-	if (space == 0x02)
-		return IORESOURCE_MEM;
-	else if (space == 0x01)
-		return IORESOURCE_IO;
-	else {
-		printk(KERN_WARNING "prom.c: bus_space_to_resource_flags(), space: %x\n",
-		    	bus_space);
-		return 0;
-	}
-}
-
-#ifdef CONFIG_PCI
-static struct resource *find_parent_pci_resource(struct pci_dev* pdev,
-						 struct address_range *range)
-{
-	unsigned long mask;
-	int i;
-
-	/* Check this one */
-	mask = bus_space_to_resource_flags(range->space);
-	for (i=0; i<DEVICE_COUNT_RESOURCE; i++) {
-		if ((pdev->resource[i].flags & mask) == mask &&
-			pdev->resource[i].start <= range->address &&
-			pdev->resource[i].end > range->address) {
-				if ((range->address + range->size - 1) > pdev->resource[i].end) {
-					/* Add better message */
-					printk(KERN_WARNING "PCI/OF resource overlap !\n");
-					return NULL;
-				}
-				break;
-			}
-	}
-	if (i == DEVICE_COUNT_RESOURCE)
-		return NULL;
-	return &pdev->resource[i];
-}
-
-/*
- * Request an OF device resource. Currently handles child of PCI devices,
- * or other nodes attached to the root node. Ultimately, put some
- * link to resources in the OF node.
- */
-struct resource *request_OF_resource(struct device_node* node, int index,
-				     const char* name_postfix)
-{
-	struct pci_dev* pcidev;
-	u8 pci_bus, pci_devfn;
-	unsigned long iomask;
-	struct device_node* nd;
-	struct resource* parent;
-	struct resource *res = NULL;
-	int nlen, plen;
-
-	if (index >= node->n_addrs)
-		goto fail;
-
-	/* Sanity check on bus space */
-	iomask = bus_space_to_resource_flags(node->addrs[index].space);
-	if (iomask & IORESOURCE_MEM)
-		parent = &iomem_resource;
-	else if (iomask & IORESOURCE_IO)
-		parent = &ioport_resource;
-	else
-		goto fail;
-
-	/* Find a PCI parent if any */
-	nd = node;
-	pcidev = NULL;
-	while (nd) {
-		if (!pci_device_from_OF_node(nd, &pci_bus, &pci_devfn))
-			pcidev = pci_find_slot(pci_bus, pci_devfn);
-		if (pcidev) break;
-		nd = nd->parent;
-	}
-	if (pcidev)
-		parent = find_parent_pci_resource(pcidev, &node->addrs[index]);
-	if (!parent) {
-		printk(KERN_WARNING "request_OF_resource(%s), parent not found\n",
-			node->name);
-		goto fail;
-	}
-
-	res = __request_region(parent, node->addrs[index].address,
-			       node->addrs[index].size, NULL);
-	if (!res)
-		goto fail;
-	nlen = strlen(node->name);
-	plen = name_postfix ? strlen(name_postfix) : 0;
-	res->name = (const char *)kmalloc(nlen+plen+1, GFP_KERNEL);
-	if (res->name) {
-		strcpy((char *)res->name, node->name);
-		if (plen)
-			strcpy((char *)res->name+nlen, name_postfix);
-	}
-	return res;
-fail:
-	return NULL;
-}
-EXPORT_SYMBOL(request_OF_resource);
 
-int release_OF_resource(struct device_node *node, int index)
-{
-	struct pci_dev* pcidev;
-	u8 pci_bus, pci_devfn;
-	unsigned long iomask, start, end;
-	struct device_node* nd;
-	struct resource* parent;
-	struct resource *res = NULL;
-
-	if (index >= node->n_addrs)
-		return -EINVAL;
-
-	/* Sanity check on bus space */
-	iomask = bus_space_to_resource_flags(node->addrs[index].space);
-	if (iomask & IORESOURCE_MEM)
-		parent = &iomem_resource;
-	else if (iomask & IORESOURCE_IO)
-		parent = &ioport_resource;
-	else
-		return -EINVAL;
-
-	/* Find a PCI parent if any */
-	nd = node;
-	pcidev = NULL;
-	while(nd) {
-		if (!pci_device_from_OF_node(nd, &pci_bus, &pci_devfn))
-			pcidev = pci_find_slot(pci_bus, pci_devfn);
-		if (pcidev) break;
-		nd = nd->parent;
-	}
-	if (pcidev)
-		parent = find_parent_pci_resource(pcidev, &node->addrs[index]);
-	if (!parent) {
-		printk(KERN_WARNING "release_OF_resource(%s), parent not found\n",
-			node->name);
-		return -ENODEV;
-	}
-
-	/* Find us in the parent and its childs */
-	res = parent->child;
-	start = node->addrs[index].address;
-	end = start + node->addrs[index].size - 1;
-	while (res) {
-		if (res->start == start && res->end == end &&
-		    (res->flags & IORESOURCE_BUSY))
-		    	break;
-		if (res->start <= start && res->end >= end)
-			res = res->child;
-		else
-			res = res->sibling;
-	}
-	if (!res)
-		return -ENODEV;
-
-	if (res->name) {
-		kfree(res->name);
-		res->name = NULL;
-	}
-	release_resource(res);
-	kfree(res);
-
-	return 0;
-}
-EXPORT_SYMBOL(release_OF_resource);
-#endif /* CONFIG_PCI */
Index: linux-work/include/asm-powerpc/prom.h
===================================================================
--- linux-work.orig/include/asm-powerpc/prom.h	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/include/asm-powerpc/prom.h	2005-12-13 17:51:20.000000000 +1100
@@ -65,49 +65,11 @@ struct boot_param_header
 typedef u32 phandle;
 typedef u32 ihandle;
 
-struct address_range {
-	unsigned long space;
-	unsigned long address;
-	unsigned long size;
-};
-
 struct interrupt_info {
 	int	line;
 	int	sense;		/* +ve/-ve logic, edge or level, etc. */
 };
 
-struct pci_address {
-	u32 a_hi;
-	u32 a_mid;
-	u32 a_lo;
-};
-
-struct isa_address {
-	u32 a_hi;
-	u32 a_lo;
-};
-
-struct isa_range {
-	struct isa_address isa_addr;
-	struct pci_address pci_addr;
-	unsigned int size;
-};
-
-struct reg_property {
-	unsigned long address;
-	unsigned long size;
-};
-
-struct reg_property32 {
-	unsigned int address;
-	unsigned int size;
-};
-
-struct reg_property64 {
-	u64 address;
-	u64 size;
-};
-
 struct property {
 	char	*name;
 	int	length;
@@ -120,8 +82,6 @@ struct device_node {
 	char	*type;
 	phandle	node;
 	phandle linux_phandle;
-	int	n_addrs;
-	struct	address_range *addrs;
 	int	n_intrs;
 	struct	interrupt_info *intrs;
 	char	*full_name;
Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2005-12-13 17:51:20.000000000 +1100
@@ -1445,20 +1445,55 @@ static long g5_i2s_enable(struct device_
 	/* Very crude implementation for now */
 	struct macio_chip *macio = &macio_chips[0];
 	unsigned long flags;
+	int cell;
+	u32 fcrs[3][3] = {
+		{ 0,
+		  K2_FCR1_I2S0_CELL_ENABLE |
+		  K2_FCR1_I2S0_CLK_ENABLE_BIT | K2_FCR1_I2S0_ENABLE,
+		  KL3_I2S0_CLK18_ENABLE
+		},
+		{ KL0_SCC_A_INTF_ENABLE,
+		  K2_FCR1_I2S1_CELL_ENABLE |
+		  K2_FCR1_I2S1_CLK_ENABLE_BIT | K2_FCR1_I2S1_ENABLE,
+		  KL3_I2S1_CLK18_ENABLE
+		},
+		{ KL0_SCC_B_INTF_ENABLE,
+		  SH_FCR1_I2S2_CELL_ENABLE |
+		  SH_FCR1_I2S2_CLK_ENABLE_BIT | SH_FCR1_I2S2_ENABLE,
+		  SH_FCR3_I2S2_CLK18_ENABLE
+		},
+	};
 
-	if (value == 0)
-		return 0; /* don't disable yet */
+	if (macio->type != macio_keylargo2 /* && macio->type != macio_shasta*/)
+		return -ENODEV;
+	if (strncmp(node->name, "i2s-", 4))
+		return -ENODEV;
+	cell = node->name[4] - 'a';
+	switch(cell) {
+	case 0:
+	case 1:
+		break;
+#if 0
+	case 2:
+		if (macio->type == macio_shasta)
+			break;
+#endif
+	default:
+		return -ENODEV;
+	}
 
 	LOCK(flags);
-	MACIO_BIS(KEYLARGO_FCR3, KL3_CLK45_ENABLE | KL3_CLK49_ENABLE |
-		  KL3_I2S0_CLK18_ENABLE);
-	udelay(10);
-	MACIO_BIS(KEYLARGO_FCR1, K2_FCR1_I2S0_CELL_ENABLE |
-		  K2_FCR1_I2S0_CLK_ENABLE_BIT | K2_FCR1_I2S0_ENABLE);
+	if (value) {
+		MACIO_BIC(KEYLARGO_FCR0, fcrs[cell][0]);
+		MACIO_BIS(KEYLARGO_FCR1, fcrs[cell][1]);
+		MACIO_BIS(KEYLARGO_FCR3, fcrs[cell][2]);
+	} else {
+		MACIO_BIC(KEYLARGO_FCR3, fcrs[cell][2]);
+		MACIO_BIC(KEYLARGO_FCR1, fcrs[cell][1]);
+		MACIO_BIS(KEYLARGO_FCR0, fcrs[cell][0]);
+	}
 	udelay(10);
-	MACIO_BIC(KEYLARGO_FCR1, K2_FCR1_I2S0_RESET);
 	UNLOCK(flags);
-	udelay(10);
 
 	return 0;
 }
@@ -2960,26 +2995,6 @@ pmac_feature_init(void)
 	set_initial_features();
 }
 
-int __init pmac_feature_late_init(void)
-{
-#if 0
-	struct device_node *np;
-
-	/* Request some resources late */
-	if (uninorth_node)
-		request_OF_resource(uninorth_node, 0, NULL);
-	np = find_devices("hammerhead");
-	if (np)
-		request_OF_resource(np, 0, NULL);
-	np = find_devices("interrupt-controller");
-	if (np)
-		request_OF_resource(np, 0, NULL);
-#endif
-	return 0;
-}
-
-device_initcall(pmac_feature_late_init);
-
 #if 0
 static void dump_HT_speeds(char *name, u32 cfg, u32 frq)
 {
Index: linux-work/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pic.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pic.c	2005-12-13 17:51:20.000000000 +1100
@@ -5,8 +5,8 @@
  *  in a separate file
  *
  *  Copyright (C) 1997 Paul Mackerras (paulus@samba.org)
- *
- *  Maintained by Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *  Copyright (C) 2005 Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *                     IBM, Corp.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -54,12 +54,7 @@ struct pmac_irq_hw {
 };
 
 /* Default addresses */
-static volatile struct pmac_irq_hw *pmac_irq_hw[4] = {
-        (struct pmac_irq_hw *) 0xf3000020,
-        (struct pmac_irq_hw *) 0xf3000010,
-        (struct pmac_irq_hw *) 0xf4000020,
-        (struct pmac_irq_hw *) 0xf4000010,
-};
+static volatile struct pmac_irq_hw __iomem *pmac_irq_hw[4];
 
 #define GC_LEVEL_MASK		0x3ff00000
 #define OHARE_LEVEL_MASK	0x1ff00000
@@ -82,8 +77,7 @@ static unsigned long ppc_lost_interrupts
  * since it can lose interrupts (see pmac_set_irq_mask).
  * -- Cort
  */
-void
-__set_lost(unsigned long irq_nr, int nokick)
+void __set_lost(unsigned long irq_nr, int nokick)
 {
 	if (!test_and_set_bit(irq_nr, ppc_lost_interrupts)) {
 		atomic_inc(&ppc_n_lost_interrupts);
@@ -92,8 +86,7 @@ __set_lost(unsigned long irq_nr, int nok
 	}
 }
 
-static void
-pmac_mask_and_ack_irq(unsigned int irq_nr)
+static void pmac_mask_and_ack_irq(unsigned int irq_nr)
 {
         unsigned long bit = 1UL << (irq_nr & 0x1f);
         int i = irq_nr >> 5;
@@ -224,8 +217,7 @@ static irqreturn_t gatwick_action(int cp
 	return IRQ_NONE;
 }
 
-int
-pmac_get_irq(struct pt_regs *regs)
+static int pmac_get_irq(struct pt_regs *regs)
 {
 	int irq;
 	unsigned long bits = 0;
@@ -256,34 +248,40 @@ pmac_get_irq(struct pt_regs *regs)
 
 /* This routine will fix some missing interrupt values in the device tree
  * on the gatwick mac-io controller used by some PowerBooks
+ *
+ * Walking of OF nodes could use a bit more fixing up here, but it's not
+ * very important as this is all boot time code on static portions of the
+ * device-tree.
+ *
+ * However, the modifications done to "intrs" will have to be removed and
+ * replaced with proper updates of the "interrupts" properties or
+ * AAPL,interrupts, yet to be decided, once the dynamic parsing is there.
  */
-static void __init
-pmac_fix_gatwick_interrupts(struct device_node *gw, int irq_base)
+static void __init pmac_fix_gatwick_interrupts(struct device_node *gw,
+					       int irq_base)
 {
 	struct device_node *node;
 	int count;
 
 	memset(gatwick_int_pool, 0, sizeof(gatwick_int_pool));
-	node = gw->child;
 	count = 0;
-	while(node)
-	{
+	for (node = NULL; (node = of_get_next_child(gw, node)) != NULL;) {
 		/* Fix SCC */
-		if (strcasecmp(node->name, "escc") == 0)
-			if (node->child) {
-				if (node->child->n_intrs < 3) {
-					node->child->intrs = &gatwick_int_pool[count];
-					count += 3;
-				}
-				node->child->n_intrs = 3;
-				node->child->intrs[0].line = 15+irq_base;
-				node->child->intrs[1].line =  4+irq_base;
-				node->child->intrs[2].line =  5+irq_base;
-				printk(KERN_INFO "irq: fixed SCC on second controller (%d,%d,%d)\n",
-					node->child->intrs[0].line,
-					node->child->intrs[1].line,
-					node->child->intrs[2].line);
+		if ((strcasecmp(node->name, "escc") == 0) && node->child) {
+			if (node->child->n_intrs < 3) {
+				node->child->intrs = &gatwick_int_pool[count];
+				count += 3;
 			}
+			node->child->n_intrs = 3;
+			node->child->intrs[0].line = 15+irq_base;
+			node->child->intrs[1].line =  4+irq_base;
+			node->child->intrs[2].line =  5+irq_base;
+			printk(KERN_INFO "irq: fixed SCC on gatwick"
+			       " (%d,%d,%d)\n",
+			       node->child->intrs[0].line,
+			       node->child->intrs[1].line,
+			       node->child->intrs[2].line);
+		}
 		/* Fix media-bay & left SWIM */
 		if (strcasecmp(node->name, "media-bay") == 0) {
 			struct device_node* ya_node;
@@ -292,12 +290,11 @@ pmac_fix_gatwick_interrupts(struct devic
 				node->intrs = &gatwick_int_pool[count++];
 			node->n_intrs = 1;
 			node->intrs[0].line = 29+irq_base;
-			printk(KERN_INFO "irq: fixed media-bay on second controller (%d)\n",
-					node->intrs[0].line);
+			printk(KERN_INFO "irq: fixed media-bay on gatwick"
+			       " (%d)\n", node->intrs[0].line);
 
 			ya_node = node->child;
-			while(ya_node)
-			{
+			while(ya_node) {
 				if (strcasecmp(ya_node->name, "floppy") == 0) {
 					if (ya_node->n_intrs < 2) {
 						ya_node->intrs = &gatwick_int_pool[count];
@@ -323,7 +320,6 @@ pmac_fix_gatwick_interrupts(struct devic
 				ya_node = ya_node->sibling;
 			}
 		}
-		node = node->sibling;
 	}
 	if (count > 10) {
 		printk("WARNING !! Gatwick interrupt pool overflow\n");
@@ -338,45 +334,41 @@ pmac_fix_gatwick_interrupts(struct devic
  * controller.  If we find this second ohare, set it up and fix the
  * interrupt value in the device tree for the ethernet chip.
  */
-static int __init enable_second_ohare(void)
+static void __init enable_second_ohare(struct device_node *np)
 {
 	unsigned char bus, devfn;
 	unsigned short cmd;
-        unsigned long addr;
-	struct device_node *irqctrler = find_devices("pci106b,7");
 	struct device_node *ether;
 
-	if (irqctrler == NULL || irqctrler->n_addrs <= 0)
-		return -1;
-	addr = (unsigned long) ioremap(irqctrler->addrs[0].address, 0x40);
-	pmac_irq_hw[1] = (volatile struct pmac_irq_hw *)(addr + 0x20);
-	max_irqs = 64;
-	if (pci_device_from_OF_node(irqctrler, &bus, &devfn) == 0) {
-		struct pci_controller* hose = pci_find_hose_for_OF_device(irqctrler);
-		if (!hose)
-		    printk(KERN_ERR "Can't find PCI hose for OHare2 !\n");
-		else {
-		    early_read_config_word(hose, bus, devfn, PCI_COMMAND, &cmd);
-		    cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
-	  	    cmd &= ~PCI_COMMAND_IO;
-		    early_write_config_word(hose, bus, devfn, PCI_COMMAND, cmd);
+	/* This code doesn't strictly belong here, it could be part of
+	 * either the PCI initialisation or the feature code. It's kept
+	 * here for historical reasons.
+	 */
+	if (pci_device_from_OF_node(np, &bus, &devfn) == 0) {
+		struct pci_controller* hose =
+			pci_find_hose_for_OF_device(np);
+		if (!hose) {
+			printk(KERN_ERR "Can't find PCI hose for OHare2 !\n");
+			return;
 		}
+		early_read_config_word(hose, bus, devfn, PCI_COMMAND, &cmd);
+		cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+		cmd &= ~PCI_COMMAND_IO;
+		early_write_config_word(hose, bus, devfn, PCI_COMMAND, cmd);
 	}
 
 	/* Fix interrupt for the modem/ethernet combo controller. The number
-	   in the device tree (27) is bogus (correct for the ethernet-only
-	   board but not the combo ethernet/modem board).
-	   The real interrupt is 28 on the second controller -> 28+32 = 60.
-	*/
-	ether = find_devices("pci1011,14");
+	 * in the device tree (27) is bogus (correct for the ethernet-only
+	 * board but not the combo ethernet/modem board).
+	 * The real interrupt is 28 on the second controller -> 28+32 = 60.
+	 */
+	ether = of_find_node_by_name(NULL, "pci1011,14");
 	if (ether && ether->n_intrs > 0) {
 		ether->intrs[0].line = 60;
 		printk(KERN_INFO "irq: Fixed ethernet IRQ to %d\n",
 		       ether->intrs[0].line);
 	}
-
-	/* Return the interrupt number of the cascade */
-	return irqctrler->intrs[0].line;
+	of_node_put(ether);
 }
 
 #ifdef CONFIG_XMON
@@ -394,189 +386,233 @@ static struct irqaction gatwick_cascade_
 	.mask		= CPU_MASK_NONE,
 	.name		= "cascade",
 };
-#endif /* CONFIG_PPC32 */
 
-static int pmac_u3_cascade(struct pt_regs *regs, void *data)
+static void __init pmac_pic_probe_oldstyle(void)
 {
-	return mpic_get_one_irq((struct mpic *)data, regs);
-}
-
-void __init pmac_pic_init(void)
-{
-        struct device_node *irqctrler  = NULL;
-        struct device_node *irqctrler2 = NULL;
-	struct device_node *np;
-#ifdef CONFIG_PPC32
         int i;
-        unsigned long addr;
 	int irq_cascade = -1;
-#endif
-	struct mpic *mpic1, *mpic2;
+        struct device_node *master = NULL;
+	struct device_node *slave = NULL;
+	u8 __iomem *addr;
+	struct resource r;
 
-	/* We first try to detect Apple's new Core99 chipset, since mac-io
-	 * is quite different on those machines and contains an IBM MPIC2.
-	 */
-	np = find_type_devices("open-pic");
-	while (np) {
-		if (np->parent && !strcmp(np->parent->name, "u3"))
-			irqctrler2 = np;
-		else
-			irqctrler = np;
-		np = np->next;
-	}
-	if (irqctrler != NULL && irqctrler->n_addrs > 0) {
-		unsigned char senses[128];
-
-		printk(KERN_INFO "PowerMac using OpenPIC irq controller at 0x%08x\n",
-		       (unsigned int)irqctrler->addrs[0].address);
-		pmac_call_feature(PMAC_FTR_ENABLE_MPIC, irqctrler, 0, 0);
-
-		prom_get_irq_senses(senses, 0, 128);
-		mpic1 = mpic_alloc(irqctrler->addrs[0].address,
-				   MPIC_PRIMARY | MPIC_WANTS_RESET,
-				   0, 0, 128, 252, senses, 128, " OpenPIC  ");
-		BUG_ON(mpic1 == NULL);
-		mpic_init(mpic1);		
-
-		if (irqctrler2 != NULL && irqctrler2->n_intrs > 0 &&
-		    irqctrler2->n_addrs > 0) {
-			printk(KERN_INFO "Slave OpenPIC at 0x%08x hooked on IRQ %d\n",
-			       (u32)irqctrler2->addrs[0].address,
-			       irqctrler2->intrs[0].line);
-
-			pmac_call_feature(PMAC_FTR_ENABLE_MPIC, irqctrler2, 0, 0);
-			prom_get_irq_senses(senses, 128, 128 + 124);
-
-			/* We don't need to set MPIC_BROKEN_U3 here since we don't have
-			 * hypertransport interrupts routed to it
-			 */
-			mpic2 = mpic_alloc(irqctrler2->addrs[0].address,
-					   MPIC_BIG_ENDIAN | MPIC_WANTS_RESET,
-					   0, 128, 124, 0, senses, 124,
-					   " U3-MPIC  ");
-			BUG_ON(mpic2 == NULL);
-			mpic_init(mpic2);
-			mpic_setup_cascade(irqctrler2->intrs[0].line,
-					   pmac_u3_cascade, mpic2);
-		}
-#if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
-		{
-			struct device_node* pswitch;
-			int nmi_irq;
-
-			pswitch = find_devices("programmer-switch");
-			if (pswitch && pswitch->n_intrs) {
-				nmi_irq = pswitch->intrs[0].line;
-				mpic_irq_set_priority(nmi_irq, 9);
-				setup_irq(nmi_irq, &xmon_action);
-			}
-		}
-#endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
-		return;
-	}
-	irqctrler = NULL;
+	/* Set our get_irq function */
+	ppc_md.get_irq = pmac_get_irq;
 
-#ifdef CONFIG_PPC32
-	/* Get the level/edge settings, assume if it's not
-	 * a Grand Central nor an OHare, then it's an Heathrow
-	 * (or Paddington).
+	/*
+	 * Find the interrupt controller type & node
 	 */
-	ppc_md.get_irq = pmac_get_irq;
-	if (find_devices("gc"))
+
+	if ((master = of_find_node_by_name(NULL, "gc")) != NULL) {
+		max_irqs = max_real_irqs = 32;
 		level_mask[0] = GC_LEVEL_MASK;
-	else if (find_devices("ohare")) {
+	} else if ((master = of_find_node_by_name(NULL, "ohare")) != NULL) {
+		max_irqs = max_real_irqs = 32;
 		level_mask[0] = OHARE_LEVEL_MASK;
+
 		/* We might have a second cascaded ohare */
-		level_mask[1] = OHARE_LEVEL_MASK;
-	} else {
+		slave = of_find_node_by_name(NULL, "pci106b,7");
+		if (slave) {
+			max_irqs = 64;
+			level_mask[1] = OHARE_LEVEL_MASK;
+			enable_second_ohare(slave);
+		}
+	} else if ((master = of_find_node_by_name(NULL, "mac-io")) != NULL) {
+		max_irqs = max_real_irqs = 64;
 		level_mask[0] = HEATHROW_LEVEL_MASK;
 		level_mask[1] = 0;
+
 		/* We might have a second cascaded heathrow */
-		level_mask[2] = HEATHROW_LEVEL_MASK;
-		level_mask[3] = 0;
-	}
+		slave = of_find_node_by_name(master, "mac-io");
 
-	/*
-	 * G3 powermacs and 1999 G3 PowerBooks have 64 interrupts,
-	 * 1998 G3 Series PowerBooks have 128,
-	 * other powermacs have 32.
-	 * The combo ethernet/modem card for the Powerstar powerbooks
-	 * (2400/3400/3500, ohare based) has a second ohare chip
-	 * effectively making a total of 64.
-	 */
-	max_irqs = max_real_irqs = 32;
-	irqctrler = find_devices("mac-io");
-	if (irqctrler)
-	{
-		max_real_irqs = 64;
-		if (irqctrler->next)
+		/* Check ordering of master & slave */
+		if (device_is_compatible(master, "gatwick")) {
+			struct device_node *tmp;
+			BUG_ON(slave == NULL);
+			tmp = master;
+			master = slave;
+			slave = tmp;
+		}
+
+		/* We found a slave */
+		if (slave) {
 			max_irqs = 128;
-		else
-			max_irqs = 64;
+			level_mask[2] = HEATHROW_LEVEL_MASK;
+			level_mask[3] = 0;
+			pmac_fix_gatwick_interrupts(slave, max_real_irqs);
+		}
 	}
+	BUG_ON(master == NULL);
+
+	/* Set the handler for the main PIC */
 	for ( i = 0; i < max_real_irqs ; i++ )
 		irq_desc[i].handler = &pmac_pic;
 
-	/* get addresses of first controller */
-	if (irqctrler) {
-		if  (irqctrler->n_addrs > 0) {
-			addr = (unsigned long)
-				ioremap(irqctrler->addrs[0].address, 0x40);
-			for (i = 0; i < 2; ++i)
-				pmac_irq_hw[i] = (volatile struct pmac_irq_hw*)
-					(addr + (2 - i) * 0x10);
-		}
+	/* Get addresses of first controller if we have a node for it */
+	BUG_ON(of_address_to_resource(master, 0, &r));
 
-		/* get addresses of second controller */
-		irqctrler = irqctrler->next;
-		if (irqctrler && irqctrler->n_addrs > 0) {
-			addr = (unsigned long)
-				ioremap(irqctrler->addrs[0].address, 0x40);
-			for (i = 2; i < 4; ++i)
-				pmac_irq_hw[i] = (volatile struct pmac_irq_hw*)
-					(addr + (4 - i) * 0x10);
-			irq_cascade = irqctrler->intrs[0].line;
-			if (device_is_compatible(irqctrler, "gatwick"))
-				pmac_fix_gatwick_interrupts(irqctrler, max_real_irqs);
-		}
-	} else {
-		/* older powermacs have a GC (grand central) or ohare at
-		   f3000000, with interrupt control registers at f3000020. */
-		addr = (unsigned long) ioremap(0xf3000000, 0x40);
-		pmac_irq_hw[0] = (volatile struct pmac_irq_hw *) (addr + 0x20);
+	/* Map interrupts of primary controller */
+	addr = (u8 __iomem *) ioremap(r.start, 0x40);
+	i = 0;
+	pmac_irq_hw[i++] = (volatile struct pmac_irq_hw __iomem *)
+		(addr + 0x20);
+	if (max_real_irqs > 32)
+		pmac_irq_hw[i++] = (volatile struct pmac_irq_hw __iomem *)
+			(addr + 0x10);
+	of_node_put(master);
+
+	printk(KERN_INFO "irq: Found primary Apple PIC %s for %d irqs\n",
+	       master->full_name, max_real_irqs);
+
+	/* Map interrupts of cascaded controller */
+	if (slave && !of_address_to_resource(slave, 0, &r)) {
+		addr = (u8 __iomem *)ioremap(r.start, 0x40);
+		pmac_irq_hw[i++] = (volatile struct pmac_irq_hw __iomem *)
+			(addr + 0x20);
+		if (max_irqs > 64)
+			pmac_irq_hw[i++] =
+				(volatile struct pmac_irq_hw __iomem *)
+				(addr + 0x10);
+		irq_cascade = slave->intrs[0].line;
+
+		printk(KERN_INFO "irq: Found slave Apple PIC %s for %d irqs"
+		       " cascade: %d\n", slave->full_name,
+		       max_irqs - max_real_irqs, irq_cascade);
 	}
-
-	/* PowerBooks 3400 and 3500 can have a second controller in a second
-	   ohare chip, on the combo ethernet/modem card */
-	if (machine_is_compatible("AAPL,3400/2400")
-	     || machine_is_compatible("AAPL,3500"))
-		irq_cascade = enable_second_ohare();
+	of_node_put(slave);
 
 	/* disable all interrupts in all controllers */
 	for (i = 0; i * 32 < max_irqs; ++i)
 		out_le32(&pmac_irq_hw[i]->enable, 0);
+
 	/* mark level interrupts */
 	for (i = 0; i < max_irqs; i++)
 		if (level_mask[i >> 5] & (1UL << (i & 0x1f)))
 			irq_desc[i].status = IRQ_LEVEL;
 
-	/* get interrupt line of secondary interrupt controller */
-	if (irq_cascade >= 0) {
-		printk(KERN_INFO "irq: secondary controller on irq %d\n",
-			(int)irq_cascade);
+	/* Setup handlers for secondary controller and hook cascade irq*/
+	if (slave) {
 		for ( i = max_real_irqs ; i < max_irqs ; i++ )
 			irq_desc[i].handler = &gatwick_pic;
 		setup_irq(irq_cascade, &gatwick_cascade_action);
 	}
-	printk("System has %d possible interrupts\n", max_irqs);
-	if (max_irqs != max_real_irqs)
-		printk(KERN_DEBUG "%d interrupts on main controller\n",
-			max_real_irqs);
-
+	printk(KERN_INFO "irq: System has %d possible interrupts\n", max_irqs);
 #ifdef CONFIG_XMON
 	setup_irq(20, &xmon_action);
-#endif	/* CONFIG_XMON */
-#endif	/* CONFIG_PPC32 */
+#endif
+}
+#endif /* CONFIG_PPC32 */
+
+static int pmac_u3_cascade(struct pt_regs *regs, void *data)
+{
+	return mpic_get_one_irq((struct mpic *)data, regs);
+}
+
+static void __init pmac_pic_setup_mpic_nmi(struct mpic *mpic)
+{
+#if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
+	struct device_node* pswitch;
+	int nmi_irq;
+
+	pswitch = of_find_node_by_name(NULL, "programmer-switch");
+	if (pswitch && pswitch->n_intrs) {
+		nmi_irq = pswitch->intrs[0].line;
+		mpic_irq_set_priority(nmi_irq, 9);
+		setup_irq(nmi_irq, &xmon_action);
+	}
+	of_node_put(pswitch);
+#endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
+}
+
+static int __init pmac_pic_probe_mpic(void)
+{
+	struct mpic *mpic1, *mpic2;
+	struct device_node *np, *master = NULL, *slave = NULL;
+	unsigned char senses[128];
+	struct resource r;
+
+	/* We can have up to 2 MPICs cascaded */
+	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
+		     != NULL;) {
+		if (master == NULL &&
+		    get_property(np, "interrupt-parent", NULL) != NULL)
+			master = of_node_get(np);
+		else if (slave == NULL)
+			slave = of_node_get(np);
+		if (master && slave)
+			break;
+	}
+
+	/* Check for bogus setups */
+	if (master == NULL && slave != NULL) {
+		master = slave;
+		slave = NULL;
+	}
+
+	/* Not found, default to good old pmac pic */
+	if (master == NULL)
+		return -ENODEV;
+
+	/* Set master handler */
+	ppc_md.get_irq = mpic_get_irq;
+
+	/* Setup master */
+	BUG_ON(of_address_to_resource(master, 0, &r));
+	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, master, 0, 0);
+	prom_get_irq_senses(senses, 0, 128);
+	mpic1 = mpic_alloc(r.start, MPIC_PRIMARY | MPIC_WANTS_RESET,
+			   0, 0, 128, 252, senses, 128, " OpenPIC  ");
+	BUG_ON(mpic1 == NULL);
+	mpic_init(mpic1);
+
+	/* Install NMI if any */
+	pmac_pic_setup_mpic_nmi(mpic1);
+
+	of_node_put(master);
+
+	/* No slave, let's go out */
+	if (slave == NULL || slave->n_intrs < 1)
+		return 0;
+
+	/* Setup slave, failures are non-fatal */
+	if (of_address_to_resource(slave, 0, &r)) {
+		printk(KERN_ERR "Can't get address of MPIC %s\n",
+		       slave->full_name);
+		return 0;
+	}
+	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, slave, 0, 0);
+	prom_get_irq_senses(senses, 128, 128 + 124);
+
+	/* We don't need to set MPIC_BROKEN_U3 here since we don't have
+	 * hypertransport interrupts routed to it, at least not on currently
+	 * supported machines, that may change.
+	 */
+	mpic2 = mpic_alloc(r.start, MPIC_BIG_ENDIAN | MPIC_WANTS_RESET,
+			   0, 128, 124, 0, senses, 124, " U3-MPIC  ");
+	if (mpic2 == NULL) {
+		printk(KERN_ERR "Can't create slave MPIC %s\n",
+		       slave->full_name);
+		return 0;
+	}
+	mpic_init(mpic2);
+	mpic_setup_cascade(slave->intrs[0].line, pmac_u3_cascade, mpic2);
+
+	of_node_put(slave);
+	return 0;
+}
+
+
+void __init pmac_pic_init(void)
+{
+	/* We first try to detect Apple's new Core99 chipset, since mac-io
+	 * is quite different on those machines and contains an IBM MPIC2.
+	 */
+	if (pmac_pic_probe_mpic() == 0)
+		return;
+
+#ifdef CONFIG_PPC32
+	pmac_pic_probe_oldstyle();
+#endif
 }
 
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
Index: linux-work/drivers/macintosh/via-cuda.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-cuda.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/macintosh/via-cuda.c	2005-12-13 17:51:20.000000000 +1100
@@ -193,10 +193,6 @@ static int __init via_cuda_start(void)
     if (via == NULL)
 	return -ENODEV;
 
-#ifdef CONFIG_PPC
-    request_OF_resource(vias, 0, NULL);
-#endif
-
     if (request_irq(CUDA_IRQ, cuda_interrupt, 0, "ADB", cuda_interrupt)) {
 	printk(KERN_ERR "cuda_init: can't get irq %d\n", CUDA_IRQ);
 	return -EAGAIN;
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2005-12-13 17:51:20.000000000 +1100
@@ -298,7 +298,7 @@ static struct backlight_controller pmu_b
 
 int __init find_via_pmu(void)
 {
-	phys_addr_t taddr;
+	u64 taddr;
 	u32 *reg;
 
 	if (via != 0)
@@ -337,7 +337,7 @@ int __init find_via_pmu(void)
 	else if (device_is_compatible(vias->parent, "Keylargo")
 		 || device_is_compatible(vias->parent, "K2-Keylargo")) {
 		struct device_node *gpiop;
-		phys_addr_t gaddr = 0;
+		u64 gaddr = OF_BAD_ADDR;
 
 		pmu_kind = PMU_KEYLARGO_BASED;
 		pmu_has_adb = (find_type_devices("adb") != NULL);
@@ -352,7 +352,7 @@ int __init find_via_pmu(void)
 			reg = (u32 *)get_property(gpiop, "reg", NULL);
 			if (reg)
 				gaddr = of_translate_address(gpiop, reg);
-			if (gaddr != 0)
+			if (gaddr != OF_BAD_ADDR)
 				gpio_reg = ioremap(gaddr, 0x10);
 		}
 		if (gpio_reg == NULL)
@@ -479,9 +479,6 @@ static int __init via_pmu_dev_init(void)
 	if (vias == NULL)
 		return -ENODEV;
 
-#ifndef CONFIG_PPC64
-	request_OF_resource(vias, 0, NULL);
-#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 	/* Enable backlight */
 	register_backlight_controller(&pmu_backlight_controller, NULL, "pmu");
Index: linux-work/arch/powerpc/platforms/powermac/nvram.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/nvram.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/nvram.c	2005-12-13 17:51:20.000000000 +1100
@@ -514,7 +514,7 @@ static void core99_nvram_sync(void)
 #endif
 }
 
-static int __init core99_nvram_setup(struct device_node *dp)
+static int __init core99_nvram_setup(struct device_node *dp, unsigned long addr)
 {
 	int i;
 	u32 gen_bank0, gen_bank1;
@@ -528,7 +528,7 @@ static int __init core99_nvram_setup(str
 		printk(KERN_ERR "nvram: can't allocate ram image\n");
 		return -ENOMEM;
 	}
-	nvram_data = ioremap(dp->addrs[0].address, NVRAM_SIZE*2);
+	nvram_data = ioremap(addr, NVRAM_SIZE*2);
 	nvram_naddrs = 1; /* Make sure we get the correct case */
 
 	DBG("nvram: Checking bank 0...\n");
@@ -570,34 +570,48 @@ static int __init core99_nvram_setup(str
 int __init pmac_nvram_init(void)
 {
 	struct device_node *dp;
+	struct resource r1, r2;
+	unsigned int s1 = 0, s2 = 0;
 	int err = 0;
 
 	nvram_naddrs = 0;
 
-	dp = find_devices("nvram");
+	dp = of_find_node_by_name(NULL, "nvram");
 	if (dp == NULL) {
 		printk(KERN_ERR "Can't find NVRAM device\n");
 		return -ENODEV;
 	}
-	nvram_naddrs = dp->n_addrs;
+
+	/* Try to obtain an address */
+	if (of_address_to_resource(dp, 0, &r1) == 0) {
+		nvram_naddrs = 1;
+		s1 = (r1.end - r1.start) + 1;
+		if (of_address_to_resource(dp, 1, &r2) == 0) {
+			nvram_naddrs = 2;
+			s2 = (r2.end - r2.start) + 1;
+		}
+	}
+
 	is_core_99 = device_is_compatible(dp, "nvram,flash");
-	if (is_core_99)
-		err = core99_nvram_setup(dp);
+	if (is_core_99) {
+		err = core99_nvram_setup(dp, r1.start);
+		goto bail;
+	}
+
 #ifdef CONFIG_PPC32
-	else if (_machine == _MACH_chrp && nvram_naddrs == 1) {
-		nvram_data = ioremap(dp->addrs[0].address + isa_mem_base,
-				     dp->addrs[0].size);
+	if (_machine == _MACH_chrp && nvram_naddrs == 1) {
+		nvram_data = ioremap(r1.start, s1);
 		nvram_mult = 1;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
 	} else if (nvram_naddrs == 1) {
-		nvram_data = ioremap(dp->addrs[0].address, dp->addrs[0].size);
-		nvram_mult = (dp->addrs[0].size + NVRAM_SIZE - 1) / NVRAM_SIZE;
+		nvram_data = ioremap(r1.start, s1);
+		nvram_mult = (s1 + NVRAM_SIZE - 1) / NVRAM_SIZE;
 		ppc_md.nvram_read_val	= direct_nvram_read_byte;
 		ppc_md.nvram_write_val	= direct_nvram_write_byte;
 	} else if (nvram_naddrs == 2) {
-		nvram_addr = ioremap(dp->addrs[0].address, dp->addrs[0].size);
-		nvram_data = ioremap(dp->addrs[1].address, dp->addrs[1].size);
+		nvram_addr = ioremap(r1.start, s1);
+		nvram_data = ioremap(r2.start, s2);
 		ppc_md.nvram_read_val	= indirect_nvram_read_byte;
 		ppc_md.nvram_write_val	= indirect_nvram_write_byte;
 	} else if (nvram_naddrs == 0 && sys_ctrler == SYS_CTRLER_PMU) {
@@ -606,13 +620,15 @@ int __init pmac_nvram_init(void)
 		ppc_md.nvram_read_val	= pmu_nvram_read_byte;
 		ppc_md.nvram_write_val	= pmu_nvram_write_byte;
 #endif /* CONFIG_ADB_PMU */
-	}
-#endif
-	else {
+	} else {
 		printk(KERN_ERR "Incompatible type of NVRAM\n");
-		return -ENXIO;
+		err = -ENXIO;
 	}
-	lookup_partitions();
+#endif /* CONFIG_PPC32 */
+bail:
+	of_node_put(dp);
+	if (err == 0)
+		lookup_partitions();
 	return err;
 }
 
Index: linux-work/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pci.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pci.c	2005-12-13 17:51:20.000000000 +1100
@@ -285,15 +285,13 @@ static struct pci_ops chaos_pci_ops =
 };
 
 static void __init setup_chaos(struct pci_controller *hose,
-			       struct reg_property *addr)
+			       struct resource *addr)
 {
 	/* assume a `chaos' bridge */
 	hose->ops = &chaos_pci_ops;
-	hose->cfg_addr = ioremap(addr->address + 0x800000, 0x1000);
-	hose->cfg_data = ioremap(addr->address + 0xc00000, 0x1000);
+	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
+	hose->cfg_data = ioremap(addr->start + 0xc00000, 0x1000);
 }
-#else
-#define setup_chaos(hose, addr)
 #endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PPC64
@@ -356,9 +354,11 @@ static unsigned long u3_ht_cfg_access(st
 		/* For now, we don't self probe U3 HT bridge */
 		if (PCI_SLOT(devfn) == 0)
 			return 0;
-		return ((unsigned long)hose->cfg_data) + U3_HT_CFA0(devfn, offset);
+		return ((unsigned long)hose->cfg_data) +
+			U3_HT_CFA0(devfn, offset);
 	} else
-		return ((unsigned long)hose->cfg_data) + U3_HT_CFA1(bus, devfn, offset);
+		return ((unsigned long)hose->cfg_data) +
+			U3_HT_CFA1(bus, devfn, offset);
 }
 
 static int u3_ht_read_config(struct pci_bus *bus, unsigned int devfn,
@@ -532,7 +532,8 @@ static void __init init_p2pbridge(void)
 	}
 	if (early_read_config_word(hose, bus, devfn,
 				   PCI_BRIDGE_CONTROL, &val) < 0) {
-		printk(KERN_ERR "init_p2pbridge: couldn't read bridge control\n");
+		printk(KERN_ERR "init_p2pbridge: couldn't read bridge"
+		       " control\n");
 		return;
 	}
 	val &= ~PCI_BRIDGE_CTL_MASTER_ABORT;
@@ -576,36 +577,38 @@ static void __init fixup_nec_usb2(void)
 			continue;
 		early_read_config_dword(hose, bus, devfn, 0xe4, &data);
 		if (data & 1UL) {
-			printk("Found NEC PD720100A USB2 chip with disabled EHCI, fixing up...\n");
+			printk("Found NEC PD720100A USB2 chip with disabled"
+			       " EHCI, fixing up...\n");
 			data &= ~1UL;
 			early_write_config_dword(hose, bus, devfn, 0xe4, data);
-			early_write_config_byte(hose, bus, devfn | 2, PCI_INTERRUPT_LINE,
+			early_write_config_byte(hose, bus,
+						devfn | 2, PCI_INTERRUPT_LINE,
 				nec->intrs[0].line);
 		}
 	}
 }
 
 static void __init setup_bandit(struct pci_controller *hose,
-				struct reg_property *addr)
+				struct resource *addr)
 {
 	hose->ops = &macrisc_pci_ops;
-	hose->cfg_addr = ioremap(addr->address + 0x800000, 0x1000);
-	hose->cfg_data = ioremap(addr->address + 0xc00000, 0x1000);
+	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
+	hose->cfg_data = ioremap(addr->start + 0xc00000, 0x1000);
 	init_bandit(hose);
 }
 
 static int __init setup_uninorth(struct pci_controller *hose,
-				 struct reg_property *addr)
+				 struct resource *addr)
 {
 	pci_assign_all_buses = 1;
 	has_uninorth = 1;
 	hose->ops = &macrisc_pci_ops;
-	hose->cfg_addr = ioremap(addr->address + 0x800000, 0x1000);
-	hose->cfg_data = ioremap(addr->address + 0xc00000, 0x1000);
+	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
+	hose->cfg_data = ioremap(addr->start + 0xc00000, 0x1000);
 	/* We "know" that the bridge at f2000000 has the PCI slots. */
-	return addr->address == 0xf2000000;
+	return addr->start == 0xf2000000;
 }
-#endif
+#endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PPC64
 static void __init setup_u3_agp(struct pci_controller* hose)
@@ -722,7 +725,7 @@ static void __init setup_u3_ht(struct pc
 		hose->mem_resources[cur-1].end = res->start - 1;
 	}
 }
-#endif
+#endif /* CONFIG_PPC64 */
 
 /*
  * We assume that if we have a G3 powermac, we have one bridge called
@@ -733,24 +736,17 @@ static int __init add_bridge(struct devi
 {
 	int len;
 	struct pci_controller *hose;
-#ifdef CONFIG_PPC32
-	struct reg_property *addr;
-#endif
+	struct resource rsrc;
 	char *disp_name;
 	int *bus_range;
-	int primary = 1;
+	int primary = 1, has_address = 0;
 
 	DBG("Adding PCI host bridge %s\n", dev->full_name);
 
-#ifdef CONFIG_PPC32
-	/* XXX fix this */
-	addr = (struct reg_property *) get_property(dev, "reg", &len);
-	if (addr == NULL || len < sizeof(*addr)) {
-		printk(KERN_WARNING "Can't use %s: no address\n",
-		       dev->full_name);
-		return -ENODEV;
-	}
-#endif
+	/* Fetch host bridge registers address */
+	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+
+	/* Get bus range if any */
 	bus_range = (int *) get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int)) {
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
@@ -770,6 +766,8 @@ static int __init add_bridge(struct devi
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
 	disp_name = NULL;
+
+	/* 64 bits only bridges */
 #ifdef CONFIG_PPC64
 	if (device_is_compatible(dev, "u3-agp")) {
 		setup_u3_agp(hose);
@@ -782,25 +780,30 @@ static int __init add_bridge(struct devi
 	}
 	printk(KERN_INFO "Found %s PCI host bridge.  Firmware bus number: %d->%d\n",
 		disp_name, hose->first_busno, hose->last_busno);
-#else
+#endif /* CONFIG_PPC64 */
+
+	/* 32 bits only bridges */
+#ifdef CONFIG_PPC32
 	if (device_is_compatible(dev, "uni-north")) {
-		primary = setup_uninorth(hose, addr);
+		primary = setup_uninorth(hose, &rsrc);
 		disp_name = "UniNorth";
 	} else if (strcmp(dev->name, "pci") == 0) {
 		/* XXX assume this is a mpc106 (grackle) */
 		setup_grackle(hose);
 		disp_name = "Grackle (MPC106)";
 	} else if (strcmp(dev->name, "bandit") == 0) {
-		setup_bandit(hose, addr);
+		setup_bandit(hose, &rsrc);
 		disp_name = "Bandit";
 	} else if (strcmp(dev->name, "chaos") == 0) {
-		setup_chaos(hose, addr);
+		setup_chaos(hose, &rsrc);
 		disp_name = "Chaos";
 		primary = 0;
 	}
-	printk(KERN_INFO "Found %s PCI host bridge at 0x%08lx. Firmware bus number: %d->%d\n",
-		disp_name, addr->address, hose->first_busno, hose->last_busno);
-#endif
+	printk(KERN_INFO "Found %s PCI host bridge at 0x%08lx. "
+	       "Firmware bus number: %d->%d\n",
+		disp_name, rsrc.start, hose->first_busno, hose->last_busno);
+#endif /* CONFIG_PPC32 */
+
 	DBG(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
 		hose, hose->cfg_addr, hose->cfg_data);
 
@@ -814,8 +817,7 @@ static int __init add_bridge(struct devi
 	return 0;
 }
 
-static void __init
-pcibios_fixup_OF_interrupts(void)
+static void __init pcibios_fixup_OF_interrupts(void)
 {
 	struct pci_dev* dev = NULL;
 
@@ -835,8 +837,7 @@ pcibios_fixup_OF_interrupts(void)
 	}
 }
 
-void __init
-pmac_pcibios_fixup(void)
+void __init pmac_pcibios_fixup(void)
 {
 	/* Fixup interrupts according to OF tree */
 	pcibios_fixup_OF_interrupts();
Index: linux-work/arch/powerpc/platforms/powermac/pmac.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pmac.h	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pmac.h	2005-12-13 17:51:20.000000000 +1100
@@ -42,10 +42,6 @@ extern void pmac_ide_init_hwif_ports(hw_
 	unsigned long data_port, unsigned long ctrl_port, int *irq);
 
 extern int pmac_nvram_init(void);
-
-extern struct hw_interrupt_type pmac_pic;
-
-void pmac_pic_init(void);
-int pmac_get_irq(struct pt_regs *regs);
+extern void pmac_pic_init(void);
 
 #endif /* __PMAC_H__ */
Index: linux-work/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2005-12-13 17:51:20.000000000 +1100
@@ -75,7 +75,6 @@
 #include <asm/iommu.h>
 #include <asm/smu.h>
 #include <asm/pmc.h>
-#include <asm/mpic.h>
 #include <asm/lmb.h>
 #include <asm/udbg.h>
 
@@ -751,7 +750,7 @@ struct machdep_calls __initdata pmac_md 
 	.init_early		= pmac_init_early,
 	.show_cpuinfo		= pmac_show_cpuinfo,
 	.init_IRQ		= pmac_pic_init,
-	.get_irq		= mpic_get_irq,	/* changed later */
+	.get_irq		= NULL,	/* changed later */
 	.pcibios_fixup		= pmac_pcibios_fixup,
 	.restart		= pmac_restart,
 	.power_off		= pmac_power_off,
Index: linux-work/arch/powerpc/platforms/powermac/time.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/time.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/time.c	2005-12-13 17:51:20.000000000 +1100
@@ -258,15 +258,20 @@ int __init via_calibrate_decr(void)
 	volatile unsigned char __iomem *via;
 	int count = VIA_TIMER_FREQ_6 / 100;
 	unsigned int dstart, dend;
+	struct resource rsrc;
 
-	vias = find_devices("via-cuda");
+	vias = of_find_node_by_name(NULL, "via-cuda");
 	if (vias == 0)
-		vias = find_devices("via-pmu");
+		vias = of_find_node_by_name(NULL, "via-pmu");
 	if (vias == 0)
-		vias = find_devices("via");
-	if (vias == 0 || vias->n_addrs == 0)
+		vias = of_find_node_by_name(NULL, "via");
+	if (vias == 0 || of_address_to_resource(vias, 0, &rsrc))
 		return 0;
-	via = ioremap(vias->addrs[0].address, vias->addrs[0].size);
+	via = ioremap(rsrc.start, rsrc.end - rsrc.start + 1);
+	if (via == NULL) {
+		printk(KERN_ERR "Failed to map VIA for timer calibration !\n");
+		return 0;
+	}
 
 	/* set timer 1 for continuous interrupts */
 	out_8(&via[ACR], (via[ACR] & ~T1MODE) | T1MODE_CONT);
Index: linux-work/drivers/macintosh/macio_asic.c
===================================================================
--- linux-work.orig/drivers/macintosh/macio_asic.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/macintosh/macio_asic.c	2005-12-13 17:51:20.000000000 +1100
@@ -256,42 +256,42 @@ static int macio_resource_quirks(struct 
 {
 	if (res->flags & IORESOURCE_MEM) {
 		/* Grand Central has too large resource 0 on some machines */
-		if (index == 0 && !strcmp(np->name, "gc")) {
-			np->addrs[0].size = 0x20000;
+		if (index == 0 && !strcmp(np->name, "gc"))
 			res->end = res->start + 0x1ffff;
-		}
+
 		/* Airport has bogus resource 2 */
 		if (index >= 2 && !strcmp(np->name, "radio"))
 			return 1;
+
+#ifndef CONFIG_PPC64
 		/* DBDMAs may have bogus sizes */
-		if ((res->start & 0x0001f000) == 0x00008000) {
-			np->addrs[index].size = 0x100;
+		if ((res->start & 0x0001f000) == 0x00008000)
 			res->end = res->start + 0xff;
-		}
+#endif /* CONFIG_PPC64 */
+
 		/* ESCC parent eats child resources. We could have added a
 		 * level of hierarchy, but I don't really feel the need
 		 * for it
 		 */
 		if (!strcmp(np->name, "escc"))
 			return 1;
+
 		/* ESCC has bogus resources >= 3 */
 		if (index >= 3 && !(strcmp(np->name, "ch-a") &&
 				    strcmp(np->name, "ch-b")))
 			return 1;
+
 		/* Media bay has too many resources, keep only first one */
 		if (index > 0 && !strcmp(np->name, "media-bay"))
 			return 1;
+
 		/* Some older IDE resources have bogus sizes */
 		if (!(strcmp(np->name, "IDE") && strcmp(np->name, "ATA") &&
 		      strcmp(np->type, "ide") && strcmp(np->type, "ata"))) {
-			if (index == 0 && np->addrs[0].size > 0x1000) {
-				np->addrs[0].size = 0x1000;
+			if (index == 0 && (res->end - res->start) > 0xfff)
 				res->end = res->start + 0xfff;
-			}
-			if (index == 1 && np->addrs[1].size > 0x100) {
-				np->addrs[1].size = 0x100;
+			if (index == 1 && (res->end - res->start) > 0xff)
 				res->end = res->start + 0xff;
-			}
 		}
 	}
 	return 0;
@@ -349,7 +349,7 @@ static void macio_setup_resources(struct
 		/* Currently, we consider failure as harmless, this may
 		 * change in the future, once I've found all the device
 		 * tree bugs in older machines & worked around them
-l		 */
+		 */
 		if (insert_resource(parent_res, res)) {
 			printk(KERN_WARNING "Can't request resource "
 			       "%d for MacIO device %s\n",
Index: linux-work/drivers/macintosh/mediabay.c
===================================================================
--- linux-work.orig/drivers/macintosh/mediabay.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/macintosh/mediabay.c	2005-12-13 17:51:20.000000000 +1100
@@ -647,6 +647,7 @@ static int __devinit media_bay_attach(st
 	struct media_bay_info* bay;
 	u32 __iomem *regbase;
 	struct device_node *ofnode;
+	unsigned long base;
 	int i;
 
 	ofnode = mdev->ofdev.node;
@@ -656,10 +657,11 @@ static int __devinit media_bay_attach(st
 	if (macio_request_resources(mdev, "media-bay"))
 		return -EBUSY;
 	/* Media bay registers are located at the beginning of the
-         * mac-io chip, we get the parent address for now (hrm...)
+         * mac-io chip, for now, we trick and align down the first
+	 * resource passed in
          */
-	regbase = (u32 __iomem *)
-		ioremap(ofnode->parent->addrs[0].address, 0x100);
+	base = macio_resource_start(mdev, 0) & 0xffff0000u;
+	regbase = (u32 __iomem *)ioremap(base, 0x100);
 	if (regbase == NULL) {
 		macio_release_resources(mdev);
 		return -ENOMEM;
Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/ide/ppc/pmac.c	2005-12-13 17:51:20.000000000 +1100
@@ -1271,7 +1271,7 @@ static int
 pmac_ide_setup_device(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif)
 {
 	struct device_node *np = pmif->node;
-	int *bidp, i;
+	int *bidp;
 
 	pmif->cable_80 = 0;
 	pmif->broken_dma = pmif->broken_dma_warn = 0;
@@ -1430,7 +1430,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	pmif = &pmac_ide[i];
 	hwif = &ide_hwifs[i];
 
-	if (mdev->ofdev.node->n_addrs == 0) {
+	if (macio_resource_count(mdev) == 0) {
 		printk(KERN_WARNING "ide%d: no address for %s\n",
 		       i, mdev->ofdev.node->full_name);
 		return -ENXIO;
Index: linux-work/drivers/scsi/mac53c94.c
===================================================================
--- linux-work.orig/drivers/scsi/mac53c94.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/scsi/mac53c94.c	2005-12-13 17:51:20.000000000 +1100
@@ -432,11 +432,12 @@ static int mac53c94_probe(struct macio_d
 	struct Scsi_Host *host;
 	void *dma_cmd_space;
 	unsigned char *clkprop;
-	int proplen;
+	int proplen, rc = -ENODEV;
 
 	if (macio_resource_count(mdev) != 2 || macio_irq_count(mdev) != 2) {
-		printk(KERN_ERR "mac53c94: expected 2 addrs and intrs (got %d/%d)\n",
-		       node->n_addrs, node->n_intrs);
+		printk(KERN_ERR "mac53c94: expected 2 addrs and intrs"
+		       " (got %d/%d)\n",
+		       macio_resource_count(mdev), macio_irq_count(mdev));
 		return -ENODEV;
 	}
 
@@ -448,6 +449,7 @@ static int mac53c94_probe(struct macio_d
        	host = scsi_host_alloc(&mac53c94_template, sizeof(struct fsc_state));
 	if (host == NULL) {
 		printk(KERN_ERR "mac53c94: couldn't register host");
+		rc = -ENOMEM;
 		goto out_release;
 	}
 
@@ -486,6 +488,7 @@ static int mac53c94_probe(struct macio_d
        	if (dma_cmd_space == 0) {
        		printk(KERN_ERR "mac53c94: couldn't allocate dma "
        		       "command space for %s\n", node->full_name);
+		rc = -ENOMEM;
        		goto out_free;
        	}
 	state->dma_cmds = (struct dbdma_cmd *)DBDMA_ALIGN(dma_cmd_space);
@@ -495,18 +498,21 @@ static int mac53c94_probe(struct macio_d
 
 	mac53c94_init(state);
 
-	if (request_irq(state->intr, do_mac53c94_interrupt, 0, "53C94", state)) {
+	if (request_irq(state->intr, do_mac53c94_interrupt, 0, "53C94",state)) {
 		printk(KERN_ERR "mac53C94: can't get irq %d for %s\n",
 		       state->intr, node->full_name);
 		goto out_free_dma;
 	}
 
-	/* XXX FIXME: handle failure */
-	scsi_add_host(host, &mdev->ofdev.dev);
-	scsi_scan_host(host);
+	rc = scsi_add_host(host, &mdev->ofdev.dev);
+	if (rc != 0)
+		goto out_release_irq;
 
+	scsi_scan_host(host);
 	return 0;
 
+ out_release_irq:
+	free_irq(state->intr, state);
  out_free_dma:
 	kfree(state->dma_cmd_space);
  out_free:
@@ -518,7 +524,7 @@ static int mac53c94_probe(struct macio_d
  out_release:
 	macio_release_resources(mdev);
 
-	return  -ENODEV;
+	return rc;
 }
 
 static int mac53c94_remove(struct macio_dev *mdev)
Index: linux-work/drivers/scsi/mesh.c
===================================================================
--- linux-work.orig/drivers/scsi/mesh.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/scsi/mesh.c	2005-12-13 17:51:20.000000000 +1100
@@ -1869,7 +1869,8 @@ static int mesh_probe(struct macio_dev *
 
 	if (macio_resource_count(mdev) != 2 || macio_irq_count(mdev) != 2) {
        		printk(KERN_ERR "mesh: expected 2 addrs and 2 intrs"
-	       	       " (got %d,%d)\n", mesh->n_addrs, mesh->n_intrs);
+	       	       " (got %d,%d)\n", macio_resource_count(mdev),
+		       macio_irq_count(mdev));
 		return -ENODEV;
 	}
 
Index: linux-work/drivers/video/offb.c
===================================================================
--- linux-work.orig/drivers/video/offb.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/video/offb.c	2005-12-13 17:51:20.000000000 +1100
@@ -223,6 +223,7 @@ static int offb_blank(int blank, struct 
 int __init offb_init(void)
 {
 	struct device_node *dp = NULL, *boot_disp = NULL;
+
 #if defined(CONFIG_BOOTX_TEXT) && defined(CONFIG_PPC32)
 	struct device_node *macos_display = NULL;
 #endif
@@ -234,60 +235,54 @@ int __init offb_init(void)
 	if (boot_infos != 0) {
 		unsigned long addr =
 		    (unsigned long) boot_infos->dispDeviceBase;
+		u32 *addrp;
+		u64 daddr, dsize;
+		unsigned int flags;
+
 		/* find the device node corresponding to the macos display */
 		while ((dp = of_find_node_by_type(dp, "display"))) {
 			int i;
-			/*
-			 * Grrr...  It looks like the MacOS ATI driver
-			 * munges the assigned-addresses property (but
-			 * the AAPL,address value is OK).
-			 */
-			if (strncmp(dp->name, "ATY,", 4) == 0
-			    && dp->n_addrs == 1) {
-				unsigned int *ap =
-				    (unsigned int *) get_property(dp,
-								  "AAPL,address",
-								  NULL);
-				if (ap != NULL) {
-					dp->addrs[0].address = *ap;
-					dp->addrs[0].size = 0x01000000;
-				}
-			}
 
 			/*
-			 * The LTPro on the Lombard powerbook has no addresses
-			 * on the display nodes, they are on their parent.
+			 * Look for an AAPL,address property first.
 			 */
-			if (dp->n_addrs == 0
-			    && device_is_compatible(dp, "ATY,264LTPro")) {
-				int na;
-				unsigned int *ap = (unsigned int *)
-				    get_property(dp, "AAPL,address", &na);
-				if (ap != 0)
-					for (na /= sizeof(unsigned int);
-					     na > 0; --na, ++ap)
-						if (*ap <= addr
-						    && addr <
-						    *ap + 0x1000000)
-							goto foundit;
+			unsigned int na;
+			unsigned int *ap =
+				(unsigned int *)get_property(dp, "AAPL,address",
+							     &na);
+			if (ap != 0) {
+				for (na /= sizeof(unsigned int); na > 0;
+				     --na, ++ap)
+					if (*ap <= addr &&
+					    addr < *ap + 0x1000000) {
+						macos_display = dp;
+						goto foundit;
+					}
 			}
 
 			/*
 			 * See if the display address is in one of the address
 			 * ranges for this display.
 			 */
-			for (i = 0; i < dp->n_addrs; ++i) {
-				if (dp->addrs[i].address <= addr
-				    && addr <
-				    dp->addrs[i].address +
-				    dp->addrs[i].size)
+			i = 0;
+			for (;;) {
+				addrp = of_get_address(dp, i++, &dsize, &flags);
+				if (addrp == NULL)
 					break;
+				if (!(flags & IORESOURCE_MEM))
+					continue;
+				daddr = of_translate_address(dp, addrp);
+				if (daddr == OF_BAD_ADDR)
+					continue;
+				if (daddr <= addr && addr < (daddr + dsize)) {
+					macos_display = dp;
+					goto foundit;
+				}
 			}
-			if (i < dp->n_addrs) {
-			      foundit:
+		foundit:
+			if (macos_display) {
 				printk(KERN_INFO "MacOS display is %s\n",
 				       dp->full_name);
-				macos_display = dp;
 				break;
 			}
 		}
@@ -326,8 +321,10 @@ static void __init offb_init_nodriver(st
 	int *pp, i;
 	unsigned int len;
 	int width = 640, height = 480, depth = 8, pitch;
-	unsigned int rsize, *up;
-	unsigned long address = 0;
+	unsigned int flags, rsize, *up;
+	u64 address = OF_BAD_ADDR;
+	u32 *addrp;
+	u64 asize;
 
 	if ((pp = (int *) get_property(dp, "depth", &len)) != NULL
 	    && len == sizeof(int))
@@ -363,7 +360,7 @@ static void __init offb_init_nodriver(st
                                break;
 	       }
                if (pdev) {
-                       for (i = 0; i < 6 && address == 0; i++) {
+                       for (i = 0; i < 6 && address == OF_BAD_ADDR; i++) {
                                if ((pci_resource_flags(pdev, i) &
 				    IORESOURCE_MEM) &&
 				   (pci_resource_len(pdev, i) >= rsize))
@@ -374,27 +371,33 @@ static void __init offb_init_nodriver(st
         }
 #endif /* CONFIG_PCI */
 
-	if (address == 0 &&
-	    (up = (unsigned *) get_property(dp, "address", &len)) != NULL &&
-	    len == sizeof(unsigned))
-		address = (u_long) * up;
-	if (address == 0) {
-		for (i = 0; i < dp->n_addrs; ++i)
-			if (dp->addrs[i].size >=
-			    pitch * height * depth / 8)
-				break;
-		if (i >= dp->n_addrs) {
+       /* This one is dodgy, we may drop it ... */
+       if (address == OF_BAD_ADDR &&
+	   (up = (unsigned *) get_property(dp, "address", &len)) != NULL &&
+	   len == sizeof(unsigned int))
+	       address = (u64) * up;
+
+       if (address == OF_BAD_ADDR) {
+	       for (i = 0; (addrp = of_get_address(dp, i, &asize, &flags))
+			    != NULL; i++) {
+		       if (!(flags & IORESOURCE_MEM))
+			       continue;
+		       if (asize >= pitch * height * depth / 8)
+			       break;
+	       }
+		if (addrp == NULL) {
 			printk(KERN_ERR
 			       "no framebuffer address found for %s\n",
 			       dp->full_name);
 			return;
 		}
-
-		address = (u_long) dp->addrs[i].address;
-
-#ifdef CONFIG_PPC64
-		address += ((struct pci_dn *)dp->data)->phb->pci_mem_offset;
-#endif
+		address = of_translate_address(dp, addrp);
+		if (address == OF_BAD_ADDR) {
+			printk(KERN_ERR
+			       "can't translate framebuffer address for %s\n",
+			       dp->full_name);
+			return;
+		}
 
 		/* kludge for valkyrie */
 		if (strcmp(dp->name, "valkyrie") == 0)
@@ -459,7 +462,9 @@ static void __init offb_init_fb(const ch
 
 	par->cmap_type = cmap_unknown;
 	if (depth == 8) {
-		/* XXX kludge for ati */
+
+		/* Palette hacks disabled for now */
+#if 0
 		if (dp && !strncmp(name, "ATY,Rage128", 11)) {
 			unsigned long regbase = dp->addrs[2].address;
 			par->cmap_adr = ioremap(regbase, 0x1FFF);
@@ -490,6 +495,7 @@ static void __init offb_init_fb(const ch
 			par->cmap_adr = ioremap(regbase + 0x6000, 0x1000);
 			par->cmap_type = cmap_gxt2000;
 		}
+#endif
 		fix->visual = par->cmap_adr ? FB_VISUAL_PSEUDOCOLOR
 		    : FB_VISUAL_STATIC_PSEUDOCOLOR;
 	} else
Index: linux-work/arch/powerpc/kernel/btext.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/btext.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/btext.c	2005-12-13 17:51:20.000000000 +1100
@@ -211,8 +211,6 @@ int __init btext_find_display(int allow_
 	struct device_node *np = NULL; 
 	int rc = -ENODEV;
 
-	printk("trying to initialize btext ...\n");
-
 	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
 	if (name != NULL) {
 		np = of_find_node_by_path(name);
Index: linux-work/drivers/serial/pmac_zilog.c
===================================================================
--- linux-work.orig/drivers/serial/pmac_zilog.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/serial/pmac_zilog.c	2005-12-13 17:51:20.000000000 +1100
@@ -1431,11 +1431,14 @@ static int __init pmz_init_port(struct u
 		char	name[1];
 	} *slots;
 	int len;
+	struct resource r_ports, r_rxdma, r_txdma;
 
 	/*
 	 * Request & map chip registers
 	 */
-	uap->port.mapbase = np->addrs[0].address;
+	if (of_address_to_resource(np, 0, &r_ports))
+		return -ENODEV;
+	uap->port.mapbase = r_ports.start;
 	uap->port.membase = ioremap(uap->port.mapbase, 0x1000);
       
 	uap->control_reg = uap->port.membase;
@@ -1445,16 +1448,20 @@ static int __init pmz_init_port(struct u
 	 * Request & map DBDMA registers
 	 */
 #ifdef HAS_DBDMA
-	if (np->n_addrs >= 3 && np->n_intrs >= 3)
+	if (of_address_to_resource(np, 1, &r_txdma) == 0 &&
+	    of_address_to_resource(np, 2, &r_rxdma) == 0)
 		uap->flags |= PMACZILOG_FLAG_HAS_DMA;
+#else
+	memset(&r_txdma, 0, sizeof(struct resource));
+	memset(&r_rxdma, 0, sizeof(struct resource));
 #endif	
 	if (ZS_HAS_DMA(uap)) {
-		uap->tx_dma_regs = ioremap(np->addrs[np->n_addrs - 2].address, 0x1000);
+		uap->tx_dma_regs = ioremap(r_txdma.start, 0x100);
 		if (uap->tx_dma_regs == NULL) {	
 			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
-		uap->rx_dma_regs = ioremap(np->addrs[np->n_addrs - 1].address, 0x1000);
+		uap->rx_dma_regs = ioremap(r_rxdma.start, 0x100);
 		if (uap->rx_dma_regs == NULL) {	
 			iounmap(uap->tx_dma_regs);
 			uap->tx_dma_regs = NULL;
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2005-12-13 17:51:20.000000000 +1100
@@ -896,6 +896,25 @@ static void __devinit pci_process_ISA_OF
 				      unsigned long phb_io_base_phys,
 				      void __iomem * phb_io_base_virt)
 {
+	/* Remove these asap */
+
+	struct pci_address {
+		u32 a_hi;
+		u32 a_mid;
+		u32 a_lo;
+	};
+
+	struct isa_address {
+		u32 a_hi;
+		u32 a_lo;
+	};
+
+	struct isa_range {
+		struct isa_address isa_addr;
+		struct pci_address pci_addr;
+		unsigned int size;
+	};
+
 	struct isa_range *range;
 	unsigned long pci_addr;
 	unsigned int isa_addr;
@@ -1330,8 +1349,9 @@ unsigned int pci_address_to_pio(phys_add
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		if (address >= hose->io_base_phys &&
 		    address < (hose->io_base_phys + hose->pci_io_size))
-			return (unsigned int)hose->io_base_virt +
-				(address - hose->io_base_phys);
+			return (unsigned int)
+				((unsigned long)hose->io_base_virt +
+				 (address - hose->io_base_phys));
 	}
 	return (unsigned int)-1;
 }
Index: linux-work/sound/ppc/pmac.c
===================================================================
--- linux-work.orig/sound/ppc/pmac.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/sound/ppc/pmac.c	2005-12-13 17:51:20.000000000 +1100
@@ -817,21 +817,17 @@ static int snd_pmac_free(pmac_t *chip)
 		iounmap(chip->playback.dma);
 	if (chip->capture.dma)
 		iounmap(chip->capture.dma);
-#ifndef CONFIG_PPC64
+
 	if (chip->node) {
 		int i;
-
 		for (i = 0; i < 3; i++) {
-			if (chip->of_requested & (1 << i)) {
-				if (chip->is_k2)
-					release_OF_resource(chip->node->parent,
-							    i);
-				else
-					release_OF_resource(chip->node, i);
-			}
+			if (chip->requested & (1 << i))
+				release_mem_region(chip->rsrc[i].start,
+						   chip->rsrc[i].end -
+						   chip->rsrc[i].start + 1);
 		}
 	}
-#endif /* CONFIG_PPC64 */
+
 	if (chip->pdev)
 		pci_dev_put(chip->pdev);
 	kfree(chip);
@@ -1005,6 +1001,11 @@ static int __init snd_pmac_detect(pmac_t
 			chip->can_byte_swap = 0; /* FIXME: check this */
 			chip->control_mask = MASK_IEPC | 0x11;/* disable IEE */
 			break;
+		default:
+			printk(KERN_ERR "snd: Unknown layout ID 0x%x\n",
+			       layout_id);
+			return -ENODEV;
+
 		}
 	}
 	prop = (unsigned int *)get_property(sound, "device-id", NULL);
@@ -1186,46 +1187,69 @@ int __init snd_pmac_new(snd_card_t *card
 	}
 
 	np = chip->node;
+	chip->requested = 0;
 	if (chip->is_k2) {
-		if (np->parent->n_addrs < 2 || np->n_intrs < 3) {
+		static char *rnames[] = {
+			"Sound Control", "Sound DMA" };
+		if (np->n_intrs < 3) {
 			err = -ENODEV;
 			goto __error;
 		}
-		for (i = 0; i < 2; i++) {
-#ifndef CONFIG_PPC64
-			static char *name[2] = { "- Control", "- DMA" };
-			if (! request_OF_resource(np->parent, i, name[i])) {
-				snd_printk(KERN_ERR "pmac: can't request resource %d!\n", i);
+		for (i = 0; i < 2; i ++) {
+			if (of_address_to_resource(np->parent, i,
+						   &chip->rsrc[i])) {
+				printk(KERN_ERR "snd: can't translate rsrc "
+				       " %d (%s)\n", i, rnames[i]);
+				err = -ENODEV;
+				goto __error;
+			}
+			if (request_mem_region(chip->rsrc[i].start,
+					       chip->rsrc[i].end -
+					       chip->rsrc[i].start + 1,
+					       rnames[i]) == NULL) {
+				printk(KERN_ERR "snd: can't request rsrc "
+				       " %d (%s: 0x%08lx:%08lx)\n",
+				       i, rnames[i], chip->rsrc[i].start,
+				       chip->rsrc[i].end);
 				err = -ENODEV;
 				goto __error;
 			}
-			chip->of_requested |= (1 << i);
-#endif /* CONFIG_PPC64 */
-			ctrl_addr = np->parent->addrs[0].address;
-			txdma_addr = np->parent->addrs[1].address;
-			rxdma_addr = txdma_addr + 0x100;
+			chip->requested |= (1 << i);
 		}
-
+		ctrl_addr = chip->rsrc[0].start;
+		txdma_addr = chip->rsrc[1].start;
+		rxdma_addr = txdma_addr + 0x100;
 	} else {
-		if (np->n_addrs < 3 || np->n_intrs < 3) {
+		static char *rnames[] = {
+			"Sound Control", "Sound Tx DMA", "Sound Rx DMA" };
+		if (np->n_intrs < 3) {
 			err = -ENODEV;
 			goto __error;
 		}
-
-		for (i = 0; i < 3; i++) {
-#ifndef CONFIG_PPC64
-			static char *name[3] = { "- Control", "- Tx DMA", "- Rx DMA" };
-			if (! request_OF_resource(np, i, name[i])) {
-				snd_printk(KERN_ERR "pmac: can't request resource %d!\n", i);
+		for (i = 0; i < 3; i ++) {
+			if (of_address_to_resource(np->parent, i,
+						   &chip->rsrc[i])) {
+				printk(KERN_ERR "snd: can't translate rsrc "
+				       " %d (%s)\n", i, rnames[i]);
+				err = -ENODEV;
+				goto __error;
+			}
+			if (request_mem_region(chip->rsrc[i].start,
+					       chip->rsrc[i].end -
+					       chip->rsrc[i].start + 1,
+					       rnames[i]) == NULL) {
+				printk(KERN_ERR "snd: can't request rsrc "
+				       " %d (%s: 0x%08lx:%08lx)\n",
+				       i, rnames[i], chip->rsrc[i].start,
+				       chip->rsrc[i].end);
 				err = -ENODEV;
 				goto __error;
 			}
-			chip->of_requested |= (1 << i);
-#endif /* CONFIG_PPC64 */
-			ctrl_addr = np->addrs[0].address;
-			txdma_addr = np->addrs[1].address;
-			rxdma_addr = np->addrs[2].address;
+			chip->requested |= (1 << i);
 		}
+		ctrl_addr = chip->rsrc[0].start;
+		txdma_addr = chip->rsrc[1].start;
+		rxdma_addr = chip->rsrc[2].start;
 	}
 
 	chip->awacs = ioremap(ctrl_addr, 0x1000);
@@ -1277,9 +1301,11 @@ int __init snd_pmac_new(snd_card_t *card
 	} else if (chip->is_pbook_G3) {
 		struct device_node* mio;
 		for (mio = chip->node->parent; mio; mio = mio->parent) {
-			if (strcmp(mio->name, "mac-io") == 0
-			    && mio->n_addrs > 0) {
-				chip->macio_base = ioremap(mio->addrs[0].address, 0x40);
+			if (strcmp(mio->name, "mac-io") == 0) {
+				struct resource r;
+				if (of_address_to_resource(mio, 0, &r) == 0)
+					chip->macio_base =
+						ioremap(r.start, 0x40);
 				break;
 			}
 		}
Index: linux-work/sound/ppc/pmac.h
===================================================================
--- linux-work.orig/sound/ppc/pmac.h	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/sound/ppc/pmac.h	2005-12-13 17:51:20.000000000 +1100
@@ -122,7 +122,8 @@ struct snd_pmac {
 	unsigned int initialized : 1;
 	unsigned int feature_is_set : 1;
 
-	unsigned int of_requested;
+	unsigned int requested;
+	struct resource rsrc[3];
 
 	int num_freqs;
 	int *freq_table;
Index: linux-work/include/asm-powerpc/keylargo.h
===================================================================
--- linux-work.orig/include/asm-powerpc/keylargo.h	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/include/asm-powerpc/keylargo.h	2005-12-13 17:51:20.000000000 +1100
@@ -232,10 +232,12 @@
 #define K2_FCR1_I2S0_RESET		0x00000800
 #define K2_FCR1_I2S0_CLK_ENABLE_BIT	0x00001000
 #define K2_FCR1_I2S0_ENABLE    		0x00002000
-
 #define K2_FCR1_PCI1_CLK_ENABLE		0x00004000
 #define K2_FCR1_FW_CLK_ENABLE		0x00008000
 #define K2_FCR1_FW_RESET_N		0x00010000
+#define K2_FCR1_I2S1_CELL_ENABLE	0x00020000
+#define K2_FCR1_I2S1_CLK_ENABLE_BIT	0x00080000
+#define K2_FCR1_I2S1_ENABLE		0x00100000
 #define K2_FCR1_GMAC_CLK_ENABLE		0x00400000
 #define K2_FCR1_GMAC_POWER_DOWN		0x00800000
 #define K2_FCR1_GMAC_RESET_N		0x01000000
@@ -246,3 +248,9 @@
 #define K2_FCR1_UATA_RESET_N		0x40000000
 #define K2_FCR1_UATA_CHOOSE_CLK66	0x80000000
 
+/* Shasta definitions */
+#define SH_FCR1_I2S2_CELL_ENABLE	0x00000010
+#define SH_FCR1_I2S2_CLK_ENABLE_BIT	0x00000040
+#define SH_FCR1_I2S2_ENABLE		0x00000080
+#define SH_FCR3_I2S2_CLK18_ENABLE	0x00008000
+
Index: linux-work/drivers/video/platinumfb.c
===================================================================
--- linux-work.orig/drivers/video/platinumfb.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/video/platinumfb.c	2005-12-13 17:51:20.000000000 +1100
@@ -69,6 +69,8 @@ struct fb_info_platinum {
 	unsigned long			total_vram;
 	int				clktype;
 	int				dactype;
+
+	struct resource			rsrc_fb, rsrc_reg;
 };
 
 /*
@@ -97,9 +99,6 @@ static int platinum_var_to_par(struct fb
  * Interface used by the world
  */
 
-int platinumfb_init(void);
-int platinumfb_setup(char*);
-
 static struct fb_ops platinumfb_ops = {
 	.owner =	THIS_MODULE,
 	.fb_check_var	= platinumfb_check_var,
@@ -485,7 +484,7 @@ static int platinum_var_to_par(struct fb
 /* 
  * Parse user speficied options (`video=platinumfb:')
  */
-int __init platinumfb_setup(char *options)
+static int __init platinumfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -526,19 +525,15 @@ int __init platinumfb_setup(char *option
 #define invalidate_cache(addr)
 #endif
 
-static int __devinit platinumfb_probe(struct of_device* odev, const struct of_device_id *match)
+static int __devinit platinumfb_probe(struct of_device* odev,
+				      const struct of_device_id *match)
 {
 	struct device_node	*dp = odev->node;
 	struct fb_info		*info;
 	struct fb_info_platinum	*pinfo;
-	unsigned long		addr, size;
 	volatile __u8		*fbuffer;
-	int			i, bank0, bank1, bank2, bank3, rc;
+	int			bank0, bank1, bank2, bank3, rc;
 
-	if (dp->n_addrs != 2) {
-		printk(KERN_ERR "expecting 2 address for platinum (got %d)", dp->n_addrs);
-		return -ENXIO;
-	}
 	printk(KERN_INFO "platinumfb: Found Apple Platinum video hardware\n");
 
 	info = framebuffer_alloc(sizeof(*pinfo), &odev->dev);
@@ -546,27 +541,40 @@ static int __devinit platinumfb_probe(st
 		return -ENOMEM;
 	pinfo = info->par;
 
-	/* Map in frame buffer and registers */
-	for (i = 0; i < dp->n_addrs; ++i) {
-		addr = dp->addrs[i].address;
-		size = dp->addrs[i].size;
-		/* Let's assume we can request either all or nothing */
-		if (!request_mem_region(addr, size, "platinumfb")) {
-			framebuffer_release(info);
-			return -ENXIO;
-		}
-		if (size >= 0x400000) {
-			/* frame buffer - map only 4MB */
-			pinfo->frame_buffer_phys = addr;
-			pinfo->frame_buffer = __ioremap(addr, 0x400000, _PAGE_WRITETHRU);
-			pinfo->base_frame_buffer = pinfo->frame_buffer;
-		} else {
-			/* registers */
-			pinfo->platinum_regs_phys = addr;
-			pinfo->platinum_regs = ioremap(addr, size);
-		}
+	if (of_address_to_resource(dp, 0, &pinfo->rsrc_reg) ||
+	    of_address_to_resource(dp, 1, &pinfo->rsrc_fb)) {
+		printk(KERN_ERR "platinumfb: Can't get resources\n");
+		framebuffer_release(info);
+		return -ENXIO;
+	}
+	if (!request_mem_region(pinfo->rsrc_reg.start,
+				pinfo->rsrc_reg.start -
+				pinfo->rsrc_reg.end + 1,
+				"platinumfb registers")) {
+		framebuffer_release(info);
+		return -ENXIO;
+	}
+	if (!request_mem_region(pinfo->rsrc_fb.start,
+				pinfo->rsrc_fb.start
+				- pinfo->rsrc_fb.end + 1,
+				"platinumfb framebuffer")) {
+		release_mem_region(pinfo->rsrc_reg.start,
+				   pinfo->rsrc_reg.end -
+				   pinfo->rsrc_reg.start + 1);
+		framebuffer_release(info);
+		return -ENXIO;
 	}
 
+	/* frame buffer - map only 4MB */
+	pinfo->frame_buffer_phys = pinfo->rsrc_fb.start;
+	pinfo->frame_buffer = __ioremap(pinfo->rsrc_fb.start, 0x400000,
+					_PAGE_WRITETHRU);
+	pinfo->base_frame_buffer = pinfo->frame_buffer;
+
+	/* registers */
+	pinfo->platinum_regs_phys = pinfo->rsrc_reg.start;
+	pinfo->platinum_regs = ioremap(pinfo->rsrc_reg.start, 0x1000);
+
 	pinfo->cmap_regs_phys = 0xf301b000;	/* XXX not in prom? */
 	request_mem_region(pinfo->cmap_regs_phys, 0x1000, "platinumfb cmap");
 	pinfo->cmap_regs = ioremap(pinfo->cmap_regs_phys, 0x1000);
@@ -628,18 +636,16 @@ static int __devexit platinumfb_remove(s
 {
 	struct fb_info		*info = dev_get_drvdata(&odev->dev);
 	struct fb_info_platinum	*pinfo = info->par;
-	struct device_node *dp = odev->node;
-	unsigned long addr, size;
-	int i;
 	
         unregister_framebuffer (info);
 	
 	/* Unmap frame buffer and registers */
-	for (i = 0; i < dp->n_addrs; ++i) {
-		addr = dp->addrs[i].address;
-		size = dp->addrs[i].size;
-		release_mem_region(addr, size);
-	}
+	release_mem_region(pinfo->rsrc_fb.start,
+			   pinfo->rsrc_fb.end -
+			   pinfo->rsrc_fb.start + 1);
+	release_mem_region(pinfo->rsrc_reg.start,
+			   pinfo->rsrc_reg.end -
+			   pinfo->rsrc_reg.start + 1);
 	iounmap(pinfo->frame_buffer);
 	iounmap(pinfo->platinum_regs);
 	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
@@ -666,7 +672,7 @@ static struct of_platform_driver platinu
 	.remove		= platinumfb_remove,
 };
 
-int __init platinumfb_init(void)
+static int __init platinumfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -680,7 +686,7 @@ int __init platinumfb_init(void)
 	return 0;
 }
 
-void __exit platinumfb_exit(void)
+static void __exit platinumfb_exit(void)
 {
 	of_unregister_driver(&platinum_driver);	
 }
Index: linux-work/drivers/video/controlfb.c
===================================================================
--- linux-work.orig/drivers/video/controlfb.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/video/controlfb.c	2005-12-13 17:51:20.000000000 +1100
@@ -133,12 +133,6 @@ static int controlfb_mmap(struct fb_info
 static int controlfb_set_par (struct fb_info *info);
 static int controlfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info);
 
-/*
- * inititialization
- */
-int control_init(void);
-void control_setup(char *);
-
 /******************** Prototypes for internal functions **********************/
 
 static void set_control_clock(unsigned char *params);
@@ -550,9 +544,46 @@ static void control_set_hardware(struct 
 
 
 /*
- * Called from fbmem.c for probing & initializing
+ * Parse user speficied options (`video=controlfb:')
  */
-int __init control_init(void)
+static void __init control_setup(char *options)
+{
+	char *this_opt;
+
+	if (!options || !*options)
+		return;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!strncmp(this_opt, "vmode:", 6)) {
+			int vmode = simple_strtoul(this_opt+6, NULL, 0);
+			if (vmode > 0 && vmode <= VMODE_MAX &&
+			    control_mac_modes[vmode - 1].m[1] >= 0)
+				default_vmode = vmode;
+		} else if (!strncmp(this_opt, "cmode:", 6)) {
+			int depth = simple_strtoul(this_opt+6, NULL, 0);
+			switch (depth) {
+			 case CMODE_8:
+			 case CMODE_16:
+			 case CMODE_32:
+			 	default_cmode = depth;
+			 	break;
+			 case 8:
+				default_cmode = CMODE_8;
+				break;
+			 case 15:
+			 case 16:
+				default_cmode = CMODE_16;
+				break;
+			 case 24:
+			 case 32:
+				default_cmode = CMODE_32;
+				break;
+			}
+		}
+	}
+}
+
+static int __init control_init(void)
 {
 	struct device_node *dp;
 	char *option = NULL;
@@ -651,15 +682,16 @@ static void __init find_vram_size(struct
 static int __init control_of_init(struct device_node *dp)
 {
 	struct fb_info_control	*p;
-	unsigned long		addr;
-	int			i;
+	struct resource		fb_res, reg_res;
 
 	if (control_fb) {
 		printk(KERN_ERR "controlfb: only one control is supported\n");
 		return -ENXIO;
 	}
-	if(dp->n_addrs != 2) {
-		printk(KERN_ERR "expecting 2 address for control (got %d)", dp->n_addrs);
+
+	if (of_pci_address_to_resource(dp, 2, &fb_res) ||
+	    of_pci_address_to_resource(dp, 1, &reg_res)) {
+		printk(KERN_ERR "can't get 2 addresses for control\n");
 		return -ENXIO;
 	}
 	p = kmalloc(sizeof(*p), GFP_KERNEL);
@@ -669,18 +701,12 @@ static int __init control_of_init(struct
 	memset(p, 0, sizeof(*p));
 
 	/* Map in frame buffer and registers */
-	for (i = 0; i < dp->n_addrs; ++i) {
-		addr = dp->addrs[i].address;
-		if (dp->addrs[i].size >= 0x800000) {
-			p->fb_orig_base = addr;
-			p->fb_orig_size = dp->addrs[i].size;
-			/* use the big-endian aperture (??) */
-			p->frame_buffer_phys = addr + 0x800000;
-		} else {
-			p->control_regs_phys = addr;
-			p->control_regs_size = dp->addrs[i].size;
-		}
-	}
+	p->fb_orig_base = fb_res.start;
+	p->fb_orig_size = fb_res.end - fb_res.start + 1;
+	/* use the big-endian aperture (??) */
+	p->frame_buffer_phys = fb_res.start + 0x800000;
+	p->control_regs_phys = reg_res.start;
+	p->control_regs_size = reg_res.end - reg_res.start + 1;
 
 	if (!p->fb_orig_base ||
 	    !request_mem_region(p->fb_orig_base,p->fb_orig_size,"controlfb")) {
@@ -1059,43 +1085,3 @@ static void control_cleanup(void)
 }
 
 
-/*
- * Parse user speficied options (`video=controlfb:')
- */
-void __init control_setup(char *options)
-{
-	char *this_opt;
-
-	if (!options || !*options)
-		return;
-
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!strncmp(this_opt, "vmode:", 6)) {
-			int vmode = simple_strtoul(this_opt+6, NULL, 0);
-			if (vmode > 0 && vmode <= VMODE_MAX &&
-			    control_mac_modes[vmode - 1].m[1] >= 0)
-				default_vmode = vmode;
-		} else if (!strncmp(this_opt, "cmode:", 6)) {
-			int depth = simple_strtoul(this_opt+6, NULL, 0);
-			switch (depth) {
-			 case CMODE_8:
-			 case CMODE_16:
-			 case CMODE_32:
-			 	default_cmode = depth;
-			 	break;
-			 case 8:
-				default_cmode = CMODE_8;
-				break;
-			 case 15:
-			 case 16:
-				default_cmode = CMODE_16;
-				break;
-			 case 24:
-			 case 32:
-				default_cmode = CMODE_32;
-				break;
-			}
-		}
-	}
-}
-
Index: linux-work/sound/oss/dmasound/dmasound_awacs.c
===================================================================
--- linux-work.orig/sound/oss/dmasound/dmasound_awacs.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/sound/oss/dmasound/dmasound_awacs.c	2005-12-13 17:51:20.000000000 +1100
@@ -125,6 +125,7 @@ static int awacs_rate_index;
 static int awacs_subframe;
 static struct device_node* awacs_node;
 static struct device_node* i2s_node;
+static struct resource awacs_rsrc[3];
 
 static char awacs_name[64];
 static int awacs_revision;
@@ -667,9 +668,12 @@ static void PMacIrqCleanup(void)
 	iounmap(awacs_txdma);
 	iounmap(awacs_rxdma);
 
-	release_OF_resource(awacs_node, 0);
-	release_OF_resource(awacs_node, 1);
-	release_OF_resource(awacs_node, 2);
+	release_mem_region(awacs_rsrc[0].start,
+			   awacs_rsrc[0].end - awacs_rsrc[0].start + 1);
+	release_mem_region(awacs_rsrc[1].start,
+			   awacs_rsrc[1].end - awacs_rsrc[1].start + 1);
+	release_mem_region(awacs_rsrc[2].start,
+			   awacs_rsrc[2].end - awacs_rsrc[2].start + 1);
 
 	kfree(awacs_tx_cmd_space);
 	kfree(awacs_rx_cmd_space);
@@ -2863,46 +2867,58 @@ printk("dmasound_pmac: couldn't find a C
 	 * other info if necessary (early AWACS we want to read chip ids)
 	 */
 
-	if (io->n_addrs < 3 || io->n_intrs < 3) {
+	if (of_get_address(io, 2, NULL, NULL) == NULL || io->n_intrs < 3) {
 		/* OK - maybe we need to use the 'awacs' node (on earlier
 		 * machines).
-		*/
+		 */
 		if (awacs_node) {
 			io = awacs_node ;
-			if (io->n_addrs < 3 || io->n_intrs < 3) {
-				printk("dmasound_pmac: can't use %s"
-					" (%d addrs, %d intrs)\n",
-		      		 io->full_name, io->n_addrs, io->n_intrs);
+			if (of_get_address(io, 2, NULL, NULL) == NULL ||
+			    io->n_intrs < 3) {
+				printk("dmasound_pmac: can't use %s\n",
+				       io->full_name);
 				return -ENODEV;
 			}
-		} else {
-			printk("dmasound_pmac: can't use %s (%d addrs, %d intrs)\n",
-		 	      io->full_name, io->n_addrs, io->n_intrs);
-		}
+		} else
+			printk("dmasound_pmac: can't use %s\n", io->full_name);
 	}
 
-	if (!request_OF_resource(io, 0, NULL)) {
+	if (of_address_to_resource(io, 0, &awacs_rsrc[0]) ||
+	    request_mem_region(awacs_rsrc[0].start,
+			       awacs_rsrc[0].end - awacs_rsrc[0].start + 1,
+			       " (IO)") == NULL) {
 		printk(KERN_ERR "dmasound: can't request IO resource !\n");
 		return -ENODEV;
 	}
-	if (!request_OF_resource(io, 1, " (tx dma)")) {
-		release_OF_resource(io, 0);
-		printk(KERN_ERR "dmasound: can't request TX DMA resource !\n");
+	if (of_address_to_resource(io, 1, &awacs_rsrc[1]) ||
+	    request_mem_region(awacs_rsrc[1].start,
+			       awacs_rsrc[1].end - awacs_rsrc[1].start + 1,
+			       " (tx dma)") == NULL) {
+		release_mem_region(awacs_rsrc[0].start,
+				   awacs_rsrc[0].end - awacs_rsrc[0].start + 1);
+		printk(KERN_ERR "dmasound: can't request Tx DMA resource !\n");
 		return -ENODEV;
 	}
-
-	if (!request_OF_resource(io, 2, " (rx dma)")) {
-		release_OF_resource(io, 0);
-		release_OF_resource(io, 1);
-		printk(KERN_ERR "dmasound: can't request RX DMA resource !\n");
+	if (of_address_to_resource(io, 2, &awacs_rsrc[2]) ||
+	    request_mem_region(awacs_rsrc[2].start,
+			       awacs_rsrc[2].end - awacs_rsrc[2].start + 1,
+			       " (rx dma)") == NULL) {
+		release_mem_region(awacs_rsrc[0].start,
+				   awacs_rsrc[0].end - awacs_rsrc[0].start + 1);
+		release_mem_region(awacs_rsrc[1].start,
+				   awacs_rsrc[1].end - awacs_rsrc[1].start + 1);
+		printk(KERN_ERR "dmasound: can't request Rx DMA resource !\n");
 		return -ENODEV;
 	}
 
 	awacs_beep_dev = input_allocate_device();
 	if (!awacs_beep_dev) {
-		release_OF_resource(io, 0);
-		release_OF_resource(io, 1);
-		release_OF_resource(io, 2);
+		release_mem_region(awacs_rsrc[0].start,
+				   awacs_rsrc[0].end - awacs_rsrc[0].start + 1);
+		release_mem_region(awacs_rsrc[1].start,
+				   awacs_rsrc[1].end - awacs_rsrc[1].start + 1);
+		release_mem_region(awacs_rsrc[2].start,
+				   awacs_rsrc[2].end - awacs_rsrc[2].start + 1);
 		printk(KERN_ERR "dmasound: can't allocate input device !\n");
 		return -ENOMEM;
 	}
@@ -2916,11 +2932,11 @@ printk("dmasound_pmac: couldn't find a C
 
 	/* all OF versions I've seen use this value */
 	if (i2s_node)
-		i2s = ioremap(io->addrs[0].address, 0x1000);
+		i2s = ioremap(awacs_rsrc[0].start, 0x1000);
 	else
-		awacs = ioremap(io->addrs[0].address, 0x1000);
-	awacs_txdma = ioremap(io->addrs[1].address, 0x100);
-	awacs_rxdma = ioremap(io->addrs[2].address, 0x100);
+		awacs = ioremap(awacs_rsrc[0].start, 0x1000);
+	awacs_txdma = ioremap(awacs_rsrc[1].start, 0x100);
+	awacs_rxdma = ioremap(awacs_rsrc[2].start, 0x100);
 
 	/* first of all make sure that the chip is powered up....*/
 	pmac_call_feature(PMAC_FTR_SOUND_CHIP_ENABLE, io, 0, 1);
@@ -3083,9 +3099,10 @@ printk("dmasound_pmac: Awacs/Screamer Co
 		struct device_node* mio;
 		macio_base = NULL;
 		for (mio = io->parent; mio; mio = mio->parent) {
-			if (strcmp(mio->name, "mac-io") == 0
-			    && mio->n_addrs > 0) {
-				macio_base = ioremap(mio->addrs[0].address, 0x40);
+			if (strcmp(mio->name, "mac-io") == 0) {
+				struct resource r;
+				if (of_address_to_resource(mio, 0, &r) == 0)
+					macio_base = ioremap(r.start, 0x40);
 				break;
 			}
 		}
Index: linux-work/drivers/video/valkyriefb.c
===================================================================
--- linux-work.orig/drivers/video/valkyriefb.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/video/valkyriefb.c	2005-12-13 17:51:20.000000000 +1100
@@ -342,19 +342,19 @@ int __init valkyriefb_init(void)
 #else /* ppc (!CONFIG_MAC) */
 	{
 		struct device_node *dp;
+		struct resource r;
 
-		dp = find_devices("valkyrie");
+		dp = of_find_node_by_name(NULL, "valkyrie");
 		if (dp == 0)
 			return 0;
 
-		if (dp->n_addrs != 1) {
-			printk(KERN_ERR "expecting 1 address for valkyrie (got %d)\n",
-			       dp->n_addrs);
+		if (of_address_to_resource(dp, 0, &r)) {
+			printk(KERN_ERR "can't find address for valkyrie\n");
 			return 0;
 		}
 
-		frame_buffer_phys = dp->addrs[0].address;
-		cmap_regs_phys = dp->addrs[0].address+0x304000;
+		frame_buffer_phys = r.start;
+		cmap_regs_phys = r.start + 0x304000;
 		flags = _PAGE_WRITETHRU;
 	}
 #endif /* ppc (!CONFIG_MAC) */
Index: linux-work/drivers/block/swim3.c
===================================================================
--- linux-work.orig/drivers/block/swim3.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/drivers/block/swim3.c	2005-12-13 17:51:20.000000000 +1100
@@ -1083,23 +1083,33 @@ static int swim3_add_device(struct devic
 {
 	struct device_node *mediabay;
 	struct floppy_state *fs = &floppy_states[floppy_count];
+	struct resource res_reg, res_dma;
 
-	if (swim->n_addrs < 2)
-	{
-		printk(KERN_INFO "swim3: expecting 2 addrs (n_addrs:%d, n_intrs:%d)\n",
-		       swim->n_addrs, swim->n_intrs);
+	if (of_address_to_resource(swim, 0, &res_reg) ||
+	    of_address_to_resource(swim, 1, &res_dma)) {
+		printk(KERN_ERR "swim3: Can't get addresses\n");
 		return -EINVAL;
 	}
-
-	if (swim->n_intrs < 2)
-	{
-		printk(KERN_INFO "swim3: expecting 2 intrs (n_addrs:%d, n_intrs:%d)\n",
-		       swim->n_addrs, swim->n_intrs);
+	if (request_mem_region(res_reg.start, res_reg.end - res_reg.start + 1,
+			       " (reg)") == NULL) {
+		printk(KERN_ERR "swim3: Can't request register space\n");
+		return -EINVAL;
+	}
+	if (request_mem_region(res_dma.start, res_dma.end - res_dma.start + 1,
+			       " (dma)") == NULL) {
+		release_mem_region(res_reg.start,
+				   res_reg.end - res_reg.start + 1);
+		printk(KERN_ERR "swim3: Can't request DMA space\n");
 		return -EINVAL;
 	}
 
-	if (!request_OF_resource(swim, 0, NULL)) {
-		printk(KERN_INFO "swim3: can't request IO resource !\n");
+	if (swim->n_intrs < 2) {
+		printk(KERN_INFO "swim3: expecting 2 intrs (n_intrs:%d)\n",
+		       swim->n_intrs);
+		release_mem_region(res_reg.start,
+				   res_reg.end - res_reg.start + 1);
+		release_mem_region(res_dma.start,
+				   res_dma.end - res_dma.start + 1);
 		return -EINVAL;
 	}
 
@@ -1110,10 +1120,8 @@ static int swim3_add_device(struct devic
 	memset(fs, 0, sizeof(*fs));
 	spin_lock_init(&fs->lock);
 	fs->state = idle;
-	fs->swim3 = (struct swim3 __iomem *)
-		ioremap(swim->addrs[0].address, 0x200);
-	fs->dma = (struct dbdma_regs __iomem *)
-		ioremap(swim->addrs[1].address, 0x200);
+	fs->swim3 = (struct swim3 __iomem *)ioremap(res_reg.start, 0x200);
+	fs->dma = (struct dbdma_regs __iomem *)ioremap(res_dma.start, 0x200);
 	fs->swim3_intr = swim->intrs[0].line;
 	fs->dma_intr = swim->intrs[1].line;
 	fs->cur_cyl = -1;
Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_init.c	2005-12-13 17:51:20.000000000 +1100
@@ -558,7 +558,8 @@ unsigned long prom_memparse(const char *
 static void __init early_cmdline_parse(void)
 {
 	struct prom_t *_prom = &RELOC(prom);
-	char *opt, *p;
+	const char *opt;
+	char *p;
 	int l = 0;
 
 	RELOC(prom_cmd_line[0]) = 0;
Index: linux-work/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas_pci.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/rtas_pci.c	2005-12-13 17:51:20.000000000 +1100
@@ -188,39 +188,19 @@ int is_python(struct device_node *dev)
 	return 0;
 }
 
-static int get_phb_reg_prop(struct device_node *dev,
-			    unsigned int addr_size_words,
-			    struct reg_property64 *reg)
+static void python_countermeasures(struct device_node *dev)
 {
-	unsigned int *ui_ptr = NULL, len;
-
-	/* Found a PHB, now figure out where his registers are mapped. */
-	ui_ptr = (unsigned int *)get_property(dev, "reg", &len);
-	if (ui_ptr == NULL)
-		return 1;
-
-	if (addr_size_words == 1) {
-		reg->address = ((struct reg_property32 *)ui_ptr)->address;
-		reg->size    = ((struct reg_property32 *)ui_ptr)->size;
-	} else {
-		*reg = *((struct reg_property64 *)ui_ptr);
-	}
-
-	return 0;
-}
-
-static void python_countermeasures(struct device_node *dev,
-				   unsigned int addr_size_words)
-{
-	struct reg_property64 reg_struct;
+	struct resource registers;
 	void __iomem *chip_regs;
 	volatile u32 val;
 
-	if (get_phb_reg_prop(dev, addr_size_words, &reg_struct))
+	if (of_address_to_resource(dev, 0, &registers)) {
+		printk(KERN_ERR "Can't get address for Python workarounds !\n");
 		return;
+	}
 
 	/* Python's register file is 1 MB in size. */
-	chip_regs = ioremap(reg_struct.address & ~(0xfffffUL), 0x100000);
+	chip_regs = ioremap(registers.start & ~(0xfffffUL), 0x100000);
 
 	/*
 	 * Firmware doesn't always clear this bit which is critical
@@ -301,11 +281,10 @@ static int phb_set_bus_ranges(struct dev
 }
 
 static int __devinit setup_phb(struct device_node *dev,
-			       struct pci_controller *phb,
-			       unsigned int addr_size_words)
+			       struct pci_controller *phb)
 {
 	if (is_python(dev))
-		python_countermeasures(dev, addr_size_words);
+		python_countermeasures(dev);
 
 	if (phb_set_bus_ranges(dev, phb))
 		return 1;
@@ -320,8 +299,8 @@ unsigned long __init find_and_init_phbs(
 {
 	struct device_node *node;
 	struct pci_controller *phb;
-	unsigned int root_size_cells = 0;
 	unsigned int index;
+	unsigned int root_size_cells = 0;
 	unsigned int *opprop = NULL;
 	struct device_node *root = of_find_node_by_path("/");
 
@@ -343,10 +322,11 @@ unsigned long __init find_and_init_phbs(
 		phb = pcibios_alloc_controller(node);
 		if (!phb)
 			continue;
-		setup_phb(node, phb, root_size_cells);
+		setup_phb(node, phb);
 		pci_process_bridge_OF_ranges(phb, node, 0);
 		pci_setup_phb_io(phb, index == 0);
 #ifdef CONFIG_PPC_PSERIES
+		/* XXX This code need serious fixing ... --BenH */
 		if (ppc64_interrupt_controller == IC_OPEN_PIC && pSeries_mpic) {
 			int addr = root_size_cells * (index + 2) - 1;
 			mpic_assign_isu(pSeries_mpic, index, opprop[addr]);
@@ -381,22 +361,17 @@ unsigned long __init find_and_init_phbs(
 
 struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
 {
-	struct device_node *root = of_find_node_by_path("/");
-	unsigned int root_size_cells = 0;
 	struct pci_controller *phb;
 	int primary;
 
-	root_size_cells = prom_n_size_cells(root);
-
 	primary = list_empty(&hose_list);
 	phb = pcibios_alloc_controller(dn);
 	if (!phb)
 		return NULL;
-	setup_phb(dn, phb, root_size_cells);
+	setup_phb(dn, phb);
 	pci_process_bridge_OF_ranges(phb, dn, primary);
 
 	pci_setup_phb_io_dynamic(phb, primary);
-	of_node_put(root);
 
 	pci_devs_phb_init_dynamic(phb);
 	scan_phb(phb);
Index: linux-work/arch/powerpc/mm/numa.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/numa.c	2005-12-13 17:49:22.000000000 +1100
+++ linux-work/arch/powerpc/mm/numa.c	2005-12-13 17:51:20.000000000 +1100
@@ -432,7 +432,8 @@ static int __init parse_numa_properties(
 		if (!memcell_buf || len <= 0)
 			continue;
 
-		ranges = memory->n_addrs;
+		/* ranges in cell */
+		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
 new_range:
 		/* these are order-sensitive, and modify the buffer pointer */
 		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
@@ -746,7 +747,8 @@ int hot_add_scn_to_nid(unsigned long scn
 		if (!memcell_buf || len <= 0)
 			continue;
 
-		ranges = memory->n_addrs;	/* ranges in cell */
+		/* ranges in cell */
+		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
 ha_new_range:
 		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
 		size = read_n_cells(n_mem_size_cells, &memcell_buf);
