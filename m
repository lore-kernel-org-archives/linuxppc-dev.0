Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1A51BDE0B8
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:58:42 +1000 (EST)
Date: Tue, 3 Apr 2007 10:56:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 4/6] [POWERPC] Rename prom_n_addr_cells to of_n_addr_cells
Message-Id: <20070403105650.204003b6.sfr@canb.auug.org.au>
In-Reply-To: <20070403105539.7222cf2a.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is more consistent and gets us closer to the Sparc code.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_32.c           |    2 +-
 arch/powerpc/kernel/pci_64.c           |    2 +-
 arch/powerpc/kernel/prom.c             |    5 ++---
 arch/powerpc/kernel/prom_parse.c       |    4 ++--
 arch/powerpc/kernel/setup-common.c     |    2 +-
 arch/powerpc/mm/numa.c                 |    2 +-
 arch/powerpc/platforms/chrp/setup.c    |    4 ++--
 arch/powerpc/platforms/maple/setup.c   |    2 +-
 arch/powerpc/platforms/pasemi/setup.c  |    2 +-
 arch/powerpc/platforms/pseries/setup.c |    4 ++--
 arch/powerpc/platforms/pseries/xics.c  |    2 +-
 drivers/char/tpm/tpm_atmel.h           |    2 +-
 include/asm-powerpc/prom.h             |    2 +-
 13 files changed, 17 insertions(+), 18 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index d8ef2e1..ecc7658 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -895,7 +895,7 @@ pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	int rlen = 0, orig_rlen;
 	int memno = 0;
 	struct resource *res;
-	int np, na = prom_n_addr_cells(dev);
+	int np, na = of_n_addr_cells(dev);
 	np = na + 5;
 
 	/* First we try to merge ranges to fix a problem with some pmacs
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index db1d40e..84b4f66 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -957,7 +957,7 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
 	int rlen = 0;
 	int memno = 0;
 	struct resource *res;
-	int np, na = prom_n_addr_cells(dev);
+	int np, na = of_n_addr_cells(dev);
 	unsigned long pci_addr, cpu_phys_addr;
 
 	np = na + 5;
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d2840b6..08d6197 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1041,8 +1041,7 @@ void __init early_init_devtree(void *params)
 
 #undef printk
 
-int
-prom_n_addr_cells(struct device_node* np)
+int of_n_addr_cells(struct device_node* np)
 {
 	const int *ip;
 	do {
@@ -1055,7 +1054,7 @@ prom_n_addr_cells(struct device_node* np)
 	/* No #address-cells property for the root node, default to 1 */
 	return 1;
 }
-EXPORT_SYMBOL(prom_n_addr_cells);
+EXPORT_SYMBOL(of_n_addr_cells);
 
 int
 prom_n_size_cells(struct device_node* np)
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 91b443c..e3d036f 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -68,7 +68,7 @@ static void of_bus_default_count_cells(struct device_node *dev,
 				       int *addrc, int *sizec)
 {
 	if (addrc)
-		*addrc = prom_n_addr_cells(dev);
+		*addrc = of_n_addr_cells(dev);
 	if (sizec)
 		*sizec = prom_n_size_cells(dev);
 }
@@ -654,7 +654,7 @@ void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 	if (!prop)
 		prop = get_property(dn, "#address-cells", NULL);
 
-	cells = prop ? *(u32 *)prop : prom_n_addr_cells(dn);
+	cells = prop ? *(u32 *)prop : of_n_addr_cells(dn);
 	*phys = of_read_number(dma_window, cells);
 
 	dma_window += cells;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index d050d9a..54f449e 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -380,7 +380,7 @@ void __init smp_setup_cpu_maps(void)
 		int num_addr_cell, num_size_cell, maxcpus;
 		const unsigned int *ireg;
 
-		num_addr_cell = prom_n_addr_cells(dn);
+		num_addr_cell = of_n_addr_cells(dn);
 		num_size_cell = prom_n_size_cells(dn);
 
 		ireg = get_property(dn, "ibm,lrdr-capacity", NULL);
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e86c37c..119cef9 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -201,7 +201,7 @@ static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
 	if (!memory)
 		panic("numa.c: No memory nodes found!");
 
