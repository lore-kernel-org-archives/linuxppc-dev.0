Message-ID: <38396AF1.7A0F3986@switchboard.ericsson.se>
Date: Mon, 22 Nov 1999 17:10:25 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: generic smc code patch
Content-Type: multipart/mixed;
 boundary="------------D49D3ECE483FAD501E8887EC"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D49D3ECE483FAD501E8887EC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello all,

This patch for embedded-2.2.13 will make macros out of 
some SMC / SCC constants in commproc.h.

Creating generic SCC and SMC code will now be easier.

Instead of PROFF_SCC1 use PROFF_SCC(1), or PROFF_SCC(n).

Patch instructions:
$ pwd
/xxx/yyy/zzz/embedded-2.2.13
$ cat smc_scc.diff | patch -p1

Comments ?

/ Magnus
--------------D49D3ECE483FAD501E8887EC
Content-Type: text/plain; charset=us-ascii;
 name="smc_scc.diff"
Content-Disposition: inline;
 filename="smc_scc.diff"
Content-Transfer-Encoding: 7bit

diff -u -r embedded-2.2.13/arch/ppc/8xx_io/commproc.h embedded-2.2.13_smcp/arch/ppc/8xx_io/commproc.h
--- embedded-2.2.13/arch/ppc/8xx_io/commproc.h	Sat Oct 23 01:14:48 1999
+++ embedded-2.2.13_smcp/arch/ppc/8xx_io/commproc.h	Thu Nov 18 09:08:24 1999
@@ -14,7 +14,18 @@
  * bytes of the DP RAM and relocates the I2C parameter area to the
  * IDMA1 space.  The remaining DP RAM is available for buffer descriptors
  * or other use.
+ *
+ * 17 Nov 1999: Magnus Damm <damm@bitsmart.com>
+ * Converted some constants to macros for the SCC:s and SMC:s. 
+ * 
+ * CPM_CR_CH_SxCn -> CPM_CR_CH_SxC(n)
+ * PROFF_SxCn     -> PROFF_SxC(n)
+ * CPMVEC_SxCn    -> CPMVEC_SxC(n)
+ *
+ * Generic SCC/SMC code will now be smaller/faster/better.
+ * No bounds checking is done, be careful. 
  */
+
 #ifndef __CPM_8XX__
 #define __CPM_8XX__
 
@@ -39,14 +50,17 @@
 
 /* Channel numbers.
 */
-#define CPM_CR_CH_SCC1	((ushort)0x0000)
+#define CPM_CR_CH_SCC(n) ((ushort)(((n)-1) << 2))
+#define CPM_CR_CH_SMC(n) ((ushort)(0x0009 | (((n)-1) << 2)))
+
+/* #define CPM_CR_CH_SCC1	((ushort)0x0000) */
 #define CPM_CR_CH_I2C	((ushort)0x0001)	/* I2C and IDMA1 */
-#define CPM_CR_CH_SCC2	((ushort)0x0004)
+/* #define CPM_CR_CH_SCC2	((ushort)0x0004) */
 #define CPM_CR_CH_SPI	((ushort)0x0005)	/* SPI / IDMA2 / Timers */
-#define CPM_CR_CH_SCC3	((ushort)0x0008)
-#define CPM_CR_CH_SMC1	((ushort)0x0009)	/* SMC1 / DSP1 */
-#define CPM_CR_CH_SCC4	((ushort)0x000c)
-#define CPM_CR_CH_SMC2	((ushort)0x000d)	/* SMC2 / DSP2 */
+/* #define CPM_CR_CH_SCC3	((ushort)0x0008) */
+/* #define CPM_CR_CH_SMC1	((ushort)0x0009) */	/* SMC1 / DSP1 */
+/* #define CPM_CR_CH_SCC4	((ushort)0x000c) */
+/* #define CPM_CR_CH_SMC2	((ushort)0x000d) */	/* SMC2 / DSP2 */
 
 #define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))
 
@@ -91,14 +105,18 @@
 
 /* Parameter RAM offsets.
 */
