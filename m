Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 13:10:10 +1100
Message-Id: <1134526211.6458.42.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Experimental support for new G5 Macs (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

his adds some very basic support for the new machines, including the
Quad G5 (tested), and other new dual core based machines and iMac G5
iSight (untested). This is still experimental !  There is no thermal
control yet, there is no proper handing of MSIs, etc.. but it
boots, I have all 4 cores up on my machine. Compared to the previous
version of this patch, this one adds DART IOMMU support for the U4
chipset and thus should work fine on setups with more than 2Gb of RAM.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/feature.c	2005-12-13 17:51:20.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/feature.c	2005-12-13 18:13:11.000000000 +1100
@@ -101,7 +101,8 @@ static const char *macio_names[] =
 	"Keylargo",
 	"Pangea",
 	"Intrepid",
-	"K2"
+	"K2",
+	"Shasta",
 };
 

@@ -119,7 +120,7 @@ static const char *macio_names[] =
 static struct device_node *uninorth_node;
 static u32 __iomem *uninorth_base;
 static u32 uninorth_rev;
-static int uninorth_u3;
+static int uninorth_maj;
 static void __iomem *u3_ht;
 
 /*
@@ -1399,8 +1400,15 @@ static long g5_fw_enable(struct device_n
 static long g5_mpic_enable(struct device_node *node, long param, long value)
 {
 	unsigned long flags;
+	struct device_node *parent = of_get_parent(node);
+	int is_u3;
 
-	if (node->parent == NULL || strcmp(node->parent->name, "u3"))
+	if (parent == NULL)
+		return 0;
+	is_u3 = strcmp(parent->name, "u3") == 0 ||
+		strcmp(parent->name, "u4") == 0;
+	of_node_put(parent);
+	if (!is_u3)
 		return 0;
 
 	LOCK(flags);
@@ -1464,7 +1472,7 @@ static long g5_i2s_enable(struct device_
 		},
 	};
 
-	if (macio->type != macio_keylargo2 /* && macio->type != macio_shasta*/)
+	if (macio->type != macio_keylargo2 && macio->type != macio_shasta)
 		return -ENODEV;
 	if (strncmp(node->name, "i2s-", 4))
 		return -ENODEV;
@@ -1473,11 +1481,9 @@ static long g5_i2s_enable(struct device_
 	case 0:
 	case 1:
 		break;
-#if 0
 	case 2:
 		if (macio->type == macio_shasta)
 			break;
-#endif
 	default:
 		return -ENODEV;
 	}
