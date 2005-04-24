Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6112A67B26
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Apr 2005 07:31:04 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DPoh7-0004k7-Ow@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Sun, 24 Apr 2005 22:31:13 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc trivial iomem annotations: chrp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-pmac_smp/arch/ppc/platforms/chrp_pci.c RC12-rc3-chrp/arch/ppc/platforms/chrp_pci.c
--- RC12-rc3-pmac_smp/arch/ppc/platforms/chrp_pci.c	Fri Mar 11 15:54:45 2005
+++ RC12-rc3-chrp/arch/ppc/platforms/chrp_pci.c	Sun Apr 24 16:20:05 2005
@@ -129,7 +129,7 @@
 	rtas_write_config
 };
 
-volatile struct Hydra *Hydra = NULL;
+volatile struct Hydra __iomem *Hydra = NULL;
 
 int __init
 hydra_init(void)
@@ -175,13 +175,14 @@
 static void __init
 setup_python(struct pci_controller *hose, struct device_node *dev)
 {
-	u32 *reg, val;
+	u32 __iomem *reg;
+	u32 val;
 	unsigned long addr = dev->addrs[0].address;
 
 	setup_indirect_pci(hose, addr + 0xf8000, addr + 0xf8010);
 
 	/* Clear the magic go-slow bit */
-	reg = (u32 *) ioremap(dev->addrs[0].address + 0xf6000, 0x40);
+	reg = ioremap(dev->addrs[0].address + 0xf6000, 0x40);
 	val = in_be32(&reg[12]);
 	if (val & PRG_CL_RESET_VALID) {
 		out_be32(&reg[12], val & ~PRG_CL_RESET_VALID);
diff -urN RC12-rc3-pmac_smp/arch/ppc/platforms/chrp_setup.c RC12-rc3-chrp/arch/ppc/platforms/chrp_setup.c
--- RC12-rc3-pmac_smp/arch/ppc/platforms/chrp_setup.c	Wed Apr 20 21:25:28 2005
+++ RC12-rc3-chrp/arch/ppc/platforms/chrp_setup.c	Sun Apr 24 16:20:05 2005
@@ -356,7 +356,7 @@
 	struct device_node *np;
 	int len, i;
 	unsigned int *iranges;
-	void *isu;
+	void __iomem *isu;
 
 	np = find_type_devices("open-pic");
 	if (np == NULL || np->n_addrs == 0)
diff -urN RC12-rc3-pmac_smp/include/asm-ppc/hydra.h RC12-rc3-chrp/include/asm-ppc/hydra.h
--- RC12-rc3-pmac_smp/include/asm-ppc/hydra.h	Wed Feb  4 09:34:02 2004
+++ RC12-rc3-chrp/include/asm-ppc/hydra.h	Sun Apr 24 16:20:05 2005
@@ -51,7 +51,7 @@
     char OpenPIC[0x40000];
 };
 
-extern volatile struct Hydra *Hydra;
+extern volatile struct Hydra __iomem *Hydra;
 
 
     /*
