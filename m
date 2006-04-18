Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A0EC679EA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 14:12:02 +1000 (EST)
Subject: [PATCH] powermac: Fix i2c on keywest based chips
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 14:11:53 +1000
Message-Id: <1145333513.4705.45.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new i2c implementation for PowerMac has a regression that causes the
hardware to go out of state when probing non-existent devices. While
fixing that, I also found & fixed a couple of other corner cases. This
fixes booting with a pbbuttons version that scans the i2c bus for an LMU
controller among others. Tested on a dual G5 with thermal control (which
has heavy i2c activity) with no problem so far.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/low_i2c.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/low_i2c.c	2006-04-17 16:08:42.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/low_i2c.c	2006-04-17 16:41:32.000000000 +1000
@@ -231,6 +231,14 @@
 	return isr;
 }
 
+static void kw_i2c_do_stop(struct pmac_i2c_host_kw *host, int result)
+{
+	kw_write_reg(reg_control, KW_I2C_CTL_STOP);
+	host->state = state_stop;
+	host->result = result;
+}
+
+
 static void kw_i2c_handle_interrupt(struct pmac_i2c_host_kw *host, u8 isr)
 {
 	u8 ack;
@@ -246,42 +254,36 @@
 	}
 
 	if (isr == 0) {
+		printk(KERN_WARNING "low_i2c: Timeout in i2c transfer"
+		       " on keywest !\n");
 		if (host->state != state_stop) {
-			DBG_LOW("KW: Timeout !\n");
-			host->result = -EIO;
-			goto stop;
-		}
-		if (host->state == state_stop) {
-			ack = kw_read_reg(reg_status);
-			if (ack & KW_I2C_STAT_BUSY)
-				kw_write_reg(reg_status, 0);
-			host->state = state_idle;
-			kw_write_reg(reg_ier, 0x00);
-			if (!host->polled)
-				complete(&host->complete);
+			kw_i2c_do_stop(host, -EIO);
+			return;
 		}
+		ack = kw_read_reg(reg_status);
+		if (ack & KW_I2C_STAT_BUSY)
+			kw_write_reg(reg_status, 0);
+		host->state = state_idle;
+		kw_write_reg(reg_ier, 0x00);
+		if (!host->polled)
+			complete(&host->complete);
 		return;
 	}
 
 	if (isr & KW_I2C_IRQ_ADDR) {
 		ack = kw_read_reg(reg_status);
 		if (host->state != state_addr) {
-			kw_write_reg(reg_isr, KW_I2C_IRQ_ADDR);
 			WRONG_STATE("KW_I2C_IRQ_ADDR"); 
-			host->result = -EIO;
-			goto stop;
+			kw_i2c_do_stop(host, -EIO);
 		}
 		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
-			host->result = -ENODEV;
-			DBG_LOW("KW: NAK on address\n");
+			host->result = -ENXIO;
 			host->state = state_stop;
-			return;
+			DBG_LOW("KW: NAK on address\n");
 		} else {
-			if (host->len == 0) {
-				kw_write_reg(reg_isr, KW_I2C_IRQ_ADDR);
-				goto stop;
-			}
-			if (host->rw) {
+			if (host->len == 0)
+				kw_i2c_do_stop(host, 0);
+			else if (host->rw) {
 				host->state = state_read;
 				if (host->len > 1)
 					kw_write_reg(reg_control,
@@ -308,25 +310,19 @@
 			ack = kw_read_reg(reg_status);
 			if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
 				DBG_LOW("KW: nack on data write\n");
-				host->result = -EIO;
-				goto stop;
+				host->result = -EFBIG;
+				host->state = state_stop;
 			} else if (host->len) {
 				kw_write_reg(reg_data, *(host->data++));
 				host->len--;
-			} else {
-				kw_write_reg(reg_control, KW_I2C_CTL_STOP);
-				host->state = state_stop;
-				host->result = 0;
-			}
-			kw_write_reg(reg_isr, KW_I2C_IRQ_DATA);
+			} else
+				kw_i2c_do_stop(host, 0);
 		} else {
-			kw_write_reg(reg_isr, KW_I2C_IRQ_DATA);
 			WRONG_STATE("KW_I2C_IRQ_DATA"); 
-			if (host->state != state_stop) {
-				host->result = -EIO;
-				goto stop;
-			}
+			if (host->state != state_stop)
+				kw_i2c_do_stop(host, -EIO);
 		}
+		kw_write_reg(reg_isr, KW_I2C_IRQ_DATA);
 	}
 
 	if (isr & KW_I2C_IRQ_STOP) {
@@ -340,14 +336,10 @@
 			complete(&host->complete);
 	}
 
+	/* Below should only happen in manual mode which we don't use ... */
 	if (isr & KW_I2C_IRQ_START)
 		kw_write_reg(reg_isr, KW_I2C_IRQ_START);
 
-	return;
- stop:
-	kw_write_reg(reg_control, KW_I2C_CTL_STOP);	
-	host->state = state_stop;
-	return;
 }
 
 /* Interrupt handler */
@@ -544,11 +536,11 @@
 		return NULL;
 	}
 
-	/* Make sure IRA is disabled */
+	/* Make sure IRQ is disabled */
 	kw_write_reg(reg_ier, 0);
 
 	/* Request chip interrupt */
-	if (request_irq(host->irq, kw_i2c_irq, SA_SHIRQ, "keywest i2c", host))
+	if (request_irq(host->irq, kw_i2c_irq, 0, "keywest i2c", host))
 		host->irq = NO_IRQ;
 
 	printk(KERN_INFO "KeyWest i2c @0x%08x irq %d %s\n",