-#define PROFF_SCC1	((uint)0x0000)
+
+#define PROFF_SCC(n)    ((uint)(((n)-1) << 8))           /* SCC(1) -> SCC(4) */
+#define PROFF_SMC(n)    ((uint)((((n)-1) << 8) + 0x280)) /* SMC(1) -> SMC(2) */
+
+/* #define PROFF_SCC1	((uint)0x0000) */
 #define PROFF_IIC	((uint)0x0080)
-#define PROFF_SCC2	((uint)0x0100)
+/* #define PROFF_SCC2	((uint)0x0100) */
 #define PROFF_SPI	((uint)0x0180)
-#define PROFF_SCC3	((uint)0x0200)
-#define PROFF_SMC1	((uint)0x0280)
-#define PROFF_SCC4	((uint)0x0300)
-#define PROFF_SMC2	((uint)0x0380)
+/* #define PROFF_SCC3	((uint)0x0200) */
+/* #define PROFF_SMC1	((uint)0x0280) */
+/* #define PROFF_SCC4	((uint)0x0300) */
+/* #define PROFF_SMC2	((uint)0x0380) */
 
 /* Define enough so I can at least use the serial port as a UART.
  * The MBX uses SMC1 as the host serial port.
@@ -653,12 +671,16 @@
  * use the table as defined in the manuals (i.e. no special high
  * priority and SCC1 == SCCa, etc...).
  */
+
+#define CPMVEC_SCC(n)           ((ushort)(0x1f-(n))) /* SCC(1) -> SCC(4) */
+#define CPMVEC_SMC(n)           ((ushort)(0x05-(n))) /* SMC(1) -> SMC(2) */
+
 #define CPMVEC_NR		32
 #define	CPMVEC_PIO_PC15		((ushort)0x1f)
-#define	CPMVEC_SCC1		((ushort)0x1e)
-#define	CPMVEC_SCC2		((ushort)0x1d)
-#define	CPMVEC_SCC3		((ushort)0x1c)
-#define	CPMVEC_SCC4		((ushort)0x1b)
+/* #define	CPMVEC_SCC1		((ushort)0x1e) */
+/* #define	CPMVEC_SCC2		((ushort)0x1d) */
+/* #define	CPMVEC_SCC3		((ushort)0x1c) */
+/* #define	CPMVEC_SCC4		((ushort)0x1b) */
 #define	CPMVEC_PIO_PC14		((ushort)0x1a)
 #define	CPMVEC_TIMER1		((ushort)0x19)
 #define	CPMVEC_PIO_PC13		((ushort)0x18)
@@ -678,8 +700,8 @@
 #define CPMVEC_TIMER4		((ushort)0x07)
 #define	CPMVEC_PIO_PC6		((ushort)0x06)
 #define	CPMVEC_SPI		((ushort)0x05)
-#define	CPMVEC_SMC1		((ushort)0x04)
-#define	CPMVEC_SMC2		((ushort)0x03)
+/* #define	CPMVEC_SMC1		((ushort)0x04) */
+/* #define	CPMVEC_SMC2		((ushort)0x03) */
 #define	CPMVEC_PIO_PC5		((ushort)0x02)
 #define	CPMVEC_PIO_PC4		((ushort)0x01)
 #define	CPMVEC_ERROR		((ushort)0x00)
Only in embedded-2.2.13_smcp/arch/ppc/8xx_io: commproc.h~
Only in embedded-2.2.13_smcp/arch/ppc/8xx_io: commproc.o
diff -u -r embedded-2.2.13/arch/ppc/8xx_io/enet.c embedded-2.2.13_smcp/arch/ppc/8xx_io/enet.c
--- embedded-2.2.13/arch/ppc/8xx_io/enet.c	Fri Oct 22 23:24:13 1999
+++ embedded-2.2.13_smcp/arch/ppc/8xx_io/enet.c	Wed Nov 17 16:28:29 1999
@@ -21,6 +21,8 @@
  * will be much more memory efficient and will easily handle lots of
  * small packets.
  *
+ * 17 Nov 1999: Magnus Damm <damm@bitsmart.com>
+ * Converted some constants to macros for the SCC:s and SMC:s. 
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -167,18 +169,14 @@
 /* Typically, 860(T) boards use SCC1 for Ethernet, and other 8xx boards
  * use SCC2.  This is easily extended if necessary.
  */
