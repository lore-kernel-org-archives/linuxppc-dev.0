Message-Id: <199909171404.QAA25414@denx.local.net>
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems with initrd on linux-2.3.18
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Fri, 17 Sep 1999 16:04:10 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to get linux-2.3.18 running on  a  MPC850  system;  should
this be working, or should I better stick with embedded-2.2.5?

The main problem I'm strugging with is loading the initrd.

My modified boot loader works, the kernel starts and finds all  para-
meters and memory, it finds the compressed initrd image, uncompresses
it,  but  then  it  does  not  run /linuxrc, nor can it find /init or
/bin/sh, so it crashes with `Kernel panic: No init found'.

The  problem  seems  to  be  in  drivers/block/rd.c:  the  gunzip  in
crd_load()  returns  ok,  so  crd_load() return 0 to rd_load_image(),
where we `goto successful_load'. There infile.f_op->release points to
initrd_release(), which is  called:  it  releases  the  initrd,  sets
initrd_start=0,  and  this  causes  init/main.c  to think there is no
initrd.

Any ideas what's going on here?



Another, less important question: this  system  has  the  console  on
SMC2;  there seem to be some bugs in the relevant code for a 850: the
following patch works for me - any comments?

--- uart.c.ORIG	Tue Sep 14 19:23:43 1999
+++ uart.c	Thu Sep 16 22:24:50 1999
@@ -47,7 +47,11 @@
 /* this defines the index into rs_table for the port to use
 */
 #ifndef CONFIG_SERIAL_CONSOLE_PORT
+# ifdef CONFIG_TQM850L
+#define CONFIG_SERIAL_CONSOLE_PORT	1	/* TQM850L uses SMC2 */
+# else
 #define CONFIG_SERIAL_CONSOLE_PORT	0
+# endif
 #endif
 #endif
 
@@ -91,7 +95,7 @@
  * want the SMC to work as a uart :-)..
  * The "type" field is currently set to 0, for PORT_UNKNOWN.  It is
  * not currently used.  I should probably use it to indicate the port
- * type of CMS or SCC.
+ * type of SMC or SCC.
  * The SMCs do not support any modem control signals.
  */
 #define smc_scc_num	hub6
@@ -2360,13 +2364,24 @@
 	/* Configure SMCs Tx/Rx instead of port B parallel I/O.
 	*/
 #if USE_SMC2
-	cp->cp_pbpar |= 0x00000cc0;
+# ifdef	CONFIG_MPC850
+	/* This will enable SMC1 and SMC2 Tx/Rx
+	*/
+	immap->im_ioport.iop_papar |=  0x00C0;
+	immap->im_ioport.iop_padir &= ~0x00C0;
+	immap->im_ioport.iop_paodr &= ~0x00C0;
+	cp->cp_pbpar |=  0x000000c0;
+	cp->cp_pbdir &= ~0x000000c0;
+	cp->cp_pbodr &= ~0x000000c0;
+# else
+	cp->cp_pbpar |=  0x00000cc0;
 	cp->cp_pbdir &= ~0x00000cc0;
 	cp->cp_pbodr &= ~0x00000cc0;
+# endif
 #else
 	/* This will only enable SMC1 if you want SMC2 for something else.
 	*/
-	cp->cp_pbpar |= 0x000000c0;
+	cp->cp_pbpar |=  0x000000c0;
 	cp->cp_pbdir &= ~0x000000c0;
 	cp->cp_pbodr &= ~0x000000c0;
 #endif
@@ -2374,13 +2389,13 @@
 	/* Configure SCC2 and SCC3 instead of port A parallel I/O.
 	 */
 #if defined(CONFIG_MPC860) || defined(CONFIG_MPC860T)
-#ifndef CONFIG_MBX
+# ifndef CONFIG_MBX
 	/* The "standard" configuration through the 860.
 	*/
 	immap->im_ioport.iop_papar |= 0x003c;
 	immap->im_ioport.iop_padir &= ~0x003c;
 	immap->im_ioport.iop_paodr &= ~0x003c;
-#else
+# else
 	/* On the MBX, SCC3 is through Port D.
 	*/
 	immap->im_ioport.iop_papar |= 0x000c;	/* SCC2 on port A */
@@ -2388,7 +2403,7 @@
 	immap->im_ioport.iop_paodr &= ~0x000c;
 
 	immap->im_ioport.iop_pdpar |= 0x0030;	/* SCC3 on port D */
-#endif
+# endif	/* CONFIG_MBX */
 
 	/* Since we don't yet do modem control, connect the port C pins
 	 * as general purpose I/O.  This will assert CTS and CD for the
@@ -2402,7 +2417,7 @@
 	 */
 	cp->cp_sicr &= ~0x00ffff00;
 	cp->cp_sicr |= 0x001b1200;
-#endif
+#endif	/* CONFIG_MPC860, CONFIG_MPC860T */
 
 	/* Wire BRG1 to SMC1 and BRG2 to SMC2.
 	*/
@@ -2641,6 +2656,7 @@
 	volatile	cpm8xx_t	*cp;
 	volatile	smc_t		*sp;
 	volatile	smc_uart_t	*up;
+	volatile	immap_t		*immap;
 
 #ifndef CONFIG_MBX
 	bd_t				*bd;
@@ -2670,7 +2686,15 @@
 	 * from dual port ram, and a character buffer area from host mem.
 	 */
 	up = (smc_uart_t *)&cp->cp_dparam[ser->port];
+#ifdef CONFIG_TQM850L
+	asm( "mfspr %0,638": "=r"(immap) : );
+
+	immap->im_ioport.iop_papar |=  0x00c0;	/* Enable SMC2 */
+	immap->im_ioport.iop_padir &= ~0x00c0;
+	immap->im_ioport.iop_paodr &= ~0x00c0;
+#else
 	cp->cp_pbpar = 0x00c0;	/* Enable SMC1 instead of Port B I/O */
+#endif
 
 	/* Allocate space for two buffer descriptors in the DP ram.
 	*/
@@ -2707,7 +2731,11 @@
 
 	/* Send the CPM an initialize command.
 	*/
+#ifdef CONFIG_TQM850L
+	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC2, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+#else
 	cp->cp_cpcr = mk_cr_cmd(CPM_CR_CH_SMC1, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+#endif
 	/*
 	 * delay for a bit - this is necessary on my board!
 	 *  -- Cort

Wolfgang

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The game of life is a game of boomerangs.  Our  thoughts,  deeds  and
words return to us sooner or later with astounding accuracy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
