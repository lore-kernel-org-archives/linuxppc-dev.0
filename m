Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9148367B27
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 16:04:07 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPwhb-0007Ra-Uy@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Mon, 25 Apr 2005 07:04:15 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc iomem annotations: ->io_base_virt
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* ->io_base_virt in struct pci_controller is iomem pointer.  Marked as such.
  Most of the places that used it are already annotated to expect iomem.
* places that did gratitious (and wrong) casts a-la
	isa_io_base = (unsigned long)ioremap(...);
	hose->io_base_virt = (void *)isa_io_base;
  turned into
	hose->io_base_virt = ioremap(...);
	isa_io_base = (unsigned long)hose->io_base_virt;
* pci_bus_io_base() annotated as returning iomem pointer.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-ppc-sigcontext/arch/ppc/kernel/pci.c RC12-rc3-io_virt_base/arch/ppc/kernel/pci.c
--- RC12-rc3-ppc-sigcontext/arch/ppc/kernel/pci.c	Wed Apr 20 21:25:28 2005
+++ RC12-rc3-io_virt_base/arch/ppc/kernel/pci.c	Mon Apr 25 00:40:04 2005
@@ -1432,7 +1432,7 @@
 	return NULL;
 }
 
-void*
+void __iomem *
 pci_bus_io_base(unsigned int bus)
 {
 	struct pci_controller *hose;
diff -urN RC12-rc3-ppc-sigcontext/arch/ppc/platforms/4xx/ebony.c RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/ebony.c
--- RC12-rc3-ppc-sigcontext/arch/ppc/platforms/4xx/ebony.c	Wed Apr 20 21:25:28 2005
+++ RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/ebony.c	Mon Apr 25 00:40:04 2005
@@ -210,9 +210,8 @@
 	hose->io_space.end = EBONY_PCI_UPPER_IO;
 	hose->mem_space.start = EBONY_PCI_LOWER_MEM;
 	hose->mem_space.end = EBONY_PCI_UPPER_MEM;
-	isa_io_base =
-		(unsigned long)ioremap64(EBONY_PCI_IO_BASE, EBONY_PCI_IO_SIZE);
-	hose->io_base_virt = (void *)isa_io_base;
+	hose->io_base_virt = ioremap64(EBONY_PCI_IO_BASE, EBONY_PCI_IO_SIZE);
+	isa_io_base = (unsigned long)hose->io_base_virt;
 
 	setup_indirect_pci(hose,
 			EBONY_PCI_CFGA_PLB32,
diff -urN RC12-rc3-ppc-sigcontext/arch/ppc/platforms/4xx/luan.c RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/luan.c
--- RC12-rc3-ppc-sigcontext/arch/ppc/platforms/4xx/luan.c	Fri Mar 11 15:54:45 2005
+++ RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/luan.c	Mon Apr 25 00:40:04 2005
@@ -223,9 +223,8 @@
 	hose->io_space.end = LUAN_PCIX_UPPER_IO;
 	hose->mem_space.start = lower_mem;
 	hose->mem_space.end = upper_mem;
-	isa_io_base =
-		(unsigned long)ioremap64(pcix_io_base, PCIX_IO_SIZE);
-	hose->io_base_virt = (void *)isa_io_base;
+	hose->io_base_virt = ioremap64(pcix_io_base, PCIX_IO_SIZE);
+	isa_io_base = (unsigned long) hose->io_base_virt;
 
 	setup_indirect_pci(hose, cfga, cfgd);
 	hose->set_cfg_type = 1;
diff -urN RC12-rc3-ppc-sigcontext/arch/ppc/platforms/4xx/ocotea.c RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/ocotea.c
--- RC12-rc3-ppc-sigcontext/arch/ppc/platforms/4xx/ocotea.c	Fri Mar 11 15:54:45 2005
+++ RC12-rc3-io_virt_base/arch/ppc/platforms/4xx/ocotea.c	Mon Apr 25 00:40:04 2005
@@ -227,9 +227,8 @@
 	hose->io_space.end = OCOTEA_PCI_UPPER_IO;
 	hose->mem_space.start = OCOTEA_PCI_LOWER_MEM;
 	hose->mem_space.end = OCOTEA_PCI_UPPER_MEM;
-	isa_io_base =
-		(unsigned long)ioremap64(OCOTEA_PCI_IO_BASE, OCOTEA_PCI_IO_SIZE);
-	hose->io_base_virt = (void *)isa_io_base;
+	hose->io_base_virt = ioremap64(OCOTEA_PCI_IO_BASE, OCOTEA_PCI_IO_SIZE);
+	isa_io_base = (unsigned long) hose->io_base_virt;
 
 	setup_indirect_pci(hose,
 			OCOTEA_PCI_CFGA_PLB32,
diff -urN RC12-rc3-ppc-sigcontext/arch/ppc/syslib/m8260_pci.c RC12-rc3-io_virt_base/arch/ppc/syslib/m8260_pci.c
--- RC12-rc3-ppc-sigcontext/arch/ppc/syslib/m8260_pci.c	Tue Jun 29 20:03:48 2004
+++ RC12-rc3-io_virt_base/arch/ppc/syslib/m8260_pci.c	Mon Apr 25 00:40:04 2005
@@ -171,10 +171,9 @@
 	m8260_setup_pci(hose);
         hose->pci_mem_offset = MPC826x_PCI_MEM_OFFSET;
 
-        isa_io_base =
-                (unsigned long) ioremap(MPC826x_PCI_IO_BASE,
+        hose->io_base_virt = ioremap(MPC826x_PCI_IO_BASE,
                                         MPC826x_PCI_IO_SIZE);
-        hose->io_base_virt = (void *) isa_io_base;
+        isa_io_base = (unsigned long) hose->io_base_virt;
  
         /* setup resources */
         pci_init_resource(&hose->mem_resources[0],
diff -urN RC12-rc3-ppc-sigcontext/arch/ppc/syslib/mpc52xx_pci.c RC12-rc3-io_virt_base/arch/ppc/syslib/mpc52xx_pci.c
--- RC12-rc3-ppc-sigcontext/arch/ppc/syslib/mpc52xx_pci.c	Wed Apr 20 21:25:28 2005
+++ RC12-rc3-io_virt_base/arch/ppc/syslib/mpc52xx_pci.c	Mon Apr 25 00:40:04 2005
@@ -205,13 +205,11 @@
 
 	hose->pci_mem_offset = MPC52xx_PCI_MEM_OFFSET;
 
-	isa_io_base =
-		(unsigned long) ioremap(MPC52xx_PCI_IO_BASE,
-					MPC52xx_PCI_IO_SIZE);
-	hose->io_base_virt = (void *) isa_io_base;
+	hose->io_base_virt = ioremap(MPC52xx_PCI_IO_BASE, MPC52xx_PCI_IO_SIZE);
+	isa_io_base = (unsigned long) hose->io_base_virt;
 
 	hose->cfg_addr = &pci_regs->car;
-	hose->cfg_data = (void __iomem *) isa_io_base;
+	hose->cfg_data = hose->io_base_virt;
 
 	/* Setup resources */
 	pci_init_resource(&hose->mem_resources[0],
diff -urN RC12-rc3-ppc-sigcontext/arch/ppc/syslib/ppc85xx_setup.c RC12-rc3-io_virt_base/arch/ppc/syslib/ppc85xx_setup.c
--- RC12-rc3-ppc-sigcontext/arch/ppc/syslib/ppc85xx_setup.c	Fri Mar 11 15:54:45 2005
+++ RC12-rc3-io_virt_base/arch/ppc/syslib/ppc85xx_setup.c	Mon Apr 25 00:40:04 2005
@@ -280,16 +280,14 @@
 	hose_a->io_space.end = MPC85XX_PCI1_UPPER_IO;
 	hose_a->io_base_phys = MPC85XX_PCI1_IO_BASE;
 #ifdef CONFIG_85xx_PCI2
-	isa_io_base =
-		(unsigned long) ioremap(MPC85XX_PCI1_IO_BASE,
+	hose_a->io_base_virt =  ioremap(MPC85XX_PCI1_IO_BASE,
 					MPC85XX_PCI1_IO_SIZE +
 					MPC85XX_PCI2_IO_SIZE);
 #else
-	isa_io_base =
-		(unsigned long) ioremap(MPC85XX_PCI1_IO_BASE,
+	hose_a->io_base_virt =  ioremap(MPC85XX_PCI1_IO_BASE,
 					MPC85XX_PCI1_IO_SIZE);
 #endif
-	hose_a->io_base_virt = (void *) isa_io_base;
+	isa_io_base = (unsigned long)hose_a->io_base_virt;
 
 	/* setup resources */
 	pci_init_resource(&hose_a->mem_resources[0],
@@ -329,8 +327,8 @@
 	hose_b->io_space.start = MPC85XX_PCI2_LOWER_IO;
 	hose_b->io_space.end = MPC85XX_PCI2_UPPER_IO;
 	hose_b->io_base_phys = MPC85XX_PCI2_IO_BASE;
-	hose_b->io_base_virt = (void *) isa_io_base + MPC85XX_PCI1_IO_SIZE;
-
+	hose_b->io_base_virt = hose_a->io_base_virt + MPC85XX_PCI1_IO_SIZE;
+	
 	/* setup resources */
 	pci_init_resource(&hose_b->mem_resources[0],
 			MPC85XX_PCI2_LOWER_MEM,
diff -urN RC12-rc3-ppc-sigcontext/include/asm-ppc/pci-bridge.h RC12-rc3-io_virt_base/include/asm-ppc/pci-bridge.h
--- RC12-rc3-ppc-sigcontext/include/asm-ppc/pci-bridge.h	Fri Mar 11 15:54:57 2005
+++ RC12-rc3-io_virt_base/include/asm-ppc/pci-bridge.h	Mon Apr 25 00:40:04 2005
@@ -12,7 +12,7 @@
  * pci_io_base returns the memory address at which you can access
  * the I/O space for PCI bus number `bus' (or NULL on error).
  */
-extern void *pci_bus_io_base(unsigned int bus);
+extern void __iomem *pci_bus_io_base(unsigned int bus);
 extern unsigned long pci_bus_io_base_phys(unsigned int bus);
 extern unsigned long pci_bus_mem_base_phys(unsigned int bus);
 
@@ -48,7 +48,7 @@
 	int last_busno;
 	int bus_offset;
 
-	void *io_base_virt;
+	void __iomem *io_base_virt;
 	unsigned long io_base_phys;
 
 	/* Some machines (PReP) have a non 1:1 mapping of
