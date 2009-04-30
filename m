Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07328DE10C
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 23:10:29 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 9/9] powerpc/pci: clean up direct access to sysdata by celleb
	platforms
Date: Thu, 30 Apr 2009 08:10:15 -0500
Message-Id: <1241097015-11208-9-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1241097015-11208-8-git-send-email-galak@kernel.crashing.org>
References: <1241097015-11208-1-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-2-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-3-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-4-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-5-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-6-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-7-git-send-email-galak@kernel.crashing.org>
	<1241097015-11208-8-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We shouldn't directly access sysdata to get the device node to just
go get the pci_controller.  We can call pci_bus_to_host() for this
purpose.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/cell/celleb_pci.c       |   10 ++--------
 arch/powerpc/platforms/cell/celleb_scc_epci.c  |   13 ++-----------
 arch/powerpc/platforms/cell/celleb_scc_pciex.c |   12 ++----------
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index f39a3b2..00eaaa7 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -162,8 +162,7 @@ static int celleb_fake_pci_read_config(struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 *val)
 {
 	char *config;
-	struct device_node *node;
-	struct pci_controller *hose;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	unsigned int devno = devfn >> 3;
 	unsigned int fn = devfn & 0x7;
 
@@ -171,8 +170,6 @@ static int celleb_fake_pci_read_config(struct pci_bus *bus,
 	BUG_ON(where % size);
 
 	pr_debug("    fake read: bus=0x%x, ", bus->number);
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
 	config = get_fake_config_start(hose, devno, fn);
 
 	pr_debug("devno=0x%x, where=0x%x, size=0x%x, ", devno, where, size);
@@ -192,8 +189,7 @@ static int celleb_fake_pci_write_config(struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 val)
 {
 	char *config;
-	struct device_node *node;
-	struct pci_controller *hose;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct celleb_pci_resource *res;
 	unsigned int devno = devfn >> 3;
 	unsigned int fn = devfn & 0x7;
@@ -201,8 +197,6 @@ static int celleb_fake_pci_write_config(struct pci_bus *bus,
 	/* allignment check */
 	BUG_ON(where % size);
 
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
 	config = get_fake_config_start(hose, devno, fn);
 
 	if (!config)
diff --git a/arch/powerpc/platforms/cell/celleb_scc_epci.c b/arch/powerpc/platforms/cell/celleb_scc_epci.c
index 48ec88a..05b0db3 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_epci.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_epci.c
@@ -134,15 +134,11 @@ static int celleb_epci_read_config(struct pci_bus *bus,
 {
 	PCI_IO_ADDR epci_base;
 	PCI_IO_ADDR addr;
-	struct device_node *node;
-	struct pci_controller *hose;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 
 	/* allignment check */
 	BUG_ON(where % size);
 
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
-
 	if (!celleb_epci_get_epci_cfg(hose))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -198,16 +194,11 @@ static int celleb_epci_write_config(struct pci_bus *bus,
 {
 	PCI_IO_ADDR epci_base;
 	PCI_IO_ADDR addr;
-	struct device_node *node;
-	struct pci_controller *hose;
+	struct pci_controller *hose = pci_bus_to_host(bus);
 
 	/* allignment check */
 	BUG_ON(where % size);
 
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
-
-
 	if (!celleb_epci_get_epci_cfg(hose))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
diff --git a/arch/powerpc/platforms/cell/celleb_scc_pciex.c b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
index 3e7e0f1..7fca09f 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_pciex.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
@@ -366,11 +366,7 @@ static void config_write_pciex_rc(unsigned int __iomem *base, uint32_t where,
 static int scc_pciex_read_config(struct pci_bus *bus, unsigned int devfn,
 				 int where, int size, unsigned int *val)
 {
-	struct device_node *dn;
-	struct pci_controller *phb;
-
-	dn = bus->sysdata;
-	phb = pci_find_hose_for_OF_device(dn);
+	struct pci_controller *phb = pci_bus_to_host(bus);
 
 	if (bus->number == phb->first_busno && PCI_SLOT(devfn) != 1) {
 		*val = ~0;
@@ -389,11 +385,7 @@ static int scc_pciex_read_config(struct pci_bus *bus, unsigned int devfn,
 static int scc_pciex_write_config(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, unsigned int val)
 {
-	struct device_node *dn;
-	struct pci_controller *phb;
-
-	dn = bus->sysdata;
-	phb = pci_find_hose_for_OF_device(dn);
+	struct pci_controller *phb = pci_bus_to_host(bus);
 
 	if (bus->number == phb->first_busno && PCI_SLOT(devfn) != 1)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-- 
1.6.0.6
