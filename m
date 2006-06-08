Return-Path: <moilanen@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E1E267C27
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 02:21:36 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k58GLWsA015975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 12:21:32 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k58GLVgr276294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 10:21:31 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k58GLVt5026031
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 10:21:31 -0600
Date: Thu, 8 Jun 2006 11:13:13 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 3/3] RTAS MSI
Message-Id: <20060608111313.26e43995.moilanen@austin.ibm.com>
In-Reply-To: <20060607225843.GW8934@localdomain>
References: <20060607160212.1203d9ea.moilanen@austin.ibm.com>
	<20060607162540.f53bc270.moilanen@austin.ibm.com>
	<20060607225843.GW8934@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a version addressing Nathan's concerns.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

Index: 2.6/drivers/pci/Makefile
===================================================================
--- 2.6.orig/drivers/pci/Makefile	2006-06-08 10:30:14.000000000 -0500
+++ 2.6/drivers/pci/Makefile	2006-06-08 10:30:21.000000000 -0500
@@ -26,7 +26,14 @@
 obj-$(CONFIG_PPC64) += setup-bus.o
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
-obj-$(CONFIG_PCI_MSI) += msi.o
+
+msiobj-$(CONFIG_X86) += msi.o msi-apic.o msi-intel.o
+msiobj-$(CONFIG_IA64) += msi.o msi-apic.o msi-intel.o
+msiobj-$(CONFIG_IA64_GENERIC) += msi.o msi-altix.o
+msiobj-$(CONFIG_IA64_SGI_SN2) += msi.o msi-altix.o
+msiobj-$(CONFIG_PPC_PSERIES) += msi-rtas.o
+
+obj-$(CONFIG_PCI_MSI) += $(msiobj-y)
 
 #
 # ACPI Related PCI FW Functions
Index: 2.6/drivers/pci/msi-rtas.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6/drivers/pci/msi-rtas.c	2006-06-08 10:51:13.000000000 -0500
@@ -0,0 +1,150 @@
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
+	int seq_num = 1;
+	int i;
+	int rc;
+	int query_token = rtas_token("ibm,query-interrupt-source-number");
+	int devfn;
+	int busno;
+	u32 *reg;
+	int reglen;
+	int ret[3];
+	int dummy;
+	unsigned int virq;
+	unsigned int addr;
+	unsigned long buid = -1;
+	struct device_node * dn;
+
+	BUG_ON(!pdev);
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
+	if (rc)
+	{
+		printk(KERN_WARNING "error[%d]: getting the number of "
+		       "MSI interrupts for %s\n", rc, dn->name);
+		return -EIO;
+	}
+
+	/* Return if there's no MSI interrupts */
+	if (!ret[0])
+		return -ENOENT;
+
+	dn->n_intrs = ret[0];
+
+	dn->intrs = kmalloc(dn->n_intrs * sizeof(*(dn->intrs)), GFP_KERNEL);
+	if (!dn->intrs) {
+		printk(KERN_WARNING "rtas_enable_msi: can't allocate space\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < dn->n_intrs; i++) {
+		do {
+			rc = rtas_call(query_token, 4, 3, ret, addr,
+				       buid >> 32, buid & 0xffffffff, i);
+		} while (rtas_busy_delay(rc));
+
+		if (!rc) {
+			virq = virt_irq_create_mapping(ret[0]);
+
+			dn->intrs[i].line = irq_offset_up(virq);
+			dn->intrs[i].sense = ret[1];
+		} else {
+			printk(KERN_WARNING "error[%d]: query-interrupt-source-number for %s\n",
+			       rc, dn->name);
+		}
+	}
+
+	/* Just give the first vector out for now */
+	pdev->irq = dn->intrs[0].line;
+
+	return 0;
+}
+
+void rtas_disable_msi(struct pci_dev* pdev)
+{
+	int seq_num = 1;
+	struct device_node * dn;
+	int rc;
+	int devfn;
+	int busno;
+	u32 *reg;
+	int reglen;
+	int ret[3];
+	int dummy;
+	unsigned int addr;
+	unsigned long buid = -1;
+
+	BUG_ON(!pdev);
+
+	dn = pci_device_to_OF_node(pdev);
+
+	if (!of_find_property(dn, "ibm,req#msi", &dummy))
+		return;
+
+	reg = (u32 *) get_property(dn, "reg", &reglen);
+	if (reg == NULL || reglen < 20)
+		return;
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
+			       2, 0, seq_num);
+
+		seq_num = ret[1];
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		printk(KERN_WARNING "error[%d]: setting the number of "
+		       "MSI interrupts for %s\n", rc, dn->name);
+		return;
+	}
+
+	dn->n_intrs = 0;
+
+	kfree(dn->intrs);
+}
Index: 2.6/drivers/pci/Kconfig
===================================================================
--- 2.6.orig/drivers/pci/Kconfig	2006-06-08 10:30:14.000000000 -0500
+++ 2.6/drivers/pci/Kconfig	2006-06-08 10:30:21.000000000 -0500
@@ -4,7 +4,7 @@
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
-	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64
+	depends on (X86_LOCAL_APIC && X86_IO_APIC) || IA64 || PPC_PSERIES
 	help
 	   This allows device drivers to enable MSI (Message Signaled
 	   Interrupts).  Message Signaled Interrupts enable a device to
Index: 2.6/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/pseries/setup.c	2006-06-08 10:30:14.000000000 -0500
+++ 2.6/arch/powerpc/platforms/pseries/setup.c	2006-06-08 10:30:21.000000000 -0500
@@ -205,6 +205,10 @@
 	} else {
 		ppc_md.init_IRQ       = xics_init_IRQ;
 		ppc_md.get_irq        = xics_get_irq;
+#ifdef CONFIG_PCI_MSI
+		ppc_md.enable_msi	= rtas_enable_msi;
+		ppc_md.disable_msi	= rtas_disable_msi;
+#endif
 	}
 
 #ifdef CONFIG_SMP
Index: 2.6/include/asm-powerpc/rtas.h
===================================================================
--- 2.6.orig/include/asm-powerpc/rtas.h	2006-06-08 10:30:21.000000000 -0500
+++ 2.6/include/asm-powerpc/rtas.h	2006-06-08 10:30:21.000000000 -0500
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/page.h>
+#include <linux/pci.h>
 
 /*
  * Definitions for talking to the RTAS on CHRP machines.
@@ -182,6 +183,9 @@
 
 extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
 
+extern int rtas_enable_msi(struct pci_dev* pdev);
+extern void rtas_disable_msi(struct pci_dev * pdev);
+
 /* Error types logged.  */
 #define ERR_FLAG_ALREADY_LOGGED	0x0
 #define ERR_FLAG_BOOT		0x1 	/* log was pulled from NVRAM on boot */
