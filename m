Return-Path: <cajus.hahn@de.abb.com>
Received: from smtp01.abb.de (smtp01.abb.de [138.222.187.21])
	by ozlabs.org (Postfix) with ESMTP id 28C8B68097
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 18:16:38 +1000 (EST)
From: Cajus Hahn <cajus.hahn@de.abb.com>
To: linuxppc-embedded@ozlabs.org, cajus.hahn@de.abb.com
Date: Thu, 11 Aug 2005 09:42:33 +0200
MIME-Version: 1.0
Message-Id: <200508110942.34174.cajus.hahn@de.abb.com>
Content-Type: text/plain;
  charset="us-ascii"
Subject: 8xx: i2c-algo-8xx - fixed timeout detection and transmission errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcello,

my "old" version is from the linuxppc_2_4_devel CVS archive on www.denx.de:/cvsroot.
The i2c-algo-8xx.c there has the revision number 1.5.

Regards
Cajus



--- ../../i2c-algo-8xx.c	2005-08-10 16:19:09.000000000 +0200
+++ drivers/i2c/i2c-algo-8xx.c	2005-08-10 08:03:46.000000000 +0200
@@ -19,12 +19,19 @@
  * moved into proper i2c interface; separated out platform specific
  * parts into i2c-rpx.c
  * Brad Parker (brad@heeltoe.com)
+ *
+ * added define for BUSY_WAIT and INTERRUPTIBLE_SLEEP, added I2C_ALGO_8XX_DATE + ..VERSION
+ * fixed bug in cpm_iic_read and cpm_iic_write (timeout never detected if count < 16)
+ * added force_reinit(): in certain cases (disturbances on the I2C bus) a timeout will
+ * occur. After this a complete re-initialisation will be necessary, otherwise all
+ * following transmissions will have a timeout.
+ * Cajus Hahn, 09.08.2005
  */
 
 // XXX todo
 // timeout sleep?
 
-/* $Id: i2c-algo-8xx.c,v 1.7 2002/08/03 22:48:18 ac9410 Exp $ */
+/* $Id: i2c-algo-8xx.c,v 1.2 2005/08/10 06:03:46 cajus Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -43,8 +50,16 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-8xx.h>
 
+#define I2C_ALGO_8XX_DATE "20050809"
+#define I2C_ALGO_8XX_VERSION "2.6.2"
+
 #define CPM_MAX_READ	513
 /* #define I2C_CHIP_ERRATA */ /* Try uncomment this if you have an older CPU(earlier than rev D4) */
+#define I2C_BUSY_WAIT /* Uncomment this if you want to do a busy wait in cpm_iic_read and
+                               cpm_iic_write. In a timeout case the CPU load will be 99.9% ! */
+#define I2C_INTERRUPTIBLE_SLEEP /* Uncomment this if you want the waiting in cpm_iic_read and
+                                         cpm_iic_write being interruptable by signals */
+
 static wait_queue_head_t iic_wait;
 static ushort r_tbase, r_rbase;
 
@@ -73,7 +88,11 @@
 
 	/* Get 'me going again.
 	*/
+#ifdef I2C_INTERRUPTIBLE_SLEEP
 	wake_up_interruptible(&iic_wait);
+#else
+	wake_up(&iic_wait);
+#endif
 }
 
 static void
@@ -201,20 +220,77 @@
 static void force_close(struct i2c_algo_8xx_data *cpm)
 {
 	volatile i2c8xx_t *i2c = cpm->i2c;
+
+        if (cpm_debug)
+            printk(KERN_DEBUG "force_close()");
+
 	if (cpm->reloc == 0) { /* micro code disabled */
 		volatile cpm8xx_t *cp = cpm->cp;
-
-		if (cpm_debug) printk(KERN_DEBUG "force_close()\n");
 		cp->cp_cpcr =
 			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
 			CPM_CR_FLG;
 
 		while (cp->cp_cpcr & CPM_CR_FLG);
 	}
+
 	i2c->i2c_i2cmr = 0x00;	/* Disable all interrupts */
 	i2c->i2c_i2cer = 0xff;
 }
 
