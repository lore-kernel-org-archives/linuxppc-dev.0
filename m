Return-Path: <jwboyer@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.179])
	by ozlabs.org (Postfix) with ESMTP id 8D289474C2
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 06:12:07 +1100 (EST)
Received: by ik-out-1112.google.com with SMTP id c28so336050ika.1
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 11:12:05 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 10 Dec 2008 14:11:49 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, michael@ellerman.id.au, galak@kernel.crashing.org
Subject: [PATCH] Introduce ppc_pci_flags accessors
Message-ID: <20081210191148.GA1769@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently there are a number of platforms that open code access to
the ppc_pci_flags global variable.  However, that variable is not
present if CONFIG_PCI is not set, which can lead to a build break.

This introduces a number of accessor functions that are defined
to be empty in the case of CONFIG_PCI being disabled.  The
various platform files in the kernel are updated to use these.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index fa8b3b7..8f2c7ca 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -13,7 +13,6 @@
 
 struct device_node;
 
-extern unsigned int ppc_pci_flags;
 enum {
 	/* Force re-assigning all resources (ignore firmware
 	 * setup completely)
@@ -36,6 +35,16 @@ enum {
 	/* ... except for domain 0 */
 	PPC_PCI_COMPAT_DOMAIN_0		= 0x00000020,
 };
+#ifdef CONFIG_PCI
+extern unsigned int ppc_pci_flags;
+#define ppc_pci_set_flags(flags) ppc_pci_flags = (flags)
+#define ppc_pci_add_flags(flags) ppc_pci_flags |= (flags)
+#define ppc_pci_flag_is_set(flag) (ppc_pci_flags & (flag))
+#else
+#define ppc_pci_set_flags(flags) do {} while (0)
+#define ppc_pci_add_flags(flags) do {} while (0)
+#define ppc_pci_flag_is_set(flag) (0)
+#endif
 
 
 /*
diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 1c721a6..535ccb6 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -38,8 +38,8 @@ struct pci_dev;
  * Set this to 1 if you want the kernel to re-assign all PCI
  * bus numbers (don't do that on ppc64 yet !)
  */
-#define pcibios_assign_all_busses()    	(ppc_pci_flags & \
-					 PPC_PCI_REASSIGN_ALL_BUS)
+#define pcibios_assign_all_busses() \
+	(ppc_pci_flag_is_set(PPC_PCI_REASSIGN_ALL_BUS))
 #define pcibios_scan_all_fns(a, b)	0
 
 static inline void pcibios_set_master(struct pci_dev *dev)
diff --git a/arch/powerpc/platforms/40x/ep405.c b/arch/powerpc/platforms/40x/ep405.c
index ae2e7f6..4058fd1 100644
--- a/arch/powerpc/platforms/40x/ep405.c
+++ b/arch/powerpc/platforms/40x/ep405.c
@@ -100,7 +100,7 @@ static void __init ep405_setup_arch(void)
 	/* Find & init the BCSR CPLD */
 	ep405_init_bcsr();
 
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+	ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
 }
 
 static int __init ep405_probe(void)
diff --git a/arch/powerpc/platforms/40x/kilauea.c b/arch/powerpc/platforms/40x/kilauea.c
index 1dd24ff..fd7d934 100644
--- a/arch/powerpc/platforms/40x/kilauea.c
+++ b/arch/powerpc/platforms/40x/kilauea.c
@@ -44,7 +44,7 @@ static int __init kilauea_probe(void)
 	if (!of_flat_dt_is_compatible(root, "amcc,kilauea"))
 		return 0;
 
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+	ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 4498a86..f40ac9b 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -61,7 +61,7 @@ static int __init ppc40x_probe(void)
 
 	for (i = 0; i < ARRAY_SIZE(board); i++) {
 		if (of_flat_dt_is_compatible(root, board[i])) {
-			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+			ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
 			return 1;
 		}
 	}
diff --git a/arch/powerpc/platforms/44x/ebony.c b/arch/powerpc/platforms/44x/ebony.c
index a0e8fe4..88b9117 100644
--- a/arch/powerpc/platforms/44x/ebony.c
+++ b/arch/powerpc/platforms/44x/ebony.c
@@ -54,7 +54,7 @@ static int __init ebony_probe(void)
 	if (!of_flat_dt_is_compatible(root, "ibm,ebony"))
 		return 0;
 
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+	ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 2967126..76fdc51 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -69,7 +69,7 @@ static int __init ppc44x_probe(void)
 
 	for (i = 0; i < ARRAY_SIZE(board); i++) {
 		if (of_flat_dt_is_compatible(root, board[i])) {
-			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+			ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
 			return 1;
 		}
 	}
