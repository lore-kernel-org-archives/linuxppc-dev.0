Date: Tue, 22 Oct 2002 11:15:38 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: 8xx i2c refers to unspecified chip errata
In-reply-to: <20021015165731.GG695@opus.bloom.county>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	sensors@stimpy.netroedge.com
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEEIFHAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> On Fri, Oct 11, 2002 at 11:12:02AM +0200, Joakim Tjernlund wrote:
>
> > OK, here it is.
> >
> > Perhaps someone can add it to the ppctree?
>
> If you can submit this as a patch vs what's in the i2c CVS tree or the
> ppctree, than yes, this can be committed there, and to the ppctrees.

Here is a patch against the PPC 2.4 devel tree for the i2c-algo-8xx.c

Tom, do you look after 8xx_io/enet.c? I sent a patch to the emmbedded list
yesterday that does away with an expensive memcpy.

 Jocke
--- i2c-algo-8xx.c	Mon Sep 30 16:20:42 2002
+++ i2c-algo-8xx.c.clean	Tue Oct 22 10:49:33 2002
@@ -7,15 +7,12 @@
  * Brad Parker (brad@heeltoe.com)
  */

-// XXX todo
-// timeout sleep?
-
 /* $Id$ */

 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/version.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
@@ -30,25 +27,25 @@
 #include <linux/i2c-algo-8xx.h>

 #define CPM_MAX_READ	513
-
+/* #define I2C_CHIP_ERRATA */ /* Try uncomment this if you have an older CPU(earlier than rev D4) */
 static wait_queue_head_t iic_wait;
 static ushort r_tbase, r_rbase;

 int cpm_scan = 0;
-int cpm_debug = 1;
+int cpm_debug = 0;

-static void
-cpm_iic_interrupt(void *dev_id)
+static  void
+cpm_iic_interrupt(void *dev_id, struct pt_regs *regs)
 {
 	volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;
-
 	if (cpm_debug > 1)
 		printk("cpm_iic_interrupt(dev_id=%p)\n", dev_id);
-
-	/* Chip errata, clear enable.
-	*/
-	i2c->i2c_i2mod = 0;
-
+#if 0
+	/* Chip errata, clear enable. This is not needed on rev D4 CPUs */
+        /* This should probably be removed and replaced by I2C_CHIP_ERRATA stuff */
+        /* Someone with a buggy CPU needs to confirm that */
+	i2c->i2c_i2mod &= ~1;
+#endif
 	/* Clear interrupt.
 	*/
 	i2c->i2c_i2cer = 0xff;
@@ -63,6 +60,8 @@
 {
 	volatile iic_t		*iip = cpm_adap->iip;
 	volatile i2c8xx_t	*i2c = cpm_adap->i2c;
+	unsigned char brg;
+	bd_t *bd = (bd_t *)__res;

 	if (cpm_debug) printk("cpm_iic_init()\n");

@@ -101,15 +100,24 @@
 		cp->cp_cpcr =
 			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
 		while (cp->cp_cpcr & CPM_CR_FLG);
+	} else {
+		iip->iic_rbptr = iip->iic_rbase;
+		iip->iic_tbptr = iip->iic_tbase;
+		iip->iic_rstate	= 0;
+		iip->iic_tstate	= 0;
 	}

 	/* Select an arbitrary address.  Just make sure it is unique.
 	*/
-	i2c->i2c_i2add = 0x34;
+	i2c->i2c_i2add = 0xfe;

-	/* Make clock run maximum slow.
+	/* Make clock run at 60 KHz.
 	*/
-	i2c->i2c_i2brg = 7;
+	brg = (unsigned char) (bd->bi_intfreq/(32*2*60000) -3);
+	i2c->i2c_i2brg = brg;
+
+	i2c->i2c_i2mod = 0x00;
+	i2c->i2c_i2com = 0x01; /* Master mode */

 	/* Disable interrupts.
 	*/
@@ -131,7 +139,7 @@

 	/* Shut down IIC.
 	*/
-	i2c->i2c_i2mod = 0;
+	i2c->i2c_i2mod &= ~1;
 	i2c->i2c_i2cmr = 0;
 	i2c->i2c_i2cer = 0xff;

@@ -151,22 +159,24 @@

 	iip->iic_rstate = 0;
 	iip->iic_rdp = 0;
-	iip->iic_rbptr = 0;
+	iip->iic_rbptr = iip->iic_rbase;
 	iip->iic_rbc = 0;
 	iip->iic_rxtmp = 0;
 	iip->iic_tstate = 0;
 	iip->iic_tdp = 0;
-	iip->iic_tbptr = 0;
+	iip->iic_tbptr = iip->iic_tbase;
 	iip->iic_tbc = 0;
 	iip->iic_txtmp = 0;
 }

 #define BD_SC_NAK		((ushort)0x0004) /* NAK - did not respond */