+
+
 #ifdef CONFIG_SCC2_ENET
-#define CPM_CR_ENET	CPM_CR_CH_SCC2
-#define PROFF_ENET	PROFF_SCC2
-#define SCC_ENET	1		/* Index, not number! */
-#define CPMVEC_ENET	CPMVEC_SCC2
+#define ENET_SCC 2
 #endif
 
 #ifdef CONFIG_SCC1_ENET
-#define CPM_CR_ENET CPM_CR_CH_SCC1
-#define PROFF_ENET	PROFF_SCC1
-#define SCC_ENET	0
-#define CPMVEC_ENET	CPMVEC_SCC1
+#define ENET_SCC 1
 #endif
 
 static int
@@ -479,7 +477,9 @@
 		 */
 		cp = cpmp;
 		cp->cp_cpcr =
-		    mk_cr_cmd(CPM_CR_ENET, CPM_CR_RESTART_TX) | CPM_CR_FLG;
+		    mk_cr_cmd(CPM_CR_CH_SCC(ENET_SCC), CPM_CR_RESTART_TX) 
+			| CPM_CR_FLG;
+
 		while (cp->cp_cpcr & CPM_CR_FLG);
 	    }
 	}
@@ -683,7 +683,10 @@
 				/* Ask CPM to run CRC and set bit in
 				 * filter mask.
 				 */
-				cpmp->cp_cpcr = mk_cr_cmd(CPM_CR_ENET, CPM_CR_SET_GADDR) | CPM_CR_FLG;
+				cpmp->cp_cpcr = mk_cr_cmd(
+					CPM_CR_CH_SCC(ENET_SCC), 
+					CPM_CR_SET_GADDR) | CPM_CR_FLG;
+
 				/* this delay is necessary here -- Cort */
 				udelay(10);
 				while (cpmp->cp_cpcr & CPM_CR_FLG);
@@ -731,11 +734,11 @@
 
 	/* Get pointer to SCC area in parameter RAM.
 	*/
-	ep = (scc_enet_t *)(&cp->cp_dparam[PROFF_ENET]);
+	ep = (scc_enet_t *)(&cp->cp_dparam[PROFF_SCC(ENET_SCC)]);
 
 	/* And another to the SCC register area.
 	*/
-	sccp = (volatile scc_t *)(&cp->cp_scc[SCC_ENET]);
+	sccp = (volatile scc_t *)(&cp->cp_scc[ENET_SCC-1]);
 	cep->sccp = (scc_t *)sccp;		/* Keep the pointer handy */
 
 	/* Disable receive and transmit in case EPPC-Bug started it.
@@ -799,7 +802,8 @@
 	 * already running.
 	 * In addition, we have to do it later because we don't yet have
 	 * all of the BD control/status set properly.
-	cp->cp_cpcr = mk_cr_cmd(CPM_CR_ENET, CPM_CR_INIT_RX) | CPM_CR_FLG;
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SCC(ENET_SCC), 
+	CPM_CR_INIT_RX) | CPM_CR_FLG;
 	while (cp->cp_cpcr & CPM_CR_FLG);
 	 */
 
@@ -914,7 +918,9 @@
 	 * than the manual describes because we have just now finished
 	 * the BD initialization.
 	 */
-	cp->cp_cpcr = mk_cr_cmd(CPM_CR_ENET, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SCC(ENET_SCC), CPM_CR_INIT_TRX) 
+		| CPM_CR_FLG;
+
 	while (cp->cp_cpcr & CPM_CR_FLG);
 
 	cep->skb_cur = cep->skb_dirty = 0;
@@ -929,7 +935,7 @@
 
 	/* Install our interrupt handler.
 	*/