+static void force_reinit(struct i2c_algo_8xx_data *cpm)
+{
+	volatile iic_t *iip = cpm->iip;
+	volatile i2c8xx_t *i2c = cpm->i2c;
+	volatile cpm8xx_t *cp = cpm->cp;
+	unsigned char brg;
+	bd_t *bd = (bd_t *)__res;
+
+	// Disable interrupts.
+	i2c->i2c_i2cmr = 0;
+	i2c->i2c_i2cer = 0xff;
+        // Clear enable
+	i2c->i2c_i2mod &= ~1;
+
+	// Initialize the parameter ram.
+	iip->iic_rstate = 0;
+	iip->iic_rdp = 0;
+	iip->iic_rbptr = 0;
+	iip->iic_rbc = 0;
+	iip->iic_rxtmp = 0;
+	iip->iic_tstate = 0;
+	iip->iic_tdp = 0;
+	iip->iic_tbptr = 0;
+	iip->iic_tbc = 0;
+	iip->iic_txtmp = 0;
+        iip->iic_tbase = r_tbase;
+	iip->iic_rbase = r_rbase;
+	iip->iic_tfcr = SMC_EB;
+	iip->iic_rfcr = SMC_EB;
+	iip->iic_mrblr = CPM_MAX_READ;
+
+	if (cpm->reloc == 0)
+        {
+		cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	}
+        else
+        {
+		iip->iic_rbptr = iip->iic_rbase;
+		iip->iic_tbptr = iip->iic_tbase;
+		iip->iic_rstate	= 0;
+		iip->iic_tstate	= 0;
+	}
+
+	// Select an arbitrary address.  Just make sure it is unique.
+	i2c->i2c_i2add = 0xfe;
+
+	// Make clock run at 60 KHz.
+	brg = (unsigned char) (bd->bi_intfreq/(32*2*60000) -3);
+	i2c->i2c_i2brg = brg;
+
+	i2c->i2c_i2mod = 0x00;
+	i2c->i2c_i2com = 0x01; /* Master mode */
+}
 
 /* Read from IIC...
  * abyte = address byte, with r/w flag already set
@@ -227,7 +303,7 @@
 	volatile cpm8xx_t *cp = cpm->cp;
 	volatile cbd_t	*tbdf, *rbdf;
 	u_char *tb;
-	unsigned long flags, tmo;
+	unsigned long flags, tmo, timedout;
 
 	if (count >= CPM_MAX_READ)
 		return -EINVAL;
@@ -269,7 +345,10 @@
 	rbdf->cbd_bufaddr = __pa(buf);
 
 	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP| BD_SC_INTRPT;
+        timedout = 0;
+#ifdef I2C_BUSY_WAIT
 	if(count > 16){
+#endif
 		/* Chip bug, set enable here */
 		local_irq_save(flags);
 		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
@@ -278,23 +357,40 @@
 		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
 
 		/* Wait for IIC transfer */
+#ifdef I2C_INTERRUPTIBLE_SLEEP
 		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+#else
+        	tmo = sleep_on_timeout(&iic_wait,1*HZ);
+#endif
+                if(tmo == 0) timedout=1;
 		local_irq_restore(flags);
+#ifdef I2C_BUSY_WAIT
 	} else { /* busy wait for small transfers, its faster */
 		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
 		i2c->i2c_i2cer = 0xff;
 		i2c->i2c_i2mod |= 1;	/* Enable */
 		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
 		tmo = jiffies + 1*HZ;
-		while(!(i2c->i2c_i2cer & 0x11 || time_after(jiffies, tmo))); /* Busy wait, with a timeout */
+		while(!(i2c->i2c_i2cer & 0x11 || (timedout = time_after(jiffies, tmo)))); /* Busy wait, with a timeout */
 	}
