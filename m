Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BFB74DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 02:19:49 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l45GJkX9032364
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:19:46 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l45GJkUE510276
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:19:46 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l45GJk3W008997
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:19:46 -0400
Received: from [9.67.207.4] (wecm-9-67-207-4.wecm.ibm.com [9.67.207.4])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l45GJjlQ008990
	for <linuxppc-dev@ozlabs.org>; Sat, 5 May 2007 12:19:46 -0400
Subject: [PATCH v2 0/1] Add tsi108_pci.h for common PCI functions
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1178381611.3393.25.camel@zod.rchland.ibm.com>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 05 May 2007 11:14:39 -0500
Message-Id: <1178381679.3393.26.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a header file for the common PCI routines used for the TSI bridge

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    5 --
 arch/powerpc/sysdev/tsi108_pci.c                  |    1 
 include/asm-powerpc/tsi108_pci.h                  |   45 ++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -41,6 +41,7 @@
 #include <asm/reg.h>
 #include <mm/mmu_decl.h>
 #include "mpc7448_hpc2.h"
+#include <asm/tsi108_pci.h>
 #include <asm/tsi108_irq.h>
 #include <asm/mpic.h>
 
@@ -57,10 +58,7 @@ isa_mem_base = MPC7448_HPC2_ISA_MEM_BASE
 pci_dram_offset = MPC7448_HPC2_PCI_MEM_OFFSET;
 #endif
 
-extern int tsi108_setup_pci(struct device_node *dev);
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
-extern void tsi108_pci_int_init(struct device_node *node);
-extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
 
 int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
 {
@@ -210,7 +208,6 @@ static int __init mpc7448_hpc2_probe(voi
 
 static int mpc7448_machine_check_exception(struct pt_regs *regs)
 {
-	extern void tsi108_clear_pci_cfg_error(void);
 	const struct exception_table_entry *entry;
 
 	/* Are we prepared to handle this fault */
--- linux-2.6.orig/arch/powerpc/sysdev/tsi108_pci.c
+++ linux-2.6/arch/powerpc/sysdev/tsi108_pci.c
@@ -35,6 +35,7 @@
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <asm/tsi108.h>
+#include <asm/tsi108_pci.h>
 #include <asm/tsi108_irq.h>
 #include <asm/prom.h>
 
--- /dev/null
+++ linux-2.6/include/asm-powerpc/tsi108_pci.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2007 IBM Corp
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#ifndef _ASM_PPC_TSI108_PCI_H
+#define _ASM_PPC_TSI108_PCI_H
+
+#include <asm/tsi108.h>
+
+/* Register definitions */
+#define TSI108_PCI_P2O_BAR0 (TSI108_PCI_OFFSET + 0x10)
+#define TSI108_PCI_P2O_BAR0_UPPER (TSI108_PCI_OFFSET + 0x14)
+#define TSI108_PCI_P2O_BAR2 (TSI108_PCI_OFFSET + 0x18)
+#define TSI108_PCI_P2O_BAR2_UPPER (TSI108_PCI_OFFSET + 0x1c)
+#define TSI108_PCI_P2O_PAGE_SIZES (TSI108_PCI_OFFSET + 0x4c)
+#define TSI108_PCI_PFAB_BAR0 (TSI108_PCI_OFFSET + 0x204)
+#define TSI108_PCI_PFAB_BAR0_UPPER (TSI108_PCI_OFFSET + 0x208)
+#define TSI108_PCI_PFAB_IO (TSI108_PCI_OFFSET + 0x20c)
+#define TSI108_PCI_PFAB_IO_UPPER (TSI108_PCI_OFFSET + 0x210)
+#define TSI108_PCI_PFAB_MEM32 (TSI108_PCI_OFFSET + 0x214)
+#define TSI108_PCI_PFAB_PFM3 (TSI108_PCI_OFFSET + 0x220)
+#define TSI108_PCI_PFAB_PFM4 (TSI108_PCI_OFFSET + 0x230)
+
+extern int tsi108_setup_pci(struct device_node *dev);
+extern void tsi108_pci_int_init(struct device_node *node);
+extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
+extern void tsi108_clear_pci_cfg_error(void);
+
+#endif				/*  _ASM_PPC_TSI108_PCI_H */