@@ -1508,7 +1514,7 @@ static long g5_reset_cpu(struct device_n
 	struct device_node *np;
 
 	macio = &macio_chips[0];
-	if (macio->type != macio_keylargo2)
+	if (macio->type != macio_keylargo2 && macio->type != macio_shasta)
 		return -ENODEV;
 
 	np = find_path_device("/cpus");
@@ -1547,7 +1553,8 @@ static long g5_reset_cpu(struct device_n
  */
 void g5_phy_disable_cpu1(void)
 {
-	UN_OUT(U3_API_PHY_CONFIG_1, 0);
+	if (uninorth_maj == 3)
+		UN_OUT(U3_API_PHY_CONFIG_1, 0);
 }
 #endif /* CONFIG_POWER4 */
 
@@ -2462,6 +2469,14 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_POWERMAC_G5_U3L,	g5_features,
 		0,
 	},
+	{	"PowerMac11,2",			"PowerMac G5 Dual Core",
+		PMAC_TYPE_POWERMAC_G5_U3L,	g5_features,
+		0,
+	},
+	{	"PowerMac12,1",			"iMac G5 (iSight)",
+		PMAC_TYPE_POWERMAC_G5_U3L,	g5_features,
+		0,
+	},
 	{       "RackMac3,1",                   "XServe G5",
 		PMAC_TYPE_XSERVE_G5,		g5_features,
 		0,
@@ -2574,6 +2589,11 @@ static int __init probe_motherboard(void
 		pmac_mb.model_name = "Unknown K2-based";
 		pmac_mb.features = g5_features;
 		break;
+	case macio_shasta:
+		pmac_mb.model_id = PMAC_TYPE_UNKNOWN_SHASTA;
+		pmac_mb.model_name = "Unknown Shasta-based";
+		pmac_mb.features = g5_features;
+		break;
 #endif /* CONFIG_POWER4 */
 	default:
 		return -ENODEV;
@@ -2651,7 +2671,12 @@ static void __init probe_uninorth(void)
 	/* Locate G5 u3 */
 	if (uninorth_node == NULL) {
 		uninorth_node = of_find_node_by_name(NULL, "u3");
-		uninorth_u3 = 1;
+		uninorth_maj = 3;
+	}
+	/* Locate G5 u4 */
+	if (uninorth_node == NULL) {
+		uninorth_node = of_find_node_by_name(NULL, "u4");
+		uninorth_maj = 4;
 	}
 	if (uninorth_node == NULL)
 		return;
@@ -2664,12 +2689,13 @@ static void __init probe_uninorth(void)
 		return;
 	uninorth_base = ioremap(address, 0x40000);
 	uninorth_rev = in_be32(UN_REG(UNI_N_VERSION));
-	if (uninorth_u3)
+	if (uninorth_maj == 3 || uninorth_maj == 4)
 		u3_ht = ioremap(address + U3_HT_CONFIG_BASE, 0x1000);
 
-	printk(KERN_INFO "Found %s memory controller & host bridge,"
-	       " revision: %d\n", uninorth_u3 ? "U3" : "UniNorth",
-	       uninorth_rev);
+	printk(KERN_INFO "Found %s memory controller & host bridge"
+	       " @ 0x%08x revision: 0x%02x\n", uninorth_maj == 3 ? "U3" :
+	       uninorth_maj == 4 ? "U4" : "UniNorth",
+	       (unsigned int)address, uninorth_rev);
 	printk(KERN_INFO "Mapped at 0x%08lx\n", (unsigned long)uninorth_base);
 
 	/* Set the arbitrer QAck delay according to what Apple does
@@ -2677,7 +2703,8 @@ static void __init probe_uninorth(void)
 	if (uninorth_rev < 0x11) {
 		actrl = UN_IN(UNI_N_ARB_CTRL) & ~UNI_N_ARB_CTRL_QACK_DELAY_MASK;
 		actrl |= ((uninorth_rev < 3) ? UNI_N_ARB_CTRL_QACK_DELAY105 :
-			UNI_N_ARB_CTRL_QACK_DELAY) << UNI_N_ARB_CTRL_QACK_DELAY_SHIFT;
+			UNI_N_ARB_CTRL_QACK_DELAY) <<
+			UNI_N_ARB_CTRL_QACK_DELAY_SHIFT;
 		UN_OUT(UNI_N_ARB_CTRL, actrl);
 	}
 
@@ -2685,7 +2712,8 @@ static void __init probe_uninorth(void)
 	 * revs 1.5 to 2.O and Pangea. Seem to toggle the UniN Maxbus/PCI
 	 * memory timeout
 	 */
-	if ((uninorth_rev >= 0x11 && uninorth_rev <= 0x24) || uninorth_rev == 0xc0)
+	if ((uninorth_rev >= 0x11 && uninorth_rev <= 0x24) ||
+	    uninorth_rev == 0xc0)
 		UN_OUT(0x2160, UN_IN(0x2160) & 0x00ffffff);
 }
 
@@ -2736,12 +2764,14 @@ static void __init probe_one_macio(const
 		       node->full_name);
 		return;
 	}
-	if (type == macio_keylargo) {
+	if (type == macio_keylargo || type == macio_keylargo2) {
 		u32 *did = (u32 *)get_property(node, "device-id", NULL);
 		if (*did == 0x00000025)
 			type = macio_pangea;
 		if (*did == 0x0000003e)
 			type = macio_intrepid;
+		if (*did == 0x0000004f)
+			type = macio_shasta;
 	}
 	macio_chips[i].of_node	= node;
 	macio_chips[i].type	= type;
@@ -2840,7 +2870,8 @@ set_initial_features(void)
 	}
 
 #ifdef CONFIG_POWER4
-	if (macio_chips[0].type == macio_keylargo2) {
+	if (macio_chips[0].type == macio_keylargo2 ||
+	    macio_chips[0].type == macio_shasta) {
 #ifndef CONFIG_SMP
 		/* On SMP machines running UP, we have the second CPU eating
 		 * bus cycles. We need to take it off the bus. This is done
Index: linux-work/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pic.c	2005-12-13 17:51:20.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pic.c	2005-12-13 18:13:11.000000000 +1100
@@ -524,18 +524,56 @@ static void __init pmac_pic_setup_mpic_n
 #endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
 }
 
+static struct mpic * __init pmac_setup_one_mpic(struct device_node *np,
+						int master)
+{
+	unsigned char senses[128];
+	int offset = master ? 0 : 128;
+	int count = master ? 128 : 124;
+	const char *name = master ? " MPIC 1   " : " MPIC 2   ";
+	struct resource r;
+	struct mpic *mpic;
+	unsigned int flags = master ? MPIC_PRIMARY : 0;
+	int rc;
+
+	rc = of_address_to_resource(np, 0, &r);
+	if (rc)
+		return NULL;
+
+	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, np, 0, 0);
+
+	prom_get_irq_senses(senses, offset, offset + count);
+
+	flags |= MPIC_WANTS_RESET;
+	if (get_property(np, "big-endian", NULL))
+		flags |= MPIC_BIG_ENDIAN;
+
+	/* Primary Big Endian means HT interrupts. This is quite dodgy
+	 * but works until I find a better way
+	 */
+	if (master && (flags & MPIC_BIG_ENDIAN))
+		flags |= MPIC_BROKEN_U3;
+
+	mpic = mpic_alloc(r.start, flags, 0, offset, count, master ? 252 : 0,
+			  senses, count, name);
+	if (mpic == NULL)
+		return NULL;
+
+	mpic_init(mpic);
+
+	return mpic;
+ }
+
 static int __init pmac_pic_probe_mpic(void)
 {
 	struct mpic *mpic1, *mpic2;
 	struct device_node *np, *master = NULL, *slave = NULL;
-	unsigned char senses[128];
-	struct resource r;
 
 	/* We can have up to 2 MPICs cascaded */
 	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
 		     != NULL;) {
 		if (master == NULL &&
-		    get_property(np, "interrupt-parent", NULL) != NULL)
+		    get_property(np, "interrupts", NULL) == NULL)
 			master = of_node_get(np);
 		else if (slave == NULL)
 			slave = of_node_get(np);
@@ -557,13 +595,8 @@ static int __init pmac_pic_probe_mpic(vo
 	ppc_md.get_irq = mpic_get_irq;
 
 	/* Setup master */
-	BUG_ON(of_address_to_resource(master, 0, &r));
-	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, master, 0, 0);
-	prom_get_irq_senses(senses, 0, 128);
-	mpic1 = mpic_alloc(r.start, MPIC_PRIMARY | MPIC_WANTS_RESET,
-			   0, 0, 128, 252, senses, 128, " OpenPIC  ");
+	mpic1 = pmac_setup_one_mpic(master, 1);
 	BUG_ON(mpic1 == NULL);
-	mpic_init(mpic1);
 
 	/* Install NMI if any */
 	pmac_pic_setup_mpic_nmi(mpic1);
@@ -574,27 +607,12 @@ static int __init pmac_pic_probe_mpic(vo
 	if (slave == NULL || slave->n_intrs < 1)
 		return 0;
 
-	/* Setup slave, failures are non-fatal */
-	if (of_address_to_resource(slave, 0, &r)) {
-		printk(KERN_ERR "Can't get address of MPIC %s\n",
-		       slave->full_name);
-		return 0;
-	}
-	pmac_call_feature(PMAC_FTR_ENABLE_MPIC, slave, 0, 0);
-	prom_get_irq_senses(senses, 128, 128 + 124);
-
-	/* We don't need to set MPIC_BROKEN_U3 here since we don't have
-	 * hypertransport interrupts routed to it, at least not on currently
-	 * supported machines, that may change.
-	 */
-	mpic2 = mpic_alloc(r.start, MPIC_BIG_ENDIAN | MPIC_WANTS_RESET,
-			   0, 128, 124, 0, senses, 124, " U3-MPIC  ");
+	mpic2 = pmac_setup_one_mpic(slave, 0);
 	if (mpic2 == NULL) {
-		printk(KERN_ERR "Can't create slave MPIC %s\n",
-		       slave->full_name);
+		printk(KERN_ERR "Failed to setup slave MPIC\n");
+		of_node_put(slave);
 		return 0;
 	}
-	mpic_init(mpic2);
 	mpic_setup_cascade(slave->intrs[0].line, pmac_u3_cascade, mpic2);
 
 	of_node_put(slave);
Index: linux-work/include/asm-powerpc/pmac_feature.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_feature.h	2005-11-24 17:18:48.000000000 +1100
+++ linux-work/include/asm-powerpc/pmac_feature.h	2005-12-13 18:13:11.000000000 +1100
@@ -121,6 +121,7 @@
 #define PMAC_TYPE_IMAC_G5		0x152	/* iMac G5 */
 #define PMAC_TYPE_XSERVE_G5		0x153	/* Xserve G5 */
 #define PMAC_TYPE_UNKNOWN_K2		0x19f	/* Any other K2 based */
+#define PMAC_TYPE_UNKNOWN_SHASTA       	0x19e	/* Any other Shasta based */
 
 /*
  * Motherboard flags
@@ -341,6 +342,7 @@ enum {
 	macio_pangea,
 	macio_intrepid,
 	macio_keylargo2,
+	macio_shasta,
 };
 
 struct macio_chip
Index: linux-work/arch/powerpc/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig	2005-12-13 15:03:21.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig	2005-12-13 18:13:11.000000000 +1100
@@ -300,6 +300,7 @@ config PPC_PMAC64
 	bool
 	depends on PPC_PMAC && POWER4
 	select U3_DART
+	select MPIC_BROKEN_U3
 	select GENERIC_TBSYNC
 	default y
 
Index: linux-work/arch/powerpc/kernel/prom.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom.c	2005-12-13 17:51:20.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom.c	2005-12-13 18:13:11.000000000 +1100
@@ -298,6 +298,16 @@ static int __devinit finish_node_interru
 	int i, j, n, sense;
 	unsigned int *irq, virq;
 	struct device_node *ic;
+	int trace = 0;
+
+	//#define TRACE(fmt...) do { if (trace) { printk(fmt); mdelay(1000); } } while(0)
+#define TRACE(fmt...)
+
+	if (!strcmp(np->name, "smu-doorbell"))
+		trace = 1;
+
+	TRACE("Finishing SMU doorbell ! num_interrupt_controllers = %d\n",
+	      num_interrupt_controllers);
 
 	if (num_interrupt_controllers == 0) {
 		/*
@@ -332,11 +342,12 @@ static int __devinit finish_node_interru
 	}
 
 	ints = (unsigned int *) get_property(np, "interrupts", &intlen);
+	TRACE("ints=%p, intlen=%d\n", ints, intlen);
 	if (ints == NULL)
 		return 0;
 	intrcells = prom_n_intr_cells(np);
 	intlen /= intrcells * sizeof(unsigned int);
-
+	TRACE("intrcells=%d, new intlen=%d\n", intrcells, intlen);
 	np->intrs = prom_alloc(intlen * sizeof(*(np->intrs)), mem_start);
 	if (!np->intrs)
 		return -ENOMEM;
@@ -347,6 +358,7 @@ static int __devinit finish_node_interru
 	intrcount = 0;
 	for (i = 0; i < intlen; ++i, ints += intrcells) {
 		n = map_interrupt(&irq, &ic, np, ints, intrcells);
+		TRACE("map, irq=%d, ic=%p, n=%d\n", irq, ic, n);
 		if (n <= 0)
 			continue;
 
@@ -357,6 +369,7 @@ static int __devinit finish_node_interru
 			np->intrs[intrcount].sense = map_isa_senses[sense];
 		} else {
 			virq = virt_irq_create_mapping(irq[0]);
+			TRACE("virq=%d\n", virq);
 #ifdef CONFIG_PPC64
 			if (virq == NO_IRQ) {
 				printk(KERN_CRIT "Could not allocate interrupt"
@@ -366,6 +379,12 @@ static int __devinit finish_node_interru
 #endif
 			np->intrs[intrcount].line = irq_offset_up(virq);
 			sense = (n > 1)? (irq[1] & 3): 1;
+
+			/* Apple uses bits in there in a different way, let's
+			 * only keep the real sense bit on macs
+			 */
+			if (_machine == PLATFORM_POWERMAC)
+				sense &= 0x1;
 			np->intrs[intrcount].sense = map_mpic_senses[sense];
 		}
 
@@ -375,12 +394,13 @@ static int __devinit finish_node_interru
 			char *name = get_property(ic->parent, "name", NULL);
 			if (name && !strcmp(name, "u3"))
 				np->intrs[intrcount].line += 128;
-			else if (!(name && !strcmp(name, "mac-io")))
+			else if (!(name && (!strcmp(name, "mac-io") ||
+					    !strcmp(name, "u4"))))
 				/* ignore other cascaded controllers, such as
 				   the k2-sata-root */
 				break;
 		}
-#endif
+#endif /* CONFIG_PPC64 */
 		if (n > 2) {
 			printk("hmmm, got %d intr cells for %s:", n,
 			       np->full_name);
Index: linux-work/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pci.c	2005-12-13 17:51:20.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/pci.c	2005-12-13 18:13:12.000000000 +1100
@@ -1,7 +1,7 @@
 /*
  * Support for PCI bridges found on Power Macintoshes.
  *
- * Copyright (C) 2003 Benjamin Herrenschmuidt (benh@kernel.crashing.org)
+ * Copyright (C) 2003-2005 Benjamin Herrenschmuidt (benh@kernel.crashing.org)
  * Copyright (C) 1997 Paul Mackerras (paulus@samba.org)
  *
  * This program is free software; you can redistribute it and/or
@@ -25,7 +25,7 @@
 #include <asm/pmac_feature.h>
 #include <asm/grackle.h>
 #ifdef CONFIG_PPC64
-#include <asm/iommu.h>
+//#include <asm/iommu.h>
 #include <asm/ppc-pci.h>
 #endif
 
@@ -44,6 +44,7 @@ static int add_bridge(struct device_node
 static int has_uninorth;
 #ifdef CONFIG_PPC64
 static struct pci_controller *u3_agp;
+static struct pci_controller *u4_pcie;
 static struct pci_controller *u3_ht;
 #endif /* CONFIG_PPC64 */
 
@@ -97,11 +98,8 @@ static void __init fixup_bus_range(struc
 
 	/* Lookup the "bus-range" property for the hose */
 	bus_range = (int *) get_property(bridge, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int)) {
-		printk(KERN_WARNING "Can't get bus-range for %s\n",
-			       bridge->full_name);
+	if (bus_range == NULL || len < 2 * sizeof(int))
 		return;
-	}
 	bus_range[1] = fixup_one_level_bus_range(bridge->child, bus_range[1]);
 }
 
@@ -128,14 +126,14 @@ static void __init fixup_bus_range(struc
  */
 
 #define MACRISC_CFA0(devfn, off)	\
-	((1 << (unsigned long)PCI_SLOT(dev_fn)) \
-	| (((unsigned long)PCI_FUNC(dev_fn)) << 8) \
-	| (((unsigned long)(off)) & 0xFCUL))
+	((1 << (unsigned int)PCI_SLOT(dev_fn)) \
+	| (((unsigned int)PCI_FUNC(dev_fn)) << 8) \
+	| (((unsigned int)(off)) & 0xFCUL))
 
 #define MACRISC_CFA1(bus, devfn, off)	\
-	((((unsigned long)(bus)) << 16) \
-	|(((unsigned long)(devfn)) << 8) \
-	|(((unsigned long)(off)) & 0xFCUL) \
+	((((unsigned int)(bus)) << 16) \
+	|(((unsigned int)(devfn)) << 8) \
+	|(((unsigned int)(off)) & 0xFCUL) \
 	|1UL)
 
 static unsigned long macrisc_cfg_access(struct pci_controller* hose,
@@ -168,7 +166,8 @@ static int macrisc_read_config(struct pc
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-
+	if (offset >= 0x100)
+		return  PCIBIOS_BAD_REGISTER_NUMBER;
 	addr = macrisc_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -199,7 +198,8 @@ static int macrisc_write_config(struct p
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-
+	if (offset >= 0x100)
+		return  PCIBIOS_BAD_REGISTER_NUMBER;
 	addr = macrisc_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -234,12 +234,13 @@ static struct pci_ops macrisc_pci_ops =
 /*
  * Verify that a specific (bus, dev_fn) exists on chaos
  */
-static int
-chaos_validate_dev(struct pci_bus *bus, int devfn, int offset)
+static int chaos_validate_dev(struct pci_bus *bus, int devfn, int offset)
 {
 	struct device_node *np;
 	u32 *vendor, *device;
 
+	if (offset >= 0x100)
+		return  PCIBIOS_BAD_REGISTER_NUMBER;
 	np = pci_busdev_to_OF_node(bus, devfn);
 	if (np == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -341,10 +342,10 @@ static int u3_ht_skip_device(struct pci_
 }
 
 #define U3_HT_CFA0(devfn, off)		\
-		((((unsigned long)devfn) << 8) | offset)
+		((((unsigned int)devfn) << 8) | offset)
 #define U3_HT_CFA1(bus, devfn, off)	\
 		(U3_HT_CFA0(devfn, off) \
-		+ (((unsigned long)bus) << 16) \
+		+ (((unsigned int)bus) << 16) \
 		+ 0x01000000UL)
 
 static unsigned long u3_ht_cfg_access(struct pci_controller* hose,
@@ -370,7 +371,8 @@ static int u3_ht_read_config(struct pci_
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-
+	if (offset >= 0x100)
+		return  PCIBIOS_BAD_REGISTER_NUMBER;
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -419,7 +421,8 @@ static int u3_ht_write_config(struct pci
 	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-
+	if (offset >= 0x100)
+		return  PCIBIOS_BAD_REGISTER_NUMBER;
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -459,6 +462,112 @@ static struct pci_ops u3_ht_pci_ops =
 	u3_ht_read_config,
 	u3_ht_write_config
 };
+
+#define U4_PCIE_CFA0(devfn, off)	\
+	((1 << ((unsigned int)PCI_SLOT(dev_fn)))	\
+	 | (((unsigned int)PCI_FUNC(dev_fn)) << 8)	\
+	 | ((((unsigned int)(off)) >> 8) << 28) \
+	 | (((unsigned int)(off)) & 0xfcU))
+
+#define U4_PCIE_CFA1(bus, devfn, off)	\
+	((((unsigned int)(bus)) << 16) \
+	 |(((unsigned int)(devfn)) << 8)	\
+	 | ((((unsigned int)(off)) >> 8) << 28) \
+	 |(((unsigned int)(off)) & 0xfcU)	\
+	 |1UL)
+
+static unsigned long u4_pcie_cfg_access(struct pci_controller* hose,
+					u8 bus, u8 dev_fn, int offset)
+{
+	unsigned int caddr;
+
+	if (bus == hose->first_busno) {
+		caddr = U4_PCIE_CFA0(dev_fn, offset);
+	} else
+		caddr = U4_PCIE_CFA1(bus, dev_fn, offset);
+
+	/* Uninorth will return garbage if we don't read back the value ! */
+	do {
+		out_le32(hose->cfg_addr, caddr);
+	} while (in_le32(hose->cfg_addr) != caddr);
+
+	offset &= 0x03;
+	return ((unsigned long)hose->cfg_data) + offset;
+}
+
+static int u4_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
+			       int offset, int len, u32 *val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (offset >= 0x1000)
+		return  PCIBIOS_BAD_REGISTER_NUMBER;
+	addr = u4_pcie_cfg_access(hose, bus->number, devfn, offset);
+	if (!addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		*val = in_8((u8 *)addr);
+		break;
+	case 2:
+		*val = in_le16((u16 *)addr);
+		break;
+	default:
+		*val = in_le32((u32 *)addr);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
+				int offset, int len, u32 val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (offset >= 0x1000)
+		return  PCIBIOS_BAD_REGISTER_NUMBER;
+	addr = u4_pcie_cfg_access(hose, bus->number, devfn, offset);
+	if (!addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		out_8((u8 *)addr, val);
+		(void) in_8((u8 *)addr);
+		break;
+	case 2:
+		out_le16((u16 *)addr, val);
+		(void) in_le16((u16 *)addr);
+		break;
+	default:
+		out_le32((u32 *)addr, val);
+		(void) in_le32((u32 *)addr);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops u4_pcie_pci_ops =
+{
+	u4_pcie_read_config,
+	u4_pcie_write_config
+};
+
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_PPC32
@@ -628,15 +737,36 @@ static void __init setup_u3_agp(struct p
 	hose->ops = &macrisc_pci_ops;
 	hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
 	hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
-
 	u3_agp = hose;
 }
 
+static void __init setup_u4_pcie(struct pci_controller* hose)
+{
+	/* We currently only implement the "non-atomic" config space, to
+	 * be optimised later.
+	 */
+	hose->ops = &u4_pcie_pci_ops;
+	hose->cfg_addr = ioremap(0xf0000000 + 0x800000, 0x1000);
+	hose->cfg_data = ioremap(0xf0000000 + 0xc00000, 0x1000);
+
+	/* The bus contains a bridge from root -> device, we need to
+	 * make it visible on bus 0 so that we pick the right type
+	 * of config cycles. If we didn't, we would have to force all
+	 * config cycles to be type 1. So we override the "bus-range"
+	 * property here
+	 */
+	hose->first_busno = 0x00;
+	hose->last_busno = 0xff;
+	u4_pcie = hose;
+}
+
 static void __init setup_u3_ht(struct pci_controller* hose)
 {
 	struct device_node *np = (struct device_node *)hose->arch_data;
+	struct pci_controller *other = NULL;
 	int i, cur;
 
+
 	hose->ops = &u3_ht_pci_ops;
 
 	/* We hard code the address because of the different size of
@@ -670,11 +800,20 @@ static void __init setup_u3_ht(struct pc
 
 	u3_ht = hose;
 
-	if (u3_agp == NULL) {
-		DBG("U3 has no AGP, using full resource range\n");
+	if (u3_agp != NULL)
+		other = u3_agp;
+	else if (u4_pcie != NULL)
+		other = u4_pcie;
+
+	if (other == NULL) {
+		DBG("U3/4 has no AGP/PCIE, using full resource range\n");
 		return;
 	}
 
+	/* Fixup bus range vs. PCIE */
+	if (u4_pcie)
+		hose->last_busno = u4_pcie->first_busno - 1;
+
 	/* We "remove" the AGP resources from the resources allocated to HT,
 	 * that is we create "holes". However, that code does assumptions
 	 * that so far happen to be true (cross fingers...), typically that
@@ -682,7 +821,7 @@ static void __init setup_u3_ht(struct pc
 	 */
 	cur = 0;
 	for (i=0; i<3; i++) {
-		struct resource *res = &u3_agp->mem_resources[i];
+		struct resource *res = &other->mem_resources[i];
 		if (res->flags != IORESOURCE_MEM)
 			continue;
 		/* We don't care about "fine" resources */
@@ -777,9 +916,13 @@ static int __init add_bridge(struct devi
 		setup_u3_ht(hose);
 		disp_name = "U3-HT";
 		primary = 1;
+	} else if (device_is_compatible(dev, "u4-pcie")) {
+		setup_u4_pcie(hose);
+		disp_name = "U4-PCIE";
+		primary = 0;
 	}
-	printk(KERN_INFO "Found %s PCI host bridge.  Firmware bus number: %d->%d\n",
-		disp_name, hose->first_busno, hose->last_busno);
+	printk(KERN_INFO "Found %s PCI host bridge.  Firmware bus number:"
+	       " %d->%d\n", disp_name, hose->first_busno, hose->last_busno);
 #endif /* CONFIG_PPC64 */
 
 	/* 32 bits only bridges */
@@ -900,6 +1043,8 @@ void __init pmac_pci_init(void)
 		pci_setup_phb_io(u3_ht, 1);
 	if (u3_agp)
 		pci_setup_phb_io(u3_agp, 0);
+	if (u4_pcie)
+		pci_setup_phb_io(u4_pcie, 0);
 
 	/*
 	 * On ppc64, fixup the IO resources on our host bridges as
@@ -912,7 +1057,8 @@ void __init pmac_pci_init(void)
 
 	/* Fixup the PCI<->OF mapping for U3 AGP due to bus renumbering. We
 	 * assume there is no P2P bridge on the AGP bus, which should be a
-	 * safe assumptions hopefully.
+	 * safe assumptions for now. We should do something better in the
+	 * future though
 	 */
 	if (u3_agp) {
 		struct device_node *np = u3_agp->arch_data;
@@ -920,7 +1066,6 @@ void __init pmac_pci_init(void)
 		for (np = np->child; np; np = np->sibling)
 			PCI_DN(np)->busno = 0xf0;
 	}
-
 	/* pmac_check_ht_link(); */
 
 	/* Tell pci.c to not use the common resource allocation mechanism */
@@ -1127,7 +1272,8 @@ void pmac_pci_fixup_pciata(struct pci_de
  good:
 	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
 	if ((progif & 5) != 5) {
-		printk(KERN_INFO "Forcing PCI IDE into native mode: %s\n", pci_name(dev));
+		printk(KERN_INFO "Forcing PCI IDE into native mode: %s\n",
+		       pci_name(dev));
 		(void) pci_write_config_byte(dev, PCI_CLASS_PROG, progif|5);
 		if (pci_read_config_byte(dev, PCI_CLASS_PROG, &progif) ||
 		    (progif & 5) != 5)
@@ -1153,7 +1299,8 @@ static void fixup_k2_sata(struct pci_dev
 		for (i = 0; i < 6; i++) {
 			dev->resource[i].start = dev->resource[i].end = 0;
 			dev->resource[i].flags = 0;
-			pci_write_config_dword(dev, PCI_BASE_ADDRESS_0 + 4 * i, 0);
+			pci_write_config_dword(dev, PCI_BASE_ADDRESS_0 + 4 * i,
+					       0);
 		}
 	} else {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
@@ -1162,7 +1309,8 @@ static void fixup_k2_sata(struct pci_dev
 		for (i = 0; i < 5; i++) {
 			dev->resource[i].start = dev->resource[i].end = 0;
 			dev->resource[i].flags = 0;
-			pci_write_config_dword(dev, PCI_BASE_ADDRESS_0 + 4 * i, 0);
+			pci_write_config_dword(dev, PCI_BASE_ADDRESS_0 + 4 * i,
+					       0);
 		}
 	}
 }
Index: linux-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mpic.c	2005-12-13 18:02:03.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/mpic.c	2005-12-13 18:13:12.000000000 +1100
@@ -13,6 +13,9 @@
  */
 
 #undef DEBUG
+#undef DEBUG_IPI
+#undef DEBUG_IRQ
+#undef DEBUG_LOW
 
 #include <linux/config.h>
 #include <linux/types.h>
@@ -168,35 +171,86 @@ static void __init mpic_test_broken_ipi(
 /* Test if an interrupt is sourced from HyperTransport (used on broken U3s)
  * to force the edge setting on the MPIC and do the ack workaround.
  */
-static inline int mpic_is_ht_interrupt(struct mpic *mpic, unsigned int source_no)
+static inline int mpic_is_ht_interrupt(struct mpic *mpic, unsigned int source)
 {
-	if (source_no >= 128 || !mpic->fixups)
+	if (source >= 128 || !mpic->fixups)
 		return 0;
-	return mpic->fixups[source_no].base != NULL;
+	return mpic->fixups[source].base != NULL;
 }
 

-static inline void mpic_apic_end_irq(struct mpic *mpic, unsigned int source_no)
+static inline void mpic_ht_end_irq(struct mpic *mpic, unsigned int source)
 {
-	struct mpic_irq_fixup *fixup = &mpic->fixups[source_no];
+	struct mpic_irq_fixup *fixup = &mpic->fixups[source];
 
-	spin_lock(&mpic->fixup_lock);
-	writeb(0x11 + 2 * fixup->irq, fixup->base + 2);
-	writel(fixup->data, fixup->base + 4);
-	spin_unlock(&mpic->fixup_lock);
+	if (fixup->applebase) {
+		unsigned int soff = (fixup->index >> 3) & ~3;
+		unsigned int mask = 1U << (fixup->index & 0x1f);
+		writel(mask, fixup->applebase + soff);
+	} else {
+		spin_lock(&mpic->fixup_lock);
+		writeb(0x11 + 2 * fixup->index, fixup->base + 2);
+		writel(fixup->data, fixup->base + 4);
+		spin_unlock(&mpic->fixup_lock);
+	}
 }
 
+static void mpic_startup_ht_interrupt(struct mpic *mpic, unsigned int source,
+				      unsigned int irqflags)
+{
+	struct mpic_irq_fixup *fixup = &mpic->fixups[source];
+	unsigned long flags;
+	u32 tmp;
+
+	if (fixup->base == NULL)
+		return;
+
+	DBG("startup_ht_interrupt(%u, %u) index: %d\n",
+	    source, irqflags, fixup->index);
+	spin_lock_irqsave(&mpic->fixup_lock, flags);
+	/* Enable and configure */
+	writeb(0x10 + 2 * fixup->index, fixup->base + 2);
+	tmp = readl(fixup->base + 4);
+	tmp &= ~(0x23U);
+	if (irqflags & IRQ_LEVEL)
+		tmp |= 0x22;
+	writel(tmp, fixup->base + 4);
+	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
+}
+
+static void mpic_shutdown_ht_interrupt(struct mpic *mpic, unsigned int source,
+				       unsigned int irqflags)
+{
+	struct mpic_irq_fixup *fixup = &mpic->fixups[source];
+	unsigned long flags;
+	u32 tmp;
+
+	if (fixup->base == NULL)
+		return;
+
+	DBG("shutdown_ht_interrupt(%u, %u)\n", source, irqflags);
+
+	/* Disable */
+	spin_lock_irqsave(&mpic->fixup_lock, flags);
+	writeb(0x10 + 2 * fixup->index, fixup->base + 2);
+	tmp = readl(fixup->base + 4);
+	tmp &= ~1U;
+	writel(tmp, fixup->base + 4);
+	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
+}
 
-static void __init mpic_scan_ioapic(struct mpic *mpic, u8 __iomem *devbase)
+static void __init mpic_scan_ht_pic(struct mpic *mpic, u8 __iomem *devbase,
+				    unsigned int devfn, u32 vdid)
 {
 	int i, irq, n;
+	u8 __iomem *base;
 	u32 tmp;
 	u8 pos;
 
-	for (pos = readb(devbase + 0x34); pos; pos = readb(devbase + pos + 1)) {
-		u8 id = readb(devbase + pos);
-
-		if (id == 0x08) {
+	for (pos = readb(devbase + PCI_CAPABILITY_LIST); pos != 0;
+	     pos = readb(devbase + pos + PCI_CAP_LIST_NEXT)) {
+		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
+		if (id == PCI_CAP_ID_HT_IRQCONF) {
 			id = readb(devbase + pos + 3);
 			if (id == 0x80)
 				break;
@@ -205,33 +259,41 @@ static void __init mpic_scan_ioapic(stru
 	if (pos == 0)
 		return;
 
-	printk(KERN_INFO "mpic:    - Workarounds @ %p, pos = 0x%02x\n", devbase, pos);
-
-	devbase += pos;
-
-	writeb(0x01, devbase + 2);
-	n = (readl(devbase + 4) >> 16) & 0xff;
+	base = devbase + pos;
+	writeb(0x01, base + 2);
+	n = (readl(base + 4) >> 16) & 0xff;
+
+	printk(KERN_INFO "mpic:   - HT:%02x.%x [0x%02x] vendor %04x device %04x"
+	       " has %d irqs\n",
+	       devfn >> 3, devfn & 0x7, pos, vdid & 0xffff, vdid >> 16, n + 1);
 
 	for (i = 0; i <= n; i++) {
-		writeb(0x10 + 2 * i, devbase + 2);
-		tmp = readl(devbase + 4);
-		if ((tmp & 0x21) != 0x20)
-			continue;
+		writeb(0x10 + 2 * i, base + 2);
+		tmp = readl(base + 4);
 		irq = (tmp >> 16) & 0xff;
-		mpic->fixups[irq].irq = i;
-		mpic->fixups[irq].base = devbase;
-		writeb(0x11 + 2 * i, devbase + 2);
-		mpic->fixups[irq].data = readl(devbase + 4) | 0x80000000;
+		DBG("HT PIC index 0x%x, irq 0x%x, tmp: %08x\n", i, irq, tmp);
+		/* mask it , will be unmasked later */
+		tmp |= 0x1;
+		writel(tmp, base + 4);
+		mpic->fixups[irq].index = i;
+		mpic->fixups[irq].base = base;
+		/* Apple HT PIC has a non-standard way of doing EOIs */
+		if ((vdid & 0xffff) == 0x106b)
+			mpic->fixups[irq].applebase = devbase + 0x60;
+		else
+			mpic->fixups[irq].applebase = NULL;
+		writeb(0x11 + 2 * i, base + 2);
+		mpic->fixups[irq].data = readl(base + 4) | 0x80000000;
 	}
 }
  
 
-static void __init mpic_scan_ioapics(struct mpic *mpic)
+static void __init mpic_scan_ht_pics(struct mpic *mpic)
 {
 	unsigned int devfn;
 	u8 __iomem *cfgspace;
 
-	printk(KERN_INFO "mpic: Setting up IO-APICs workarounds for U3\n");
+	printk(KERN_INFO "mpic: Setting up HT PICs workarounds for U3/U4\n");
 
 	/* Allocate fixups array */
 	mpic->fixups = alloc_bootmem(128 * sizeof(struct mpic_irq_fixup));
@@ -247,13 +309,14 @@ static void __init mpic_scan_ioapics(str
 	cfgspace = ioremap(0xf2000000, 0x10000);
 	BUG_ON(cfgspace == NULL);
 
-	/* Now we scan all slots. We do a very quick scan, we read the header type,
-	 * vendor ID and device ID only, that's plenty enough
+	/* Now we scan all slots. We do a very quick scan, we read the header
+	 * type, vendor ID and device ID only, that's plenty enough
 	 */
 	for (devfn = 0; devfn < 0x100; devfn++) {
 		u8 __iomem *devbase = cfgspace + (devfn << 8);
 		u8 hdr_type = readb(devbase + PCI_HEADER_TYPE);
 		u32 l = readl(devbase + PCI_VENDOR_ID);
+		u16 s;
 
 		DBG("devfn %x, l: %x\n", devfn, l);
 
@@ -261,8 +324,12 @@ static void __init mpic_scan_ioapics(str
 		if (l == 0xffffffff || l == 0x00000000 ||
 		    l == 0x0000ffff || l == 0xffff0000)
 			goto next;
+		/* Check if is supports capability lists */
+		s = readw(devbase + PCI_STATUS);
+		if (!(s & PCI_STATUS_CAP_LIST))
+			goto next;
 
-		mpic_scan_ioapic(mpic, devbase);
+		mpic_scan_ht_pic(mpic, devbase, devfn, l);
 
 	next:
 		/* next device, if function 0 */
@@ -363,6 +430,31 @@ static void mpic_enable_irq(unsigned int
 			break;
 		}
 	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);	
+
+#ifdef CONFIG_MPIC_BROKEN_U3
+	if (mpic->flags & MPIC_BROKEN_U3) {
+		unsigned int src = irq - mpic->irq_offset;
+		if (mpic_is_ht_interrupt(mpic, src) &&
+		    (irq_desc[irq].status & IRQ_LEVEL))
+			mpic_ht_end_irq(mpic, src);
+	}
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+}
+
+static unsigned int mpic_startup_irq(unsigned int irq)
+{
+#ifdef CONFIG_MPIC_BROKEN_U3
+	struct mpic *mpic = mpic_from_irq(irq);
+	unsigned int src = irq - mpic->irq_offset;
+
+	if (mpic_is_ht_interrupt(mpic, src))
+		mpic_startup_ht_interrupt(mpic, src, irq_desc[irq].status);
+
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
+	mpic_enable_irq(irq);
+
+	return 0;
 }
 
 static void mpic_disable_irq(unsigned int irq)
@@ -386,12 +478,27 @@ static void mpic_disable_irq(unsigned in
 	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
 }
 
+static void mpic_shutdown_irq(unsigned int irq)
+{
+#ifdef CONFIG_MPIC_BROKEN_U3
+	struct mpic *mpic = mpic_from_irq(irq);
+	unsigned int src = irq - mpic->irq_offset;
+
+	if (mpic_is_ht_interrupt(mpic, src))
+		mpic_shutdown_ht_interrupt(mpic, src, irq_desc[irq].status);
+
+#endif /* CONFIG_MPIC_BROKEN_U3 */
+
+	mpic_disable_irq(irq);
+}
+
 static void mpic_end_irq(unsigned int irq)
 {
 	struct mpic *mpic = mpic_from_irq(irq);
 
+#ifdef DEBUG_IRQ
 	DBG("%s: end_irq: %d\n", mpic->name, irq);
-
+#endif
 	/* We always EOI on end_irq() even for edge interrupts since that
 	 * should only lower the priority, the MPIC should have properly
 	 * latched another edge interrupt coming in anyway
@@ -400,8 +507,9 @@ static void mpic_end_irq(unsigned int ir
 #ifdef CONFIG_MPIC_BROKEN_U3
 	if (mpic->flags & MPIC_BROKEN_U3) {
 		unsigned int src = irq - mpic->irq_offset;
-		if (mpic_is_ht_interrupt(mpic, src))
-			mpic_apic_end_irq(mpic, src);
+		if (mpic_is_ht_interrupt(mpic, src) &&
+		    (irq_desc[irq].status & IRQ_LEVEL))
+			mpic_ht_end_irq(mpic, src);
 	}
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
@@ -482,6 +590,8 @@ struct mpic * __init mpic_alloc(unsigned
 	mpic->name = name;
 
 	mpic->hc_irq.typename = name;
+	mpic->hc_irq.startup = mpic_startup_irq;
+	mpic->hc_irq.shutdown = mpic_shutdown_irq;
 	mpic->hc_irq.enable = mpic_enable_irq;
 	mpic->hc_irq.disable = mpic_disable_irq;
 	mpic->hc_irq.end = mpic_end_irq;
@@ -650,10 +760,10 @@ void __init mpic_init(struct mpic *mpic)
 		mpic->irq_count = mpic->num_sources;
 
 #ifdef CONFIG_MPIC_BROKEN_U3
-	/* Do the ioapic fixups on U3 broken mpic */
+	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
 	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
-		mpic_scan_ioapics(mpic);
+		mpic_scan_ht_pics(mpic);
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
 	for (i = 0; i < mpic->num_sources; i++) {
@@ -840,7 +950,9 @@ void mpic_send_ipi(unsigned int ipi_no, 
 
 	BUG_ON(mpic == NULL);
 
+#ifdef DEBUG_IPI
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
+#endif
 
 	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
@@ -851,19 +963,28 @@ int mpic_get_one_irq(struct mpic *mpic, 
 	u32 irq;
 
 	irq = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+#ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
-
+#endif
 	if (mpic->cascade && irq == mpic->cascade_vec) {
+#ifdef DEBUG_LOW
 		DBG("%s: cascading ...\n", mpic->name);
+#endif
 		irq = mpic->cascade(regs, mpic->cascade_data);
 		mpic_eoi(mpic);
 		return irq;
 	}
 	if (unlikely(irq == MPIC_VEC_SPURRIOUS))
 		return -1;
-	if (irq < MPIC_VEC_IPI_0) 
+	if (irq < MPIC_VEC_IPI_0) {
+#ifdef DEBUG_IRQ
+		DBG("%s: irq %d\n", mpic->name, irq + mpic->irq_offset);
+#endif
 		return irq + mpic->irq_offset;
+	}
+#ifdef DEBUG_IPI
        	DBG("%s: ipi %d !\n", mpic->name, irq - MPIC_VEC_IPI_0);
+#endif
 	return irq - MPIC_VEC_IPI_0 + mpic->ipi_offset;
 }
 
Index: linux-work/include/linux/pci_regs.h
===================================================================
--- linux-work.orig/include/linux/pci_regs.h	2005-11-24 17:18:49.000000000 +1100
+++ linux-work/include/linux/pci_regs.h	2005-12-13 18:13:12.000000000 +1100
@@ -196,6 +196,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
+#define  PCI_CAP_ID_HT_IRQCONF	0x08	/* HyperTransport IRQ Configuration */
 #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
 #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2005-12-13 17:51:20.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2005-12-13 18:13:12.000000000 +1100
@@ -34,7 +34,7 @@
 
 #ifdef DEBUG
 #include <asm/udbg.h>
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG(fmt...) printk(fmt)
 #else
 #define DBG(fmt...)
 #endif
@@ -323,6 +323,7 @@ static void pci_parse_of_addrs(struct de
 	addrs = (u32 *) get_property(node, "assigned-addresses", &proplen);
 	if (!addrs)
 		return;
+	DBG("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
 	for (; proplen >= 20; proplen -= 20, addrs += 5) {
 		flags = pci_parse_of_flags(addrs[0]);
 		if (!flags)
@@ -332,6 +333,9 @@ static void pci_parse_of_addrs(struct de
 		if (!size)
 			continue;
 		i = addrs[0] & 0xff;
+		DBG("  base: %llx, size: %llx, i: %x\n",
+		    (unsigned long long)base, (unsigned long long)size, i);
+
 		if (PCI_BASE_ADDRESS_0 <= i && i <= PCI_BASE_ADDRESS_5) {
 			res = &dev->resource[(i - PCI_BASE_ADDRESS_0) >> 2];
 		} else if (i == dev->rom_base_reg) {
@@ -362,6 +366,8 @@ struct pci_dev *of_create_pci_dev(struct
 	if (type == NULL)
 		type = "";
 
+	DBG("    create device, devfn: %x, type: %s\n", devfn, type);
+
 	memset(dev, 0, sizeof(struct pci_dev));
 	dev->bus = bus;
 	dev->sysdata = node;
@@ -375,12 +381,14 @@ struct pci_dev *of_create_pci_dev(struct
 	dev->subsystem_vendor = get_int_prop(node, "subsystem-vendor-id", 0);
 	dev->subsystem_device = get_int_prop(node, "subsystem-id", 0);
 
-	dev->cfg_size = 256; /*pci_cfg_space_size(dev);*/
+	dev->cfg_size = pci_cfg_space_size(dev);
 
 	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(bus),
 		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
 	dev->class = get_int_prop(node, "class-code", 0);
 
+	DBG("    class: 0x%x\n", dev->class);
+
 	dev->current_state = 4;		/* unknown power state */
 
 	if (!strcmp(type, "pci")) {
@@ -402,6 +410,8 @@ struct pci_dev *of_create_pci_dev(struct
 
 	pci_parse_of_addrs(node, dev);
 
+	DBG("    adding to system ...\n");
+
 	pci_device_add(dev, bus);
 
 	/* XXX pci_scan_msi_device(dev); */
@@ -418,15 +428,21 @@ void __devinit of_scan_bus(struct device
 	int reglen, devfn;
 	struct pci_dev *dev;
 
+	DBG("of_scan_bus(%s) bus no %d... \n", node->full_name, bus->number);
+
 	while ((child = of_get_next_child(node, child)) != NULL) {
+		DBG("  * %s\n", child->full_name);
 		reg = (u32 *) get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
 			continue;
 		devfn = (reg[0] >> 8) & 0xff;
+
 		/* create a new pci_dev for this device */
 		dev = of_create_pci_dev(child, bus, devfn);
 		if (!dev)
 			continue;
+		DBG("dev header type: %x\n", dev->hdr_type);
+
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 			of_scan_pci_bridge(child, dev);
@@ -446,16 +462,18 @@ void __devinit of_scan_pci_bridge(struct
 	unsigned int flags;
 	u64 size;
 
+	DBG("of_scan_pci_bridge(%s)\n", node->full_name);
+
 	/* parse bus-range property */
 	busrange = (u32 *) get_property(node, "bus-range", &len);
 	if (busrange == NULL || len != 8) {
-		printk(KERN_ERR "Can't get bus-range for PCI-PCI bridge %s\n",
+		printk(KERN_DEBUG "Can't get bus-range for PCI-PCI bridge %s\n",
 		       node->full_name);
 		return;
 	}
 	ranges = (u32 *) get_property(node, "ranges", &len);
 	if (ranges == NULL) {
-		printk(KERN_ERR "Can't get ranges for PCI-PCI bridge %s\n",
+		printk(KERN_DEBUG "Can't get ranges for PCI-PCI bridge %s\n",
 		       node->full_name);
 		return;
 	}
@@ -509,10 +527,13 @@ void __devinit of_scan_pci_bridge(struct
 	}
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);
+	DBG("    bus name: %s\n", bus->name);
 
 	mode = PCI_PROBE_NORMAL;
 	if (ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
+	DBG("    probe mode: %d\n", mode);
+
 	if (mode == PCI_PROBE_DEVTREE)
 		of_scan_bus(node, bus);
 	else if (mode == PCI_PROBE_NORMAL)
@@ -528,6 +549,8 @@ void __devinit scan_phb(struct pci_contr
 	int i, mode;
 	struct resource *res;
 
+	DBG("Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
+
 	bus = pci_create_bus(NULL, hose->first_busno, hose->ops, node);
 	if (bus == NULL) {
 		printk(KERN_ERR "Failed to create bus for PCI domain %04x\n",
@@ -552,8 +575,9 @@ void __devinit scan_phb(struct pci_contr
 
 	mode = PCI_PROBE_NORMAL;
 #ifdef CONFIG_PPC_MULTIPLATFORM
-	if (ppc_md.pci_probe_mode)
+	if (node && ppc_md.pci_probe_mode)
 		mode = ppc_md.pci_probe_mode(bus);
+	DBG("    probe mode: %d\n", mode);
 	if (mode == PCI_PROBE_DEVTREE) {
 		bus->subordinate = hose->last_busno;
 		of_scan_bus(node, bus);
@@ -842,8 +866,7 @@ pgprot_t pci_phys_mem_access_prot(struct
  * Returns a negative error code on failure, zero on success.
  */
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state,
-			int write_combine)
+			enum pci_mmap_state mmap_state, int write_combine)
 {
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	struct resource *rp;
Index: linux-work/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg.c	2005-12-06 16:17:43.000000000 +1100
+++ linux-work/arch/powerpc/kernel/udbg.c	2005-12-13 18:13:12.000000000 +1100
@@ -110,10 +110,12 @@ static int early_console_initialized;
 
 void __init disable_early_printk(void)
 {
+#if 1
 	if (!early_console_initialized)
 		return;
 	unregister_console(&udbg_console);
 	early_console_initialized = 0;
+#endif
 }
 
 /* called by setup_system */
Index: linux-work/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2005-12-13 17:51:20.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2005-12-14 11:42:58.000000000 +1100
@@ -345,7 +345,7 @@ void __init pmac_setup_arch(void)
 
 #ifdef CONFIG_SMP
 	/* Check for Core99 */
-	if (find_devices("uni-n") || find_devices("u3"))
+	if (find_devices("uni-n") || find_devices("u3") || find_devices("u4"))
 		smp_ops = &core99_smp_ops;
 #ifdef CONFIG_PPC32
 	else
@@ -635,7 +635,7 @@ static void __init pmac_init_early(void)
 	/* Setup interrupt mapping options */
 	ppc64_interrupt_controller = IC_OPEN_PIC;
 
-	iommu_init_early_u3();
+	iommu_init_early_dart();
 #endif
 }
 
@@ -711,7 +711,7 @@ static int __init pmac_probe(int platfor
 	 * occupies having to be broken up so the DART itself is not
 	 * part of the cacheable linar mapping
 	 */
-	alloc_u3_dart_table();
+	alloc_dart_table();
 #endif
 
 #ifdef CONFIG_PMAC_SMU
@@ -733,10 +733,11 @@ static int pmac_pci_probe_mode(struct pc
 	struct device_node *node = bus->sysdata;
 
 	/* We need to use normal PCI probing for the AGP bus,
-	   since the device for the AGP bridge isn't in the tree. */
-	if (bus->self == NULL && device_is_compatible(node, "u3-agp"))
+	 * since the device for the AGP bridge isn't in the tree.
+	 */
+	if (bus->self == NULL && (device_is_compatible(node, "u3-agp") ||
+				  device_is_compatible(node, "u4-pcie")))
 		return PCI_PROBE_NORMAL;
-
 	return PCI_PROBE_DEVTREE;
 }
 #endif
Index: linux-work/arch/powerpc/platforms/powermac/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/smp.c	2005-12-13 15:03:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/smp.c	2005-12-13 18:13:12.000000000 +1100
@@ -361,7 +361,6 @@ static void __init psurge_dual_sync_tb(i
 	set_dec(tb_ticks_per_jiffy);
 	/* XXX fixme */
 	set_tb(0, 0);
-	last_jiffy_stamp(cpu_nr) = 0;
 
 	if (cpu_nr > 0) {
 		mb();
@@ -429,15 +428,62 @@ struct smp_ops_t psurge_smp_ops = {
 };
 #endif /* CONFIG_PPC32 - actually powersurge support */
 
+/*
+ * Core 99 and later support
+ */
+
+static void (*pmac_tb_freeze)(int freeze);
+static unsigned long timebase;
+static int tb_req;
+
+static void smp_core99_give_timebase(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	while(!tb_req)
+		barrier();
+	tb_req = 0;
+	(*pmac_tb_freeze)(1);
+	mb();
+	timebase = get_tb();
+	mb();
+	while (timebase)
+		barrier();
+	mb();
+	(*pmac_tb_freeze)(0);
+	mb();
+
+	local_irq_restore(flags);
+}
+
+
+static void __devinit smp_core99_take_timebase(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	tb_req = 1;
+	mb();
+	while (!timebase)
+		barrier();
+	mb();
+	set_tb(timebase >> 32, timebase & 0xffffffff);
+	timebase = 0;
+	mb();
+	set_dec(tb_ticks_per_jiffy/2);
+
+	local_irq_restore(flags);
+}
+
 #ifdef CONFIG_PPC64
 /*
  * G5s enable/disable the timebase via an i2c-connected clock chip.
  */
 static struct device_node *pmac_tb_clock_chip_host;
 static u8 pmac_tb_pulsar_addr;
-static void (*pmac_tb_freeze)(int freeze);
-static DEFINE_SPINLOCK(timebase_lock);
-static unsigned long timebase;
 
 static void smp_core99_cypress_tb_freeze(int freeze)
 {
@@ -447,7 +493,8 @@ static void smp_core99_cypress_tb_freeze
 	/* Strangely, the device-tree says address is 0xd2, but darwin
 	 * accesses 0xd0 ...
 	 */
-	pmac_low_i2c_setmode(pmac_tb_clock_chip_host, pmac_low_i2c_mode_combined);
+	pmac_low_i2c_setmode(pmac_tb_clock_chip_host,
+			     pmac_low_i2c_mode_combined);
 	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
 			       0xd0 | pmac_low_i2c_read,
 			       0x81, &data, 1);
@@ -475,7 +522,8 @@ static void smp_core99_pulsar_tb_freeze(
 	u8 data;
 	int rc;
 
-	pmac_low_i2c_setmode(pmac_tb_clock_chip_host, pmac_low_i2c_mode_combined);
+	pmac_low_i2c_setmode(pmac_tb_clock_chip_host,
+			     pmac_low_i2c_mode_combined);
 	rc = pmac_low_i2c_xfer(pmac_tb_clock_chip_host,
 			       pmac_tb_pulsar_addr | pmac_low_i2c_read,
 			       0x2e, &data, 1);
@@ -496,54 +544,14 @@ static void smp_core99_pulsar_tb_freeze(
 	}
 }
 
-
-static void smp_core99_give_timebase(void)
-{
-	/* Open i2c bus for synchronous access */
-	if (pmac_low_i2c_open(pmac_tb_clock_chip_host, 0))
-		panic("Can't open i2c for TB sync !\n");
-
-	spin_lock(&timebase_lock);
-	(*pmac_tb_freeze)(1);
-	mb();
-	timebase = get_tb();
-	spin_unlock(&timebase_lock);
-
-	while (timebase)
-		barrier();
-
-	spin_lock(&timebase_lock);
-	(*pmac_tb_freeze)(0);
-	spin_unlock(&timebase_lock);
-
-	/* Close i2c bus */
-	pmac_low_i2c_close(pmac_tb_clock_chip_host);
-}
-
-
-static void __devinit smp_core99_take_timebase(void)
-{
-	while (!timebase)
-		barrier();
-	spin_lock(&timebase_lock);
-	set_tb(timebase >> 32, timebase & 0xffffffff);
-	timebase = 0;
-	spin_unlock(&timebase_lock);
-}
-
-static void __init smp_core99_setup(int ncpus)
+static void __init smp_core99_setup_i2c_hwsync(int ncpus)
 {
 	struct device_node *cc = NULL;	
 	struct device_node *p;
+	const char *name = NULL;
 	u32 *reg;
 	int ok;
 
-	/* HW sync only on these platforms */
-	if (!machine_is_compatible("PowerMac7,2") &&
-	    !machine_is_compatible("PowerMac7,3") &&
-	    !machine_is_compatible("RackMac3,1"))
-		return;
-
 	/* Look for the clock chip */
 	while ((cc = of_find_node_by_name(cc, "i2c-hwclock")) != NULL) {
 		p = of_get_parent(cc);
@@ -561,114 +569,64 @@ static void __init smp_core99_setup(int 
 			if (device_is_compatible(cc, "pulsar-legacy-slewing")) {
 				pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
 				pmac_tb_pulsar_addr = 0xd2;
-				printk(KERN_INFO "Timebase clock is Pulsar chip\n");
+				name = "Pulsar";
 			} else if (device_is_compatible(cc, "cy28508")) {
 				pmac_tb_freeze = smp_core99_cypress_tb_freeze;
-				printk(KERN_INFO "Timebase clock is Cypress chip\n");
+				name = "Cypress";
 			}
 			break;
 		case 0xd4:
 			pmac_tb_freeze = smp_core99_pulsar_tb_freeze;
 			pmac_tb_pulsar_addr = 0xd4;
-			printk(KERN_INFO "Timebase clock is Pulsar chip\n");
+			name = "Pulsar";
 			break;
 		}
-		if (pmac_tb_freeze != NULL) {
-			pmac_tb_clock_chip_host = of_get_parent(cc);
-			of_node_put(cc);
+		if (pmac_tb_freeze != NULL)
 			break;
-		}
 	}
-	if (pmac_tb_freeze == NULL) {
-		smp_ops->give_timebase = smp_generic_give_timebase;
-		smp_ops->take_timebase = smp_generic_take_timebase;
+	if (pmac_tb_freeze != NULL) {
+		struct device_node *p = of_get_parent(cc);
+		of_node_put(cc);
+		while(p && strcmp(p->type, "i2c")) {
+			cc = of_get_parent(p);
+			of_node_put(p);
+			p = cc;
+		}
+		if (p == NULL)
+			goto no_i2c_sync;
+		/* Open i2c bus for synchronous access */
+		if (pmac_low_i2c_open(p, 0)) {
+			printk(KERN_ERR "Failed top open i2c bus %s for clock"
+			       " sync, fallback to software sync !\n",
+			       p->full_name);
+			of_node_put(p);
+			goto no_i2c_sync;
+		}
+		pmac_tb_clock_chip_host = p;
+		printk(KERN_INFO "Processor timebase sync using %s i2c clock\n",
+		       name);
+		return;
 	}
+ no_i2c_sync:
+	pmac_tb_freeze = NULL;
 }
 
-/* nothing to do here, caches are already set up by service processor */
-static inline void __devinit core99_init_caches(int cpu)
-{
-}
+#endif /* CONFIG_PPC64 */
 
-#else /* CONFIG_PPC64 */
 
 /*
- * SMP G4 powermacs use a GPIO to enable/disable the timebase.
+ * SMP G4 and newer G5 use a GPIO to enable/disable the timebase.
  */
 
 static unsigned int core99_tb_gpio;	/* Timebase freeze GPIO */
 
-static unsigned int pri_tb_hi, pri_tb_lo;
-static unsigned int pri_tb_stamp;
-
-/* not __init, called in sleep/wakeup code */
-void smp_core99_give_timebase(void)
+static void smp_core99_gpio_tb_freeze(int freeze)
 {
-	unsigned long flags;
-	unsigned int t;
-
-	/* wait for the secondary to be in take_timebase */
-	for (t = 100000; t > 0 && !sec_tb_reset; --t)
-		udelay(10);
-	if (!sec_tb_reset) {
-		printk(KERN_WARNING "Timeout waiting sync on second CPU\n");
-		return;
-	}
-
-	/* freeze the timebase and read it */
-	/* disable interrupts so the timebase is disabled for the
-	   shortest possible time */
-	local_irq_save(flags);
-	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 4);
+	if (freeze)
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 4);
+	else
+		pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 0);
 	pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
-	mb();
-	pri_tb_hi = get_tbu();
-	pri_tb_lo = get_tbl();
-	pri_tb_stamp = last_jiffy_stamp(smp_processor_id());
-	mb();
-
-	/* tell the secondary we're ready */
-	sec_tb_reset = 2;
-	mb();
-
-	/* wait for the secondary to have taken it */
-	/* note: can't use udelay here, since it needs the timebase running */
-	for (t = 10000000; t > 0 && sec_tb_reset; --t)
-		barrier();
-	if (sec_tb_reset)
-		/* XXX BUG_ON here? */
-		printk(KERN_WARNING "Timeout waiting sync(2) on second CPU\n");
-
-	/* Now, restart the timebase by leaving the GPIO to an open collector */
-       	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, core99_tb_gpio, 0);
-        pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, core99_tb_gpio, 0);
-	local_irq_restore(flags);
-}
-
-/* not __init, called in sleep/wakeup code */
-void smp_core99_take_timebase(void)
-{
-	unsigned long flags;
-
-	/* tell the primary we're here */
-	sec_tb_reset = 1;
-	mb();
-
-	/* wait for the primary to set pri_tb_hi/lo */
-	while (sec_tb_reset < 2)
-		mb();
-
-	/* set our stuff the same as the primary */
-	local_irq_save(flags);
-	set_dec(1);
-	set_tb(pri_tb_hi, pri_tb_lo);
-	last_jiffy_stamp(smp_processor_id()) = pri_tb_stamp;
-	mb();
-
-	/* tell the primary we're done */
-       	sec_tb_reset = 0;
-	mb();
-	local_irq_restore(flags);
 }
 
 /* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
@@ -677,6 +635,7 @@ volatile static long int core99_l3_cache
 
 static void __devinit core99_init_caches(int cpu)
 {
+#ifndef CONFIG_PPC64
 	if (!cpu_has_feature(CPU_FTR_L2CR))
 		return;
 
@@ -702,30 +661,80 @@ static void __devinit core99_init_caches
 		_set_L3CR(core99_l3_cache);
 		printk("CPU%d: L3CR set to %lx\n", cpu, core99_l3_cache);
 	}
+#endif /* !CONFIG_PPC64 */
 }
 
 static void __init smp_core99_setup(int ncpus)
 {
-	struct device_node *cpu;
-	u32 *tbprop = NULL;
-	int i;
-
-	core99_tb_gpio = KL_GPIO_TB_ENABLE;	/* default value */
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != NULL) {
-		tbprop = (u32 *)get_property(cpu, "timebase-enable", NULL);
-		if (tbprop)
-			core99_tb_gpio = *tbprop;
-		of_node_put(cpu);
-	}
-
-	/* XXX should get this from reg properties */
-	for (i = 1; i < ncpus; ++i)
-		smp_hw_index[i] = i;
-	powersave_nap = 0;
-}
+#ifdef CONFIG_PPC64
+
+	/* i2c based HW sync on some G5s */
+	if (machine_is_compatible("PowerMac7,2") ||
+	    machine_is_compatible("PowerMac7,3") ||
+	    machine_is_compatible("RackMac3,1"))
+		smp_core99_setup_i2c_hwsync(ncpus);
+
+	/* GPIO based HW sync on recent G5s */
+	if (pmac_tb_freeze == NULL) {
+		struct device_node *np =
+			of_find_node_by_name(NULL, "timebase-enable");
+		u32 *reg = (u32 *)get_property(np, "reg", NULL);
+
+		if (np && reg && !strcmp(np->type, "gpio")) {
+			core99_tb_gpio = *reg;
+			if (core99_tb_gpio < 0x50)
+				core99_tb_gpio += 0x50;
+			pmac_tb_freeze = smp_core99_gpio_tb_freeze;
+			printk(KERN_INFO "Processor timebase sync using"
+			       " GPIO 0x%02x\n", core99_tb_gpio);
+		}
+	}
+
+#else /* CONFIG_PPC64 */
+
+	/* GPIO based HW sync on ppc32 Core99 */
+	if (pmac_tb_freeze == NULL && !machine_is_compatible("MacRISC4")) {
+		struct device_node *cpu;
+		u32 *tbprop = NULL;
+
+		core99_tb_gpio = KL_GPIO_TB_ENABLE;	/* default value */
+		cpu = of_find_node_by_type(NULL, "cpu");
+		if (cpu != NULL) {
+			tbprop = (u32 *)get_property(cpu, "timebase-enable",
+						     NULL);
+			if (tbprop)
+				core99_tb_gpio = *tbprop;
+			of_node_put(cpu);
+		}
+		pmac_tb_freeze = smp_core99_gpio_tb_freeze;
+		printk(KERN_INFO "Processor timebase sync using"
+		       " GPIO 0x%02x\n", core99_tb_gpio);
+	}
+
+#endif /* CONFIG_PPC64 */
+
+	/* No timebase sync, fallback to software */
+	if (pmac_tb_freeze == NULL) {
+		smp_ops->give_timebase = smp_generic_give_timebase;
+		smp_ops->take_timebase = smp_generic_take_timebase;
+		printk(KERN_INFO "Processor timebase sync using software\n");
+	}
+
+#ifndef CONFIG_PPC64
+	{
+		int i;
+
+		/* XXX should get this from reg properties */
+		for (i = 1; i < ncpus; ++i)
+			smp_hw_index[i] = i;
+	}
 #endif
 
+	/* 32 bits SMP can't NAP */
+	if (!machine_is_compatible("MacRISC4"))
+		powersave_nap = 0;
+}
+
 static int __init smp_core99_probe(void)
 {
 	struct device_node *cpus;
@@ -803,17 +812,25 @@ static void __devinit smp_core99_setup_c
 	mpic_setup_this_cpu();
 
 	if (cpu_nr == 0) {
-#ifdef CONFIG_POWER4
+#ifdef CONFIG_PPC64
 		extern void g5_phy_disable_cpu1(void);
 
+		/* Close i2c bus if it was used for tb sync */
+		if (pmac_tb_clock_chip_host) {
+			pmac_low_i2c_close(pmac_tb_clock_chip_host);
+			pmac_tb_clock_chip_host	= NULL;
+		}
+
 		/* If we didn't start the second CPU, we must take
 		 * it off the bus
 		 */
 		if (machine_is_compatible("MacRISC4") &&
 		    num_online_cpus() < 2)		
 			g5_phy_disable_cpu1();
-#endif /* CONFIG_POWER4 */
-		if (ppc_md.progress) ppc_md.progress("core99_setup_cpu 0 done", 0x349);
+#endif /* CONFIG_PPC64 */
+
+		if (ppc_md.progress)
+			ppc_md.progress("core99_setup_cpu 0 done", 0x349);
 	}
 }
 
Index: linux-work/arch/powerpc/sysdev/u3_iommu.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/u3_iommu.c	2005-11-24 17:21:41.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,327 +0,0 @@
-/*
- * arch/powerpc/sysdev/u3_iommu.c
- *
- * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
- *
- * Based on pSeries_iommu.c:
- * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
- * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
- *
- * Dynamic DMA mapping support, Apple U3 & IBM CPC925 "DART" iommu.
- *
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-#include <linux/spinlock.h>
-#include <linux/string.h>
-#include <linux/pci.h>
-#include <linux/dma-mapping.h>
-#include <linux/vmalloc.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/iommu.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-#include <asm/abs_addr.h>
-#include <asm/cacheflush.h>
-#include <asm/lmb.h>
-#include <asm/ppc-pci.h>
-
-#include "dart.h"
-
-extern int iommu_force_on;
-
-/* Physical base address and size of the DART table */
-unsigned long dart_tablebase; /* exported to htab_initialize */
-static unsigned long dart_tablesize;
-
-/* Virtual base address of the DART table */
-static u32 *dart_vbase;
-
-/* Mapped base address for the dart */
-static unsigned int *dart; 
-
-/* Dummy val that entries are set to when unused */
-static unsigned int dart_emptyval;
-
-static struct iommu_table iommu_table_u3;
-static int iommu_table_u3_inited;
-static int dart_dirty;
-
-#define DBG(...)
-
-static inline void dart_tlb_invalidate_all(void)
-{
-	unsigned long l = 0;
-	unsigned int reg;
-	unsigned long limit;
-
-	DBG("dart: flush\n");
-
-	/* To invalidate the DART, set the DARTCNTL_FLUSHTLB bit in the
-	 * control register and wait for it to clear.
-	 *
-	 * Gotcha: Sometimes, the DART won't detect that the bit gets
-	 * set. If so, clear it and set it again.
-	 */ 
-
-	limit = 0;
-
-retry:
-	reg = in_be32((unsigned int *)dart+DARTCNTL);
-	reg |= DARTCNTL_FLUSHTLB;
-	out_be32((unsigned int *)dart+DARTCNTL, reg);
-
-	l = 0;
-	while ((in_be32((unsigned int *)dart+DARTCNTL) & DARTCNTL_FLUSHTLB) &&
-		l < (1L<<limit)) {
-		l++;
-	}
-	if (l == (1L<<limit)) {
-		if (limit < 4) {
-			limit++;
-		        reg = in_be32((unsigned int *)dart+DARTCNTL);
-		        reg &= ~DARTCNTL_FLUSHTLB;
-		        out_be32((unsigned int *)dart+DARTCNTL, reg);
-			goto retry;
-		} else
-			panic("U3-DART: TLB did not flush after waiting a long "
-			      "time. Buggy U3 ?");
-	}
-}
-
-static void dart_flush(struct iommu_table *tbl)
-{
-	if (dart_dirty)
-		dart_tlb_invalidate_all();
-	dart_dirty = 0;
-}
-
-static void dart_build(struct iommu_table *tbl, long index, 
-		       long npages, unsigned long uaddr,
-		       enum dma_data_direction direction)
-{
-	unsigned int *dp;
-	unsigned int rpn;
-
-	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
-
-	index <<= DART_PAGE_FACTOR;
-	npages <<= DART_PAGE_FACTOR;
-
-	dp = ((unsigned int*)tbl->it_base) + index;
-	
-	/* On U3, all memory is contigous, so we can move this
-	 * out of the loop.
-	 */
-	while (npages--) {
-		rpn = virt_to_abs(uaddr) >> DART_PAGE_SHIFT;
-
-		*(dp++) = DARTMAP_VALID | (rpn & DARTMAP_RPNMASK);
-
-		rpn++;
-		uaddr += DART_PAGE_SIZE;
-	}
-
-	dart_dirty = 1;
-}
-
-
-static void dart_free(struct iommu_table *tbl, long index, long npages)
-{
-	unsigned int *dp;
-	
-	/* We don't worry about flushing the TLB cache. The only drawback of
-	 * not doing it is that we won't catch buggy device drivers doing
-	 * bad DMAs, but then no 32-bit architecture ever does either.
-	 */
-
-	DBG("dart: free at: %lx, %lx\n", index, npages);
-
-	index <<= DART_PAGE_FACTOR;
-	npages <<= DART_PAGE_FACTOR;
-
-	dp  = ((unsigned int *)tbl->it_base) + index;
-		
-	while (npages--)
-		*(dp++) = dart_emptyval;
-}
-
-
-static int dart_init(struct device_node *dart_node)
-{
-	unsigned int regword;
-	unsigned int i;
-	unsigned long tmp;
-
-	if (dart_tablebase == 0 || dart_tablesize == 0) {
-		printk(KERN_INFO "U3-DART: table not allocated, using direct DMA\n");
-		return -ENODEV;
-	}
-
-	/* Make sure nothing from the DART range remains in the CPU cache
-	 * from a previous mapping that existed before the kernel took
-	 * over
-	 */
-	flush_dcache_phys_range(dart_tablebase, dart_tablebase + dart_tablesize);
-
-	/* Allocate a spare page to map all invalid DART pages. We need to do
-	 * that to work around what looks like a problem with the HT bridge
-	 * prefetching into invalid pages and corrupting data
-	 */
-	tmp = lmb_alloc(DART_PAGE_SIZE, DART_PAGE_SIZE);
-	if (!tmp)
-		panic("U3-DART: Cannot allocate spare page!");
-	dart_emptyval = DARTMAP_VALID | ((tmp >> DART_PAGE_SHIFT) & DARTMAP_RPNMASK);
-
-	/* Map in DART registers. FIXME: Use device node to get base address */
-	dart = ioremap(DART_BASE, 0x7000);
-	if (dart == NULL)
-		panic("U3-DART: Cannot map registers!");
-
-	/* Set initial control register contents: table base, 
-	 * table size and enable bit
-	 */
-	regword = DARTCNTL_ENABLE | 
-		((dart_tablebase >> DART_PAGE_SHIFT) << DARTCNTL_BASE_SHIFT) |
-		(((dart_tablesize >> DART_PAGE_SHIFT) & DARTCNTL_SIZE_MASK)
-				 << DARTCNTL_SIZE_SHIFT);
-	dart_vbase = ioremap(virt_to_abs(dart_tablebase), dart_tablesize);
-
-	/* Fill initial table */
-	for (i = 0; i < dart_tablesize/4; i++)
-		dart_vbase[i] = dart_emptyval;
-
-	/* Initialize DART with table base and enable it. */
-	out_be32((unsigned int *)dart, regword);
-
-	/* Invalidate DART to get rid of possible stale TLBs */
-	dart_tlb_invalidate_all();
-
-	printk(KERN_INFO "U3/CPC925 DART IOMMU initialized\n");
-
-	return 0;
-}
-
-static void iommu_table_u3_setup(void)
-{
-	iommu_table_u3.it_busno = 0;
-	iommu_table_u3.it_offset = 0;
-	/* it_size is in number of entries */
-	iommu_table_u3.it_size = (dart_tablesize / sizeof(u32)) >> DART_PAGE_FACTOR;
-
-	/* Initialize the common IOMMU code */
-	iommu_table_u3.it_base = (unsigned long)dart_vbase;
-	iommu_table_u3.it_index = 0;
-	iommu_table_u3.it_blocksize = 1;
-	iommu_init_table(&iommu_table_u3);
-
-	/* Reserve the last page of the DART to avoid possible prefetch
-	 * past the DART mapped area
-	 */
-	set_bit(iommu_table_u3.it_size - 1, iommu_table_u3.it_map);
-}
-
-static void iommu_dev_setup_u3(struct pci_dev *dev)
-{
-	struct device_node *dn;
-
-	/* We only have one iommu table on the mac for now, which makes
-	 * things simple. Setup all PCI devices to point to this table
-	 *
-	 * We must use pci_device_to_OF_node() to make sure that
-	 * we get the real "final" pointer to the device in the
-	 * pci_dev sysdata and not the temporary PHB one
-	 */
-	dn = pci_device_to_OF_node(dev);
-
-	if (dn)
-		PCI_DN(dn)->iommu_table = &iommu_table_u3;
-}
-
-static void iommu_bus_setup_u3(struct pci_bus *bus)
-{
-	struct device_node *dn;
-
-	if (!iommu_table_u3_inited) {
-		iommu_table_u3_inited = 1;
-		iommu_table_u3_setup();
-	}
-
-	dn = pci_bus_to_OF_node(bus);
-
-	if (dn)
-		PCI_DN(dn)->iommu_table = &iommu_table_u3;
-}
-
-static void iommu_dev_setup_null(struct pci_dev *dev) { }
-static void iommu_bus_setup_null(struct pci_bus *bus) { }
-
-void iommu_init_early_u3(void)
-{
-	struct device_node *dn;
-
-	/* Find the DART in the device-tree */
-	dn = of_find_compatible_node(NULL, "dart", "u3-dart");
-	if (dn == NULL)
-		return;
-
-	/* Setup low level TCE operations for the core IOMMU code */
-	ppc_md.tce_build = dart_build;
-	ppc_md.tce_free  = dart_free;
-	ppc_md.tce_flush = dart_flush;
-
-	/* Initialize the DART HW */
-	if (dart_init(dn)) {
-		/* If init failed, use direct iommu and null setup functions */
-		ppc_md.iommu_dev_setup = iommu_dev_setup_null;
-		ppc_md.iommu_bus_setup = iommu_bus_setup_null;
-
-		/* Setup pci_dma ops */
-		pci_direct_iommu_init();
-	} else {
-		ppc_md.iommu_dev_setup = iommu_dev_setup_u3;
-		ppc_md.iommu_bus_setup = iommu_bus_setup_u3;
-
-		/* Setup pci_dma ops */
-		pci_iommu_init();
-	}
-}
-
-
-void __init alloc_u3_dart_table(void)
-{
-	/* Only reserve DART space if machine has more than 2GB of RAM
-	 * or if requested with iommu=on on cmdline.
-	 */
-	if (lmb_end_of_DRAM() <= 0x80000000ull && !iommu_force_on)
-		return;
-
-	/* 512 pages (2MB) is max DART tablesize. */
-	dart_tablesize = 1UL << 21;
-	/* 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
-	 * will blow up an entire large page anyway in the kernel mapping
-	 */
-	dart_tablebase = (unsigned long)
-		abs_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
-
-	printk(KERN_INFO "U3-DART allocated at: %lx\n", dart_tablebase);
-}
Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-12-13 17:51:20.000000000 +1100
+++ linux-work/drivers/ide/ppc/pmac.c	2005-12-13 18:13:12.000000000 +1100
@@ -1686,7 +1686,7 @@ pmac_ide_probe(void)
 #else
 	macio_register_driver(&pmac_ide_macio_driver);
 	pci_register_driver(&pmac_ide_pci_driver);
-#endif	
+#endif
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
Index: linux-work/drivers/macintosh/smu.c
===================================================================
--- linux-work.orig/drivers/macintosh/smu.c	2005-11-24 17:18:43.000000000 +1100
+++ linux-work/drivers/macintosh/smu.c	2005-12-13 18:13:12.000000000 +1100
@@ -53,7 +53,7 @@
 #undef DEBUG_SMU
 
 #ifdef DEBUG_SMU
-#define DPRINTK(fmt, args...) do { udbg_printf(KERN_DEBUG fmt , ##args); } while (0)
+#define DPRINTK(fmt, args...) do { printk(KERN_DEBUG fmt , ##args); } while (0)
 #else
 #define DPRINTK(fmt, args...) do { } while (0)
 #endif
@@ -909,10 +909,13 @@ static struct smu_sdbp_header *smu_creat
 	struct property *prop;
 
 	/* First query the partition info */
+	DPRINTK("SMU: Query partition infos ... (irq=%d)\n", smu->db_irq);
 	smu_queue_simple(&cmd, SMU_CMD_PARTITION_COMMAND, 2,
 			 smu_done_complete, &comp,
 			 SMU_CMD_PARTITION_LATEST, id);
 	wait_for_completion(&comp);
+	DPRINTK("SMU: done, status: %d, reply_len: %d\n",
+		cmd.cmd.status, cmd.cmd.reply_len);
 
 	/* Partition doesn't exist (or other error) */
 	if (cmd.cmd.status != 0 || cmd.cmd.reply_len != 6)
@@ -975,6 +978,8 @@ struct smu_sdbp_header *__smu_get_sdb_pa
 
 	sprintf(pname, "sdb-partition-%02x", id);
 
+	DPRINTK("smu_get_sdb_partition(%02x)\n", id);
+
 	if (interruptible) {
 		int rc;
 		rc = down_interruptible(&smu_part_access);
@@ -986,6 +991,7 @@ struct smu_sdbp_header *__smu_get_sdb_pa
 	part = (struct smu_sdbp_header *)get_property(smu->of_node,
 						      pname, size);
 	if (part == NULL) {
+		DPRINTK("trying to extract from SMU ...\n");
 		part = smu_create_sdb_partition(id);
 		if (part != NULL && size)
 			*size = part->len << 2;
Index: linux-work/include/asm-powerpc/mpic.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mpic.h	2005-12-13 18:02:03.000000000 +1100
+++ linux-work/include/asm-powerpc/mpic.h	2005-12-13 18:13:12.000000000 +1100
@@ -117,8 +117,9 @@ typedef int (*mpic_cascade_t)(struct pt_
 struct mpic_irq_fixup
 {
 	u8 __iomem	*base;
+	u8 __iomem	*applebase;
 	u32		data;
-	unsigned int	irq;
+	unsigned int	index;
 };
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
Index: linux-work/include/asm/hardirq.h
===================================================================
--- linux-work.orig/include/asm/hardirq.h	2005-11-24 17:18:48.000000000 +1100
+++ linux-work/include/asm/hardirq.h	2005-12-13 18:13:12.000000000 +1100
@@ -11,13 +11,10 @@
  */
 typedef struct {
 	unsigned int __softirq_pending;	/* set_bit is used on this */
-	unsigned int __last_jiffy_stamp;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#define last_jiffy_stamp(cpu) __IRQ_STAT((cpu), __last_jiffy_stamp)
-
 static inline void ack_bad_irq(int irq)
 {
 	printk(KERN_CRIT "illegal vector %d received!\n", irq);
Index: linux-work/arch/powerpc/platforms/maple/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/setup.c	2005-12-13 15:03:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/maple/setup.c	2005-12-14 11:43:10.000000000 +1100
@@ -195,7 +195,7 @@ static void __init maple_init_early(void
 	/* Setup interrupt mapping options */
 	ppc64_interrupt_controller = IC_OPEN_PIC;
 
-	iommu_init_early_u3();
+	iommu_init_early_dart();
 
 	DBG(" <- maple_init_early\n");
 }
@@ -257,7 +257,7 @@ static int __init maple_probe(int platfo
 	 * occupies having to be broken up so the DART itself is not
 	 * part of the cacheable linar mapping
 	 */
-	alloc_u3_dart_table();
+	alloc_dart_table();
 
 	return 1;
 }
Index: linux-work/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/Makefile	2005-11-24 17:21:41.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/Makefile	2005-12-14 11:01:34.000000000 +1100
@@ -4,6 +4,6 @@ obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
 obj-$(CONFIG_40x)		+= dcr.o
-obj-$(CONFIG_U3_DART)		+= u3_iommu.o
+obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_83xx)		+= ipic.o
Index: linux-work/arch/powerpc/sysdev/dart.h
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/dart.h	2005-11-24 17:21:41.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/dart.h	2005-12-14 12:52:12.000000000 +1100
@@ -20,29 +20,44 @@
 #define _POWERPC_SYSDEV_DART_H
 

-/* physical base of DART registers */
-#define DART_BASE        0xf8033000UL
-
 /* Offset from base to control register */
-#define DARTCNTL   0
+#define DART_CNTL	0
+
 /* Offset from base to exception register */
-#define DARTEXCP   0x10
+#define DART_EXCP_U3	0x10
 /* Offset from base to TLB tag registers */
-#define DARTTAG    0x1000
+#define DART_TAGS_U3	0x1000
 
+/* U4 registers */
+#define DART_BASE_U4	0x10
+#define DART_SIZE_U4	0x20
+#define DART_EXCP_U4	0x30
+#define DART_TAGS_U4	0x1000
 
 /* Control Register fields */
 
-/* base address of table (pfn) */
-#define DARTCNTL_BASE_MASK    0xfffff
-#define DARTCNTL_BASE_SHIFT   12
+/* U3 registers */
+#define DART_CNTL_U3_BASE_MASK	0xfffff
+#define DART_CNTL_U3_BASE_SHIFT	12
+#define DART_CNTL_U3_FLUSHTLB	0x400
+#define DART_CNTL_U3_ENABLE	0x200
+#define DART_CNTL_U3_SIZE_MASK	0x1ff
+#define DART_CNTL_U3_SIZE_SHIFT	0
+
+/* U4 registers */
+#define DART_BASE_U4_BASE_MASK	0xffffff
+#define DART_BASE_U4_BASE_SHIFT	0
+#define DART_CNTL_U4_FLUSHTLB	0x20000000
+#define DART_CNTL_U4_ENABLE	0x80000000
+#define DART_SIZE_U4_SIZE_MASK	0x1fff
+#define DART_SIZE_U4_SIZE_SHIFT	0
+
+#define DART_REG(r)	(dart + ((r) >> 2))
+#define DART_IN(r)	(in_be32(DART_REG(r)))
+#define DART_OUT(r,v)	(out_be32(DART_REG(r), (v)))
 
-#define DARTCNTL_FLUSHTLB     0x400
-#define DARTCNTL_ENABLE       0x200
 
 /* size of table in pages */
-#define DARTCNTL_SIZE_MASK    0x1ff
-#define DARTCNTL_SIZE_SHIFT   0
 

 /* DART table fields */
Index: linux-work/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/sysdev/dart_iommu.c	2005-12-14 13:07:03.000000000 +1100
@@ -0,0 +1,350 @@
+/*
+ * arch/powerpc/sysdev/dart_iommu.c
+ *
+ * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
+ * Copyright (C) 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
+ *                    IBM Corporation
+ *
+ * Based on pSeries_iommu.c:
+ * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
+ * Copyright (C) 2004 Olof Johansson <olof@lixom.net>, IBM Corporation
+ *
+ * Dynamic DMA mapping support, Apple U3, U4 & IBM CPC925 "DART" iommu.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/iommu.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/abs_addr.h>
+#include <asm/cacheflush.h>
+#include <asm/lmb.h>
+#include <asm/ppc-pci.h>
+
+#include "dart.h"
+
+extern int iommu_force_on;
+
+/* Physical base address and size of the DART table */
+unsigned long dart_tablebase; /* exported to htab_initialize */
+static unsigned long dart_tablesize;
+
+/* Virtual base address of the DART table */
+static u32 *dart_vbase;
+
+/* Mapped base address for the dart */
+static unsigned int *__iomem dart;
+
+/* Dummy val that entries are set to when unused */
+static unsigned int dart_emptyval;
+
+static struct iommu_table iommu_table_dart;
+static int iommu_table_dart_inited;
+static int dart_dirty;
+static int dart_is_u4;
+
+#define DBG(...)
+
+static inline void dart_tlb_invalidate_all(void)
+{
+	unsigned long l = 0;
+	unsigned int reg, inv_bit;
+	unsigned long limit;
+
+	DBG("dart: flush\n");
+
+	/* To invalidate the DART, set the DARTCNTL_FLUSHTLB bit in the
+	 * control register and wait for it to clear.
+	 *
+	 * Gotcha: Sometimes, the DART won't detect that the bit gets
+	 * set. If so, clear it and set it again.
+	 */
+
+	limit = 0;
+
+	inv_bit = dart_is_u4 ? DART_CNTL_U4_FLUSHTLB : DART_CNTL_U3_FLUSHTLB;
+retry:
+	l = 0;
+	reg = DART_IN(DART_CNTL);
+	reg |= inv_bit;
+	DART_OUT(DART_CNTL, reg);
+
+	while ((DART_IN(DART_CNTL) & inv_bit) && l < (1L << limit))
+		l++;
+	if (l == (1L << limit)) {
+		if (limit < 4) {
+			limit++;
+		        reg = DART_IN(DART_CNTL);
+		        reg &= ~inv_bit;
+			DART_OUT(DART_CNTL, reg);
+			goto retry;
+		} else
+			panic("DART: TLB did not flush after waiting a long "
+			      "time. Buggy U3 ?");
+	}
+}
+
+static void dart_flush(struct iommu_table *tbl)
+{
+	if (dart_dirty)
+		dart_tlb_invalidate_all();
+	dart_dirty = 0;
+}
+
+static void dart_build(struct iommu_table *tbl, long index,
+		       long npages, unsigned long uaddr,
+		       enum dma_data_direction direction)
+{
+	unsigned int *dp;
+	unsigned int rpn;
+
+	DBG("dart: build at: %lx, %lx, addr: %x\n", index, npages, uaddr);
+
+	index <<= DART_PAGE_FACTOR;
+	npages <<= DART_PAGE_FACTOR;
+
+	dp = ((unsigned int*)tbl->it_base) + index;
+
+	/* On U3, all memory is contigous, so we can move this
+	 * out of the loop.
+	 */
+	while (npages--) {
+		rpn = virt_to_abs(uaddr) >> DART_PAGE_SHIFT;
+
+		*(dp++) = DARTMAP_VALID | (rpn & DARTMAP_RPNMASK);
+
+		rpn++;
+		uaddr += DART_PAGE_SIZE;
+	}
+
+	dart_dirty = 1;
+}
+
+
+static void dart_free(struct iommu_table *tbl, long index, long npages)
+{
+	unsigned int *dp;
+
+	/* We don't worry about flushing the TLB cache. The only drawback of
+	 * not doing it is that we won't catch buggy device drivers doing
+	 * bad DMAs, but then no 32-bit architecture ever does either.
+	 */
+
+	DBG("dart: free at: %lx, %lx\n", index, npages);
+
+	index <<= DART_PAGE_FACTOR;
+	npages <<= DART_PAGE_FACTOR;
+
+	dp  = ((unsigned int *)tbl->it_base) + index;
+
+	while (npages--)
+		*(dp++) = dart_emptyval;
+}
+
+
+static int dart_init(struct device_node *dart_node)
+{
+	unsigned int i;
+	unsigned long tmp, base, size;
+	struct resource r;
+
+	if (dart_tablebase == 0 || dart_tablesize == 0) {
+		printk(KERN_INFO "DART: table not allocated, using "
+		       "direct DMA\n");
+		return -ENODEV;
+	}
+
+	if (of_address_to_resource(dart_node, 0, &r))
+		panic("DART: can't get register base ! ");
+
+	/* Make sure nothing from the DART range remains in the CPU cache
+	 * from a previous mapping that existed before the kernel took
+	 * over
+	 */
+	flush_dcache_phys_range(dart_tablebase,
+				dart_tablebase + dart_tablesize);
+
+	/* Allocate a spare page to map all invalid DART pages. We need to do
+	 * that to work around what looks like a problem with the HT bridge
+	 * prefetching into invalid pages and corrupting data
+	 */
+	tmp = lmb_alloc(DART_PAGE_SIZE, DART_PAGE_SIZE);
+	if (!tmp)
+		panic("DART: Cannot allocate spare page!");
+	dart_emptyval = DARTMAP_VALID | ((tmp >> DART_PAGE_SHIFT) &
+					 DARTMAP_RPNMASK);
+
+	/* Map in DART registers */
+	dart = ioremap(r.start, r.end - r.start + 1);
+	if (dart == NULL)
+		panic("DART: Cannot map registers!");
+
+	/* Map in DART table */
+	dart_vbase = ioremap(virt_to_abs(dart_tablebase), dart_tablesize);
+
+	/* Fill initial table */
+	for (i = 0; i < dart_tablesize/4; i++)
+		dart_vbase[i] = dart_emptyval;
+
+	/* Initialize DART with table base and enable it. */
+	base = dart_tablebase >> DART_PAGE_SHIFT;
+	size = dart_tablesize >> DART_PAGE_SHIFT;
+	if (dart_is_u4) {
+		BUG_ON(size & ~DART_SIZE_U4_SIZE_MASK);
+		DART_OUT(DART_BASE_U4, base);
+		DART_OUT(DART_SIZE_U4, size);
+		DART_OUT(DART_CNTL, DART_CNTL_U4_ENABLE);
+	} else {
+		BUG_ON(size & ~DART_CNTL_U3_SIZE_MASK);
+		DART_OUT(DART_CNTL,
+			 DART_CNTL_U3_ENABLE |
+			 (base << DART_CNTL_U3_BASE_SHIFT) |
+			 (size << DART_CNTL_U3_SIZE_SHIFT));
+	}
+
+	/* Invalidate DART to get rid of possible stale TLBs */
+	dart_tlb_invalidate_all();
+
+	printk(KERN_INFO "DART IOMMU initialized for %s type chipset\n",
+	       dart_is_u4 ? "U4" : "U3");
+
+	return 0;
+}
+
+static void iommu_table_dart_setup(void)
+{
+	iommu_table_dart.it_busno = 0;
+	iommu_table_dart.it_offset = 0;
+	/* it_size is in number of entries */
+	iommu_table_dart.it_size = (dart_tablesize / sizeof(u32)) >> DART_PAGE_FACTOR;
+
+	/* Initialize the common IOMMU code */
+	iommu_table_dart.it_base = (unsigned long)dart_vbase;
+	iommu_table_dart.it_index = 0;
+	iommu_table_dart.it_blocksize = 1;
+	iommu_init_table(&iommu_table_dart);
+
+	/* Reserve the last page of the DART to avoid possible prefetch
+	 * past the DART mapped area
+	 */
+	set_bit(iommu_table_dart.it_size - 1, iommu_table_dart.it_map);
+}
+
+static void iommu_dev_setup_dart(struct pci_dev *dev)
+{
+	struct device_node *dn;
+
+	/* We only have one iommu table on the mac for now, which makes
+	 * things simple. Setup all PCI devices to point to this table
+	 *
+	 * We must use pci_device_to_OF_node() to make sure that
+	 * we get the real "final" pointer to the device in the
+	 * pci_dev sysdata and not the temporary PHB one
+	 */
+	dn = pci_device_to_OF_node(dev);
+
+	if (dn)
+		PCI_DN(dn)->iommu_table = &iommu_table_dart;
+}
+
+static void iommu_bus_setup_dart(struct pci_bus *bus)
+{
+	struct device_node *dn;
+
+	if (!iommu_table_dart_inited) {
+		iommu_table_dart_inited = 1;
+		iommu_table_dart_setup();
+	}
+
+	dn = pci_bus_to_OF_node(bus);
+
+	if (dn)
+		PCI_DN(dn)->iommu_table = &iommu_table_dart;
+}
+
+static void iommu_dev_setup_null(struct pci_dev *dev) { }
+static void iommu_bus_setup_null(struct pci_bus *bus) { }
+
+void iommu_init_early_dart(void)
+{
+	struct device_node *dn;
+
+	/* Find the DART in the device-tree */
+	dn = of_find_compatible_node(NULL, "dart", "u3-dart");
+	if (dn == NULL) {
+		dn = of_find_compatible_node(NULL, "dart", "u4-dart");
+		if (dn == NULL)
+			goto bail;
+		dart_is_u4 = 1;
+	}
+
+	/* Setup low level TCE operations for the core IOMMU code */
+	ppc_md.tce_build = dart_build;
+	ppc_md.tce_free  = dart_free;
+	ppc_md.tce_flush = dart_flush;
+
+	/* Initialize the DART HW */
+	if (dart_init(dn) == 0) {
+		ppc_md.iommu_dev_setup = iommu_dev_setup_dart;
+		ppc_md.iommu_bus_setup = iommu_bus_setup_dart;
+
+		/* Setup pci_dma ops */
+		pci_iommu_init();
+
+		return;
+	}
+
+ bail:
+	/* If init failed, use direct iommu and null setup functions */
+	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
+	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+
+	/* Setup pci_dma ops */
+	pci_direct_iommu_init();
+}
+
+
+void __init alloc_dart_table(void)
+{
+	/* Only reserve DART space if machine has more than 2GB of RAM
+	 * or if requested with iommu=on on cmdline.
+	 */
+	if (lmb_end_of_DRAM() <= 0x80000000ull && !iommu_force_on)
+		return;
+
+	/* 512 pages (2MB) is max DART tablesize. */
+	dart_tablesize = 1UL << 21;
+	/* 16MB (1 << 24) alignment. We allocate a full 16Mb chuck since we
+	 * will blow up an entire large page anyway in the kernel mapping
+	 */
+	dart_tablebase = (unsigned long)
+		abs_to_virt(lmb_alloc_base(1UL<<24, 1UL<<24, 0x80000000L));
+
+	printk(KERN_INFO "DART table allocated at: %lx\n", dart_tablebase);
+}
Index: linux-work/include/asm-powerpc/iommu.h
===================================================================
--- linux-work.orig/include/asm-powerpc/iommu.h	2005-11-24 17:21:41.000000000 +1100
+++ linux-work/include/asm-powerpc/iommu.h	2005-12-14 12:54:36.000000000 +1100
@@ -56,7 +56,7 @@ struct device_node;
 
 /* Walks all buses and creates iommu tables */
 extern void iommu_setup_pSeries(void);
-extern void iommu_setup_u3(void);
+extern void iommu_setup_dart(void);
 
 /* Frees table for an individual device node */
 extern void iommu_free_table(struct device_node *dn);
@@ -104,7 +104,7 @@ extern void iommu_unmap_single(struct io
 
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_iSeries(void);
-extern void iommu_init_early_u3(void);
+extern void iommu_init_early_dart(void);
 
 #ifdef CONFIG_PCI
 extern void pci_iommu_init(void);
@@ -113,6 +113,6 @@ extern void pci_direct_iommu_init(void);
 static inline void pci_iommu_init(void) { }
 #endif
 
-extern void alloc_u3_dart_table(void);
+extern void alloc_dart_table(void);
 
 #endif /* _ASM_IOMMU_H */
