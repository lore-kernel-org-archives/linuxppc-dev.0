Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 283/493] powerpc: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:52 -0500
Message-Id: <1353349642-3677-283-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: cbe-oss-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>,
 Olof Johansson <olof@lixom.net>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Josh Boyer <jwboyer@gmail.com> 
Cc: Matt Porter <mporter@kernel.crashing.org> 
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: Anatolij Gustschin <agust@denx.de> 
Cc: Kumar Gala <galak@kernel.crashing.org> 
Cc: Olof Johansson <olof@lixom.net> 
Cc: Geoff Levand <geoff@infradead.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
---
 arch/powerpc/include/asm/eeh.h                 |  6 ++---
 arch/powerpc/include/asm/io-workarounds.h      |  2 +-
 arch/powerpc/include/asm/parport.h             |  2 +-
 arch/powerpc/include/asm/smp.h                 |  4 +--
 arch/powerpc/include/asm/vio.h                 |  2 +-
 arch/powerpc/kernel/io-workarounds.c           |  4 +--
 arch/powerpc/kernel/isa-bridge.c               |  6 ++---
 arch/powerpc/kernel/of_platform.c              |  2 +-
 arch/powerpc/kernel/pci-common.c               | 22 ++++++++--------
 arch/powerpc/kernel/pci_32.c                   |  2 +-
 arch/powerpc/kernel/pci_64.c                   |  6 ++---
 arch/powerpc/kernel/pci_dn.c                   |  4 +--
 arch/powerpc/kernel/pci_of_scan.c              |  8 +++---
 arch/powerpc/kernel/rtas_pci.c                 |  4 +--
 arch/powerpc/kernel/smp-tbsync.c               |  8 +++---
 arch/powerpc/kernel/smp.c                      |  8 +++---
 arch/powerpc/kernel/vio.c                      |  4 +--
 arch/powerpc/platforms/44x/currituck.c         |  2 +-
 arch/powerpc/platforms/44x/virtex_ml510.c      |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c      |  6 ++---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c  |  2 +-
 arch/powerpc/platforms/82xx/ep8248e.c          |  2 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c      |  2 +-
 arch/powerpc/platforms/85xx/tqm85xx.c          |  2 +-
 arch/powerpc/platforms/86xx/gef_ppc9a.c        |  2 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c       |  2 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c       |  2 +-
 arch/powerpc/platforms/cell/setup.c            |  2 +-
 arch/powerpc/platforms/cell/smp.c              |  6 ++---
 arch/powerpc/platforms/chrp/pci.c              |  2 +-
 arch/powerpc/platforms/chrp/smp.c              |  4 +--
 arch/powerpc/platforms/fsl_uli1575.c           | 20 +++++++-------
 arch/powerpc/platforms/maple/pci.c             |  4 +--
 arch/powerpc/platforms/pasemi/gpio_mdio.c      |  2 +-
 arch/powerpc/platforms/pasemi/pasemi.h         |  4 +--
 arch/powerpc/platforms/pasemi/setup.c          |  4 +--
 arch/powerpc/platforms/powermac/pci.c          |  6 ++---
 arch/powerpc/platforms/powermac/smp.c          |  8 +++---
 arch/powerpc/platforms/powernv/pci-ioda.c      | 36 +++++++++++++-------------
 arch/powerpc/platforms/powernv/pci-p5ioc2.c    |  2 +-
 arch/powerpc/platforms/powernv/pci.c           |  9 +++----
 arch/powerpc/platforms/powernv/smp.c           |  2 +-
 arch/powerpc/platforms/ps3/repository.c        |  2 +-
 arch/powerpc/platforms/pseries/eeh_dev.c       |  4 +--
 arch/powerpc/platforms/pseries/eeh_pe.c        |  2 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c     |  2 +-
 arch/powerpc/platforms/pseries/smp.c           |  6 ++---
 arch/powerpc/platforms/wsp/scom_smp.c          |  2 +-
 arch/powerpc/platforms/wsp/smp.c               |  4 +--
 arch/powerpc/platforms/wsp/wsp.h               |  2 +-
 arch/powerpc/platforms/wsp/wsp_pci.c           |  2 +-
 arch/powerpc/sysdev/bestcomm/bestcomm.c        |  5 ++--
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c          |  2 +-
 arch/powerpc/sysdev/fsl_ifc.c                  |  4 +--
 arch/powerpc/sysdev/fsl_lbc.c                  |  4 +--
 arch/powerpc/sysdev/fsl_msi.c                  |  4 +--
 arch/powerpc/sysdev/fsl_pci.c                  |  4 +--
 arch/powerpc/sysdev/fsl_rio.c                  |  2 +-
 arch/powerpc/sysdev/mpic.c                     |  2 +-
 arch/powerpc/sysdev/mpic_msgr.c                |  2 +-
 arch/powerpc/sysdev/mv64x60_pci.c              |  2 +-
 arch/powerpc/sysdev/ppc4xx_msi.c               |  2 +-
 63 files changed, 144 insertions(+), 146 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b0ef738..a8fb03e 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -183,7 +183,7 @@ static inline void eeh_unlock(void)
 #define EEH_MAX_ALLOWED_FREEZES 5
 
 typedef void *(*eeh_traverse_func)(void *data, void *flag);
-int __devinit eeh_phb_pe_create(struct pci_controller *phb);
+int eeh_phb_pe_create(struct pci_controller *phb);
 int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev, int purge_pe);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
