Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ea4e3b0150153e512e4753071f25925962cfe46e.1302501428.git.michael@ellerman.id.au>
In-Reply-To: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
References: <3ed7c174af4ccbab67467aa80fe84bd6c6e218ee.1302501428.git.michael@ellerman.id.au>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/4] powerpc/pci: Make IO workarounds init implicit when first
	bus is registered
Date: Mon, 11 Apr 2011 15:54:28 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/io-workarounds.h |    1 -
 arch/powerpc/kernel/io-workarounds.c      |   27 +++++++++++++++------------
 arch/powerpc/platforms/cell/celleb_pci.c  |   18 +++++-------------
 arch/powerpc/platforms/cell/setup.c       |    2 --
 4 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/io-workarounds.h b/arch/powerpc/include/asm/io-workarounds.h
index 6efc778..fbae492 100644
--- a/arch/powerpc/include/asm/io-workarounds.h
+++ b/arch/powerpc/include/asm/io-workarounds.h
@@ -31,7 +31,6 @@ struct iowa_bus {
 	void   *private;
 };
 
-void __devinit io_workaround_init(void);
 void __devinit iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
 				 int (*)(struct iowa_bus *, void *), void *);
 struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR);
diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index 7e58457..d36515e 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -144,7 +144,19 @@ static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
 	return res;
 }
 
-/* Regist new bus to support workaround */
+/* Enable IO workaround */
+static void __devinit io_workaround_init(void)
+{
+	static int io_workaround_inited;
+
+	if (io_workaround_inited)
+		return;
+	ppc_pci_io = iowa_pci_io;
+	ppc_md.ioremap = iowa_ioremap;
+	io_workaround_inited = 1;
+}
+
+/* Register new bus to support workaround */
 void __devinit iowa_register_bus(struct pci_controller *phb,
 			struct ppc_pci_io *ops,
 			int (*initfunc)(struct iowa_bus *, void *), void *data)
@@ -152,6 +164,8 @@ void __devinit iowa_register_bus(struct pci_controller *phb,
 	struct iowa_bus *bus;
 	struct device_node *np = phb->dn;
 
+	io_workaround_init();
+
 	if (iowa_bus_count >= IOWA_MAX_BUS) {
 		pr_err("IOWA:Too many pci bridges, "
 		       "workarounds disabled for %s\n", np->full_name);
@@ -171,14 +185,3 @@ void __devinit iowa_register_bus(struct pci_controller *phb,
 	pr_debug("IOWA:[%d]Add bus, %s.\n", iowa_bus_count-1, np->full_name);
 }
 
-/* enable IO workaround */
-void __devinit io_workaround_init(void)
-{
-	static int io_workaround_inited;
-
-	if (io_workaround_inited)
-		return;
-	ppc_pci_io = iowa_pci_io;
-	ppc_md.ioremap = iowa_ioremap;
-	io_workaround_inited = 1;
-}
diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index c19b783..2904b0a 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -468,18 +468,6 @@ static struct of_device_id celleb_phb_match[] __initdata = {
 	},
 };
 
-static int __init celleb_io_workaround_init(struct pci_controller *phb,
-					    struct celleb_phb_spec *phb_spec)
-{
-	if (phb_spec->ops) {
-		iowa_register_bus(phb, phb_spec->ops, phb_spec->iowa_init,
-				  phb_spec->iowa_data);
-		io_workaround_init();
-	}
-
-	return 0;
-}
-
 int __init celleb_setup_phb(struct pci_controller *phb)
 {
 	struct device_node *dev = phb->dn;
@@ -499,7 +487,11 @@ int __init celleb_setup_phb(struct pci_controller *phb)
 	if (rc)
 		return 1;
 
-	return celleb_io_workaround_init(phb, phb_spec);
+	if (phb_spec->ops)
+		iowa_register_bus(phb, phb_spec->ops,
+				  phb_spec->iowa_init,
+				  phb_spec->iowa_data);
+	return 0;
 }
 
 int celleb_pci_probe_mode(struct pci_bus *bus)
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index af7b13c..c73cf4c 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -136,8 +136,6 @@ static int __devinit cell_setup_phb(struct pci_controller *phb)
 
 	iowa_register_bus(phb, &spiderpci_ops, &spiderpci_iowa_init,
 				  (void *)SPIDER_PCI_REG_BASE);
-	io_workaround_init();
-
 	return 0;
 }
 
-- 
1.7.1
