To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Console on SMC2 (was: Re: MPC823 Serial ports)
References: <38107697.9A2576F7@eng.uct.ac.za> <3810A961.FF50C5F8@netx4.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 24 Oct 1999 14:50:26 +0200
In-Reply-To: Dan Malek's message of "Fri, 22 Oct 1999 14:13:53 -0400"
Message-ID: <kfypuy4sz1p.fsf_-_@kieraypc01.p.y.ki.era.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:
>
> Yes.  I was using SMC2 on the TDM when I made the update.  You
> can enable up to four (because of baud rate generators) serial
> ports for uarts.  Pick any that you want.  This will be more
> configurable in newer versions of the config scripts I am going
> to check into CVS one of these days.

Speaking of SMCs and CVS, attached is a diff adding support for
having the boot console on SMC2. Currently I just set
CONFIG_SERIAL_CONSOLE_PORT in asm/board.h, but maybe it should be
a configuration option?

In uart.c I also fixed the major device of the console.
TTYAUX_MAJOR corresponds to the /dev/cua* devices, which are obsolete.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

===File ~/smc2-console.diff=================================
Index: uart.c
===================================================================
RCS file: /swb/cvs_repository/linux23/arch/ppc/8xx_io/uart.c,v
retrieving revision 1.1.1.4
retrieving revision 1.3
diff -u -r1.1.1.4 -r1.3
--- uart.c	1999/10/13 10:18:29	1.1.1.4
+++ uart.c	1999/10/21 12:44:44	1.3
@@ -2233,7 +2234,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTYAUX_MAJOR, 64 + c->index);
+	return MKDEV(TTY_MAJOR, 64 + c->index);
 }
 
 
@@ -2670,7 +2671,11 @@
 	 * from dual port ram, and a character buffer area from host mem.
 	 */
 	up = (smc_uart_t *)&cp->cp_dparam[ser->port];
+#if CONFIG_SERIAL_CONSOLE_PORT == 1
+	cp->cp_pbpar = 0x0c00;	/* Enable SMC2 instead of Port B I/O */
+#else
 	cp->cp_pbpar = 0x00c0;	/* Enable SMC1 instead of Port B I/O */
+#endif
 
 	/* Allocate space for two buffer descriptors in the DP ram.
 	*/
@@ -2707,7 +2712,11 @@
 
 	/* Send the CPM an initialize command.
 	*/
+#if CONFIG_SERIAL_CONSOLE_PORT == 1
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC2, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+#else
 	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC1, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+#endif
 	/*
 	 * delay for a bit - this is necessary on my board!
 	 *  -- Cort
Index: m8xx_tty.c
===================================================================
RCS file: /swb/cvs_repository/linux23/arch/ppc/mbxboot/m8xx_tty.c,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -r1.1.1.1 -r1.3
--- m8xx_tty.c	1999/10/01 16:11:54	1.1.1.1
+++ m8xx_tty.c	1999/10/24 12:34:32	1.3
@@ -16,6 +16,18 @@
 #include <asm/mpc8xx.h>
 #include "../8xx_io/commproc.h"
 
+#ifndef CONFIG_SERIAL_CONSOLE_PORT
+#define CONFIG_SERIAL_CONSOLE_PORT	0
+#endif
+
+#if CONFIG_SERIAL_CONSOLE_PORT == 1
+# define PROFF_CONSMC	PROFF_SMC2
+# define CPM_CR_CH_CON	CPM_CR_CH_SMC2
+#else
+# define PROFF_CONSMC	PROFF_SMC1
+# define CPM_CR_CH_CON	CPM_CR_CH_SMC1
+#endif
+
 #ifdef CONFIG_MBX
 #define MBX_CSR1	((volatile u_char *)0xfa100000)
 #define CSR1_COMEN	(u_char)0x02
@@ -33,8 +45,8 @@
 	uint	dpaddr, memaddr;
 
 	cp = cpmp;
-	sp = (smc_t*)&(cp->cp_smc[0]);
-	up = (smc_uart_t *)&cp->cp_dparam[PROFF_SMC1];
+	sp = (smc_t*)&(cp->cp_smc[CONFIG_SERIAL_CONSOLE_PORT]);
+	up = (smc_uart_t *)&cp->cp_dparam[PROFF_CONSMC];
 
 	/* Disable transmitter/receiver.
 	*/
@@ -96,7 +108,11 @@
 	/* Set up the baud rate generator.
 	 * See 8xx_io/commproc.c for details.
 	 */
+#if CONFIG_SERIAL_CONSOLE_PORT == 1
+	cp->cp_simode = 0x00001000;
+#else
 	cp->cp_simode = 0x10000000;
+#endif
 	cp->cp_brgc1 =
 		((((bd->bi_intfreq * 1000000)/16) / bd->bi_baudrate) << 1) | CPM_BRG_EN;
 
@@ -174,7 +190,7 @@
 
 		/* Issue a stop transmit, and wait for it.
 		*/
-		cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC1,
+		cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_CON,
 					CPM_CR_STOP_TX) | CPM_CR_FLG;
 		while (cp->cp_cpcr & CPM_CR_FLG);
 	}
@@ -191,7 +207,7 @@
 
 	/* Initialize Tx/Rx parameters.
 	*/
-	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC1, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_CON, CPM_CR_INIT_TRX) | CPM_CR_FLG;
 	while (cp->cp_cpcr & CPM_CR_FLG);
 
 	/* Enable transmitter/receiver.
@@ -206,7 +222,7 @@
 	volatile char		*buf;
 	volatile smc_uart_t	*up;
 
-	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC1];
+	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_CONSMC];
 	tbdf = (cbd_t *)&cpmp->cp_dpmem[up->smc_tbase];
 
 	/* Wait for last character to go.
@@ -227,7 +243,7 @@
 	volatile smc_uart_t	*up;
 	char			c;
 
-	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC1];
+	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_CONSMC];
 	rbdf = (cbd_t *)&cpmp->cp_dpmem[up->smc_rbase];
 
 	/* Wait for character to show up.
@@ -246,7 +262,7 @@
 	volatile cbd_t		*rbdf;
 	volatile smc_uart_t	*up;
 
-	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_SMC1];
+	up = (smc_uart_t *)&cpmp->cp_dparam[PROFF_CONSMC];
 	rbdf = (cbd_t *)&cpmp->cp_dpmem[up->smc_rbase];
 
 	return(!(rbdf->cbd_sc & BD_SC_EMPTY));
============================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
