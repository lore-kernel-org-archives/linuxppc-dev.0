Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8E46267D8E
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 20:34:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8TAYeXs000828
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 03:34:40 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8TAYbME011959
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:34:38 -0500 (CDT)
Message-ID: <451CF6E4.5040108@freescale.com>
Date: Fri, 29 Sep 2006 18:35:16 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 3/9] qe_lib: Add QE I/O ports API
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/sysdev/qe_lib/qe_io.c |  230 ++++++++++++++++++++++++++++++++++++
 1 files changed, 230 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
new file mode 100644
index 0000000..d31dafa
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -0,0 +1,230 @@
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
+#include <linux/ioport.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+#undef DEBUG
+
+#define NUM_OF_PINS     32
+
+struct port_regs {
+		u32 cpodr;	/* Open drain register */
+		u32 cpdata;	/* Data register */
+		u32 cpdir1;	/* Direction register */
+		u32 cpdir2;	/* Direction register */
+		u32 cppar1;	/* Pin assignment register */
+		u32 cppar2;	/* Pin assignment register */
+};
+
+static struct port_regs *par_io = NULL;
+static int num_par_io_ports = 0;
+
+int par_io_init(struct device_node *np)
+{
+	struct resource res;
+	int ret;
+	u32 *num_ports;
+
+	/* Map Parallel I/O ports registers */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+	par_io = (struct port_regs *)ioremap(res.start, res.end - res.start + 1);
+
+	num_ports = get_property(np, "num-ports", NULL);
+	if (num_ports)
+		num_par_io_ports = *num_ports;
+
+	return 0;
+}
+
+int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+		      int assignment, int has_irq)
+{
+	u32 pinMask1bit, pinMask2bits, newMask2bits, tmp_val;
+
+	if (!par_io)
+		return -1;
+	
+	/* calculate pin location for single and 2 bits  information */
+	pinMask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
+
+	/* Set open drain, if required */
+	tmp_val = in_be32(&par_io[port].cpodr);
+	if (open_drain)
+		out_be32(&par_io[port].cpodr, pinMask1bit | tmp_val);
+	else
+		out_be32(&par_io[port].cpodr, ~pinMask1bit & tmp_val);
+
+	/* define direction */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+	    in_be32(&par_io[port].cpdir2) :
+	    in_be32(&par_io[port].cpdir1);
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
+		out_be32(&par_io[port].cpdir2,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io[port].cpdir2, newMask2bits | tmp_val);
+	} else {
+		out_be32(&par_io[port].cpdir1,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io[port].cpdir1, newMask2bits | tmp_val);
+	}
+	/* define pin assignment */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+	    in_be32(&par_io[port].cppar2) :
+	    in_be32(&par_io[port].cppar1);
+
+	newMask2bits = (u32) (assignment << (NUM_OF_PINS -
+			(pin % (NUM_OF_PINS / 2) + 1) * 2));
+	/* clear and set 2 bits mask */
+	if (pin > (NUM_OF_PINS / 2) - 1) {
+		out_be32(&par_io[port].cppar2,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io[port].cppar2, newMask2bits | tmp_val);
+	} else {
+		out_be32(&par_io[port].cppar1,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io[port].cppar1, newMask2bits | tmp_val);
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
+	if (port >= num_par_io_ports)
+		return -EINVAL;
+	if (pin >= NUM_OF_PINS)
+		return -EINVAL;
+	/* calculate pin location */
+	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
+
+	tmp_val = in_be32(&par_io[port].cpdata);
+
+	if (val == 0)		/* clear  */
+		out_be32(&par_io[port].cpdata, ~pin_mask & tmp_val);
+	else			/* set */
+		out_be32(&par_io[port].cpdata, pin_mask | tmp_val);
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
+	if (par_io == NULL) {
+		printk(KERN_ERR "par_io not initialized \n");
+		return -1;
+	}
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
+	for (i = 0; i < num_par_io_ports; i++) {
+		printk(KERN_INFO "cpodr[%d] : addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpodr,
+		       in_be32(&par_io[i].cpodr));
+		printk(KERN_INFO "cpdata[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpdata,
+		       in_be32(&par_io[i].cpdata));
+		printk(KERN_INFO "cpdir1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpdir1,
+		       in_be32(&par_io[i].cpdir1));
+		printk(KERN_INFO "cpdir2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpdir2,
+		       in_be32(&par_io[i].cpdir2));
+		printk(KERN_INFO "cppar1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cppar1,
+		       in_be32(&par_io[i].cppar1));
+		printk(KERN_INFO "cppar2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cppar2,
+		       in_be32(&par_io[i].cppar2));
+	}
+
+}
+
+EXPORT_SYMBOL(dump_par_io);
+#endif
