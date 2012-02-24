Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D34F4B6FBB
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:35 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 10:29:27 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9X2773588136
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:33:02 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cNDl007731
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:23 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/21] Introduce EEH device
Date: Fri, 24 Feb 2012 17:38:11 +0800
Message-Id: <1330076298-7006-15-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: kernel.crashing.org@shangw, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Original EEH implementation depends on struct pci_dn heavily. However,
EEH shouldn't depend on that actually because EEH needn't share much
information with other PCI components. That's to say, EEH should have
worked independently.

The patch introduces struct eeh_dev so that EEH core components needn't
be working based on struct pci_dn in future. Also, struct pci_dn, struct
eeh_dev instances are created in dynamic fasion and the binding with EEH
device, OF node, PCI device is implemented as well.

The EEH devices are created after PHBs are detected and initialized, but
PCI emunation hasn't started yet. Apart from that, PHB might be created
dynamically through DLPAR component and the EEH devices should be creatd
as well. Another case might be OF node is created dynamically by DR
(Dynamic Reconfiguration), which has been defined by PAPR. For those OF
nodes created by DR, EEH devices should be also created accordingly. The
binding between EEH device and OF node is done while the EEH device is
initially created.

The binding between EEH device and PCI device should be done after PCI
emunation is done. Besides, PCI hotplug also needs the binding so that
the EEH devices could be traced from the newly coming PCI buses or PCI
devices.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/device.h          |    3 ++
 arch/powerpc/include/asm/eeh.h             |   51 ++++++++++++++++++++++++----
 arch/powerpc/kernel/of_platform.c          |    3 ++
 arch/powerpc/kernel/rtas_pci.c             |    3 ++
 arch/powerpc/platforms/pseries/Makefile    |    3 +-
 arch/powerpc/platforms/pseries/pci_dlpar.c |    3 ++
 arch/powerpc/platforms/pseries/setup.c     |    6 +++-
 include/linux/of.h                         |    3 ++
 8 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index d57c08a..4668344 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -31,6 +31,9 @@ struct dev_archdata {
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
+#ifdef CONFIG_EEH
+	void			*edev;
+#endif
 };
 
 struct pdev_archdata {
diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ad8f318..1310971 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -32,6 +32,37 @@ struct device_node;
 #ifdef CONFIG_EEH
 
 /*
+ * The struct is used to trace EEH state for the associated
+ * PCI device node or PCI device. In future, it might
+ * represent PE as well so that the EEH device to form
+ * another tree except the currently existing tree of PCI
+ * buses and PCI devices
+ */
+#define EEH_MODE_SUPPORTED	(1<<0)	/* EEH supported on the device	*/
+#define EEH_MODE_NOCHECK	(1<<1)	/* EEH check should be skipped	*/
+#define EEH_MODE_ISOLATED	(1<<2)	/* The device has been isolated	*/
+#define EEH_MODE_RECOVERING	(1<<3)	/* Recovering the device	*/
+#define EEH_MODE_IRQ_DISABLED	(1<<4)	/* Interrupt disabled		*/
+
+struct eeh_dev {
+	int mode;			/* EEH mode			*/
+	int class_code;			/* Class code of the device	*/
+	int config_addr;		/* Config address		*/
+	int pe_config_addr;		/* PE config address		*/
+	int check_count;		/* Times of ignored error	*/
+	int freeze_count;		/* Times of froze up		*/
+	int false_positives;		/* Times of reported #ff's	*/
+	u32 config_space[16];		/* Saved PCI config space	*/
+	struct pci_controller *phb;	/* Associated PHB		*/
+	struct device_node *dn;		/* Associated device node	*/
+	struct pci_dev *pdev;		/* Associated PCI device	*/
+};
+#define EEH_DEV_TO_OF_NODE(edev)	(edev->dn)
+#define EEH_DEV_TO_PCI_DEV(edev)	(edev->pdev)
+#define OF_NODE_TO_EEH_DEV(dn)		((struct eeh_dev *)(dn->edev))
+#define PCI_DEV_TO_EEH_DEV(pdev)	((struct eeh_dev *)(pdev->dev.archdata.edev))
+
+/*
  * The struct is used to trace the registered EEH operation
  * callback functions. Actually, those operation callback
  * functions are heavily platform dependent. That means the
@@ -70,19 +101,15 @@ struct eeh_ops {
 extern struct eeh_ops *eeh_ops;
 extern int eeh_subsystem_enabled;
 
-/* Values for eeh_mode bits in device_node */
-#define EEH_MODE_SUPPORTED     (1<<0)
-#define EEH_MODE_NOCHECK       (1<<1)
-#define EEH_MODE_ISOLATED      (1<<2)
-#define EEH_MODE_RECOVERING    (1<<3)
-#define EEH_MODE_IRQ_DISABLED  (1<<4)
-
 /*
  * Max number of EEH freezes allowed before we consider the device
  * to be permanently disabled.
  */
 #define EEH_MAX_ALLOWED_FREEZES 5
 
+void * __devinit eeh_dev_init(struct device_node *dn, void *data);
+void __devinit eeh_dev_phb_init_dynamic(struct pci_controller *phb);
+void __init eeh_dev_phb_init(void);
 void __init eeh_init(void);
 #ifdef CONFIG_PPC_PSERIES
 int __init eeh_pseries_init(void);
@@ -113,6 +140,16 @@ void eeh_remove_bus_device(struct pci_dev *);
 #define EEH_IO_ERROR_VALUE(size)	(~0U >> ((4 - (size)) * 8))
 
 #else /* !CONFIG_EEH */
+
+static inline void *eeh_dev_init(struct device_node *dn, void *data)
+{
+	return NULL;
+}
+
+static inline void eeh_dev_phb_init_dynamic(struct pci_controller *phb) { }
+
+static inline void eeh_dev_phb_init(void) { }
+
 static inline void eeh_init(void) { }
 
 #ifdef CONFIG_PPC_PSERIES
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index e1612df..9239c3a 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -66,6 +66,9 @@ static int __devinit of_pci_phb_probe(struct platform_device *dev)
 	/* Init pci_dn data structures */
 	pci_devs_phb_init_dynamic(phb);
 
+	/* Create EEH devices for the PHB */
+	eeh_dev_phb_init_dynamic(phb);
+
 	/* Register devices with EEH */
 #ifdef CONFIG_EEH
 	if (dev->dev.of_node->child)
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 6cd8f01..517bd86 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -275,6 +275,9 @@ void __init find_and_init_phbs(void)
 	of_node_put(root);
 	pci_devs_phb_init();
 
+	/* Create EEH devices for all PHBs */
+	eeh_dev_phb_init();
+
 	/*
 	 * pci_probe_only and pci_assign_all_buses can be set via properties
 	 * in chosen.
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 9aa5581..12dae0b 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -6,7 +6,8 @@ obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
 			   firmware.o power.o dlpar.o mobility.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
-obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh_sysfs.o eeh_pseries.o
+obj-$(CONFIG_EEH)	+= eeh.o eeh_dev.o eeh_cache.o eeh_driver.o \
+			   eeh_event.o eeh_sysfs.o eeh_pseries.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PSERIES_MSI)	+= msi.o
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 55d4ec1..fbb21fc 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -147,6 +147,9 @@ struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
 
 	pci_devs_phb_init_dynamic(phb);
 
+	/* Create EEH devices for the PHB */
+	eeh_dev_phb_init_dynamic(phb);
+
 	if (dn->child)
 		eeh_add_device_tree_early(dn);
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 809d9d9..60f9462 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -261,8 +261,12 @@ static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long act
 	switch (action) {
 	case PSERIES_RECONFIG_ADD:
 		pci = np->parent->data;
-		if (pci)
+		if (pci) {
 			update_dn_pci_info(np, pci->phb);
+
+			/* Create EEH device for the OF node */
+			eeh_dev_init(np, pci->phb);
+		}
 		break;
 	default:
 		err = NOTIFY_DONE;
diff --git a/include/linux/of.h b/include/linux/of.h
index a75a831..61863a9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -58,6 +58,9 @@ struct device_node {
 	struct	kref kref;
 	unsigned long _flags;
 	void	*data;
+#if defined(CONFIG_EEH)
+	void	*edev;
+#endif
 #if defined(CONFIG_SPARC)
 	char	*path_component_name;
 	unsigned int unique_id;
-- 
1.7.5.4
