Return-Path: <moilanen@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC3F067A3F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jul 2006 04:30:48 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6RIUjFO004695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 14:30:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6RIUggO147708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 12:30:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6RIUgeJ001429
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 12:30:42 -0600
Subject: [PATCH][2/2] RTAS MSI
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1154024154.29826.229.camel@goblue>
References: <1154024154.29826.229.camel@goblue>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 13:27:13 -0500
Message-Id: <1154024834.29826.240.camel@goblue>
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

Rebased with the IRQ layer rewrite.  The code is not deallocating the
vectors on a pci_disable_msi().  This is to work around a firmware
vector release bug.  Plus it is really not needed, as
irq_create_mapping() just returns mappings to irqs that it knows of.

Additionally, the patch includes the client architecture bit for MSI,
and correctly identifying that MSI is edge triggered.  

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

 arch/powerpc/kernel/prom_init.c        |    8 ++
 arch/powerpc/platforms/pseries/setup.c |    4 +
 arch/powerpc/platforms/pseries/xics.c  |    5 -
 drivers/pci/Kconfig                    |    2 
 drivers/pci/Makefile                   |    9 +-
 drivers/pci/msi-rtas.c                 |  111
+++++++++++++++++++++++++++++++++
 include/asm-powerpc/rtas.h             |    4 +
 7 files changed, 136 insertions(+), 7 deletions(-)

Index: 2.6-msi/drivers/pci/Makefile
===================================================================
--- 2.6-msi.orig/drivers/pci/Makefile
+++ 2.6-msi/drivers/pci/Makefile
@@ -27,9 +27,12 @@ obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
 
-msiobj-y := msi.o msi-apic.o
-msiobj-$(CONFIG_IA64_GENERIC) += msi-altix.o
-msiobj-$(CONFIG_IA64_SGI_SN2) += msi-altix.o
+msiobj-$(CONFIG_X86) += msi.o msi-apic.o
+msiobj-$(CONFIG_IA64) += msi.o msi-apic.o
+msiobj-$(CONFIG_IA64_GENERIC) += msi.o msi-apic.o msi-altix.o
+msiobj-$(CONFIG_IA64_SGI_SN2) += msi.o msi-apic.o msi-altix.o
+msiobj-$(CONFIG_PPC_PSERIES) += msi-rtas.o
+
 obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
 
 #