+#endif
+        if(timedout)
+        {
+            printk(KERN_DEBUG "cpm_iic_read: timeout!\n");
+            force_reinit(cpm);
+            return -EIO;
+        }
+
+#ifdef I2C_INTERRUPTIBLE_SLEEP
+	if (signal_pending(current))
+        {
+            force_close(cpm);
+	    if (cpm_debug)
+                printk(KERN_DEBUG "cpm_iic_read: signal_pending! \n");
+ 	    return -EINTR;
+        }
+#endif
 
-	if (signal_pending(current) || !tmo){
-		force_close(cpm);
-		if(cpm_debug)
-			printk(KERN_DEBUG "IIC read: timeout!\n");
- 		return -EIO;
-	}
 #ifdef I2C_CHIP_ERRATA
 	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
 	 Disabling I2C too early may cause too short stop condition */
@@ -359,7 +455,7 @@
 	volatile cpm8xx_t *cp = cpm->cp;
 	volatile cbd_t	*tbdf;
 	u_char *tb;
-	unsigned long flags, tmo;
+	unsigned long flags, tmo, timedout;
 
 	/* check for and use a microcode relocation patch */
 	if (cpm->reloc) {
@@ -385,7 +481,10 @@
 	tbdf[1].cbd_datlen = count;
 	tbdf[1].cbd_sc = BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;
 
+        timedout = 0;
+#ifdef I2C_BUSY_WAIT
 	if(count > 16){
+#endif
 		/* Chip bug, set enable here */
 		local_irq_save(flags);
 		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
@@ -394,23 +493,39 @@
 		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
 
 		/* Wait for IIC transfer */
+#ifdef I2C_INTERRUPTIBLE_SLEEP
 		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+#else
+        	tmo = sleep_on_timeout(&iic_wait,1*HZ);
+#endif
+                if(tmo == 0) timedout=1;
 		local_irq_restore(flags);
+#ifdef I2C_BUSY_WAIT
 	} else {  /* busy wait for small transfers, its faster */
 		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
 		i2c->i2c_i2cer = 0xff;
 		i2c->i2c_i2mod |= 1;	/* Enable */
 		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
 		tmo = jiffies + 1*HZ;
-		while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo))); /* Busy wait, with a timeout */
-	}
-
-	if (signal_pending(current) || !tmo){
-		force_close(cpm);
-		if(cpm_debug && !tmo)
-			printk(KERN_DEBUG "IIC write: timeout!\n");
-		return -EIO;
+		while(!(i2c->i2c_i2cer & 0x12 || (timedout = time_after(jiffies, tmo)))); /* Busy wait, with a timeout */
 	}
+#endif
+        if(timedout)
+        {
+            printk(KERN_DEBUG "cpm_iic_write: timeout!\n");
+            force_reinit(cpm);
+            return -EIO;
+        }
+
+#ifdef I2C_INTERRUPTIBLE_SLEEP
+	if (signal_pending(current))
+        {
+            force_close(cpm);
+	    if (cpm_debug)
+                printk(KERN_DEBUG "cpm_iic_write: signal_pending! \n");
+ 	    return -EINTR;
+        }
+#endif
 
 #if I2C_CHIP_ERRATA
 	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
@@ -495,7 +610,11 @@
 	if (cpm_debug > 1) printk(KERN_DEBUG "about to sleep\n");
 
 	/* wait for IIC transfer */
+#ifdef I2C_INTERRUPTIBLE_SLEEP
 	tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+#else
+	tmo = sleep_on_timeout(&iic_wait,1*HZ);
+#endif
 	local_irq_restore(flags);
 
 #ifdef I2C_CHIP_ERRATA
@@ -658,7 +777,7 @@
 
 int __init i2c_algo_8xx_init (void)
 {
-	printk(KERN_INFO "i2c-algo-8xx.o: i2c mpc8xx algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c-algo-8xx.o: i2c mpc8xx algorithm module version %s (%s)\n", I2C_ALGO_8XX_VERSION, I2C_ALGO_8XX_DATE);
 	return 0;
 }
 
