Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E0A9E67B22
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 18:15:04 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8M9YlMZ020605
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 03:34:47 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8M8ExMO025366
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 03:15:00 -0500 (CDT)
Message-ID: <45139BA2.4000805@freescale.com>
Date: Fri, 22 Sep 2006 16:15:30 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH12/11] qe_lib: Fix QE I/O ports API
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove QE I/O ports interrupt code.  Read register base and 
I/O ports number from device tree.

Signed-off-by: Li Yang <leoli@freescale.com>

---
This patch is patched on [PATCH 0/11] Add support for QE and 
8360EMDS board series.

 arch/powerpc/boot/dts/mpc8360emds.dts     |    2 
 arch/powerpc/platforms/83xx/mpc8360e_pb.c |    9 +-
 arch/powerpc/platforms/83xx/mpc8360e_pb.h |    1 
 arch/powerpc/sysdev/qe_lib/qe_io.c        |  160 +++++++++++------------------
 4 files changed, 69 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8360emds.dts b/arch/powerpc/boot/dts/mpc8360emds.dts
index ad3beec..afa953e 100644
--- a/arch/powerpc/boot/dts/mpc8360emds.dts
+++ b/arch/powerpc/boot/dts/mpc8360emds.dts
@@ -188,6 +188,8 @@
 		par_io@1400 {
 			reg = <1400 100>;
 			device_type = "par_io";
+			num-ports = <7>;
+
 			ucc_pin@01 {
 				linux,phandle = <140001>;
 				pio-map = <
diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
index b4692d7..9d101ae 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
@@ -98,8 +98,13 @@ #endif
 #ifdef CONFIG_QUICC_ENGINE
 	qe_reset();
 
-	for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
-		par_io_of_config(np);
+	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
+		par_io_init(np);
+		of_node_put(np);
+		
+		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
+			par_io_of_config(np);
+	}
 	
 	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth")) 
 			!= NULL){
diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.h b/arch/powerpc/platforms/83xx/mpc8360e_pb.h
index 84282e5..c83bb88 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.h
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.h
@@ -25,6 +25,7 @@ #define BCSR_SIZE		((uint)(32 * 1024))
 
 #ifdef CONFIG_QUICC_ENGINE
 extern void qe_reset(void);
+extern int par_io_init(struct device_node *np);
 extern int par_io_of_config(struct device_node *np);
 #endif  /* CONFIG_QUICC_ENGINE */
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index e905d35..d31dafa 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -19,6 +19,7 @@ #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/module.h>
+#include <linux/ioport.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -26,84 +27,60 @@ #include <sysdev/fsl_soc.h>
 #undef DEBUG
 
 #define NUM_OF_PINS     32
-#define NUM_OF_PAR_IOS  7
 
-typedef struct par_io {
-	struct {
+struct port_regs {
 		u32 cpodr;	/* Open drain register */
 		u32 cpdata;	/* Data register */
 		u32 cpdir1;	/* Direction register */
 		u32 cpdir2;	/* Direction register */
 		u32 cppar1;	/* Pin assignment register */
 		u32 cppar2;	/* Pin assignment register */
-	} io_regs[NUM_OF_PAR_IOS];
-} par_io_t;
-
-typedef struct qe_par_io {
-	u8 res[0xc];
-	u32 cepier;		/* QE ports interrupt event register */
-	u32 cepimr;		/* QE ports mask event register */
-	u32 cepicr;		/* QE ports control event register */
-} qe_par_io_t;
-
-static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] = {
-	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /* 24 - 31 */
-	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0, 0,0,0,0,0,1,1,0},
-	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 0,0,1,1,0,0,0,0},
-	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,1,1,1,0,0},
-	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0, 0,0,1,1,0,0,0,0},
-	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 1,1,1,1,0,0,0,1},
-	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0, 0,0,0,0,0,0,0,0},
-	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1}
 };
 
+static struct port_regs *par_io = NULL;
+static int num_par_io_ports = 0;
 
-static u8 get_irq_num(u8 port, u8 pin)
+int par_io_init(struct device_node *np)
 {
-	int i, j;
-	u8 num = 0;
+	struct resource res;
+	int ret;
+	u32 *num_ports;
 
-	if (qe_irq_ports[port][pin] == 0) 
-		return -1;
-	for (j = 0; j <= port; j++)
-		for (i = 0; i < pin; i++)
-			if (qe_irq_ports[j][i])
-				num++;
-	return num;
-}
+	/* Map Parallel I/O ports registers */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+	par_io = (struct port_regs *)ioremap(res.start, res.end - res.start + 1);
+
+	num_ports = get_property(np, "num-ports", NULL);
+	if (num_ports)
+		num_par_io_ports = *num_ports;
 