diff --git a/arch/powerpc/platforms/44x/sam440ep.c b/arch/powerpc/platforms/44x/sam440ep.c
index 47f10e6..a78e8eb 100644
--- a/arch/powerpc/platforms/44x/sam440ep.c
+++ b/arch/powerpc/platforms/44x/sam440ep.c
@@ -51,7 +51,7 @@ static int __init sam440ep_probe(void)
 	if (!of_flat_dt_is_compatible(root, "acube,sam440ep"))
 		return 0;
 
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+	ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index b49a185..c3f2c21 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -375,7 +375,7 @@ mpc52xx_add_bridge(struct device_node *node)
 
 	pr_debug("Adding MPC52xx PCI host bridge %s\n", node->full_name);
 
-	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+	ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);
 
 	if (of_address_to_resource(node, 0, &rsrc) != 0) {
 		printk(KERN_ERR "Can't get %s resources\n", node->full_name);
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index 1b75902..9761a59 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -53,7 +53,7 @@ static void __init pq2_pci_add_bridge(struct device_node *np)
 	if (of_address_to_resource(np, 0, &r) || r.end - r.start < 0x10b)
 		goto err;
 
-	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+	ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);
 
 	hose = pcibios_alloc_controller(np);
 	if (!hose)
diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index d3cde6b..e0392e2 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -198,7 +198,7 @@ static void __init setup_peg2(struct pci_controller *hose, struct device_node *d
 		printk ("RTAS supporting Pegasos OF not found, please upgrade"
 			" your firmware\n");
 	}
-	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+	ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);
 	/* keep the reference to the root node */
 }
 
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index bcf50d7..61f1a39 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -729,7 +729,7 @@ static void __init setup_bandit(struct pci_controller *hose,
 static int __init setup_uninorth(struct pci_controller *hose,
 				 struct resource *addr)
 {
-	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+	ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);
 	has_uninorth = 1;
 	hose->ops = &macrisc_pci_ops;
 	hose->cfg_addr = ioremap(addr->start + 0x800000, 0x1000);
@@ -996,7 +996,7 @@ void __init pmac_pci_init(void)
 	struct device_node *np, *root;
 	struct device_node *ht = NULL;
 
-	ppc_pci_flags = PPC_PCI_CAN_SKIP_ISA_ALIGN;
+	ppc_pci_set_flags(PPC_PCI_CAN_SKIP_ISA_ALIGN);
 
 	root = of_find_node_by_path("/");
 	if (root == NULL) {
@@ -1055,7 +1055,7 @@ void __init pmac_pci_init(void)
 	 * some offset between bus number and domains for now when we
 	 * assign all busses should help for now
 	 */
-	if (ppc_pci_flags & PPC_PCI_REASSIGN_ALL_BUS)
+	if (ppc_pci_flag_is_set(PPC_PCI_REASSIGN_ALL_BUS))
 		pcibios_assign_bus_offset = 0x10;
 #endif
 }
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 5b264eb..d5f9ae0 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -187,7 +187,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 		printk(KERN_WARNING "Can't get bus-range for %s, assume"
 			" bus 0\n", dev->full_name);
 
-	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+	ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);
 	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
@@ -300,7 +300,7 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 		       " bus 0\n", dev->full_name);
 	}
 
-	ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+	ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);
 	hose = pcibios_alloc_controller(dev);
 	if (!hose)
 		return -ENOMEM;
diff --git a/arch/powerpc/sysdev/grackle.c b/arch/powerpc/sysdev/grackle.c
index d502927..5da37c2 100644
--- a/arch/powerpc/sysdev/grackle.c
+++ b/arch/powerpc/sysdev/grackle.c
@@ -57,7 +57,7 @@ void __init setup_grackle(struct pci_controller *hose)
 {
 	setup_indirect_pci(hose, 0xfec00000, 0xfee00000, 0);
 	if (machine_is_compatible("PowerMac1,1"))
-		ppc_pci_flags |= PPC_PCI_REASSIGN_ALL_BUS;
+		ppc_pci_add_flags(PPC_PCI_REASSIGN_ALL_BUS);
 	if (machine_is_compatible("AAPL,PowerBook1998"))
 		grackle_set_loop_snoop(hose, 1);
 #if 0	/* Disabled for now, HW problems ??? */
