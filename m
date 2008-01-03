Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2C273DDE39
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 15:13:48 +1100 (EST)
Date: Thu, 3 Jan 2008 15:13:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] arch/powerpc/kernel: use for_each_child_of_node
Message-Id: <20080103151337.4b7dd98b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
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
 arch/powerpc/kernel/ibmebus.c     |    2 +-
 arch/powerpc/kernel/of_platform.c |    4 ++--
 arch/powerpc/kernel/pci_32.c      |    4 ++--
 arch/powerpc/kernel/pci_64.c      |    4 ++--
 arch/powerpc/kernel/rtas_pci.c    |    5 +----
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index caae49f..1844359 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -171,7 +171,7 @@ static int ibmebus_create_devices(const struct of_device_id *matches)
 
 	root = of_find_node_by_path("/");
 
-	for (child = NULL; (child = of_get_next_child(root, child)); ) {
+	for_each_child_of_node(root, child) {
 		if (!of_match_node(matches, child))
 			continue;
 
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index de36e23..7a60191 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -108,7 +108,7 @@ static int of_platform_bus_create(const struct device_node *bus,
 	struct of_device *dev;
 	int rc = 0;
 
-	for (child = NULL; (child = of_get_next_child(bus, child)); ) {
+	for_each_child_of_node(bus, child) {
 		pr_debug("   create child: %s\n", child->full_name);
 		dev = of_platform_device_create(child, NULL, parent);
 		if (dev == NULL)
@@ -170,7 +170,7 @@ int of_platform_bus_probe(struct device_node *root,
 		rc = of_platform_bus_create(root, matches, &dev->dev);
 		goto bail;
 	}
-	for (child = NULL; (child = of_get_next_child(root, child)); ) {
+	for_each_child_of_node(root, child) {
 		if (!of_match_node(matches, child))
 			continue;
 
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 47dc754..14e300f 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -276,11 +276,11 @@ scan_OF_pci_childs(struct device_node *parent, pci_OF_scan_iterator filter, void
 static struct device_node *scan_OF_for_pci_dev(struct device_node *parent,
 					       unsigned int devfn)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 	const u32 *reg;
 	unsigned int psize;
 
-	while ((np = of_get_next_child(parent, np)) != NULL) {
+	for_each_child_of_node(parent, np) {
 		reg = of_get_property(np, "reg", &psize);
 		if (reg == NULL || psize < 4)
 			continue;
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 5949bba..1930f39 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -227,7 +227,7 @@ EXPORT_SYMBOL(of_create_pci_dev);
 void __devinit of_scan_bus(struct device_node *node,
 			   struct pci_bus *bus)
 {
-	struct device_node *child = NULL;
+	struct device_node *child;
 	const u32 *reg;
 	int reglen, devfn;
 	struct pci_dev *dev;
@@ -235,7 +235,7 @@ void __devinit of_scan_bus(struct device_node *node,
 	DBG("of_scan_bus(%s) bus no %d... \n", node->full_name, bus->number);
 
 	/* Scan direct children */
-	while ((child = of_get_next_child(node, child)) != NULL) {
+	for_each_child_of_node(node, child) {
 		DBG("  * %s\n", child->full_name);
 		reg = of_get_property(child, "reg", &reglen);
 		if (reg == NULL || reglen < 20)
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 99aaae3..433a0a0 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -280,10 +280,7 @@ void __init find_and_init_phbs(void)
 	struct pci_controller *phb;
 	struct device_node *root = of_find_node_by_path("/");
 
-	for (node = of_get_next_child(root, NULL);
-	     node != NULL;
-	     node = of_get_next_child(root, node)) {
-
+	for_each_child_of_node(root, node) {
 		if (node->type == NULL || (strcmp(node->type, "pci") != 0 &&
 					   strcmp(node->type, "pciex") != 0))
 			continue;
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