-static par_io_t *par_io = NULL;
-static qe_par_io_t *qe_par_io = NULL;
+	return 0;
+}
 
 int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 		      int assignment, int has_irq)
 {
 	u32 pinMask1bit, pinMask2bits, newMask2bits, tmp_val;
 
-	if (!par_io) {
-		par_io = (par_io_t *) ioremap(get_immrbase() + 0x1400,
-					      sizeof(par_io_t));
-		qe_par_io = (qe_par_io_t *) ioremap(get_immrbase() + 0xC00,
-						    sizeof(qe_par_io_t));
-
-		/* clear event bits in the event register of the QE ports */
-		out_be32(&qe_par_io->cepier, 0xFFFFFFFF);
-	}
-
+	if (!par_io)
+		return -1;
+	
 	/* calculate pin location for single and 2 bits  information */
 	pinMask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
 
 	/* Set open drain, if required */
-	tmp_val = in_be32(&par_io->io_regs[port].cpodr);
+	tmp_val = in_be32(&par_io[port].cpodr);
 	if (open_drain)
-		out_be32(&par_io->io_regs[port].cpodr, pinMask1bit | tmp_val);
+		out_be32(&par_io[port].cpodr, pinMask1bit | tmp_val);
 	else
-		out_be32(&par_io->io_regs[port].cpodr, ~pinMask1bit & tmp_val);
+		out_be32(&par_io[port].cpodr, ~pinMask1bit & tmp_val);
 
 	/* define direction */
 	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
-	    in_be32(&par_io->io_regs[port].cpdir2) :
-	    in_be32(&par_io->io_regs[port].cpdir1);
+	    in_be32(&par_io[port].cpdir2) :
+	    in_be32(&par_io[port].cpdir1);
 
 	/* get all bits mask for 2 bit per port */
 	pinMask2bits = (u32) (0x3 <<
@@ -117,50 +94,34 @@ int par_io_config_pin(u8 port, u8 pin, i
 
 	/* clear and set 2 bits mask */
 	if (pin > (NUM_OF_PINS / 2) - 1) {
-		out_be32(&par_io->io_regs[port].cpdir2,
+		out_be32(&par_io[port].cpdir2,
 			 ~pinMask2bits & tmp_val);
 		tmp_val &= ~pinMask2bits;
-		out_be32(&par_io->io_regs[port].cpdir2, newMask2bits | tmp_val);
+		out_be32(&par_io[port].cpdir2, newMask2bits | tmp_val);
 	} else {
-		out_be32(&par_io->io_regs[port].cpdir1,
+		out_be32(&par_io[port].cpdir1,
 			 ~pinMask2bits & tmp_val);
 		tmp_val &= ~pinMask2bits;
-		out_be32(&par_io->io_regs[port].cpdir1, newMask2bits | tmp_val);
+		out_be32(&par_io[port].cpdir1, newMask2bits | tmp_val);
 	}
 	/* define pin assignment */
 	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
-	    in_be32(&par_io->io_regs[port].cppar2) :
-	    in_be32(&par_io->io_regs[port].cppar1);
+	    in_be32(&par_io[port].cppar2) :
+	    in_be32(&par_io[port].cppar1);
 
 	newMask2bits = (u32) (assignment << (NUM_OF_PINS -
 			(pin % (NUM_OF_PINS / 2) + 1) * 2));
 	/* clear and set 2 bits mask */
 	if (pin > (NUM_OF_PINS / 2) - 1) {
-		out_be32(&par_io->io_regs[port].cppar2,
+		out_be32(&par_io[port].cppar2,
 			 ~pinMask2bits & tmp_val);
 		tmp_val &= ~pinMask2bits;
-		out_be32(&par_io->io_regs[port].cppar2, newMask2bits | tmp_val);
+		out_be32(&par_io[port].cppar2, newMask2bits | tmp_val);
 	} else {
-		out_be32(&par_io->io_regs[port].cppar1,
+		out_be32(&par_io[port].cppar1,
 			 ~pinMask2bits & tmp_val);
 		tmp_val &= ~pinMask2bits;
-		out_be32(&par_io->io_regs[port].cppar1, newMask2bits | tmp_val);
-	}
-
-	/* Set interrupt mask if the pin generates interrupt */
-	if (has_irq) {
-		int irq = get_irq_num(port, pin);
-		u32 mask = 0;
-
-		if (irq == -1) {
-			printk(KERN_WARNING "Port %d, pin %d is can't be "
-					"interrupt\n", port, pin);
-			return -EINVAL;
-		}
-		mask = 0x80000000 >> irq;
-
-		tmp_val = in_be32(&qe_par_io->cepimr);
-		out_be32(&qe_par_io->cepimr, mask | tmp_val);
+		out_be32(&par_io[port].cppar1, newMask2bits | tmp_val);
 	}
 
 	return 0;
@@ -172,19 +133,19 @@ int par_io_data_set(u8 port, u8 pin, u8 
 {
 	u32 pin_mask, tmp_val;
 
-	if (port >= NUM_OF_PAR_IOS)
+	if (port >= num_par_io_ports)
 		return -EINVAL;
 	if (pin >= NUM_OF_PINS)
 		return -EINVAL;
 	/* calculate pin location */
 	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
 
-	tmp_val = in_be32(&par_io->io_regs[port].cpdata);
+	tmp_val = in_be32(&par_io[port].cpdata);
 
 	if (val == 0)		/* clear  */
-		out_be32(&par_io->io_regs[port].cpdata, ~pin_mask & tmp_val);
+		out_be32(&par_io[port].cpdata, ~pin_mask & tmp_val);
 	else			/* set */
-		out_be32(&par_io->io_regs[port].cpdata, pin_mask | tmp_val);
+		out_be32(&par_io[port].cpdata, pin_mask | tmp_val);
 
 	return 0;
 }
@@ -197,6 +158,11 @@ int par_io_of_config(struct device_node 
 	phandle *ph;
 	int pio_map_len;
 	unsigned int *pio_map;
+
+	if (par_io == NULL) {
+		printk(KERN_ERR "par_io not initialized \n");
+		return -1;
+	}
 	
 	ph = (phandle *) get_property(np, "pio-handle", NULL);
 	if (ph == 0) {
@@ -237,35 +203,27 @@ static void dump_par_io(void)
 
 	printk(KERN_INFO "PAR IO registars:\n");
 	printk(KERN_INFO "Base address: 0x%08x\n", (u32) par_io);
-	for (i = 0; i < NUM_OF_PAR_IOS; i++) {
+	for (i = 0; i < num_par_io_ports; i++) {
 		printk(KERN_INFO "cpodr[%d] : addr - 0x%08x, val - 0x%08x\n",
-		       i, (u32) & par_io->io_regs[i].cpodr,
-		       in_be32(&par_io->io_regs[i].cpodr));
+		       i, (u32) & par_io[i].cpodr,
+		       in_be32(&par_io[i].cpodr));
 		printk(KERN_INFO "cpdata[%d]: addr - 0x%08x, val - 0x%08x\n",
-		       i, (u32) & par_io->io_regs[i].cpdata,
-		       in_be32(&par_io->io_regs[i].cpdata));
+		       i, (u32) & par_io[i].cpdata,
+		       in_be32(&par_io[i].cpdata));
 		printk(KERN_INFO "cpdir1[%d]: addr - 0x%08x, val - 0x%08x\n",
-		       i, (u32) & par_io->io_regs[i].cpdir1,
-		       in_be32(&par_io->io_regs[i].cpdir1));
+		       i, (u32) & par_io[i].cpdir1,
+		       in_be32(&par_io[i].cpdir1));
 		printk(KERN_INFO "cpdir2[%d]: addr - 0x%08x, val - 0x%08x\n",
-		       i, (u32) & par_io->io_regs[i].cpdir2,
-		       in_be32(&par_io->io_regs[i].cpdir2));
+		       i, (u32) & par_io[i].cpdir2,
+		       in_be32(&par_io[i].cpdir2));
 		printk(KERN_INFO "cppar1[%d]: addr - 0x%08x, val - 0x%08x\n",
-		       i, (u32) & par_io->io_regs[i].cppar1,
-		       in_be32(&par_io->io_regs[i].cppar1));
+		       i, (u32) & par_io[i].cppar1,
+		       in_be32(&par_io[i].cppar1));
 		printk(KERN_INFO "cppar2[%d]: addr - 0x%08x, val - 0x%08x\n",
-		       i, (u32) & par_io->io_regs[i].cppar2,
-		       in_be32(&par_io->io_regs[i].cppar2));
+		       i, (u32) & par_io[i].cppar2,
+		       in_be32(&par_io[i].cppar2));
 	}
 
-	printk(KERN_INFO "QE PAR IO registars:\n");
-	printk(KERN_INFO "Base address: 0x%08x\n", (u32) qe_par_io);
-	printk(KERN_INFO "cepier : addr - 0x%08x, val - 0x%08x\n",
-	       (u32) & qe_par_io->cepier, in_be32(&qe_par_io->cepier));
-	printk(KERN_INFO "cepimr : addr - 0x%08x, val - 0x%08x\n",
-	       (u32) & qe_par_io->cepimr, in_be32(&qe_par_io->cepimr));
-	printk(KERN_INFO "cepicr : addr - 0x%08x, val - 0x%08x\n",
-	       (u32) & qe_par_io->cepicr, in_be32(&qe_par_io->cepicr));
 }
 
 EXPORT_SYMBOL(dump_par_io);