Index: 2.6-msi/drivers/pci/msi-rtas.c
===================================================================
--- /dev/null
+++ 2.6-msi/drivers/pci/msi-rtas.c
@@ -0,0 +1,111 @@
+/*
+ * Jake Moilanen <moilanen@austin.ibm.com>
+ * Copyright (C) 2006 IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <asm/rtas.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+int rtas_enable_msi(struct pci_dev* pdev)
+{
+	static int seq_num = 1;
+	int i;
+	int rc;
+	int query_token = rtas_token("ibm,query-interrupt-source-number");
+	int devfn;
+	int busno;
+	u32 *reg;
+	int reglen;
+	int ret[3];
+	int dummy;
+	int n_intr;
+	int last_virq = NO_IRQ;
+	int virq;
+	unsigned int addr;
+	unsigned long buid = -1;
+	struct device_node * dn;
+
+	dn = pci_device_to_OF_node(pdev);
+
+	if (!of_find_property(dn, "ibm,req#msi", &dummy))
+		return -ENOENT;
+
+	reg = (u32 *) get_property(dn, "reg", &reglen);
+	if (reg == NULL || reglen < 20)
+		return -ENXIO;
+
+	devfn = (reg[0] >> 8) & 0xff;
+	busno = (reg[0] >> 16) & 0xff;
+
+	buid = get_phb_buid(dn->parent);
+	addr = (busno << 16) | (devfn << 8);
+
+	do {
+		rc = rtas_call(rtas_token("ibm,change-msi"), 6, 3, ret, addr,
+			       buid >> 32, buid & 0xffffffff,
+			       0, 0, seq_num);
+
+		seq_num = ret[1];
+	} while (rtas_busy_delay(rc));
+
+	if (rc)	{
+		printk(KERN_WARNING "error[%d]: getting the number of "
+		       "MSI interrupts for %s\n", rc, dn->name);
+		return -EIO;
+	}
+
+	/* Return if there's no MSI interrupts */
+	if (!ret[0])
+		return -ENOENT;
+
+	n_intr = ret[0];
+
+	for (i = 0; i < n_intr; i++) {
+		do {
+			rc = rtas_call(query_token, 4, 3, ret, addr,
+				       buid >> 32, buid & 0xffffffff, i);
+		} while (rtas_busy_delay(rc));
+
+		if (!rc) {
+			virq = irq_create_mapping(irq_find_host(dn), ret[0],
+						ret[1] ? IRQ_TYPE_EDGE_RISING :
+						IRQ_TYPE_LEVEL_LOW);
+
+			/* for now, take the last valid vector given out */
+			if (virq != NO_IRQ)
+				last_virq = virq;
+
+		} else {
+			printk(KERN_WARNING "error[%d]: "
+			       "query-interrupt-source-number for %s\n",
+			       rc, dn->name);
+		}
+	}
+
+	/*
+	 * If we can't get any MSI vectors, fail and try falling
+	 * back to LSI
+	 */
+	if (last_virq == NO_IRQ)
+		return -EIO;
+
+	pdev->irq = last_virq;
+
+	return 0;
+}
+
+void rtas_disable_msi(struct pci_dev* pdev)
+{
+	/*
+	 * for now, we don't give firmware back vectors to their pool
+	 */
+}
Index: 2.6-msi/drivers/pci/Kconfig
===================================================================
--- 2.6-msi.orig/drivers/pci/Kconfig
+++ 2.6-msi/drivers/pci/Kconfig
@@ -4,7 +4,7 @@
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
-	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
+	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || PPC_PSERIES
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
Index: 2.6-msi/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- 2.6-msi.orig/arch/powerpc/platforms/pseries/setup.c
+++ 2.6-msi/arch/powerpc/platforms/pseries/setup.c
@@ -267,6 +267,10 @@ static void __init pseries_discover_pic(
 			return;
 		} else if (strstr(typep, "ppc-xicp")) {
 			ppc_md.init_IRQ       = xics_init_IRQ;
+#ifdef CONFIG_PCI_MSI
+			ppc_md.enable_msi	= rtas_enable_msi;
+			ppc_md.disable_msi	= rtas_disable_msi;
+#endif
 #ifdef CONFIG_KEXEC
 			ppc_md.kexec_cpu_down = pseries_kexec_cpu_down_xics;
 #endif
Index: 2.6-msi/include/asm-powerpc/rtas.h
===================================================================
--- 2.6-msi.orig/include/asm-powerpc/rtas.h
+++ 2.6-msi/include/asm-powerpc/rtas.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/page.h>
+#include <linux/pci.h>
 
 /*
  * Definitions for talking to the RTAS on CHRP machines.
@@ -186,6 +187,9 @@ extern int early_init_dt_scan_rtas(unsig
 
 extern void pSeries_log_error(char *buf, unsigned int err_type, int
fatal);
 
+extern int rtas_enable_msi(struct pci_dev* pdev);
+extern void rtas_disable_msi(struct pci_dev * pdev);
+
 /* Error types logged.  */
 #define ERR_FLAG_ALREADY_LOGGED	0x0
 #define ERR_FLAG_BOOT		0x1 	/* log was pulled from NVRAM on boot */
Index: 2.6-msi/arch/powerpc/kernel/prom_init.c
===================================================================
--- 2.6-msi.orig/arch/powerpc/kernel/prom_init.c
+++ 2.6-msi/arch/powerpc/kernel/prom_init.c
@@ -632,6 +632,12 @@ static void __init early_cmdline_parse(v
 /* ibm,dynamic-reconfiguration-memory property supported */
 #define OV5_DRCONF_MEMORY	0x20
 #define OV5_LARGE_PAGES		0x10	/* large pages supported */
+/* PCIe/MSI support.  Without MSI full PCIe is not supported */
+#ifdef CONFIG_PCI_MSI
+#define OV5_MSI			0x01	/* PCIe/MSI support */
+#else
+#define OV5_MSI			0x00
+#endif /* CONFIG_PCI_MSI */
 
 /*
  * The architecture vector has an array of PVR mask/value pairs,
@@ -675,7 +681,7 @@ static unsigned char ibm_architecture_ve
 	/* option vector 5: PAPR/OF options */
 	3 - 1,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES,
+	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_MSI,
 };
 
 /* Old method - ELF header with PT_NOTE sections */
Index: 2.6-msi/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- 2.6-msi.orig/arch/powerpc/platforms/pseries/xics.c
+++ 2.6-msi/arch/powerpc/platforms/pseries/xics.c
@@ -526,11 +526,12 @@ static int xics_host_map_lpar(struct irq
 	pr_debug("xics: map_lpar virq %d, hwirq 0x%lx, flags: 0x%x\n",
 		 virq, hw, flags);
 
-	if (sense && sense != IRQ_TYPE_LEVEL_LOW)
+	if (sense && !(sense & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_RISING)))
 		printk(KERN_WARNING "xics: using unsupported sense 0x%x"
 		       " for irq %d (h: 0x%lx)\n", flags, virq, hw);
 
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	if (sense && sense & IRQ_TYPE_LEVEL_LOW)
+		get_irq_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &xics_pic_lpar, handle_fasteoi_irq);
 	return 0;
 }
