Message-ID: <38C16DAC.81460D77@inu.se>
Date: Sat, 04 Mar 2000 21:10:20 +0100
From: Björn Lundberg <bjorn.lundberg@inu.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: commproc.c
References: <4.2.2.20000302111129.00a638d0@mail.kerbango.com>
Content-Type: multipart/mixed;
 boundary="------------F773EEAA220C77DA94981C53"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------F773EEAA220C77DA94981C53
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Steve Calfee wrote:
>
> Hi all,
>
> I have been working on doing a 823 USB driver. It is my first driver for
snip

We've got an USB host driver in alpha stage for the 850 (done with the
823 manual since 850 lacked documentation).
I'll try to clean it up and submit it to the list in a few days.

Changes we've done to commproc.c and .h against 2.2.5 are attached.
These concern _dpalloc alignment and increased size (microcode alert)
plus RISC-timer IRQ (used to generate SOF in the USB driver).

As stated earlier we haven't moved to 2.2.13 due to performance issues.

Cheers
 Bjorn
--------------F773EEAA220C77DA94981C53
Content-Type: text/plain; charset=us-ascii;
 name="commproc.c.diff"
Content-Disposition: inline;
 filename="commproc.c.diff"
Content-Transfer-Encoding: 7bit

--- linux-org/linux-2.2.5-embedded/arch/ppc/8xx_io/commproc.c	Fri Apr  9 06:46:08 1999
+++ linux-york/arch/ppc/8xx_io/commproc.c	Thu Feb 10 13:25:35 2000
@@ -3,6 +3,7 @@
  * General Purpose functions for the global management of the
  * Communication Processor Module.
  * Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
+ * Copyright (c) 1999 Honeywell INUcontrol (bjorn.lundberg@inu.se)
  *
  * In addition to the individual control of the communication
  * channels, there are a few functions that globally affect the
@@ -20,6 +21,9 @@
  * memory that can never be used for microcode.  If there are
  * applications that require more DP ram, we can expand the boundaries
  * but then we have to be careful of any downloaded microcode.
+ *
+ * Added support for RISC-timer IRQ and more DP ram (microcode alert).
+ * bjorn.lundberg@inu.se
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -49,6 +53,7 @@
 	void	*dev_id;
 };
 static	struct	cpm_action cpm_vecs[CPMVEC_NR];
+static	struct	cpm_action cpm_risctimer_vecs[16];
 static	void	cpm_interrupt(int irq, void * dev, struct pt_regs * regs);
 static	void	cpm_error_interrupt(void *);

@@ -104,12 +109,16 @@
 	cpmp = (cpm8xx_t *)commproc;
 }

+static	void cpm_risctimer_interrupt(void *dev);
+
 /* This is called during init_IRQ.  We used to do it above, but this
  * was too early since init_IRQ was not yet called.
  */
 void