-	cpm_install_handler(CPMVEC_ENET, cpm_enet_interrupt, dev);
+	cpm_install_handler(CPMVEC_SCC(ENET_SCC), cpm_enet_interrupt, dev);
 
 	/* Set GSMR_H to enable all normal operating modes.
 	 * Set GSMR_L to enable Ethernet to MC68160.
diff -u -r embedded-2.2.13/arch/ppc/8xx_io/uart.c embedded-2.2.13_smcp/arch/ppc/8xx_io/uart.c
--- embedded-2.2.13/arch/ppc/8xx_io/uart.c	Thu Oct 21 00:02:21 1999
+++ embedded-2.2.13_smcp/arch/ppc/8xx_io/uart.c	Thu Nov 18 09:09:31 1999
@@ -16,6 +16,9 @@
  * This module exports the following rs232 io functions:
  *
  *	int rs_8xx_init(void);
+ *
+ * 17 Nov 1999: Magnus Damm <damm@bitsmart.com>
+ * Converted some constants to macros for the SCC:s and SMC:s. 
  */
 
 #include <linux/config.h>
@@ -107,14 +110,14 @@
  * address that someday.
  */
 static struct serial_state rs_table[] = {
-	/* UART CLK   PORT          IRQ      FLAGS  NUM   */
-	{ 0,     0, PROFF_SMC1, CPMVEC_SMC1,   0,    0 },    /* SMC1 ttyS0 */
+	/* UART CLK   PORT          IRQ          FLAGS  NUM   */
+	{ 0,     0, PROFF_SMC(1), CPMVEC_SMC(1),   0,    0 }, /* SMC1 ttyS0 */
 #if 0 /* TDM Sound */
-	{ 0,     0, PROFF_SMC2, CPMVEC_SMC2,   0,    1 },    /* SMC2 ttyS1 */
+	{ 0,     0, PROFF_SMC(2), CPMVEC_SMC(2),   0,    1 }, /* SMC2 ttyS1 */
 #endif
 #ifdef CONFIG_MPC860
-	{ 0,     0, PROFF_SCC2, CPMVEC_SCC2,   0,    2 },    /* SCC2 ttyS2 */
-	{ 0,     0, PROFF_SCC3, CPMVEC_SCC3,   0,    3 },    /* SCC3 ttyS3 */
+	{ 0,     0, PROFF_SCC(2), CPMVEC_SCC(2),   0,    2 }, /* SCC2 ttyS2 */
+	{ 0,     0, PROFF_SCC(3), CPMVEC_SCC(3),   0,    3 }, /* SCC3 ttyS3 */
 #endif
 };
 
@@ -1258,21 +1261,11 @@
 
 	cp = cpmp;
 
-	if ((num = info->state->smc_scc_num) < SCC_NUM_BASE) {
-		if (num == 0)
-			chan = CPM_CR_CH_SMC1;
-		else
-			chan = CPM_CR_CH_SMC2;
-	}
+	if ((num = info->state->smc_scc_num) < SCC_NUM_BASE)
+		chan = CPM_CR_CH_SMC(num+1);
 	else {
 		num -= SCC_NUM_BASE;
-		switch (num) {
-		case 0: chan = CPM_CR_CH_SCC1; break;
-		case 1: chan = CPM_CR_CH_SCC2; break;
-		case 2: chan = CPM_CR_CH_SCC3; break;
-		case 3: chan = CPM_CR_CH_SCC4; break;
-		default: return;
-		}
+		chan = CPM_CR_CH_SCC(num+1);
 	}
 	cp->cp_cpcr = mk_cr_cmd(chan, CPM_CR_STOP_TX) | CPM_CR_FLG;
 	while (cp->cp_cpcr & CPM_CR_FLG);
@@ -1286,21 +1279,11 @@
 
 	cp = cpmp;
 
-	if ((num = info->state->smc_scc_num) < SCC_NUM_BASE) {
-		if (num == 0)
-			chan = CPM_CR_CH_SMC1;
-		else
-			chan = CPM_CR_CH_SMC2;
-	}
+	if ((num = info->state->smc_scc_num) < SCC_NUM_BASE)
+		chan = CPM_CR_CH_SMC(num+1);
 	else {
 		num -= SCC_NUM_BASE;
-		switch (num) {
-		case 0: chan = CPM_CR_CH_SCC1; break;
-		case 1: chan = CPM_CR_CH_SCC2; break;
-		case 2: chan = CPM_CR_CH_SCC3; break;
-		case 3: chan = CPM_CR_CH_SCC4; break;
-		default: return;
-		}
+		chan = CPM_CR_CH_SCC(num+1);
 	}
 	cp->cp_cpcr = mk_cr_cmd(chan, CPM_CR_RESTART_TX) | CPM_CR_FLG;
 	while (cp->cp_cpcr & CPM_CR_FLG);
