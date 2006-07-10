Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7114767B6C
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 16:39:34 +1000 (EST)
Subject: [POWERPC] Fix SMU driver interrupt mapping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 16:39:07 +1000
Message-Id: <1152513548.1576.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The SMU driver tries to map an interrupt from the device-tree before the
interrupt controllers in the machine have been enumerated. This doesn't
work properly and cause machines like the Quad g5 to fail booting later
on when some drivers waits endlessly for an SMU request to complete.
This is the second problem preventing boot on the Quad g5. This fixes it
and also makes the SMU driver a bit more resilient to not having an
interrupt.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/drivers/macintosh/smu.c
===================================================================
--- linux-irq-work.orig/drivers/macintosh/smu.c	2006-07-10 12:39:08.000000000 +1000
+++ linux-irq-work/drivers/macintosh/smu.c	2006-07-10 12:41:01.000000000 +1000
@@ -75,9 +75,11 @@
 	struct of_device	*of_dev;
 	int			doorbell;	/* doorbell gpio */
 	u32 __iomem		*db_buf;	/* doorbell buffer */
-	int			db_irq;
+	struct device_node	*db_node;
+	unsigned int		db_irq;
 	int			msg;
-	int			msg_irq;
+	struct device_node	*msg_node;
+	unsigned int		msg_irq;
 	struct smu_cmd_buf	*cmd_buf;	/* command buffer virtual */
 	u32			cmd_buf_abs;	/* command buffer absolute */
 	struct list_head	cmd_list;
@@ -93,6 +95,7 @@
  */
 static struct smu_device	*smu;
 static DEFINE_MUTEX(smu_part_access);
+static int smu_irq_inited;
 
 static void smu_i2c_retry(unsigned long data);
 
@@ -257,6 +260,10 @@
 		smu_start_cmd();
 	spin_unlock_irqrestore(&smu->lock, flags);
 
+	/* Workaround for early calls when irq isn't available */
+	if (!smu_irq_inited || smu->db_irq == NO_IRQ)
+		smu_spinwait_cmd(cmd);
+
 	return 0;
 }
 EXPORT_SYMBOL(smu_queue_cmd);
@@ -478,14 +485,15 @@
 	smu->cmd_buf_abs = (u32)smu_cmdbuf_abs;
 	smu->cmd_buf = (struct smu_cmd_buf *)abs_to_virt(smu_cmdbuf_abs);
 
-	np = of_find_node_by_name(NULL, "smu-doorbell");
-	if (np == NULL) {
+	smu->db_node = of_find_node_by_name(NULL, "smu-doorbell");
+	if (smu->db_node == NULL) {
 		printk(KERN_ERR "SMU: Can't find doorbell GPIO !\n");
 		goto fail;
 	}
-	data = (u32 *)get_property(np, "reg", NULL);
+	data = (u32 *)get_property(smu->db_node, "reg", NULL);
 	if (data == NULL) {
-		of_node_put(np);
+		of_node_put(smu->db_node);
+		smu->db_node = NULL;
 		printk(KERN_ERR "SMU: Can't find doorbell GPIO address !\n");
 		goto fail;
 	}
@@ -497,25 +505,21 @@
 	smu->doorbell = *data;
 	if (smu->doorbell < 0x50)
 		smu->doorbell += 0x50;
-	smu->db_irq = irq_of_parse_and_map(np, 0);
-
-	of_node_put(np);
 
 	/* Now look for the smu-interrupt GPIO */
 	do {
-		np = of_find_node_by_name(NULL, "smu-interrupt");
-		if (np == NULL)
+		smu->msg_node = of_find_node_by_name(NULL, "smu-interrupt");
+		if (smu->msg_node == NULL)
 			break;
-		data = (u32 *)get_property(np, "reg", NULL);
+		data = (u32 *)get_property(smu->msg_node, "reg", NULL);
 		if (data == NULL) {
-			of_node_put(np);
+			of_node_put(smu->msg_node);
+			smu->msg_node = NULL;
 			break;
 		}
 		smu->msg = *data;
 		if (smu->msg < 0x50)
 			smu->msg += 0x50;
-		smu->msg_irq = irq_of_parse_and_map(np, 0);
-		of_node_put(np);
 	} while(0);
 
 	/* Doorbell buffer is currently hard-coded, I didn't find a proper
@@ -547,6 +551,19 @@
 	smu->i2c_timer.function = smu_i2c_retry;
 	smu->i2c_timer.data = (unsigned long)smu;
 
+	if (smu->db_node) {
+		smu->db_irq = irq_of_parse_and_map(smu->db_node, 0);
+		if (smu->db_irq == NO_IRQ)
+			printk(KERN_ERR "smu: failed to map irq for node %s\n",
+			       smu->db_node->full_name);
+	}
+	if (smu->msg_node) {
+		smu->msg_irq = irq_of_parse_and_map(smu->msg_node, 0);
+		if (smu->msg_irq == NO_IRQ)
+			printk(KERN_ERR "smu: failed to map irq for node %s\n",
+			       smu->msg_node->full_name);
+	}
+
 	/*
 	 * Try to request the interrupts
 	 */
@@ -571,6 +588,7 @@
 		}
 	}
 
+	smu_irq_inited = 1;
 	return 0;
 }
 /* This has to be before arch_initcall as the low i2c stuff relies on the
@@ -742,6 +760,11 @@
 	if (fail && --cmd->retries > 0) {
 		DPRINTK("SMU: i2c failure, starting timer...\n");
 		BUG_ON(cmd != smu->cmd_i2c_cur);
+		if (!smu_irq_inited) {
+			mdelay(5);
+			smu_i2c_retry(0);
+			return;
+		}
 		mod_timer(&smu->i2c_timer, jiffies + msecs_to_jiffies(5));
 		return;
 	}