+#define BD_SC_OV		((ushort)0x0002) /* OV - receive overrun */
 #define CPM_CR_CLOSE_RXBD	((ushort)0x0007)

 static void force_close(struct i2c_algo_8xx_data *cpm)
 {
-	if (cpm->reloc == 0) {
+	volatile i2c8xx_t *i2c = cpm->i2c;
+	if (cpm->reloc == 0) { /* micro code disabled */
 		volatile cpm8xx_t *cp = cpm->cp;

 		if (cpm_debug) printk("force_close()\n");
@@ -176,6 +186,8 @@

 		while (cp->cp_cpcr & CPM_CR_FLG);
 	}
+	i2c->i2c_i2cmr = 0x00;	/* Disable all interrupts */
+	i2c->i2c_i2cer = 0xff;
 }


@@ -190,7 +202,7 @@
 	volatile cpm8xx_t *cp = cpm->cp;
 	volatile cbd_t	*tbdf, *rbdf;
 	u_char *tb;
-	unsigned long flags;
+	unsigned long flags, tmo;

 	if (count >= CPM_MAX_READ)
 		return -EINVAL;
@@ -207,68 +219,104 @@
 	 * All that is used is the first byte for address, the remainder
 	 * is just used for timing (and doesn't really have to exist).
 	 */
-	if (cpm->reloc) {
-		cpm_reset_iic_params(iip);
-	}
 	tb = cpm->temp;
 	tb = (u_char *)(((uint)tb + 15) & ~15);
 	tb[0] = abyte;		/* Device address byte w/rw flag */

-	flush_dcache_range(tb, tb+1);
-
+	flush_dcache_range((unsigned long)tb, (unsigned long)(tb+1));
 	if (cpm_debug) printk("cpm_iic_read(abyte=0x%x)\n", abyte);

 	tbdf->cbd_bufaddr = __pa(tb);
 	tbdf->cbd_datlen = count + 1;
 	tbdf->cbd_sc =
-		BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
+		BD_SC_READY | BD_SC_LAST |
 		BD_SC_WRAP | BD_IIC_START;

+	iip->iic_mrblr = count +1; /* prevent excessive read, +1
+				      is needed otherwise will the
+				      RXB interrupt come too early */
+
+	/* flush will invalidate too. */
+	flush_dcache_range((unsigned long)buf, (unsigned long)(buf+count));
+
 	rbdf->cbd_datlen = 0;
 	rbdf->cbd_bufaddr = __pa(buf);
-	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
-
-	/* Chip bug, set enable here */
-	save_flags(flags); cli();
-	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
-	i2c->i2c_i2cer = 0xff;
-	i2c->i2c_i2mod = 1;	/* Enable */
-	i2c->i2c_i2com = 0x81;	/* Start master */
+	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP| BD_SC_INTRPT;
+	if(count > 16){
+		/* Chip bug, set enable here */
+		local_irq_save(flags);
+		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+
+		/* Wait for IIC transfer */
+		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+		local_irq_restore(flags);
+	} else { /* busy wait for small transfers, its faster */
+		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+		tmo = jiffies + 1*HZ;
+		while(!(i2c->i2c_i2cer & 0x11 || time_after(jiffies, tmo))); /* Busy wait, with a timeout */
+	}

-	/* Wait for IIC transfer */
-	interruptible_sleep_on(&iic_wait);
-	restore_flags(flags);
-	if (signal_pending(current))
+	if (signal_pending(current) || !tmo){
+		force_close(cpm);
+		if(cpm_debug)
+			printk("IIC read: timeout!\n");
 		return -EIO;
-
+	}
+#ifdef I2C_CHIP_ERRATA
+	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
+	 Disabling I2C too early may cause too short stop condition */
+	udelay(4);
+	i2c->i2c_i2mod &= ~1;
+#endif
 	if (cpm_debug) {
 		printk("tx sc %04x, rx sc %04x\n",
 		       tbdf->cbd_sc, rbdf->cbd_sc);
 	}

+	if (tbdf->cbd_sc & BD_SC_READY) {
+		printk("IIC read; complete but tbuf ready\n");
+		force_close(cpm);
+		printk("tx sc %04x, rx sc %04x\n",
+		       tbdf->cbd_sc, rbdf->cbd_sc);
+	}
+
 	if (tbdf->cbd_sc & BD_SC_NAK) {
-		printk("IIC read; no ack\n");
-		return 0;
+		if (cpm_debug)
+			printk("IIC read; no ack\n");
+		return -EREMOTEIO;
 	}

 	if (rbdf->cbd_sc & BD_SC_EMPTY) {
-		printk("IIC read; complete but rbuf empty\n");
-		force_close(cpm);
-		printk("tx sc %04x, rx sc %04x\n",
-		       tbdf->cbd_sc, rbdf->cbd_sc);
+		/* force_close(cpm); */
+		if (cpm_debug){
+			printk("IIC read; complete but rbuf empty\n");
+			printk("tx sc %04x, rx sc %04x\n",
+			       tbdf->cbd_sc, rbdf->cbd_sc);
+		}
+		return -EREMOTEIO;
+	}
+
+	if (rbdf->cbd_sc & BD_SC_OV) {
+		if (cpm_debug)
+			printk("IIC read; Overrun\n");
+		return -EREMOTEIO;;
 	}

 	if (cpm_debug) printk("read %d bytes\n", rbdf->cbd_datlen);

 	if (rbdf->cbd_datlen < count) {
-		printk("IIC read; short, wanted %d got %d\n",
-		       count, rbdf->cbd_datlen);
+		if (cpm_debug)
+			printk("IIC read; short, wanted %d got %d\n",
+			       count, rbdf->cbd_datlen);
 		return 0;
 	}

-
-	invalidate_dcache_range(buf, buf+count);
-
 	return count;
 }

@@ -283,7 +331,7 @@
 	volatile cpm8xx_t *cp = cpm->cp;
 	volatile cbd_t	*tbdf;
 	u_char *tb;
-	unsigned long flags;
+	unsigned long flags, tmo;

 	/* check for and use a microcode relocation patch */
 	if (cpm->reloc) {
@@ -293,8 +341,8 @@
 	tb = (u_char *)(((uint)tb + 15) & ~15);
 	*tb = abyte;		/* Device address byte w/rw flag */

-	flush_dcache_range(tb, tb+1);
-	flush_dcache_range(buf, buf+count);
+	flush_dcache_range((unsigned long)tb, (unsigned long)(tb+1));
+	flush_dcache_range((unsigned long)buf, (unsigned long)(buf+count));

 	if (cpm_debug) printk("cpm_iic_write(abyte=0x%x)\n", abyte);

@@ -309,31 +357,53 @@
 	tbdf[1].cbd_datlen = count;
 	tbdf[1].cbd_sc = BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;

-	/* Chip bug, set enable here */
-	save_flags(flags); cli();
-	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
-	i2c->i2c_i2cer = 0xff;
-	i2c->i2c_i2mod = 1;	/* Enable */
-	i2c->i2c_i2com = 0x81;	/* Start master */
+	if(count > 16){
+		/* Chip bug, set enable here */
+		local_irq_save(flags);
+		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+
+		/* Wait for IIC transfer */
+		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+		local_irq_restore(flags);
+	} else {  /* busy wait for small transfers, its faster */
+		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+		tmo = jiffies + 1*HZ;
+		while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo))); /* Busy wait, with a timeout */
+	}

