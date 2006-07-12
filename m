Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 06/16] [powerpc,chrp] Constify & voidify get_property()
Message-ID: <1152678686.20160.06@pokey>
Date: Wed, 12 Jul 2006 15:40:05 +1000 (EST)
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

chrp platform changes.

Built for chrp32_defconfig

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 nvram.c |    5 +++--
 pci.c   |   11 +++++------
 setup.c |   21 +++++++++------------
 3 files changed, 17 insertions(+), 20 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/chrp/nvram.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/chrp/nvram.c
+++ linux-2.6/arch/powerpc/platforms/chrp/nvram.c
@@ -67,13 +67,14 @@ static void chrp_nvram_write(int addr, u
 void __init chrp_nvram_init(void)
 {
 	struct device_node *nvram;
-	unsigned int *nbytes_p, proplen;
+	const unsigned int *nbytes_p;
+	unsigned int proplen;
 
 	nvram = of_find_node_by_type(NULL, "nvram");
 	if (nvram == NULL)
 		return;
 
-	nbytes_p = (unsigned int *)get_property(nvram, "#bytes", &proplen);
+	nbytes_p = get_property(nvram, "#bytes", &proplen);
 	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
 		return;
 
Index: linux-2.6/arch/powerpc/platforms/chrp/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/chrp/pci.c
+++ linux-2.6/arch/powerpc/platforms/chrp/pci.c
@@ -214,11 +214,11 @@ void __init
 chrp_find_bridges(void)
 {
 	struct device_node *dev;
-	int *bus_range;
+	const int *bus_range;
 	int len, index = -1;
 	struct pci_controller *hose;
-	unsigned int *dma;
-	char *model, *machine;
+	const unsigned int *dma;
+	const char *model, *machine;
 	int is_longtrail = 0, is_mot = 0, is_pegasos = 0;
 	struct device_node *root = find_path_device("/");
 	struct resource r;
@@ -246,7 +246,7 @@ chrp_find_bridges(void)
 			       dev->full_name);
 			continue;
 		}
-		bus_range = (int *) get_property(dev, "bus-range", &len);
+		bus_range = get_property(dev, "bus-range", &len);
 		if (bus_range == NULL || len < 2 * sizeof(int)) {
 			printk(KERN_WARNING "Can't get bus-range for %s\n",
 				dev->full_name);
@@ -312,8 +312,7 @@ chrp_find_bridges(void)
 
 		/* check the first bridge for a property that we can
 		   use to set pci_dram_offset */
-		dma = (unsigned int *)
-			get_property(dev, "ibm,dma-ranges", &len);
+		dma = get_property(dev, "ibm,dma-ranges", &len);
 		if (index == 0 && dma != NULL && len >= 6 * sizeof(*dma)) {
 			pci_dram_offset = dma[2] - dma[3];
 			printk("pci_dram_offset = %lx\n", pci_dram_offset);
Index: linux-2.6/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/chrp/setup.c
+++ linux-2.6/arch/powerpc/platforms/chrp/setup.c
@@ -226,8 +226,7 @@ static void __init pegasos_set_l2cr(void
 	/* Enable L2 cache if needed */
 	np = find_type_devices("cpu");
 	if (np != NULL) {
-		unsigned int *l2cr = (unsigned int *)
-			get_property (np, "l2cr", NULL);
+		const unsigned int *l2cr = get_property(np, "l2cr", NULL);
 		if (l2cr == NULL) {
 			printk ("Pegasos l2cr : no cpu l2cr property found\n");
 			return;
@@ -252,7 +251,7 @@ static void briq_restart(char *cmd)
 void __init chrp_setup_arch(void)
 {
 	struct device_node *root = find_path_device ("/");
-	char *machine = NULL;
+	const char *machine = NULL;
 
 	/* init to some ~sane value until calibrate_delay() runs */
 	loops_per_jiffy = 50000000/HZ;
@@ -353,7 +352,7 @@ static void __init chrp_find_openpic(voi
 	struct device_node *np, *root;
 	int len, i, j;
 	int isu_size, idu_size;
-	unsigned int *iranges, *opprop = NULL;
+	const unsigned int *iranges, *opprop = NULL;
 	int oplen = 0;
 	unsigned long opaddr;
 	int na = 1;
@@ -363,8 +362,7 @@ static void __init chrp_find_openpic(voi
 		return;
 	root = of_find_node_by_path("/");
 	if (root) {
-		opprop = (unsigned int *) get_property
-			(root, "platform-open-pic", &oplen);
+		opprop = get_property(root, "platform-open-pic", &oplen);
 		na = prom_n_addr_cells(root);
 	}
 	if (opprop && oplen >= na * sizeof(unsigned int)) {
@@ -381,7 +379,7 @@ static void __init chrp_find_openpic(voi
 
 	printk(KERN_INFO "OpenPIC at %lx\n", opaddr);
 
-	iranges = (unsigned int *) get_property(np, "interrupt-ranges", &len);
+	iranges = get_property(np, "interrupt-ranges", &len);
 	if (iranges == NULL)
 		len = 0;	/* non-distributed mpic */
 	else
@@ -467,8 +465,8 @@ static void __init chrp_find_8259(void)
 	 * from anyway
 	 */
 	for (np = find_devices("pci"); np != NULL; np = np->next) {
-		unsigned int *addrp = (unsigned int *)
-			get_property(np, "8259-interrupt-acknowledge", NULL);
+		const unsigned int *addrp = get_property(np,
+				"8259-interrupt-acknowledge", NULL);
 
 		if (addrp == NULL)
 			continue;
@@ -527,7 +525,7 @@ void __init
 chrp_init2(void)
 {
 	struct device_node *device;
-	unsigned int *p = NULL;
+	const unsigned int *p = NULL;
 
 #ifdef CONFIG_NVRAM
 	chrp_nvram_init();
@@ -545,8 +543,7 @@ chrp_init2(void)
 	 */
 	device = find_devices("rtas");
 	if (device)
-		p = (unsigned int *) get_property
-			(device, "rtas-event-scan-rate", NULL);
+		p = get_property(device, "rtas-event-scan-rate", NULL);
 	if (p && *p) {
 		/*
 		 * Arrange to call chrp_event_scan at least *p times
