Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDFBCDDFBE
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:29 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] [POWERPC] Merge ppc32 and ppc64
	pcibios_alloc_controller() prototypes
Date: Wed, 27 Jun 2007 13:19:15 -0500
Message-Id: <11829683691025-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683663762-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
	<11829683631074-git-send-email-galak@kernel.crashing.org>
	<11829683663762-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the ppc32 pcibios_alloc_controller take a device node to match
the ppc64 prototypes and have it set arch_data.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c                     |    3 ++-
 arch/powerpc/platforms/52xx/efika.c              |    3 +--
 arch/powerpc/platforms/52xx/mpc52xx_pci.c        |    4 +---
 arch/powerpc/platforms/82xx/mpc82xx_ads.c        |    4 +---
 arch/powerpc/platforms/83xx/pci.c                |    3 +--
 arch/powerpc/platforms/85xx/pci.c                |    3 +--
 arch/powerpc/platforms/86xx/pci.c                |    4 ++--
 arch/powerpc/platforms/chrp/pci.c                |    3 +--
 arch/powerpc/platforms/embedded6xx/linkstation.c |    3 +--
 arch/powerpc/platforms/powermac/pci.c            |    6 ------
 arch/powerpc/sysdev/mv64x60_pci.c                |    4 +---
 arch/powerpc/sysdev/tsi108_pci.c                 |    3 +--
 include/asm-powerpc/pci-bridge.h                 |    8 +++-----
 13 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 56deb31..df3251c 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -610,7 +610,7 @@ pcibios_enable_resources(struct pci_dev *dev, int mask)
 static int next_controller_index;
 
 struct pci_controller * __init
-pcibios_alloc_controller(void)
+pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *hose;
 
@@ -621,6 +621,7 @@ pcibios_alloc_controller(void)
 	hose_tail = &hose->next;
 
 	hose->global_number = next_controller_index++;
+	hose->arch_data = dev;
 
 	return hose;
 }
diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
index 010be5c..0256423 100644
--- a/arch/powerpc/platforms/52xx/efika.c
+++ b/arch/powerpc/platforms/52xx/efika.c
@@ -128,7 +128,7 @@ void __init efika_pcisetup(void)
 	printk(" controlled by %s\n", pcictrl->full_name);
 	printk("\n");
 
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(of_node_get(pcictrl));
 	if (!hose) {
 		printk(KERN_WARNING EFIKA_PLATFORM_NAME
 		       ": Can't allocate PCI controller structure for %s\n",
@@ -136,7 +136,6 @@ void __init efika_pcisetup(void)
 		return;
 	}
 
-	hose->arch_data = of_node_get(pcictrl);
 	hose->first_busno = bus_range[0];
 	hose->last_busno = bus_range[1];
 	hose->ops = &rtas_pci_ops;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 69a0421..4c6c82a 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -385,12 +385,10 @@ mpc52xx_add_bridge(struct device_node *node)
 	 * tree are needed to configure the 52xx PCI controller.  Rather
 	 * than parse the tree here, let pci_process_bridge_OF_ranges()
 	 * do it for us and extract the values after the fact */
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(node);
 	if (!hose)
 		return -ENOMEM;
 
-	hose->arch_data = node;
-
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
diff --git a/arch/powerpc/platforms/82xx/mpc82xx_ads.c b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
index d1e0919..da20832 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -543,13 +543,11 @@ static void __init mpc82xx_add_bridge(struct device_node *np)
 
 	pci_assign_all_buses = 1;
 
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(np);
 
 	if (!hose)
 		return;
 
-	hose->arch_data = np;
-
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
diff --git a/arch/powerpc/platforms/83xx/pci.c b/arch/powerpc/platforms/83xx/pci.c
index f49ed27..c0e2b89 100644
--- a/arch/powerpc/platforms/83xx/pci.c
+++ b/arch/powerpc/platforms/83xx/pci.c
@@ -62,10 +62,9 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	}
 
 	pci_assign_all_buses = 1;
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
-	hose->arch_data = dev;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index a25b3e7..8118417 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -56,10 +56,9 @@ int __init mpc85xx_add_bridge(struct device_node *dev)
 	}
 
 	pci_assign_all_buses = 1;
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
-	hose->arch_data = dev;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index 2d7254c..5cb2188 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -196,10 +196,10 @@ int __init mpc86xx_add_bridge(struct device_node *dev)
 		       " bus 0\n", dev->full_name);
 
 	pci_assign_all_buses = 1;
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
-	hose->arch_data = dev;
+
 	hose->indirect_type = PPC_INDIRECT_TYPE_EXT_REG |
 				PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
 
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index d840863..3690624 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -254,13 +254,12 @@ chrp_find_bridges(void)
 			printk(" at %llx", (unsigned long long)r.start);
 		printk("\n");
 
-		hose = pcibios_alloc_controller();
+		hose = pcibios_alloc_controller(dev);
 		if (!hose) {
 			printk("Can't allocate PCI controller structure for %s\n",
 				dev->full_name);
 			continue;
 		}
-		hose->arch_data = dev;
 		hose->first_busno = bus_range[0];
 		hose->last_busno = bus_range[1];
 
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 885c789..f4d0a7a 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -68,12 +68,11 @@ static int __init linkstation_add_bridge(struct device_node *dev)
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 				" bus 0\n", dev->full_name);
 
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(dev);
 	if (hose == NULL)
 		return -ENOMEM;
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-	hose->arch_data = dev;
 	setup_indirect_pci(hose, 0xfec00000, 0xfee00000);
 
 	/* Interpret the "ranges" property */
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index fb853c0..92586db 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -916,15 +916,9 @@ static int __init pmac_add_bridge(struct device_node *dev)
 		       " bus 0\n", dev->full_name);
 	}
 
-	/* XXX Different prototypes, to be merged */
-#ifdef CONFIG_PPC64
 	hose = pcibios_alloc_controller(dev);
-#else
-	hose = pcibios_alloc_controller();
-#endif
 	if (!hose)
 		return -ENOMEM;
-	hose->arch_data = dev;
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 2e77384..45db86c 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -137,12 +137,10 @@ static int __init mv64x60_add_bridge(struct device_node *dev)
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 		       " bus 0\n", dev->full_name);
 
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
 
-	hose->arch_data = dev;
-
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 298e2dd..90db8a7 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -221,13 +221,12 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
 		       " bus 0\n", dev->full_name);
 	}
 
-	hose = pcibios_alloc_controller();
+	hose = pcibios_alloc_controller(dev);
 
 	if (!hose) {
 		printk("PCI Host bridge init failed\n");
 		return -ENOMEM;
 	}
-	hose->arch_data = dev;
 
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 80cfb4a..d5a9c9f 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -9,9 +9,6 @@
 struct device_node;
 struct pci_controller;
 
-/* Allocate a new PCI host bridge structure */
-extern struct pci_controller* pcibios_alloc_controller(void);
-
 /* Get the PCI host controller for a bus */
 extern struct pci_controller* pci_bus_to_hose(int bus);
 
@@ -232,8 +229,6 @@ static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
 	return PCI_DN(busdn)->phb;
 }
 
-extern struct pci_controller *
-pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
 
 extern void isa_bridge_find_early(struct pci_controller *hose);
@@ -263,6 +258,9 @@ extern void
 pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			   struct device_node *dev, int primary);
 
+/* Allocate a new PCI host bridge structure */
+extern struct pci_controller *
+pcibios_alloc_controller(struct device_node *dev);
 #ifdef CONFIG_PCI
 extern unsigned long pci_address_to_pio(phys_addr_t address);
 #else
-- 
1.5.2.1
