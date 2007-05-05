Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51EB0DDECD
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 02:22:02 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l45GLxe5001469
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:21:59 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45GLx6e546314
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:21:59 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45GLxNs004495
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:21:59 -0400
Received: from [9.67.207.4] (wecm-9-67-207-4.wecm.ibm.com [9.67.207.4])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l45GLwx9004492
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:21:59 -0400
Subject: [PATCH v2 3/7] Generalize TSI 108 PCI setup
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1178381611.3393.25.camel@zod.rchland.ibm.com>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 05 May 2007 11:16:52 -0500
Message-Id: <1178381812.3393.31.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Generalize tsi108_setup_pci to take the config space physical address as
a parameter.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 +-
 arch/powerpc/sysdev/tsi108_pci.c                  |    9 +++++----
 include/asm-powerpc/tsi108_pci.h                  |    2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -79,7 +79,7 @@ static void __init mpc7448_hpc2_setup_ar
 	/* setup PCI host bridge */
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		tsi108_setup_pci(np);
+		tsi108_setup_pci(np, TSI108_CFG_BASE_PHYS);
 
 	ppc_md.pci_exclude_device = mpc7448_hpc2_exclude_device;
 	if (ppc_md.progress)
--- linux-2.6.orig/arch/powerpc/sysdev/tsi108_pci.c
+++ linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
@@ -50,6 +50,7 @@
 	((((bus)<<16) | ((devfunc)<<8) | (offset & 0xfc)) + tsi108_pci_cfg_base)
 
 u32 tsi108_pci_cfg_base;
+static u32 tsi108_pci_cfg_phys;
 u32 tsi108_csr_vir_base;
 static struct device_node *pci_irq_node;
 static struct irq_host *pci_irq_host;
@@ -186,7 +187,7 @@ tsi108_direct_read_config(struct pci_bus
 
 void tsi108_clear_pci_cfg_error(void)
 {
-	tsi108_clear_pci_error(TSI108_PCI_CFG_BASE_PHYS);
+	tsi108_clear_pci_error(tsi108_pci_cfg_phys);
 }
 
 static struct pci_ops tsi108_direct_pci_ops = {
@@ -194,7 +195,7 @@ static struct pci_ops tsi108_direct_pci_
 	tsi108_direct_write_config
 };
 
-int __init tsi108_setup_pci(struct device_node *dev)
+int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys)
 {
 	int len;
 	struct pci_controller *hose;
@@ -203,8 +204,8 @@ int __init tsi108_setup_pci(struct devic
 	int primary = 0, has_address = 0;
 
 	/* PCI Config mapping */
-	tsi108_pci_cfg_base = (u32)ioremap(TSI108_PCI_CFG_BASE_PHYS,
-			TSI108_PCI_CFG_SIZE);
+	tsi108_pci_cfg_base = (u32)ioremap(cfg_phys, TSI108_PCI_CFG_SIZE);
+	tsi108_pci_cfg_phys = cfg_phys;
 	DBG("TSI_PCI: %s tsi108_pci_cfg_base=0x%x\n", __FUNCTION__,
 	    tsi108_pci_cfg_base);
 
--- linux-2.6.orig/include/asm-powerpc/tsi108_pci.h
+++ linux-2.6/include/asm-powerpc/tsi108_pci.h
@@ -37,7 +37,7 @@
 #define TSI108_PCI_PFAB_PFM3 (TSI108_PCI_OFFSET + 0x220)
 #define TSI108_PCI_PFAB_PFM4 (TSI108_PCI_OFFSET + 0x230)
 
-extern int tsi108_setup_pci(struct device_node *dev);
+extern int tsi108_setup_pci(struct device_node *dev, u32 cfg_phys);
 extern void tsi108_pci_int_init(struct device_node *node);
 extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
 extern void tsi108_clear_pci_cfg_error(void);