-	/* Wait for IIC transfer */
-	interruptible_sleep_on(&iic_wait);
-	restore_flags(flags);
-	if (signal_pending(current))
+	if (signal_pending(current) || !tmo){
+		force_close(cpm);
+		if(cpm_debug && !tmo)
+			printk("IIC write: timeout!\n");
 		return -EIO;
-
+	}
+
+#if I2C_CHIP_ERRATA
+	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
+	 Disabling I2C too early may cause too short stop condition */
+	udelay(4);
+	i2c->i2c_i2mod &= ~1;
+#endif
 	if (cpm_debug) {
 		printk("tx0 sc %04x, tx1 sc %04x\n",
 		       tbdf[0].cbd_sc, tbdf[1].cbd_sc);
 	}

 	if (tbdf->cbd_sc & BD_SC_NAK) {
-		printk("IIC write; no ack\n");
+		if (cpm_debug)
+			printk("IIC write; no ack\n");
 		return 0;
 	}

 	if (tbdf->cbd_sc & BD_SC_READY) {
-		printk("IIC write; complete but tbuf ready\n");
+		if (cpm_debug)
+			printk("IIC write; complete but tbuf ready\n");
 		return 0;
 	}

@@ -351,7 +421,7 @@
 	volatile cpm8xx_t *cp = cpm->cp;
 	volatile cbd_t *tbdf, *rbdf;
 	u_char *tb;
