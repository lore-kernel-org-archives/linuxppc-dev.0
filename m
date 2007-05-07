Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00D9ADDEE0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 00:57:50 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47EvlbM025842
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 10:57:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47EvlFC175114
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 08:57:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47EvlT4026154
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 08:57:47 -0600
Subject: [PATCH v3 3/7] Generalize tsi108 PCI setup
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
In-Reply-To: <1178549324.2990.52.camel@zod.rchland.ibm.com>
References: <1178549324.2990.52.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 07 May 2007 09:52:15 -0500
Message-Id: <1178549535.2990.59.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    4 +++-
 arch/powerpc/sysdev/tsi108_pci.c                  |    9 +++++----
 include/asm-powerpc/tsi108.h                      |    1 -
 include/asm-powerpc/tsi108_pci.h                  |    2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -52,6 +52,8 @@
 #define DBG(fmt...) do { } while(0)
 #endif
 
+#define MPC7448HPC2_PCI_CFG_PHYS 0xfb000000
+
 #ifndef CONFIG_PCI
 isa_io_base = MPC7448_HPC2_ISA_IO_BASE;
 isa_mem_base = MPC7448_HPC2_ISA_MEM_BASE;
@@ -79,7 +81,7 @@ static void __init mpc7448_hpc2_setup_ar
 	/* setup PCI host bridge */
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		tsi108_setup_pci(np);
+		tsi108_setup_pci(np, MPC7448HPC2_PCI_CFG_PHYS);
 
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
--- linux-2.6.orig/include/asm-powerpc/tsi108.h
+++ linux-2.6/include/asm-powerpc/tsi108.h
@@ -68,7 +68,6 @@
 #define TSI108_PB_ERRCS_ES		(1 << 1)
 #define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
 
-#define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
 #define TSI108_PCI_CFG_SIZE		(0x01000000)
 
 /*