@@ -191,8 +191,8 @@ void *eeh_pe_dev_traverse(struct eeh_pe *root,
 void eeh_pe_restore_bars(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 
-void * __devinit eeh_dev_init(struct device_node *dn, void *data);
-void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
+void *eeh_dev_init(struct device_node *dn, void *data);
+void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 unsigned long eeh_check_failure(const volatile void __iomem *token,
diff --git a/arch/powerpc/include/asm/io-workarounds.h b/arch/powerpc/include/asm/io-workarounds.h
index fbae492..9b6fa3d 100644
--- a/arch/powerpc/include/asm/io-workarounds.h
+++ b/arch/powerpc/include/asm/io-workarounds.h
@@ -31,7 +31,7 @@ struct iowa_bus {
 	void   *private;
 };
 
-void __devinit iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
+void iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
 				 int (*)(struct iowa_bus *, void *), void *);
 struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR);
 struct iowa_bus *iowa_pio_find_bus(unsigned long);
diff --git a/arch/powerpc/include/asm/parport.h b/arch/powerpc/include/asm/parport.h
index 1ca1102..6dc2577 100644
--- a/arch/powerpc/include/asm/parport.h
+++ b/arch/powerpc/include/asm/parport.h
@@ -12,7 +12,7 @@
 
 #include <asm/prom.h>
 
-static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
+static int parport_pc_find_nonpci_ports (int autoirq, int autodma)
 {
 	struct device_node *np;
 	const u32 *prop;
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 5a4e437..195ce2a 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -54,8 +54,8 @@ struct smp_ops_t {
 
 extern void smp_send_debugger_break(void);
 extern void start_secondary_resume(void);
-extern void __devinit smp_generic_give_timebase(void);
-extern void __devinit smp_generic_take_timebase(void);
+extern void smp_generic_give_timebase(void);
+extern void smp_generic_take_timebase(void);
 
 DECLARE_PER_CPU(unsigned int, cpu_pvr);
 
diff --git a/arch/powerpc/include/asm/vio.h b/arch/powerpc/include/asm/vio.h
index df81cb7..68d0cc9 100644
--- a/arch/powerpc/include/asm/vio.h
+++ b/arch/powerpc/include/asm/vio.h
@@ -139,7 +139,7 @@ extern void vio_unregister_driver(struct vio_driver *drv);
 extern int vio_cmo_entitlement_update(size_t);
 extern void vio_cmo_set_dev_desired(struct vio_dev *viodev, size_t desired);
 
-extern void __devinit vio_unregister_device(struct vio_dev *dev);
+extern void vio_unregister_device(struct vio_dev *dev);
 
 extern int vio_h_cop_sync(struct vio_dev *vdev, struct vio_pfo_op *op);
 
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index 12d329b..34b909c 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -146,7 +146,7 @@ static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
 }
 
 /* Enable IO workaround */
-static void __devinit io_workaround_init(void)
+static void io_workaround_init(void)
 {
 	static int io_workaround_inited;
 
@@ -158,7 +158,7 @@ static void __devinit io_workaround_init(void)
 }
 
 /* Register new bus to support workaround */
-void __devinit iowa_register_bus(struct pci_controller *phb,
+void iowa_register_bus(struct pci_controller *phb,
 			struct ppc_pci_io *ops,
 			int (*initfunc)(struct iowa_bus *, void *), void *data)
 {
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index d45ec58..af9104cb 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -41,7 +41,7 @@ EXPORT_SYMBOL_GPL(isa_bridge_pcidev);
 #define ISA_SPACE_MASK 0x1
 #define ISA_SPACE_IO 0x1
 
-static void __devinit pci_process_ISA_OF_ranges(struct device_node *isa_node,
+static void pci_process_ISA_OF_ranges(struct device_node *isa_node,
 						unsigned long phb_io_base_phys)
 {
 	/* We should get some saner parsing here and remove these structs */
@@ -170,7 +170,7 @@ void __init isa_bridge_find_early(struct pci_controller *hose)
  * isa_bridge_find_late - Find and map the ISA IO space upon discovery of
  *                        a new ISA bridge
  */
-static void __devinit isa_bridge_find_late(struct pci_dev *pdev,
+static void isa_bridge_find_late(struct pci_dev *pdev,
 					   struct device_node *devnode)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
@@ -215,7 +215,7 @@ static void isa_bridge_remove(void)
 /**
  * isa_bridge_notify - Get notified of PCI devices addition/removal
  */
-static int __devinit isa_bridge_notify(struct notifier_block *nb,
+static int isa_bridge_notify(struct notifier_block *nb,
 				       unsigned long action, void *data)
 {
 	struct device *dev = data;
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 2049f2d..0a3b438 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -37,7 +37,7 @@
  * lacking some bits needed here.
  */
 
-static int __devinit of_pci_phb_probe(struct platform_device *dev)
+static int of_pci_phb_probe(struct platform_device *dev)
 {
 	struct pci_controller *phb;
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index abc0d08..c25463e 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -673,7 +673,7 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
  *   - Some 32 bits platforms such as 4xx can have physical space larger than
  *     32 bits so we need to use 64 bits values for the parsing
  */
-void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
+void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 					    struct device_node *dev,
 					    int primary)
 {
@@ -848,7 +848,7 @@ int pci_proc_domain(struct pci_bus *bus)
 /* This header fixup will do the resource fixup for all devices as they are
  * probed, but not for bridge ranges
  */
-static void __devinit pcibios_fixup_resources(struct pci_dev *dev)
+static void pcibios_fixup_resources(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	int i;
@@ -902,7 +902,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
  * things go more smoothly when it gets it right. It should covers cases such
  * as Apple "closed" bridge resources and bare-metal pSeries unassigned bridges
  */
-static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
+static int pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 							   struct resource *res)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
@@ -967,7 +967,7 @@ static int __devinit pcibios_uninitialized_bridge_resource(struct pci_bus *bus,
 }
 
 /* Fixup resources of a PCI<->PCI bridge */
-static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
+static void pcibios_fixup_bridge(struct pci_bus *bus)
 {
 	struct resource *res;
 	int i;
@@ -1007,7 +1007,7 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
 	}
 }
 
-void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
+void pcibios_setup_bus_self(struct pci_bus *bus)
 {
 	/* Fix up the bus resources for P2P bridges */
 	if (bus->self != NULL)
@@ -1024,7 +1024,7 @@ void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
 		ppc_md.pci_dma_bus_setup(bus);
 }
 
-void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
+void pcibios_setup_bus_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
@@ -1063,7 +1063,7 @@ void pcibios_set_master(struct pci_dev *dev)
 	/* No special bus mastering setup handling */
 }
 
-void __devinit pcibios_fixup_bus(struct pci_bus *bus)
+void pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* When called from the generic PCI probe, read PCI<->PCI bridge
 	 * bases. This is -not- called when generating the PCI tree from
@@ -1080,7 +1080,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
 
-void __devinit pci_fixup_cardbus(struct pci_bus *bus)
+void pci_fixup_cardbus(struct pci_bus *bus)
 {
 	/* Now fixup devices on that bus */
 	pcibios_setup_bus_devices(bus);
@@ -1264,7 +1264,7 @@ void pcibios_allocate_bus_resources(struct pci_bus *bus)
 		pcibios_allocate_bus_resources(b);
 }
 
-static inline void __devinit alloc_resource(struct pci_dev *dev, int idx)
+static inline void alloc_resource(struct pci_dev *dev, int idx)
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
@@ -1500,7 +1500,7 @@ resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
 	return (unsigned long) hose->io_base_virt - _IO_BASE;
 }
 
-static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
+static void pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
 {
 	struct resource *res;
 	int i;
@@ -1639,7 +1639,7 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
  * pci_scan_phb - Given a pci_controller, setup and scan the PCI bus
  * @hose: Pointer to the PCI host controller instance structure
  */
-void __devinit pcibios_scan_phb(struct pci_controller *hose)
+void pcibios_scan_phb(struct pci_controller *hose)
 {
 	LIST_HEAD(resources);
 	struct pci_bus *bus;
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 64f526a..e37c215 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -213,7 +213,7 @@ pci_create_OF_bus_map(void)
 	}
 }
 
-void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
+void pcibios_setup_phb_io_space(struct pci_controller *hose)
 {
 	unsigned long io_offset;
 	struct resource *res = &hose->io_resource;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 2cbe676..51a133a 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -122,7 +122,7 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_unmap_io_space);
 
-static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
+static int pcibios_map_phb_io_space(struct pci_controller *hose)
 {
 	struct vm_struct *area;
 	unsigned long phys_page;
@@ -173,7 +173,7 @@ static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
 	return 0;
 }
 
-int __devinit pcibios_map_io_space(struct pci_bus *bus)
+int pcibios_map_io_space(struct pci_bus *bus)
 {
 	WARN_ON(bus == NULL);
 
@@ -193,7 +193,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_map_io_space);
 
-void __devinit pcibios_setup_phb_io_space(struct pci_controller *hose)
+void pcibios_setup_phb_io_space(struct pci_controller *hose)
 {
 	pcibios_map_phb_io_space(hose);
 }
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index dd9e4a0..e7af165 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -36,7 +36,7 @@
  * Traverse_func that inits the PCI fields of the device node.
  * NOTE: this *must* be done before read/write config to the device.
  */
-void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
+void *update_dn_pci_info(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
 	const int *type =
@@ -129,7 +129,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
  * subsystem is set up, before kmalloc is valid) and during the 
  * dynamic lpar operation of adding a PHB to a running system.
  */
-void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
+void pci_devs_phb_init_dynamic(struct pci_controller *phb)
 {
 	struct device_node *dn = phb->dn;
 	struct pci_dn *pdn;
diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 30378a1..562317d 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -204,7 +204,7 @@ EXPORT_SYMBOL(of_create_pci_dev);
  * this routine in turn call of_scan_bus() recusively to scan for more child
  * devices.
  */
-void __devinit of_scan_pci_bridge(struct pci_dev *dev)
+void of_scan_pci_bridge(struct pci_dev *dev)
 {
 	struct device_node *node = dev->dev.of_node;
 	struct pci_bus *bus;
@@ -299,7 +299,7 @@ EXPORT_SYMBOL(of_scan_pci_bridge);
  * @bus: pci_bus structure for the PCI bus
  * @rescan_existing: Flag indicating bus has already been set up
  */
-static void __devinit __of_scan_bus(struct device_node *node,
+static void __of_scan_bus(struct device_node *node,
 				    struct pci_bus *bus, int rescan_existing)
 {
 	struct device_node *child;
@@ -348,7 +348,7 @@ static void __devinit __of_scan_bus(struct device_node *node,
  * @node: device tree node for the PCI bus
  * @bus: pci_bus structure for the PCI bus
  */
-void __devinit of_scan_bus(struct device_node *node,
+void of_scan_bus(struct device_node *node,
 			   struct pci_bus *bus)
 {
 	__of_scan_bus(node, bus, 0);
@@ -363,7 +363,7 @@ EXPORT_SYMBOL_GPL(of_scan_bus);
  * Same as of_scan_bus, but for a pci_bus structure that has already been
  * setup.
  */
-void __devinit of_rescan_bus(struct device_node *node,
+void of_rescan_bus(struct device_node *node,
 			     struct pci_bus *bus)
 {
 	__of_scan_bus(node, bus, 1);
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 6de63e3..71cb20d 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -209,7 +209,7 @@ void __init init_pci_config_tokens (void)
 	ibm_write_pci_config = rtas_token("ibm,write-pci-config");
 }
 
-unsigned long __devinit get_phb_buid (struct device_node *phb)
+unsigned long get_phb_buid (struct device_node *phb)
 {
 	struct resource r;
 
@@ -237,7 +237,7 @@ static int phb_set_bus_ranges(struct device_node *dev,
 	return 0;
 }
 
-int __devinit rtas_setup_phb(struct pci_controller *phb)
+int rtas_setup_phb(struct pci_controller *phb)
 {
 	struct device_node *dev = phb->dn;
 
diff --git a/arch/powerpc/kernel/smp-tbsync.c b/arch/powerpc/kernel/smp-tbsync.c
index 640de83..e68fd1a 100644
--- a/arch/powerpc/kernel/smp-tbsync.c
+++ b/arch/powerpc/kernel/smp-tbsync.c
@@ -36,13 +36,13 @@ static struct {
 
 static volatile int		running;
 
-static void __devinit enter_contest(u64 mark, long add)
+static void enter_contest(u64 mark, long add)
 {
 	while (get_tb() < mark)
 		tbsync->race_result = add;
 }
 
-void __devinit smp_generic_take_timebase(void)
+void smp_generic_take_timebase(void)
 {
 	int cmd;
 	u64 tb;
@@ -75,7 +75,7 @@ void __devinit smp_generic_take_timebase(void)
 	local_irq_restore(flags);
 }
 
-static int __devinit start_contest(int cmd, long offset, int num)
+static int start_contest(int cmd, long offset, int num)
 {
 	int i, score=0;
 	u64 tb;
@@ -110,7 +110,7 @@ static int __devinit start_contest(int cmd, long offset, int num)
 	return score;
 }
 
-void __devinit smp_generic_give_timebase(void)
+void smp_generic_give_timebase(void)
 {
 	int i, score, score2, old, min=0, max=5000, offset=1000;
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e5b133e..793401e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -82,7 +82,7 @@ int smt_enabled_at_boot = 1;
 static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
 
 #ifdef CONFIG_PPC64
-int __devinit smp_generic_kick_cpu(int nr)
+int smp_generic_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
@@ -311,7 +311,7 @@ void smp_send_stop(void)
 
 struct thread_info *current_set[NR_CPUS];
 
-static void __devinit smp_store_cpu_info(int id)
+static void smp_store_cpu_info(int id)
 {
 	per_cpu(cpu_pvr, id) = mfspr(SPRN_PVR);
 #ifdef CONFIG_PPC_FSL_BOOK3E
@@ -355,7 +355,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		max_cpus = 1;
 }
 
-void __devinit smp_prepare_boot_cpu(void)
+void smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != boot_cpuid);
 #ifdef CONFIG_PPC64
@@ -610,7 +610,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
 }
 
 /* Activate a secondary processor. */
-void __devinit start_secondary(void *unused)
+void start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
 	struct device_node *l2_cache;
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 201ba59..536016d 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1289,7 +1289,7 @@ void vio_unregister_driver(struct vio_driver *viodrv)
 EXPORT_SYMBOL(vio_unregister_driver);
 
 /* vio_dev refcount hit 0 */
-static void __devinit vio_dev_release(struct device *dev)
+static void vio_dev_release(struct device *dev)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
@@ -1545,7 +1545,7 @@ static struct device_attribute vio_dev_attrs[] = {
 	__ATTR_NULL
 };
 
-void __devinit vio_unregister_device(struct vio_dev *viodev)
+void vio_unregister_device(struct vio_dev *viodev)
 {
 	device_unregister(&viodev->dev);
 }
diff --git a/arch/powerpc/platforms/44x/currituck.c b/arch/powerpc/platforms/44x/currituck.c
index 6bd89a0..ecd3890 100644
--- a/arch/powerpc/platforms/44x/currituck.c
+++ b/arch/powerpc/platforms/44x/currituck.c
@@ -46,7 +46,7 @@ static __initdata struct of_device_id ppc47x_of_bus[] = {
 
 /* The EEPROM is missing and the default values are bogus.  This forces USB in
  * to EHCI mode */
-static void __devinit quirk_ppc_currituck_usb_fixup(struct pci_dev *dev)
+static void quirk_ppc_currituck_usb_fixup(struct pci_dev *dev)
 {
 	if (of_machine_is_compatible("ibm,currituck")) {
 		pci_write_config_dword(dev, 0xe0, 0x0114231f);
diff --git a/arch/powerpc/platforms/44x/virtex_ml510.c b/arch/powerpc/platforms/44x/virtex_ml510.c
index ba4a6e3..1fdb874 100644
--- a/arch/powerpc/platforms/44x/virtex_ml510.c
+++ b/arch/powerpc/platforms/44x/virtex_ml510.c
@@ -5,7 +5,7 @@
 /**
  * ml510_ail_quirk
  */
-static void __devinit ml510_ali_quirk(struct pci_dev *dev)
+static void ml510_ali_quirk(struct pci_dev *dev)
 {
 	/* Enable the IDE controller */
 	pci_write_config_byte(dev, 0x58, 0x4c);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 028470b..871a1ba 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -669,7 +669,7 @@ static struct miscdevice mpc52xx_wdt_miscdev = {
 	.fops		= &mpc52xx_wdt_fops,
 };
 
-static int __devinit mpc52xx_gpt_wdt_init(void)
+static int mpc52xx_gpt_wdt_init(void)
 {
 	int err;
 
@@ -704,7 +704,7 @@ static int mpc52xx_gpt_wdt_setup(struct mpc52xx_gpt_priv *gpt,
 
 #else
 
-static int __devinit mpc52xx_gpt_wdt_init(void)
+static int mpc52xx_gpt_wdt_init(void)
 {
 	return 0;
 }
@@ -720,7 +720,7 @@ static inline int mpc52xx_gpt_wdt_setup(struct mpc52xx_gpt_priv *gpt,
 /* ---------------------------------------------------------------------
  * of_platform bus binding code
  */
-static int __devinit mpc52xx_gpt_probe(struct platform_device *ofdev)
+static int mpc52xx_gpt_probe(struct platform_device *ofdev)
 {
 	struct mpc52xx_gpt_priv *gpt;
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 459fa49..b89e02f 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -470,7 +470,7 @@ void mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req)
 }
 EXPORT_SYMBOL(mpc52xx_lpbfifo_abort);
 
-static int __devinit mpc52xx_lpbfifo_probe(struct platform_device *op)
+static int mpc52xx_lpbfifo_probe(struct platform_device *op)
 {
 	struct resource res;
 	int rc = -ENOMEM;
diff --git a/arch/powerpc/platforms/82xx/ep8248e.c b/arch/powerpc/platforms/82xx/ep8248e.c
index 10ff526..79799b2 100644
--- a/arch/powerpc/platforms/82xx/ep8248e.c
+++ b/arch/powerpc/platforms/82xx/ep8248e.c
@@ -111,7 +111,7 @@ static struct mdiobb_ctrl ep8248e_mdio_ctrl = {
 	.ops = &ep8248e_mdio_ops,
 };
 
-static int __devinit ep8248e_mdio_probe(struct platform_device *ofdev)
+static int ep8248e_mdio_probe(struct platform_device *ofdev)
 {
 	struct mii_bus *bus;
 	struct resource res;
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index fe27e4a..712a436 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -145,7 +145,7 @@ static int mcu_gpiochip_remove(struct mcu *mcu)
 	return gpiochip_remove(&mcu->gc);
 }
 
-static int __devinit mcu_probe(struct i2c_client *client,
+static int mcu_probe(struct i2c_client *client,
 			       const struct i2c_device_id *id)
 {
 	struct mcu *mcu;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index c474505..7a31a0e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -154,7 +154,7 @@ static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 	}
 }
 
-static void __devinit skip_fake_bridge(struct pci_dev *dev)
+static void skip_fake_bridge(struct pci_dev *dev)
 {
 	/* Make it an error to skip the fake bridge
 	 * in pci_setup_device() in probe.c */
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index b4e58cd..ec0b727 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -85,7 +85,7 @@ static void tqm85xx_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 }
 
-static void __devinit tqm85xx_ti1520_fixup(struct pci_dev *pdev)
+static void tqm85xx_ti1520_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index bf53387..c23f3443 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -159,7 +159,7 @@ static void gef_ppc9a_show_cpuinfo(struct seq_file *m)
 		gef_ppc9a_get_vme_is_syscon() ? "yes" : "no");
 }
 
-static void __devinit gef_ppc9a_nec_fixup(struct pci_dev *pdev)
+static void gef_ppc9a_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 0b78513..8a6ac20 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -146,7 +146,7 @@ static void gef_sbc310_show_cpuinfo(struct seq_file *m)
 
 }
 
-static void __devinit gef_sbc310_nec_fixup(struct pci_dev *pdev)
+static void gef_sbc310_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index b9eb174..06c7263 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -136,7 +136,7 @@ static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 }
 
-static void __devinit gef_sbc610_nec_fixup(struct pci_dev *pdev)
+static void gef_sbc610_nec_fixup(struct pci_dev *pdev)
 {
 	unsigned int val;
 
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 4ab0876..6ae25fb 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -117,7 +117,7 @@ static void cell_fixup_pcie_rootcomplex(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, cell_fixup_pcie_rootcomplex);
 
-static int __devinit cell_setup_phb(struct pci_controller *phb)
+static int cell_setup_phb(struct pci_controller *phb)
 {
 	const char *model;
 	struct device_node *np;
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index 49a65e2..d35dbbc 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -67,7 +67,7 @@ static cpumask_t of_spin_map;
  *	0	- failure
  *	1	- success
  */
-static inline int __devinit smp_startup_cpu(unsigned int lcpu)
+static inline int smp_startup_cpu(unsigned int lcpu)
 {
 	int status;
 	unsigned long start_here = __pa((u32)*((unsigned long *)
@@ -108,7 +108,7 @@ static int __init smp_iic_probe(void)
 	return cpumask_weight(cpu_possible_mask);
 }
 
-static void __devinit smp_cell_setup_cpu(int cpu)
+static void smp_cell_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		iic_setup_cpu();
@@ -119,7 +119,7 @@ static void __devinit smp_cell_setup_cpu(int cpu)
 	mtspr(SPRN_DABRX, DABRX_KERNEL | DABRX_USER);
 }
 
-static int __devinit smp_cell_kick_cpu(int nr)
+static int smp_cell_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 83285c5..1b87e19 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -323,7 +323,7 @@ chrp_find_bridges(void)
  * ATA controller to be set to fully native mode or bad things
  * will happen.
  */
-static void __devinit chrp_pci_fixup_winbond_ata(struct pci_dev *sl82c105)
+static void chrp_pci_fixup_winbond_ata(struct pci_dev *sl82c105)
 {
 	u8 progif;
 
diff --git a/arch/powerpc/platforms/chrp/smp.c b/arch/powerpc/platforms/chrp/smp.c
index feab30b..dead91b 100644
--- a/arch/powerpc/platforms/chrp/smp.c
+++ b/arch/powerpc/platforms/chrp/smp.c
@@ -30,7 +30,7 @@
 #include <asm/mpic.h>
 #include <asm/rtas.h>
 
-static int __devinit smp_chrp_kick_cpu(int nr)
+static int smp_chrp_kick_cpu(int nr)
 {
 	*(unsigned long *)KERNELBASE = nr;
 	asm volatile("dcbf 0,%0"::"r"(KERNELBASE):"memory");
@@ -38,7 +38,7 @@ static int __devinit smp_chrp_kick_cpu(int nr)
 	return 0;
 }
 
-static void __devinit smp_chrp_setup_cpu(int cpu_nr)
+static void smp_chrp_setup_cpu(int cpu_nr)
 {
 	mpic_setup_this_cpu();
 }
diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 64fde05..92ac9b5 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -59,7 +59,7 @@ static inline bool is_quirk_valid(void)
 }
 
 /* Bridge */
-static void __devinit early_uli5249(struct pci_dev *dev)
+static void early_uli5249(struct pci_dev *dev)
 {
 	unsigned char temp;
 
@@ -82,7 +82,7 @@ static void __devinit early_uli5249(struct pci_dev *dev)
 }
 
 
-static void __devinit quirk_uli1575(struct pci_dev *dev)
+static void quirk_uli1575(struct pci_dev *dev)
 {
 	int i;
 
@@ -139,7 +139,7 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 	pci_write_config_byte(dev, 0x75, ULI_8259_IRQ15);
 }
 
-static void __devinit quirk_final_uli1575(struct pci_dev *dev)
+static void quirk_final_uli1575(struct pci_dev *dev)
 {
 	/* Set i8259 interrupt trigger
 	 * IRQ 3:  Level
@@ -175,7 +175,7 @@ static void __devinit quirk_final_uli1575(struct pci_dev *dev)
 }
 
 /* SATA */
-static void __devinit quirk_uli5288(struct pci_dev *dev)
+static void quirk_uli5288(struct pci_dev *dev)
 {
 	unsigned char c;
 	unsigned int d;
@@ -200,7 +200,7 @@ static void __devinit quirk_uli5288(struct pci_dev *dev)
 }
 
 /* PATA */
-static void __devinit quirk_uli5229(struct pci_dev *dev)
+static void quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned short temp;
 
@@ -216,7 +216,7 @@ static void __devinit quirk_uli5229(struct pci_dev *dev)
 }
 
 /* We have to do a dummy read on the P2P for the RTC to work, WTF */
-static void __devinit quirk_final_uli5249(struct pci_dev *dev)
+static void quirk_final_uli5249(struct pci_dev *dev)
 {
 	int i;
 	u8 *dummy;
@@ -253,7 +253,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5249, quirk_final_uli5249);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x1575, quirk_final_uli1575);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
 
-static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
+static void hpcd_quirk_uli1575(struct pci_dev *dev)
 {
 	u32 temp32;
 
@@ -269,7 +269,7 @@ static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
 	pci_write_config_dword(dev, 0x90, (temp32 | 1<<22));
 }
 
-static void __devinit hpcd_quirk_uli5288(struct pci_dev *dev)
+static void hpcd_quirk_uli5288(struct pci_dev *dev)
 {
 	unsigned char c;
 
@@ -295,7 +295,7 @@ static void __devinit hpcd_quirk_uli5288(struct pci_dev *dev)
  * IRQ14 is a sideband interrupt from IDE device to CPU and we use this
  * as the interrupt for IDE device.
  */
-static void __devinit hpcd_quirk_uli5229(struct pci_dev *dev)
+static void hpcd_quirk_uli5229(struct pci_dev *dev)
 {
 	unsigned char c;
 
@@ -317,7 +317,7 @@ static void __devinit hpcd_quirk_uli5229(struct pci_dev *dev)
  * bug by re-assigning a correct irq to 5288.
  *
  */
-static void __devinit hpcd_final_uli5288(struct pci_dev *dev)
+static void hpcd_final_uli5288(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct device_node *hosenode = hose ? hose->dn : NULL;
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 465ee8f..f7136aa 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -543,7 +543,7 @@ static int __init maple_add_bridge(struct device_node *dev)
 }
 
 
-void __devinit maple_pci_irq_fixup(struct pci_dev *dev)
+void maple_pci_irq_fixup(struct pci_dev *dev)
 {
 	DBG(" -> maple_pci_irq_fixup\n");
 
@@ -648,7 +648,7 @@ int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
 	return irq;
 }
 
-static void __devinit quirk_ipr_msi(struct pci_dev *dev)
+static void quirk_ipr_msi(struct pci_dev *dev)
 {
 	/* Something prevents MSIs from the IPR from working on Bimini,
 	 * and the driver has no smarts to recover. So disable MSI
diff --git a/arch/powerpc/platforms/pasemi/gpio_mdio.c b/arch/powerpc/platforms/pasemi/gpio_mdio.c
index 9886296..0237ab7 100644
--- a/arch/powerpc/platforms/pasemi/gpio_mdio.c
+++ b/arch/powerpc/platforms/pasemi/gpio_mdio.c
@@ -216,7 +216,7 @@ static int gpio_mdio_reset(struct mii_bus *bus)
 }
 
 
-static int __devinit gpio_mdio_probe(struct platform_device *ofdev)
+static int gpio_mdio_probe(struct platform_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index b1e524f..ea65bf0 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -3,8 +3,8 @@
 
 extern unsigned long pas_get_boot_time(void);
 extern void pas_pci_init(void);
-extern void __devinit pas_pci_irq_fixup(struct pci_dev *dev);
-extern void __devinit pas_pci_dma_dev_setup(struct pci_dev *dev);
+extern void pas_pci_irq_fixup(struct pci_dev *dev);
+extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
 
 extern void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 2ed9212..8c54de6d 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -76,7 +76,7 @@ static void pas_restart(char *cmd)
 static arch_spinlock_t timebase_lock;
 static unsigned long timebase;
 
-static void __devinit pas_give_timebase(void)
+static void pas_give_timebase(void)
 {
 	unsigned long flags;
 
@@ -94,7 +94,7 @@ static void __devinit pas_give_timebase(void)
 	local_irq_restore(flags);
 }
 
-static void __devinit pas_take_timebase(void)
+static void pas_take_timebase(void)
 {
 	while (!timebase)
 		smp_rmb();
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 43bbe1b..2b8af75 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -561,7 +561,7 @@ static struct pci_ops u4_pcie_pci_ops =
 	.write = u4_pcie_write_config,
 };
 
-static void __devinit pmac_pci_fixup_u4_of_node(struct pci_dev *dev)
+static void pmac_pci_fixup_u4_of_node(struct pci_dev *dev)
 {
 	/* Apple's device-tree "hides" the root complex virtual P2P bridge
 	 * on U4. However, Linux sees it, causing the PCI <-> OF matching
@@ -988,7 +988,7 @@ static int __init pmac_add_bridge(struct device_node *dev)
 	return 0;
 }
 
-void __devinit pmac_pci_irq_fixup(struct pci_dev *dev)
+void pmac_pci_irq_fixup(struct pci_dev *dev)
 {
 #ifdef CONFIG_PPC32
 	/* Fixup interrupt for the modem/ethernet combo controller.
@@ -1138,7 +1138,7 @@ int pmac_pci_enable_device_hook(struct pci_dev *dev)
 	return 0;
 }
 
-void __devinit pmac_pci_fixup_ohci(struct pci_dev *dev)
+void pmac_pci_fixup_ohci(struct pci_dev *dev)
 {
 	struct device_node *node = pci_device_to_OF_node(dev);
 
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index b4ddaa3..bdb738a 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -484,7 +484,7 @@ static void smp_core99_give_timebase(void)
 }
 
 
-static void __devinit smp_core99_take_timebase(void)
+static void smp_core99_take_timebase(void)
 {
 	unsigned long flags;
 
@@ -669,7 +669,7 @@ static void smp_core99_gpio_tb_freeze(int freeze)
 volatile static long int core99_l2_cache;
 volatile static long int core99_l3_cache;
 
-static void __devinit core99_init_caches(int cpu)
+static void core99_init_caches(int cpu)
 {
 #ifndef CONFIG_PPC64
 	if (!cpu_has_feature(CPU_FTR_L2CR))
@@ -801,7 +801,7 @@ static int __init smp_core99_probe(void)
 	return ncpus;
 }
 
-static int __devinit smp_core99_kick_cpu(int nr)
+static int smp_core99_kick_cpu(int nr)
 {
 	unsigned int save_vector;
 	unsigned long target, flags;
@@ -844,7 +844,7 @@ static int __devinit smp_core99_kick_cpu(int nr)
 	return 0;
 }
 
-static void __devinit smp_core99_setup_cpu(int cpu_nr)
+static void smp_core99_setup_cpu(int cpu_nr)
 {
 	/* Setup L2/L3 */
 	if (cpu_nr != 0)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 53d052e..bfa0887 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -76,7 +76,7 @@ static struct pci_dn *pnv_ioda_get_pdn(struct pci_dev *dev)
 	return PCI_DN(np);
 }
 
-static int __devinit pnv_ioda_alloc_pe(struct pnv_phb *phb)
+static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe;
 
@@ -91,7 +91,7 @@ static int __devinit pnv_ioda_alloc_pe(struct pnv_phb *phb)
 	return pe;
 }
 
-static void __devinit pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
+static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
 {
 	WARN_ON(phb->ioda.pe_array[pe].pdev);
 
@@ -103,7 +103,7 @@ static void __devinit pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
  * but in the meantime, we need to protect them to avoid warnings
  */
 #ifdef CONFIG_PCI_MSI
-static struct pnv_ioda_pe * __devinit pnv_ioda_get_pe(struct pci_dev *dev)
+static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -117,7 +117,7 @@ static struct pnv_ioda_pe * __devinit pnv_ioda_get_pe(struct pci_dev *dev)
 }
 #endif /* CONFIG_PCI_MSI */
 
-static int __devinit pnv_ioda_configure_pe(struct pnv_phb *phb,
+static int pnv_ioda_configure_pe(struct pnv_phb *phb,
 					   struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -207,7 +207,7 @@ static int __devinit pnv_ioda_configure_pe(struct pnv_phb *phb,
 	return 0;
 }
 
-static void __devinit pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
+static void pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
 						 struct pnv_ioda_pe *pe)
 {
 	struct pnv_ioda_pe *lpe;
@@ -246,7 +246,7 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 }
 
 #if 0
-static struct pnv_ioda_pe * __devinit pnv_ioda_setup_dev_PE(struct pci_dev *dev)
+static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -343,7 +343,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
  * subordinate PCI devices and buses. The second type of PE is normally
  * orgiriated by PCIe-to-PCI bridge or PLX switch downstream ports.
  */
-static void __devinit pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
+static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -399,7 +399,7 @@ static void __devinit pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	pnv_ioda_link_pe_by_weight(phb, pe);
 }
 
-static void __devinit pnv_ioda_setup_PEs(struct pci_bus *bus)
+static void pnv_ioda_setup_PEs(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
@@ -423,7 +423,7 @@ static void __devinit pnv_ioda_setup_PEs(struct pci_bus *bus)
  * port to PE# here. The game rule here is expected to be changed
  * as soon as we can detected PLX bridge correctly.
  */
-static void __devinit pnv_pci_ioda_setup_PEs(void)
+static void pnv_pci_ioda_setup_PEs(void)
 {
 	struct pci_controller *hose, *tmp;
 
@@ -432,13 +432,13 @@ static void __devinit pnv_pci_ioda_setup_PEs(void)
 	}
 }
 
-static void __devinit pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb,
+static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb,
 						 struct pci_dev *dev)
 {
 	/* We delay DMA setup after we have assigned all PE# */
 }
 
-static void __devinit pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
+static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 					     struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -450,7 +450,7 @@ static void __devinit pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	}
 }
 
-static void __devinit pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
+static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 						struct pnv_ioda_pe *pe,
 						unsigned int base,
 						unsigned int segs)
@@ -541,7 +541,7 @@ static void __devinit pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
 
-static void __devinit pnv_ioda_setup_dma(struct pnv_phb *phb)
+static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 {
 	struct pci_controller *hose = phb->hose;
 	unsigned int residual, remaining, segs, tw, base;
@@ -684,7 +684,7 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
  * to bottom style. So the the I/O or MMIO segment assigned to
  * parent PE could be overrided by its child PEs if necessary.
  */
-static void __devinit pnv_ioda_setup_pe_seg(struct pci_controller *hose,
+static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 				struct pnv_ioda_pe *pe)
 {
 	struct pnv_phb *phb = hose->private_data;
@@ -753,7 +753,7 @@ static void __devinit pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 	}
 }
 
-static void __devinit pnv_pci_ioda_setup_seg(void)
+static void pnv_pci_ioda_setup_seg(void)
 {
 	struct pci_controller *tmp, *hose;
 	struct pnv_phb *phb;
@@ -767,7 +767,7 @@ static void __devinit pnv_pci_ioda_setup_seg(void)
 	}
 }
 
-static void __devinit pnv_pci_ioda_setup_DMA(void)
+static void pnv_pci_ioda_setup_DMA(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct pnv_phb *phb;
@@ -781,7 +781,7 @@ static void __devinit pnv_pci_ioda_setup_DMA(void)
 	}
 }
 
-static void __devinit pnv_pci_ioda_fixup(void)
+static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
 	pnv_pci_ioda_setup_seg();
@@ -829,7 +829,7 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
-static int __devinit pnv_pci_enable_device_hook(struct pci_dev *dev)
+static int pnv_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 6b4bef4..2230a5c 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -84,7 +84,7 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb)
 static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
 #endif /* CONFIG_PCI_MSI */
 
-static void __devinit pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
+static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 						   struct pci_dev *pdev)
 {
 	if (phb->p5ioc2.iommu_table.it_map == NULL)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c01688a..ae4b062 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -464,8 +464,7 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 	tbl->it_type = TCE_PCI;
 }
 
-static struct iommu_table * __devinit
-pnv_pci_setup_bml_iommu(struct pci_controller *hose)
+static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 {
 	struct iommu_table *tbl;
 	const __be64 *basep, *swinvp;
@@ -496,7 +495,7 @@ pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 	return tbl;
 }
 
-static void __devinit pnv_pci_dma_fallback_setup(struct pci_controller *hose,
+static void pnv_pci_dma_fallback_setup(struct pci_controller *hose,
 						 struct pci_dev *pdev)
 {
 	struct device_node *np = pci_bus_to_OF_node(hose->bus);
@@ -512,7 +511,7 @@ static void __devinit pnv_pci_dma_fallback_setup(struct pci_controller *hose,
 	set_iommu_table_base(&pdev->dev, pdn->iommu_table);
 }
 
-static void __devinit pnv_pci_dma_dev_setup(struct pci_dev *pdev)
+static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -527,7 +526,7 @@ static void __devinit pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 }
 
 /* Fixup wrong class code in p7ioc root complex */
-static void __devinit pnv_p7ioc_rc_quirk(struct pci_dev *dev)
+static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 7698b6e..0bdc735 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -62,7 +62,7 @@ static int pnv_smp_cpu_bootable(unsigned int nr)
 	return 1;
 }
 
-int __devinit pnv_smp_kick_cpu(int nr)
+int pnv_smp_kick_cpu(int nr)
 {
 	unsigned int pcpu = get_hard_smp_processor_id(nr);
 	unsigned long start_here = __pa(*((unsigned long *)
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 9b47ba7..bfccdc7 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -437,7 +437,7 @@ found_dev:
 	return 0;
 }
 
-int __devinit ps3_repository_find_devices(enum ps3_bus_type bus_type,
+int ps3_repository_find_devices(enum ps3_bus_type bus_type,
 	int (*callback)(const struct ps3_repository_device *repo))
 {
 	int result = 0;
diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
index 6644234..1efa28f 100644
--- a/arch/powerpc/platforms/pseries/eeh_dev.c
+++ b/arch/powerpc/platforms/pseries/eeh_dev.c
@@ -49,7 +49,7 @@
  * It will create EEH device according to the given OF node. The function
  * might be called by PCI emunation, DR, PHB hotplug.
  */
-void * __devinit eeh_dev_init(struct device_node *dn, void *data)
+void *eeh_dev_init(struct device_node *dn, void *data)
 {
 	struct pci_controller *phb = data;
 	struct eeh_dev *edev;
@@ -77,7 +77,7 @@ void * __devinit eeh_dev_init(struct device_node *dn, void *data)
  * Scan the PHB OF node and its child association, then create the
  * EEH devices accordingly
  */
-void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb)
+void eeh_dev_phb_init_dynamic(struct pci_controller *phb)
 {
 	struct device_node *dn = phb->dn;
 
diff --git a/arch/powerpc/platforms/pseries/eeh_pe.c b/arch/powerpc/platforms/pseries/eeh_pe.c
index 797cd18..2845c1e 100644
--- a/arch/powerpc/platforms/pseries/eeh_pe.c
+++ b/arch/powerpc/platforms/pseries/eeh_pe.c
@@ -66,7 +66,7 @@ static struct eeh_pe *eeh_pe_alloc(struct pci_controller *phb, int type)
  * The function should be called while the PHB is detected during
  * system boot or PCI hotplug in order to create PHB PE.
  */
-int __devinit eeh_phb_pe_create(struct pci_controller *phb)
+int eeh_phb_pe_create(struct pci_controller *phb)
 {
 	struct eeh_pe *pe;
 
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 261a577..c91b22b 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -149,7 +149,7 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
 
-struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
+struct pci_controller *init_phb_dynamic(struct device_node *dn)
 {
 	struct pci_controller *phb;
 
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 9fc0a49..80cd0be 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -87,7 +87,7 @@ int smp_query_cpu_stopped(unsigned int pcpu)
  *	0	- failure
  *	1	- success
  */
-static inline int __devinit smp_startup_cpu(unsigned int lcpu)
+static inline int smp_startup_cpu(unsigned int lcpu)
 {
 	int status;
 	unsigned long start_here = __pa((u32)*((unsigned long *)
@@ -133,7 +133,7 @@ out:
 	return 1;
 }
 
-static void __devinit smp_xics_setup_cpu(int cpu)
+static void smp_xics_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
@@ -148,7 +148,7 @@ static void __devinit smp_xics_setup_cpu(int cpu)
 #endif
 }
 
-static int __devinit smp_pSeries_kick_cpu(int nr)
+static int smp_pSeries_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
diff --git a/arch/powerpc/platforms/wsp/scom_smp.c b/arch/powerpc/platforms/wsp/scom_smp.c
index 141e780..c9d016b 100644
--- a/arch/powerpc/platforms/wsp/scom_smp.c
+++ b/arch/powerpc/platforms/wsp/scom_smp.c
@@ -337,7 +337,7 @@ scom_fail:
 	return rc;
 }
 
-int __devinit a2_scom_startup_cpu(unsigned int lcpu, int thr_idx,
+int a2_scom_startup_cpu(unsigned int lcpu, int thr_idx,
 				  struct device_node *np)
 {
 	u64 init_iar, init_msr, init_ccr2;
diff --git a/arch/powerpc/platforms/wsp/smp.c b/arch/powerpc/platforms/wsp/smp.c
index 0ba103a..332a18b 100644
--- a/arch/powerpc/platforms/wsp/smp.c
+++ b/arch/powerpc/platforms/wsp/smp.c
@@ -23,7 +23,7 @@
 #include "ics.h"
 #include "wsp.h"
 
-static void __devinit smp_a2_setup_cpu(int cpu)
+static void smp_a2_setup_cpu(int cpu)
 {
 	doorbell_setup_this_cpu();
 
@@ -31,7 +31,7 @@ static void __devinit smp_a2_setup_cpu(int cpu)
 		xics_setup_cpu();
 }
 
-int __devinit smp_a2_kick_cpu(int nr)
+int smp_a2_kick_cpu(int nr)
 {
 	const char *enable_method;
 	struct device_node *np;
diff --git a/arch/powerpc/platforms/wsp/wsp.h b/arch/powerpc/platforms/wsp/wsp.h
index 10c1d1f..62ef21a 100644
--- a/arch/powerpc/platforms/wsp/wsp.h
+++ b/arch/powerpc/platforms/wsp/wsp.h
@@ -18,7 +18,7 @@ extern void a2_setup_smp(void);
 extern int a2_scom_startup_cpu(unsigned int lcpu, int thr_idx,
 			       struct device_node *np);
 extern int smp_a2_cpu_bootable(unsigned int nr);
-extern int __devinit smp_a2_kick_cpu(int nr);
+extern int smp_a2_kick_cpu(int nr);
 
 extern void opb_pic_init(void);
 
diff --git a/arch/powerpc/platforms/wsp/wsp_pci.c b/arch/powerpc/platforms/wsp/wsp_pci.c
index 1526551..8e22f56 100644
--- a/arch/powerpc/platforms/wsp/wsp_pci.c
+++ b/arch/powerpc/platforms/wsp/wsp_pci.c
@@ -402,7 +402,7 @@ static struct wsp_dma_table *wsp_pci_create_dma32_table(struct wsp_phb *phb,
 	return ERR_PTR(-ENOMEM);
 }
 
-static void __devinit wsp_pci_dma_dev_setup(struct pci_dev *pdev)
+static void wsp_pci_dma_dev_setup(struct pci_dev *pdev)
 {
 	struct dev_archdata *archdata = &pdev->dev.archdata;
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index b3fbb27..4c15b19 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -273,8 +273,7 @@ static u32 fdt_ops[] = {
 };
 
 
-static int __devinit
-bcom_engine_init(void)
+static int bcom_engine_init(void)
 {
 	int task;
 	phys_addr_t tdt_pa, ctx_pa, var_pa, fdt_pa;
@@ -365,7 +364,7 @@ bcom_engine_cleanup(void)
 /* OF platform driver                                                       */
 /* ======================================================================== */
 
-static int __devinit mpc52xx_bcom_probe(struct platform_device *op)
+static int mpc52xx_bcom_probe(struct platform_device *op)
 {
 	struct device_node *ofn_sram;
 	struct resource res_bcom;
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index 103c94a..d06bfa1 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -69,7 +69,7 @@ static int __init get_offset_from_cmdline(char *str)
 __setup("cache-sram-size=", get_size_from_cmdline);
 __setup("cache-sram-offset=", get_offset_from_cmdline);
 
-static int __devinit mpc85xx_l2ctlr_of_probe(struct platform_device *dev)
+static int mpc85xx_l2ctlr_of_probe(struct platform_device *dev)
 {
 	long rval;
 	unsigned int rem;
diff --git a/arch/powerpc/sysdev/fsl_ifc.c b/arch/powerpc/sysdev/fsl_ifc.c
index 097cc9d2..2a36fd6 100644
--- a/arch/powerpc/sysdev/fsl_ifc.c
+++ b/arch/powerpc/sysdev/fsl_ifc.c
@@ -73,7 +73,7 @@ int fsl_ifc_find(phys_addr_t addr_base)
 }
 EXPORT_SYMBOL(fsl_ifc_find);
 
-static int __devinit fsl_ifc_ctrl_init(struct fsl_ifc_ctrl *ctrl)
+static int fsl_ifc_ctrl_init(struct fsl_ifc_ctrl *ctrl)
 {
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 
@@ -211,7 +211,7 @@ static irqreturn_t fsl_ifc_ctrl_irq(int irqno, void *data)
  * resources for the NAND banks themselves are allocated
  * in the chip probe function.
 */
-static int __devinit fsl_ifc_ctrl_probe(struct platform_device *dev)
+static int fsl_ifc_ctrl_probe(struct platform_device *dev)
 {
 	int ret = 0;
 
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 483126d..d6fde86 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -185,7 +185,7 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
 }
 EXPORT_SYMBOL(fsl_upm_run_pattern);
 
-static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl,
+static int fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl,
 				       struct device_node *node)
 {
 	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
@@ -273,7 +273,7 @@ static irqreturn_t fsl_lbc_ctrl_irq(int irqno, void *data)
  * in the chip probe function.
 */
 
-static int __devinit fsl_lbc_ctrl_probe(struct platform_device *dev)
+static int fsl_lbc_ctrl_probe(struct platform_device *dev)
 {
 	int ret;
 
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 63c5f04..d4b32ad 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -333,7 +333,7 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 	return 0;
 }
 
-static int __devinit fsl_msi_setup_hwirq(struct fsl_msi *msi,
+static int fsl_msi_setup_hwirq(struct fsl_msi *msi,
 					 struct platform_device *dev,
 					 int offset, int irq_index)
 {
@@ -363,7 +363,7 @@ static int __devinit fsl_msi_setup_hwirq(struct fsl_msi *msi,
 }
 
 static const struct of_device_id fsl_of_msi_ids[];
-static int __devinit fsl_of_msi_probe(struct platform_device *dev)
+static int fsl_of_msi_probe(struct platform_device *dev)
 {
 	const struct of_device_id *match;
 	struct fsl_msi *msi;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index ffb93ae..7e08aad 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -36,7 +36,7 @@
 
 static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
-static void __devinit quirk_fsl_pcie_header(struct pci_dev *dev)
+static void quirk_fsl_pcie_header(struct pci_dev *dev)
 {
 	u8 hdr_type;
 
@@ -871,7 +871,7 @@ void fsl_pci_assign_primary(void)
 	}
 }
 
-static int __devinit fsl_pci_probe(struct platform_device *pdev)
+static int fsl_pci_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct device_node *node;
diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 5b6f556..e2fb317 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -644,7 +644,7 @@ err_rio_regs:
 
 /* The probe function for RapidIO peer-to-peer network.
  */
-static int __devinit fsl_of_rio_rpn_probe(struct platform_device *dev)
+static int fsl_of_rio_rpn_probe(struct platform_device *dev)
 {
 	printk(KERN_INFO "Setting up RapidIO peer-to-peer network %s\n",
 			dev->dev.of_node->full_name);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9c6e535..3b2efd4 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1864,7 +1864,7 @@ int __init smp_mpic_probe(void)
 	return nr_cpus;
 }
 
-void __devinit smp_mpic_setup_cpu(int cpu)
+void smp_mpic_setup_cpu(int cpu)
 {
 	mpic_setup_this_cpu();
 }
diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msgr.c
index e961f8c..c753258 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -160,7 +160,7 @@ static int mpic_msgr_block_number(struct device_node *node)
 
 /* The probe function for a single message register block.
  */
-static __devinit int mpic_msgr_probe(struct platform_device *dev)
+static int mpic_msgr_probe(struct platform_device *dev)
 {
 	void __iomem *msgr_block_addr;
 	int block_number;
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 364b14d..330d566 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -104,7 +104,7 @@ subsys_initcall(mv64x60_sysfs_init);
 
 #endif /* CONFIG_SYSFS */
 
-static void __devinit mv64x60_pci_fixup_early(struct pci_dev *dev)
+static void mv64x60_pci_fixup_early(struct pci_dev *dev)
 {
 	/*
 	 * Set the host bridge hdr_type to an invalid value so that
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 82c6702..43948da 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -220,7 +220,7 @@ static int ppc4xx_of_msi_remove(struct platform_device *dev)
 	return 0;
 }
 
-static int __devinit ppc4xx_msi_probe(struct platform_device *dev)
+static int ppc4xx_msi_probe(struct platform_device *dev)
 {
 	struct ppc4xx_msi *msi;
 	struct resource res;
-- 
1.8.0