@@ -2511,10 +2494,7 @@
 
 				/* Send the CPM an initialize command.
 				*/
-				if (state->smc_scc_num == 0)
-					chan = CPM_CR_CH_SMC1;
-				else
-					chan = CPM_CR_CH_SMC2;
+				chan = CPM_CR_CH_SMC(state->smc_scc_num+1);
 
 				cp->cp_cpcr = mk_cr_cmd(chan,
 						CPM_CR_INIT_TRX) | CPM_CR_FLG;
@@ -2566,10 +2546,7 @@
 
 				/* Send the CPM an initialize command.
 				*/
-				if (state->smc_scc_num == 2)
-					chan = CPM_CR_CH_SCC2;
-				else
-					chan = CPM_CR_CH_SCC3;
+				chan = CPM_CR_CH_SCC(state->smc_scc_num);
 
 				cp->cp_cpcr = mk_cr_cmd(chan,
 						CPM_CR_INIT_TRX) | CPM_CR_FLG;
@@ -2692,7 +2669,8 @@
 
 	/* Send the CPM an initialize command.
 	*/
-	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC1, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC(1), CPM_CR_INIT_TRX) 
+		| CPM_CR_FLG;
 	/*
 	 * delay for a bit - this is necessary on my board!
 	 *  -- Cort
diff -u -r embedded-2.2.13/arch/ppc/mbxboot/m8xx_tty.c embedded-2.2.13_smcp/arch/ppc/mbxboot/m8xx_tty.c
--- embedded-2.2.13/arch/ppc/mbxboot/m8xx_tty.c	Thu Oct 21 00:33:51 1999
+++ embedded-2.2.13_smcp/arch/ppc/mbxboot/m8xx_tty.c	Thu Nov 18 09:14:30 1999
@@ -34,7 +34,7 @@
 
 	cp = cpmp;
 	sp = (smc_t*)&(cp->cp_smc[0]);
-	up = (smc_uart_t *)&cp->cp_dparam[PROFF_SMC1];
+	up = (smc_uart_t *)&cp->cp_dparam[PROFF_SMC(1)];
 
 	/* Disable transmitter/receiver.
 	*/
@@ -174,7 +174,7 @@
 
 		/* Issue a stop transmit, and wait for it.
 		*/
-		cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC1,
+		cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC(1),
 					CPM_CR_STOP_TX) | CPM_CR_FLG;
 		while (cp->cp_cpcr & CPM_CR_FLG);
 	}
@@ -191,7 +191,9 @@
 
 	/* Initialize Tx/Rx parameters.
 	*/
-	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC1, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC(1), CPM_CR_INIT_TRX) 
+		| CPM_CR_FLG;
+
 	while (cp->cp_cpcr & CPM_CR_FLG);
 
 	/* Enable transmitter/receiver.
@@ -206,7 +208,7 @@
 	volatile char		*buf;
 	volatile smc_uart_t	*up;
 
-	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC1];
+	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC(1)];
 	tbdf = (cbd_t *)&cpmp->cp_dpmem[up->smc_tbase];
 
 	/* Wait for last character to go.
@@ -227,7 +229,7 @@
 	volatile smc_uart_t	*up;
 	char			c;
 
-	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC1];
+	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC(1)];
 	rbdf = (cbd_t *)&cpmp->cp_dpmem[up->smc_rbase];
 
 	/* Wait for character to show up.
@@ -246,7 +248,7 @@
 	volatile cbd_t		*rbdf;
 	volatile smc_uart_t	*up;
 
-	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC1];
+	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC(1)];
 	rbdf = (cbd_t *)&cpmp->cp_dpmem[up->smc_rbase];
 
 	return(!(rbdf->cbd_sc & BD_SC_EMPTY));

--------------D49D3ECE483FAD501E8887EC--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
