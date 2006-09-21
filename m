Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7F2D4680D7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 22:18:17 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k8LCV3kg023774
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 05:31:03 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8LCIChr013507
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:18:13 -0500 (CDT)
Message-ID: <45128328.90401@freescale.com>
Date: Thu, 21 Sep 2006 20:18:48 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/11] qe_lib: Add QE I/O ports API
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/sysdev/qe_lib/qe_io.c |  272 ++++++++++++++++++++++++++++++++++++
 1 files changed, 272 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
new file mode 100644
index 0000000..e905d35
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -0,0 +1,272 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
+ *
+ * Description:
+ * QE Parallel I/O ports configuration routines.  Based on code from
+ * Shlomi Gridish <gridish@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+#undef DEBUG
+
+#define NUM_OF_PINS     32
+#define NUM_OF_PAR_IOS  7
+
+typedef struct par_io {
+	struct {
+		u32 cpodr;	/* Open drain register */
+		u32 cpdata;	/* Data register */
+		u32 cpdir1;	/* Direction register */
+		u32 cpdir2;	/* Direction register */
+		u32 cppar1;	/* Pin assignment register */
+		u32 cppar2;	/* Pin assignment register */
+	} io_regs[NUM_OF_PAR_IOS];
+} par_io_t;
+
+typedef struct qe_par_io {
+	u8 res[0xc];
+	u32 cepier;		/* QE ports interrupt event register */
+	u32 cepimr;		/* QE ports mask event register */
+	u32 cepicr;		/* QE ports control event register */
+} qe_par_io_t;
+
+static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] = {
+	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /* 24 - 31 */
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0, 0,0,0,0,0,1,1,0},
+	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 0,0,1,1,0,0,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,1,1,1,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0, 0,0,1,1,0,0,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 1,1,1,1,0,0,0,1},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0, 0,0,0,0,0,0,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1}
+};
+
+
+static u8 get_irq_num(u8 port, u8 pin)
+{
+	int i, j;
+	u8 num = 0;
+
+	if (qe_irq_ports[port][pin] == 0) 
+		return -1;
+	for (j = 0; j <= port; j++)
+		for (i = 0; i < pin; i++)
+			if (qe_irq_ports[j][i])
+				num++;
+	return num;
+}
+
+static par_io_t *par_io = NULL;
+static qe_par_io_t *qe_par_io = NULL;
+
+int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+		      int assignment, int has_irq)
+{
+	u32 pinMask1bit, pinMask2bits, newMask2bits, tmp_val;
+
+	if (!par_io) {
+		par_io = (par_io_t *) ioremap(get_immrbase() + 0x1400,
+					      sizeof(par_io_t));
+		qe_par_io = (qe_par_io_t *) ioremap(get_immrbase() + 0xC00,
+						    sizeof(qe_par_io_t));
+
+		/* clear event bits in the event register of the QE ports */
+		out_be32(&qe_par_io->cepier, 0xFFFFFFFF);
+	}
+
+	/* calculate pin location for single and 2 bits  information */
+	pinMask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
+
+	/* Set open drain, if required */
+	tmp_val = in_be32(&par_io->io_regs[port].cpodr);
+	if (open_drain)
+		out_be32(&par_io->io_regs[port].cpodr, pinMask1bit | tmp_val);
+	else
+		out_be32(&par_io->io_regs[port].cpodr, ~pinMask1bit & tmp_val);
+
+	/* define direction */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+	    in_be32(&par_io->io_regs[port].cpdir2) :
+	    in_be32(&par_io->io_regs[port].cpdir1);
+
+	/* get all bits mask for 2 bit per port */
+	pinMask2bits = (u32) (0x3 <<
+			      (NUM_OF_PINS -
+			       (pin % (NUM_OF_PINS / 2) + 1) * 2));
+
+	/* Get the final mask we need for the right definition */
+	newMask2bits = (u32) (dir <<
+			      (NUM_OF_PINS -
+			       (pin % (NUM_OF_PINS / 2) + 1) * 2));
+
+	/* clear and set 2 bits mask */
+	if (pin > (NUM_OF_PINS / 2) - 1) {
+		out_be32(&par_io->io_regs[port].cpdir2,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cpdir2, newMask2bits | tmp_val);
+	} else {
+		out_be32(&par_io->io_regs[port].cpdir1,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cpdir1, newMask2bits | tmp_val);
+	}
+	/* define pin assignment */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+	    in_be32(&par_io->io_regs[port].cppar2) :
+	    in_be32(&par_io->io_regs[port].cppar1);
+
+	newMask2bits = (u32) (assignment << (NUM_OF_PINS -
+			(pin % (NUM_OF_PINS / 2) + 1) * 2));
+	/* clear and set 2 bits mask */
+	if (pin > (NUM_OF_PINS / 2) - 1) {
+		out_be32(&par_io->io_regs[port].cppar2,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cppar2, newMask2bits | tmp_val);
+	} else {
+		out_be32(&par_io->io_regs[port].cppar1,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cppar1, newMask2bits | tmp_val);
+	}
+
+	/* Set interrupt mask if the pin generates interrupt */
+	if (has_irq) {
+		int irq = get_irq_num(port, pin);
+		u32 mask = 0;
+
+		if (irq == -1) {
+			printk(KERN_WARNING "Port %d, pin %d is can't be "
+					"interrupt\n", port, pin);
+			return -EINVAL;
+		}
+		mask = 0x80000000 >> irq;
+
+		tmp_val = in_be32(&qe_par_io->cepimr);
+		out_be32(&qe_par_io->cepimr, mask | tmp_val);
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(par_io_config_pin);
+
+int par_io_data_set(u8 port, u8 pin, u8 val)
+{
+	u32 pin_mask, tmp_val;
+
+	if (port >= NUM_OF_PAR_IOS)
+		return -EINVAL;
+	if (pin >= NUM_OF_PINS)
+		return -EINVAL;
+	/* calculate pin location */
+	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
+
+	tmp_val = in_be32(&par_io->io_regs[port].cpdata);
+
+	if (val == 0)		/* clear  */
+		out_be32(&par_io->io_regs[port].cpdata, ~pin_mask & tmp_val);
+	else			/* set */
+		out_be32(&par_io->io_regs[port].cpdata, pin_mask | tmp_val);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(par_io_data_set);
+
+int par_io_of_config(struct device_node *np)
+{
+	struct device_node *pio;
+	phandle *ph;
+	int pio_map_len;
+	unsigned int *pio_map;
+	
+	ph = (phandle *) get_property(np, "pio-handle", NULL);
+	if (ph == 0) {
+		printk(KERN_ERR "pio-handle not available \n");
+		return -1;
+	}
+		
+	pio = of_find_node_by_phandle(*ph);
+
+	pio_map = (unsigned int *)
+		get_property(pio, "pio-map", &pio_map_len);
+	if (pio_map == NULL) {
+		printk(KERN_ERR "pio-map is not set! \n");
+		return -1;
+	}
+	pio_map_len /= sizeof(unsigned int);
+	if ((pio_map_len % 6) != 0) {
+		printk(KERN_ERR "pio-map format wrong! \n");
+		return -1;
+	}
+
+	while (pio_map_len > 0) {
+		par_io_config_pin((u8) pio_map[0], (u8) pio_map[1],
+				(int) pio_map[2], (int) pio_map[3],
+				(int) pio_map[4], (int) pio_map[5]);
+		pio_map += 6;
+		pio_map_len -= 6;
+	}
+	of_node_put(pio);
+	return 0;
+}
+EXPORT_SYMBOL(par_io_of_config);
+
+#ifdef DEBUG
+static void dump_par_io(void)
+{
+	int i;
+
+	printk(KERN_INFO "PAR IO registars:\n");
+	printk(KERN_INFO "Base address: 0x%08x\n", (u32) par_io);
+	for (i = 0; i < NUM_OF_PAR_IOS; i++) {
+		printk(KERN_INFO "cpodr[%d] : addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpodr,
+		       in_be32(&par_io->io_regs[i].cpodr));
+		printk(KERN_INFO "cpdata[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpdata,
+		       in_be32(&par_io->io_regs[i].cpdata));
+		printk(KERN_INFO "cpdir1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpdir1,
+		       in_be32(&par_io->io_regs[i].cpdir1));
+		printk(KERN_INFO "cpdir2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpdir2,
+		       in_be32(&par_io->io_regs[i].cpdir2));
+		printk(KERN_INFO "cppar1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cppar1,
+		       in_be32(&par_io->io_regs[i].cppar1));
+		printk(KERN_INFO "cppar2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cppar2,
+		       in_be32(&par_io->io_regs[i].cppar2));
+	}
+
+	printk(KERN_INFO "QE PAR IO registars:\n");
+	printk(KERN_INFO "Base address: 0x%08x\n", (u32) qe_par_io);
+	printk(KERN_INFO "cepier : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & qe_par_io->cepier, in_be32(&qe_par_io->cepier));
+	printk(KERN_INFO "cepimr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & qe_par_io->cepimr, in_be32(&qe_par_io->cepimr));
+	printk(KERN_INFO "cepicr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & qe_par_io->cepicr, in_be32(&qe_par_io->cepicr));
+}
+
+EXPORT_SYMBOL(dump_par_io);
+#endif