-	*n_addr_cells = prom_n_addr_cells(memory);
+	*n_addr_cells = of_n_addr_cells(memory);
 	*n_size_cells = prom_n_size_cells(memory);
 	of_node_put(memory);
 }
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 1edce72..c0d07fb 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -362,7 +362,7 @@ static void __init chrp_find_openpic(void)
 	root = of_find_node_by_path("/");
 	if (root) {
 		opprop = get_property(root, "platform-open-pic", &oplen);
-		na = prom_n_addr_cells(root);
+		na = of_n_addr_cells(root);
 	}
 	if (opprop && oplen >= na * sizeof(unsigned int)) {
 		opaddr = opprop[na-1];	/* assume 32-bit */
@@ -469,7 +469,7 @@ static void __init chrp_find_8259(void)
 
 		if (addrp == NULL)
 			continue;
-		chrp_int_ack = addrp[prom_n_addr_cells(np)-1];
+		chrp_int_ack = addrp[of_n_addr_cells(np)-1];
 		break;
 	}
 	if (np == NULL)
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 82d3f9e..a3f05c5 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -249,7 +249,7 @@ static void __init maple_init_IRQ(void)
 
 	/* Find address list in /platform-open-pic */
 	root = of_find_node_by_path("/");
-	naddr = prom_n_addr_cells(root);
+	naddr = of_n_addr_cells(root);
 	opprop = get_property(root, "platform-open-pic", &opplen);
 	if (opprop != 0) {
 		openpic_addr = of_read_number(opprop, naddr);
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 449cf1a..d4fd613 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -136,7 +136,7 @@ static __init void pas_init_IRQ(void)
 
 	/* Find address list in /platform-open-pic */
 	root = of_find_node_by_path("/");
-	naddr = prom_n_addr_cells(root);
+	naddr = of_n_addr_cells(root);
 	opprop = get_property(root, "platform-open-pic", &opplen);
 	if (!opprop) {
 		printk(KERN_ERR "No platform-open-pic property.\n");
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ff87b1a..54e93eb 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -139,7 +139,7 @@ static void __init pseries_mpic_init_IRQ(void)
 	struct mpic *mpic;
 
 	np = of_find_node_by_path("/");
-	naddr = prom_n_addr_cells(np);
+	naddr = of_n_addr_cells(np);
 	opprop = get_property(np, "platform-open-pic", &opplen);
 	if (opprop != 0) {
 		openpic_addr = of_read_number(opprop, naddr);
@@ -193,7 +193,7 @@ static void __init pseries_mpic_init_IRQ(void)
 					    NULL);
 		if (addrp == NULL)
 			continue;
-		naddr = prom_n_addr_cells(np);
+		naddr = of_n_addr_cells(np);
 		intack = addrp[naddr-1];
 		if (naddr > 1)
 			intack |= ((unsigned long)addrp[naddr-2]) << 32;
diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 81d172d..f0795fa 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -643,7 +643,7 @@ static void __init xics_setup_8259_cascade(void)
 		addrp = get_property(np, "8259-interrupt-acknowledge", NULL);
 		if (addrp == NULL)
 			continue;
-		naddr = prom_n_addr_cells(np);
+		naddr = of_n_addr_cells(np);
 		intack = addrp[naddr-1];
 		if (naddr > 1)
 			intack |= ((unsigned long)addrp[naddr-2]) << 32;
diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
index aefd683..3501c03 100644
--- a/drivers/char/tpm/tpm_atmel.h
+++ b/drivers/char/tpm/tpm_atmel.h
@@ -53,7 +53,7 @@ static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
 	}
 
 	reg = get_property(dn, "reg", &reglen);
-	naddrc = prom_n_addr_cells(dn);
+	naddrc = of_n_addr_cells(dn);
 	nsizec = prom_n_size_cells(dn);
 
 	of_node_put(dn);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index fcacc88..e0c92bf 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -171,7 +171,7 @@ extern const void *of_get_property(const struct device_node *node,
 				int *lenp);
 #define get_property(a, b, c)	of_get_property((a), (b), (c))
 extern void print_properties(struct device_node *node);
-extern int prom_n_addr_cells(struct device_node* np);
+extern int of_n_addr_cells(struct device_node* np);
 extern int prom_n_size_cells(struct device_node* np);
 extern int prom_n_intr_cells(struct device_node* np);
 extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
-- 
1.5.0.3