-cpm_interrupt_init()
+cpm_interrupt_init(void)
 {
+	cprtt_t *rtt_pramp = (cprtt_t *)(&cpmp->cp_dparam[PROFF_RISCTT]);
+
 	/* Initialize the CPM interrupt controller.
 	*/
 	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr =
@@ -122,6 +131,19 @@
 	if (request_8xxirq(CPM_INTERRUPT, cpm_interrupt, 0, "cpm", NULL) != 0)
 		panic("Could not allocate CPM IRQ!");

+	/* Install our own timer handler.
+	*/
+	((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_rccr &= 0x00ff;	/* stop, clear TIMEP */
+	cpm_install_handler(CPMVEC_RISCTIMER, cpm_risctimer_interrupt, NULL);
+	rtt_pramp->tm_base = m8xx_cpm_dpalloc(4*16);
+
+	/* want timer period = 0.1ms -> timep = 4800/1024 = 4.69
+	 * timep = 4 -> 4096 = 0.08533 ms -> 11719Hz
+	 */
+#define RISCTIMER_FREQ	11719
+	((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_rccr |= (4 << 8);
+	((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_rccr |= (0x8000);	/* enable */
+
 	/* Install our own error handler.
 	*/
 	cpm_install_handler(CPMVEC_ERROR, cpm_error_interrupt, NULL);
@@ -144,8 +166,10 @@

 	if (cpm_vecs[vec].handler != 0)
 		(*cpm_vecs[vec].handler)(cpm_vecs[vec].dev_id);
-	else
+	else {
+		printk("CPM : No handler for irq %x.\n", vec);
 		((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr &= ~(1 << vec);
+	}

 	/* After servicing the interrupt, we have to remove the status
 	 * indicator.
@@ -164,6 +188,35 @@
 {
 }

+/* The CPM RISC timer interrupt handler.
+ */
+static	void
+cpm_risctimer_interrupt(void *dev)
+{
+	uint	i, rter;
+
+	/* first save then clear eventregister
+	 */
+	rter = ((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_rter;
+	((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_rter = 0xffff;
+
+/*  	printk("CPM : RISC-irq rtmr = %x  rter = %x.\n", ((immap_t *)IMAP_ADDR)->im_cpm.cp_rtmr, rter); */
+	for (i=0; i<16; i++) {
+		if (rter & 0x0001) {
+/*    			printk("CPM : cpm_risctimer_vecs[%d].handler=%x.\n", i, cpm_risctimer_vecs[i].handler); */
+			if (cpm_risctimer_vecs[i].handler != 0) {
+				/*  printk("CPM : calling %x.\n", cpm_risctimer_vecs[i].handler); */
+				(*cpm_risctimer_vecs[i].handler)(cpm_risctimer_vecs[i].dev_id);
+				/*  printk("CPM : called %x.\n", cpm_risctimer_vecs[i].handler); */
+			} else {
+				printk("CPM : No handler for RISC timer %x.\n", i);
+				((immap_t *)IMAP_ADDR)->im_cpm.cp_rtmr &= ~(1 << i);
+			}
+		}
+		rter >>= 1;
+	}
+}
+
 /* Install a CPM interrupt handler.
 */
 void
@@ -177,17 +230,46 @@
 	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr |= (1 << vec);
 }

-/* Allocate some memory from the dual ported ram.  We may want to
- * enforce alignment restrictions, but right now everyone is a good
- * citizen.
+/* Install a CPM RISC timer interrupt handler.
+*/
+void
+cpm_install_risctimer_handler(int timer, int n_ms, void (*handler)(void *), void *dev_id)
+{
+	volatile cpm8xx_t *cp = cpmp;	/* Get pointer to Communication Processor */
+	volatile cprtt_t  *rtt_pramp = (cprtt_t *)(&cpmp->cp_dparam[PROFF_RISCTT]);
+
+	if (cpm_risctimer_vecs[timer].handler != 0)
+		printk("CPM RISC timer interrupt %x replacing %x\n",
+			(uint)handler, (uint)cpm_risctimer_vecs[timer].handler);
+	printk("CPM RISC timer interrupt %x\n", (uint)handler);
+	cpm_risctimer_vecs[timer].handler = handler;
+	cpm_risctimer_vecs[timer].dev_id = dev_id;
+	rtt_pramp->tm_cmd = (0xC0000000 | (timer<<16) | n_ms*RISCTIMER_FREQ/1000);
+	while (cp->cp_cpcr & CPM_CR_FLG);
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SPI, CPM_CR_SET_TIMER) | CPM_CR_FLG;
+	while (cp->cp_cpcr & CPM_CR_FLG);
+	((immap_t *)IMAP_ADDR)->im_cpm.cp_rtmr |= (1 << timer);
+}
+
+/* Allocate some memory from the dual ported ram.
+ * We enforce 32 byte alignment restrictions.
  */
 uint
-m8xx_cpm_dpalloc(uint size)
+m8xx_cpm_dpalloc(uint size_non_align)
 {
 	uint	retloc;
+	uint	size = (((size_non_align - 1) / 32) + 1) * 32;

-	if ((dp_alloc_base + size) >= dp_alloc_top)
+	if ((dp_alloc_base + size) >= dp_alloc_top) {
+		if(dp_alloc_base == CPM_DATAONLY_BASE &&
+		   size < CPM_DATA2_SIZE) {
+			printk("Switching to DPRAM DATA2\n");
+			dp_alloc_base = CPM_DATA2_BASE;
+			dp_alloc_top = dp_alloc_base + CPM_DATA2_SIZE;
+		}
+		else
 		return(CPM_DP_NOSPACE);
+	}

 	retloc = dp_alloc_base;
 	dp_alloc_base += size;

--------------F773EEAA220C77DA94981C53
Content-Type: text/plain; charset=us-ascii;
 name="commproc.h.diff"
Content-Disposition: inline;
 filename="commproc.h.diff"
Content-Transfer-Encoding: 7bit

--- linux-org/linux-2.2.5-embedded/arch/ppc/8xx_io/commproc.h	Thu Apr 15 17:47:36 1999
+++ linux-york/arch/ppc/8xx_io/commproc.h	Tue Feb 22 09:01:05 2000
@@ -14,6 +14,9 @@
  * bytes of the DP RAM and relocates the I2C parameter area to the
  * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
  * or other use.
+ *
+ * Added some I2C info and cleaned out IIC (both I2C and IIC were used)
+ *	--Bjorn (bjorn.lundberg@inu.se)
  */
 #ifndef __CPM_8XX__
 #define __CPM_8XX__
@@ -36,10 +39,12 @@
 #define CPM_CR_STOP_TX		((ushort)0x0004)
 #define CPM_CR_RESTART_TX	((ushort)0x0006)
 #define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_SET_TIMER	((ushort)0x0008)

 /* Channel numbers.
 */
 #define CPM_CR_CH_SCC1	((ushort)0x0000)
+#define CPM_CR_CH_USB	((ushort)0x0000)
 #define CPM_CR_CH_I2C	((ushort)0x0001)	/* I2C and IDMA1 */
 #define CPM_CR_CH_SCC2	((ushort)0x0004)
 #define CPM_CR_CH_SPI	((ushort)0x0005)	/* SPI / IDMA2 / Timers */
@@ -57,6 +62,8 @@
  */
 #define CPM_DATAONLY_BASE	((uint)0x0800)
 #define CPM_DATAONLY_SIZE	((uint)0x0700)
+#define CPM_DATA2_BASE		((uint)0x1000)
+#define CPM_DATA2_SIZE		((uint)0x0A00)
 #define CPM_DP_NOSPACE		((uint)0x7fffffff)

 /* Export the base address of the communication processor registers
@@ -92,8 +99,9 @@
 /* Parameter RAM offsets.
 */
 #define PROFF_SCC1	((uint)0x0000)
-#define PROFF_IIC	((uint)0x0080)
+#define PROFF_I2C	((uint)0x0080)
 #define PROFF_SCC2	((uint)0x0100)
+#define PROFF_RISCTT	((uint)0x01B0)
 #define PROFF_SCC3	((uint)0x0200)
 #define PROFF_SMC1	((uint)0x0280)
 #define PROFF_SCC4	((uint)0x0300)
@@ -398,6 +406,33 @@
 #define SICR_ENET_CLKRT	((uint)0x0000003d)
 #endif

+#ifdef CONFIG_YORK
+/* This ENET stuff is for the MPC850 with ethernet on SCC2.  Some of
+ * this may be unique to the YORK.
+ */
+#define PA_ENET_RXD	((ushort)0x0004) /* RXD2 */
+#define PA_ENET_TXD	((ushort)0x0008) /* TXD2 */
+#define PA_ENET_TCLK	((ushort)0x0200) /* CLK2 */
+#define PA_ENET_RCLK	((ushort)0x0800) /* CLK4 */
+#define PB_ENET_TENA	((uint)0x00002000) /* RTS2 */
+#define PC_ENET_CLSN	((ushort)0x0080) /* CD2 */
+#define PC_ENET_RENA	((ushort)0x0040) /* CTS2 */
+
+#define PB_YORK_LBK     ((uint)0x00000008)
+#define PB_YORK_DSQE    ((uint)0x00000004)
+#define PB_YORK_FDE     ((uint)0x00000002)
+
+#define SICR_ENET_MASK	((uint)0x00007f00)
+#define SICR_ENET_CLKRT	((uint)0x00003d00)
+
+#define SICR_USB_MASK	((uint)0x00000038)
+#define SICR_USB_CLKRT	((uint)0x00000008) /* BRG2 */
+
+#define PB_I2C_SDA	((uint)0x00000010)
+#define PB_I2C_SCL	((uint)0x00000020)
+
+#endif
+
 #ifdef CONFIG_RPXLITE
 /* This ENET stuff is for the MPC850 with ethernet on SCC2.  Some of
  * this may be unique to the RPX-Lite configuration.
@@ -585,27 +620,86 @@

 #define BD_SCC_TX_LAST		((ushort)0x0800)

-/* IIC parameter RAM.
-*/
-typedef struct iic {
-	ushort	iic_rbase;	/* Rx Buffer descriptor base address */
-	ushort	iic_tbase;	/* Tx Buffer descriptor base address */
-	u_char	iic_rfcr;	/* Rx function code */
-	u_char	iic_tfcr;	/* Tx function code */
-	ushort	iic_mrblr;	/* Max receive buffer length */
-	uint	iic_rstate;	/* Internal */
-	uint	iic_rdp;	/* Internal */
-	ushort	iic_rbptr;	/* Internal */
-	ushort	iic_rbc;	/* Internal */
-	uint	iic_rxtmp;	/* Internal */
-	uint	iic_tstate;	/* Internal */
-	uint	iic_tdp;	/* Internal */
-	ushort	iic_tbptr;	/* Internal */
-	ushort	iic_tbc;	/* Internal */
-	uint	iic_txtmp;	/* Internal */
-} iic_t;

-#define BD_IIC_START		((ushort)0x0400)
+/*
+ * I2C parameter RAM.
+ * Both IIC and I2C are used, let's stick with I2C -- Bjorn
+ */
+typedef struct i2c_pram {
+	ushort	i2c_rbase;		/* RX BD base address */
+	ushort	i2c_tbase;		/* TX BD base address */
+	u_char	i2c_rfcr;		/* Rx function code */
+	u_char	i2c_tfcr;		/* Tx function code */
+	ushort	i2c_mrblr;		/* Rx buffer length */
+	uint	i2c_rstate;		/* Rx internal state */
+	uint	i2c_rptr;		/* Rx internal data pointer */
+	ushort	i2c_rbptr;		/* rb BD Pointer */
+	ushort	i2c_rcount;		/* Rx internal byte count */
+	uint	i2c_rtemp;		/* Rx temp */
+	uint	i2c_tstate;		/* Tx internal state */
+	uint	i2c_tptr;		/* Tx internal data pointer */
+	ushort	i2c_tbptr;		/* Tx BD pointer */
+	ushort	i2c_tcount;		/* Tx byte count */
+	uint	i2c_ttemp;		/* Tx temp */
+} i2cp_t;
+
+#define BD_I2C_START		((ushort)0x0400)
+
+/* Buffer descriptor control/status used by I2C receive.
+ */
+#define BD_I2C_RX_EMPTY		((ushort)0x8000)
+#define BD_I2C_RX_WRAP		((ushort)0x2000)
+#define BD_I2C_RX_INTR		((ushort)0x1000)
+#define BD_I2C_RX_LAST		((ushort)0x0800)
+#define BD_I2C_RX_OV		((ushort)0x0002)
+#define BD_I2C_RX_STATS		((ushort)0x0002)	/* All status bits */
+
+/* Buffer descriptor control/status used by I2C transmit.
+ */
+#define BD_I2C_TX_READY		((ushort)0x8000)
+#define BD_I2C_TX_PAD		((ushort)0x4000)
+#define BD_I2C_TX_WRAP		((ushort)0x2000)
+#define BD_I2C_TX_INTR		((ushort)0x1000)
+#define BD_I2C_TX_LAST		((ushort)0x0800)
+#define BD_I2C_TX_START		((ushort)0x0400)
+#define BD_I2C_TX_NAK		((ushort)0x0004)
+#define BD_I2C_TX_UN		((ushort)0x0002)
+#define BD_I2C_TX_CL		((ushort)0x0001)
+#define BD_I2C_TX_STATS		((ushort)0x0007)	/* All status bits */
+
+/* I2C Event and Mask register.
+ */
+#define	I2CM_TXE	((unsigned char)0x10)
+#define	I2CM_BSY	((unsigned char)0x04)
+#define	I2CM_TXB	((unsigned char)0x02)
+#define	I2CM_RXB	((unsigned char)0x01)
+
+/* I2C Mode register
+ */
+#define	I2MOD_EN	((unsigned char)0x01)
+
+/* I2C byte ordering
+ */
+#define I2C_xFCR_BO_PPC		((ushort)0x0010)
+#define I2C_xFCR_BO_OTHER	((ushort)0x0020)
+
+/* I2C Command register
+ */
+#define	I2COM_START	((unsigned char)0x80)
+#define I2COM_MASTER	((unsigned char)0x01)
+
+/*
+ * Communication Processor
+ * RISC Timer Table Parameter RAM
+ */
+typedef struct cprtt_pram {
+	__u16	tm_base;		/* RISC timer table base address */
+	__u16	tm_ptr;			/* RISC timer table pointer */
+	__u16	r_tmr;			/* RISC timer mode register */
+	__u16	r_tmv;			/* RISC timer valid register */
+	__u32	tm_cmd;			/* RISC timer command register */
+	__u32	tm_cnt;			/* RISC timer internal count */
+} cprtt_t;

 /* CPM interrupts.  There are nearly 32 interrupts generated by CPM
  * channels or devices.  All of these are presented to the PPC core
@@ -646,6 +740,7 @@
 #define	CPMVEC_ERROR		((ushort)0x00)

 extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
+extern void cpm_install_risctimer_handler(int timer, int n_ms, void (*handler)(void *), void *dev_id);

 /* CPM interrupt configuration vector.
 */

--------------F773EEAA220C77DA94981C53--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
