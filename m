Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id D1B1267A7A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Feb 2005 04:14:47 +1100 (EST)
Message-ID: <42162280.6040909@ru.mvista.com>
Date: Fri, 18 Feb 2005 20:14:40 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------080201010202020705020901"
Subject: [PATCH][PPC32] SCC4 UART for MPC8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080201010202020705020901
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for SCC4 UART on MPC8272ADS, it is created
against current linuxppc-2.4 tree.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

--
Sincerely, Vitaly


--------------080201010202020705020901
Content-Type: text/x-patch;
 name="cpm2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm2.diff"

===== uart.c 1.19 vs 1.21 =====
--- 1.19/arch/ppc/cpm2_io/uart.c	2005-01-04 20:12:19 +03:00
+++ 1.21/arch/ppc/cpm2_io/uart.c	2005-02-18 13:57:22 +03:00
@@ -179,7 +179,11 @@
 static struct serial_state rs_table[] = {
 	/* UART CLK   PORT          IRQ      FLAGS  NUM   */
 	{ 0,     0, PROFF_SCC1, SIU_INT_SCC1,   0, SCC_NUM_BASE},    /* SCC1 ttyS2 */
+#ifdef CONFIG_ADS8272
+	{ 0,	 0, PROFF_SCC4, SIU_INT_SCC4,	0, SCC_NUM_BASE + 3 }, /* SCC4 ttyS1 */
+#else
 	{ 0,     0, PROFF_SCC2, SIU_INT_SCC2,   0, SCC_NUM_BASE + 1},    /* SCC2 ttyS3 */
+#endif
 };
 #endif /* SCC_CONSOLE */
 
@@ -2575,6 +2579,12 @@
 	volatile	cpm2_map_t	*immap;
 	volatile	iop_cpm2_t	*io;
 
+#ifdef CONFIG_ADS8272
+	/* Enable the RS-232 transceivers.
+	*/
+	*(volatile uint *)(BCSR_ADDR + 4) &= ~(BCSR1_RS232_EN1 | BCSR1_RS232_EN2);
+#endif
+
 	init_bh(SERIAL_BH, do_serial_bh);
 
 	show_serial_version();
@@ -2693,7 +2703,14 @@
 	 */
 	immap->im_cpmux.cmx_scr &= ~0x00ffff00;
 	immap->im_cpmux.cmx_scr |= 0x00121b00;
-#else
+#else /* SCC_CONSOLE */ 
+#if !defined(CONFIG_ADS8272) /* SCC_CONSOLE && !ADS8272 */
+	/* Connect SCC1, SCC2, SCC3 to NMSI.  Connect BRG1 to SCC1,
+	 * BRG2 to SCC2, BRG3 to SCC3.
+	 */
+	immap->im_cpmux.cmx_scr &= ~0xffffff00;
+	immap->im_cpmux.cmx_scr |= 0x00091200;
+
 	/* This configures SCC2 and SCC3 as the IO pins.
 	*/
 #if !defined(CONFIG_MPC85xx_GP3)
@@ -2711,13 +2728,31 @@
 	io->iop_psord |= 0x00000002;	/* Tx */
 	io->iop_pdird &= ~0x00000001;	/* Rx */
 	io->iop_pdird |= 0x00000002;	/* Tx */
-
-	/* Connect SCC1, SCC2, SCC3 to NMSI.  Connect BRG1 to SCC1,
-	 * BRG2 to SCC2, BRG3 to SCC3.
+#else /* SCC_CONSOLE && CONFIG_ADS8272 */
+	/* wire BRG1 to SCC1 and BRG4 to SCC4 */
+	immap->im_cpmux.cmx_scr &= ~0xff0000ff;
+	immap->im_cpmux.cmx_scr |= 0x0000001b;
+
+	/* The ADS8272 has serial ports on SCC1 and SCC2 configured as follows:
+	 *	TXD1	PD30	SCC1 Output
+	 *	RTS1	PD29	General Purpose Output
+	 *	RXD1	PD31	SCC1 Input
+	 *	DCD1	PC14	General Purpose Input
+	 *
+	 *	TXD2	PD21	SCC4 Output
+	 *	RTS2	PD20	General Purpose Output
+	 *	RXD2	PD22	SCC4 Input
+	 *	DCD2	PC8	General Purpose Input
 	 */
-	immap->im_cpmux.cmx_scr &= ~0xffffff00;
-	immap->im_cpmux.cmx_scr |= 0x00091200;
+	io->iop_ppard |= 0x00000e07;
+	io->iop_psord &= ~0x00000e05;	/* Rx */
+	io->iop_psord |= 0x00000002;	/* Tx */
+	io->iop_pdird &= ~0x00000201;	/* Rx */
+	io->iop_pdird |= 0x00000c06;	/* Tx */
+	io->iop_pparc &= ~0x00820000;
+	io->iop_pdirc &= ~0x00820000;
 #endif
+#endif /*SCC_CONSOLE*/
 
 	for (i = 0, state = rs_table; i < NR_PORTS; i++,state++) {
 		state->magic = SSTATE_MAGIC;
@@ -2916,6 +2951,11 @@
 					page = CPM_CR_SCC3_PAGE;
 					sblock = CPM_CR_SCC3_SBLOCK;
 					break;
+				case 3:
+					page = CPM_CR_SCC4_PAGE;
+					sblock = CPM_CR_SCC4_SBLOCK;
+					break;
+
 				}
 #else
 				if (state->smc_scc_num == 2) {
@@ -3014,6 +3054,16 @@
 	scp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 
 #ifdef CONFIG_SCC1_CONSOLE
+#ifdef CONFIG_ADS8272
+	/* Use Port D for SCC1 and SCC4 */
+	io->iop_ppard |= 0x00000e07;
+	io->iop_psord &= ~0x00000e05;	/* Rx */
+	io->iop_psord |= 0x00000002;	/* Tx */
+	io->iop_pdird &= ~0x00000201;	/* Rx */
+	io->iop_pdird |= 0x00000c06;	/* Tx */
+	io->iop_pparc &= ~0x00820000;
+	io->iop_pdirc &= ~0x00820000;
+#else
 	/* Use Port D for SCC1 instead of other functions.
 	*/
 	io->iop_ppard |= 0x00000003;
@@ -3021,6 +3071,7 @@
 	io->iop_psord |= 0x00000002;	/* Tx */
 	io->iop_pdird &= ~0x00000001;	/* Rx */
 	io->iop_pdird |= 0x00000002;	/* Tx */
+#endif /* CONFIG_ADS8272 */
 #endif
 #if defined(CONFIG_SCC2_CONSOLE) && !defined(CONFIG_MPC85xx_GP3)
 	/* Use Port B for SCC2.
@@ -3133,6 +3184,11 @@
 			page = CPM_CR_SCC3_PAGE;
 			sblock = CPM_CR_SCC3_SBLOCK;
 			break;
+		case 4:
+			page = CPM_CR_SCC4_PAGE;
+			sblock = CPM_CR_SCC4_SBLOCK;
+			break;
+
 		}
 
 		cp->cp_cpcr = mk_cr_cmd(page, sblock, 0,


--------------080201010202020705020901--
