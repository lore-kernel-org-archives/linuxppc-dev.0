Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0FD63DE062
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:58:43 +1000 (EST)
Date: Tue, 3 Apr 2007 10:57:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 5/6] [POWERPC] Rename prom_n_size_cells to of_n_size_cells
Message-Id: <20070403105748.769f156c.sfr@canb.auug.org.au>
In-Reply-To: <20070403105650.204003b6.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
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
 arch/powerpc/kernel/prom.c         |    5 ++---
 arch/powerpc/kernel/prom_parse.c   |    4 ++--
 arch/powerpc/kernel/setup-common.c |    2 +-
 arch/powerpc/mm/numa.c             |    2 +-
 drivers/char/tpm/tpm_atmel.h       |    2 +-
 include/asm-powerpc/prom.h         |    2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 08d6197..2890ce3 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1056,8 +1056,7 @@ int of_n_addr_cells(struct device_node* np)
 }
 EXPORT_SYMBOL(of_n_addr_cells);
 
-int
-prom_n_size_cells(struct device_node* np)
+int of_n_size_cells(struct device_node* np)
 {
 	const int* ip;
 	do {
@@ -1070,7 +1069,7 @@ prom_n_size_cells(struct device_node* np)
 	/* No #size-cells property for the root node, default to 1 */
 	return 1;
 }
-EXPORT_SYMBOL(prom_n_size_cells);
+EXPORT_SYMBOL(of_n_size_cells);
 
 /**
  * Construct and return a list of the device_nodes with a given name.
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index e3d036f..ba9c7c1 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -70,7 +70,7 @@ static void of_bus_default_count_cells(struct device_node *dev,
 	if (addrc)
 		*addrc = of_n_addr_cells(dev);
 	if (sizec)
-		*sizec = prom_n_size_cells(dev);
+		*sizec = of_n_size_cells(dev);
 }
 
 static u64 of_bus_default_map(u32 *addr, const u32 *range,
@@ -660,7 +660,7 @@ void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
 	dma_window += cells;
 
 	prop = get_property(dn, "ibm,#dma-size-cells", NULL);
-	cells = prop ? *(u32 *)prop : prom_n_size_cells(dn);
+	cells = prop ? *(u32 *)prop : of_n_size_cells(dn);
 	*size = of_read_number(dma_window, cells);
 }
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 54f449e..8e33526 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -381,7 +381,7 @@ void __init smp_setup_cpu_maps(void)
 		const unsigned int *ireg;
 
 		num_addr_cell = of_n_addr_cells(dn);
-		num_size_cell = prom_n_size_cells(dn);
+		num_size_cell = of_n_size_cells(dn);
 
 		ireg = get_property(dn, "ibm,lrdr-capacity", NULL);
 
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 119cef9..683839b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -202,7 +202,7 @@ static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
 		panic("numa.c: No memory nodes found!");
 
 	*n_addr_cells = of_n_addr_cells(memory);
-	*n_size_cells = prom_n_size_cells(memory);
+	*n_size_cells = of_n_size_cells(memory);
 	of_node_put(memory);
 }
 
diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
index 3501c03..3c85200 100644
--- a/drivers/char/tpm/tpm_atmel.h
+++ b/drivers/char/tpm/tpm_atmel.h
@@ -54,7 +54,7 @@ static void __iomem * atmel_get_base_addr(unsigned long *base, int *region_size)
 
 	reg = get_property(dn, "reg", &reglen);
 	naddrc = of_n_addr_cells(dn);
-	nsizec = prom_n_size_cells(dn);
+	nsizec = of_n_size_cells(dn);
 
 	of_node_put(dn);
 
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index e0c92bf..fb068f2 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -172,7 +172,7 @@ extern const void *of_get_property(const struct device_node *node,
 #define get_property(a, b, c)	of_get_property((a), (b), (c))
 extern void print_properties(struct device_node *node);
 extern int of_n_addr_cells(struct device_node* np);
-extern int prom_n_size_cells(struct device_node* np);
+extern int of_n_size_cells(struct device_node* np);
 extern int prom_n_intr_cells(struct device_node* np);
 extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
 extern int prom_add_property(struct device_node* np, struct property* prop);
-- 
1.5.0.3