-	unsigned long flags, len;
+	unsigned long flags, len, tmo;

 	if (cpm_debug > 1)
 		printk("cpm_iic_tryaddress(cpm=%p,addr=%d)\n", cpm, addr);
@@ -376,31 +446,43 @@
 	tb[0] = (addr << 1) | 1;	/* device address (+ read) */
 	len = 2;

-	flush_dcache_range(tb, tb+1);
+	flush_dcache_range((unsigned long)tb, (unsigned long)(tb+2));

 	tbdf->cbd_bufaddr = __pa(tb);
 	tbdf->cbd_datlen = len;
 	tbdf->cbd_sc =
-		BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
+		BD_SC_READY | BD_SC_LAST |
 		BD_SC_WRAP | BD_IIC_START;

 	rbdf->cbd_datlen = 0;
 	rbdf->cbd_bufaddr = __pa(tb+2);
-	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
+	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;

-	save_flags(flags); cli();
+	local_irq_save(flags);
 	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
 	i2c->i2c_i2cer = 0xff;
-	i2c->i2c_i2mod = 1;	/* Enable */
-	i2c->i2c_i2com = 0x81;	/* Start master */
+	i2c->i2c_i2mod |= 1;	/* Enable */
+	i2c->i2c_i2com |= 0x80;	/* Begin transmission */

 	if (cpm_debug > 1) printk("about to sleep\n");

 	/* wait for IIC transfer */
-	interruptible_sleep_on(&iic_wait);
-	restore_flags(flags);
-	if (signal_pending(current))
+	tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+	local_irq_restore(flags);
+
+#ifdef I2C_CHIP_ERRATA
+	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
+	 Disabling I2C too early may cause too short stop condition */
+	udelay(4);
+	i2c->i2c_i2mod &= ~1;
+#endif
+
+	if (signal_pending(current) || !tmo){
+		force_close(cpm);
+		if(cpm_debug && !tmo)
+			printk("IIC tryaddress: timeout!\n");
 		return -EIO;
+	}

 	if (cpm_debug > 1) printk("back from sleep\n");

@@ -430,8 +512,8 @@

 		if (cpm_debug)
 			printk("i2c-algo-8xx.o: "
-			       "#%d addr=0x%x flags=0x%x len=%d\n",
-			       i, pmsg->addr, pmsg->flags, pmsg->len);
+			       "#%d addr=0x%x flags=0x%x len=%d\n buf=%lx\n",
+			       i, pmsg->addr, pmsg->flags, pmsg->len, (unsigned long)pmsg->buf);

 		addr = pmsg->addr << 1;
 		if (pmsg->flags & I2C_M_RD )

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
