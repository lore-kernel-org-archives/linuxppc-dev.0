Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B14F72BF0E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2005 01:59:16 +1100 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	j0DAAXR3026305
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2005 03:10:33 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id j0DAColu028723
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2005 04:12:51 -0600 (CST)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730813D3@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: linuxppc-dev@ozlabs.org
Date: Thu, 13 Jan 2005 18:07:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] cpm2_io/fcc_enet: make clock setting more straightforward
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch refined the clock setting part of FCC Ethernet driver, making it easier for further porting.  It also fixed MPC8272ADS setting.  If apply this patch, the previous patch is not needed.

I don't know if the style of this enhancement is good or bad, please comment.

Signed-off-by: Li Yang <LeoLi@freescale.com>

--- linux-2.4.28/arch/ppc/cpm2_io/fcc_enet.c	2004-08-08 07:26:04.000000000 +0800
+++ linux-patched/arch/ppc/cpm2_io/fcc_enet.c	2004-12-29 16:52:47.911064570 +0800
@@ -16,6 +16,9 @@
  * small packets.  Since this is a cache coherent processor and CPM,
  * I could also preallocate SKB's and use them directly on the interface.
  *
+ * 2004-12	Leo Li (leoli@freescale.com)
+ * - Rework the FCC clock configuration part, make it easier to configure.
+ *
  */
 
 #include <linux/config.h>
@@ -141,6 +144,62 @@
  * help show what pins are used for each device.
  */
 
+/* Since the CLK setting changes greatly from board to board, I changed
+ * it to a easy way.  You just need to specify which CLK number to use.
+ * Note that only limited choices can be make on each port.
+ */
+
+/* FCC1 Clock Source Configuration.  There are board specific. 
+   Can only choose from CLK9-12 */
+#ifdef CONFIG_ADS8272
+#define F1_RXCLK	11
+#define F1_TXCLK	10
+#else
+#define F1_RXCLK	12
+#define F1_TXCLK	11
+#endif
+
+/* FCC2 Clock Source Configuration.  There are board specific. 
+   Can only choose from CLK13-16 */
+#ifdef CONFIG_ADS8272
+#define F2_RXCLK	15
+#define F2_TXCLK	16
+#else
+#define F2_RXCLK	13
+#define F2_TXCLK	14
+#endif
+
+/* FCC3 Clock Source Configuration.  There are board specific. 
+   Can only choose from CLK13-16 */
+#define F3_RXCLK	15
+#define F3_TXCLK	16
+
+/* Automatically generates register configurations */
+#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
+
+#define CMXFCR_RF1CS(x) ((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
+#define CMXFCR_TF1CS(x) ((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
+#define CMXFCR_RF2CS(x) ((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
+#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
+#define CMXFCR_RF3CS(x) ((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
+#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
+
+#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
+#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
+#define CMX1_CLK_MASK	((uint)0xff000000)
+
+#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
+#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
+#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+
+#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
+#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
+#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
+
+
 /* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
  * but there is little variation among the choices.
  */
@@ -158,19 +217,6 @@
 #define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
 #define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
 
-/* CLK12 is receive, CLK11 is transmit.  These are board specific.
-*/
-#ifdef CONFIG_ADS8272
-#define PC_F1RXCLK	((uint)0x00000400)
-#define PC_F1TXCLK	((uint)0x00000200)
-#define CMX1_CLK_ROUTE	((uint)0x36000000)
-#define CMX1_CLK_MASK	((uint)0xff000000)
-#else
-#define PC_F1RXCLK	((uint)0x00000800)
-#define PC_F1TXCLK	((uint)0x00000400)
-#define CMX1_CLK_ROUTE	((uint)0x3e000000)
-#define CMX1_CLK_MASK	((uint)0xff000000)
-#endif
 
 /* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
  * but there is little variation among the choices.
@@ -189,19 +235,6 @@
 #define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
 #define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
 
-/* CLK13 is receive, CLK14 is transmit.  These are board dependent.
-*/
-#ifdef CONFIG_ADS8272
-#define PC_F2RXCLK	((uint)0x00004000)
-#define PC_F2TXCLK	((uint)0x00008000)
-#define CMX2_CLK_ROUTE	((uint)0x00370000)
-#define CMX2_CLK_MASK	((uint)0x00ff0000)
-#else
-#define PC_F2RXCLK	((uint)0x00001000)
-#define PC_F2TXCLK	((uint)0x00002000)
-#define CMX2_CLK_ROUTE	((uint)0x00250000)
-#define CMX2_CLK_MASK	((uint)0x00ff0000)
-#endif
 
 /* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
  * but there is little variation among the choices.
@@ -220,12 +253,6 @@
 #define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
 #define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
 
-/* CLK15 is receive, CLK16 is transmit.  These are board dependent.
-*/
-#define PC_F3RXCLK	((uint)0x00004000)
-#define PC_F3TXCLK	((uint)0x00008000)
-#define CMX3_CLK_ROUTE	((uint)0x00003700)
-#define CMX3_CLK_MASK	((uint)0x0000ff00)
 
 /* MII status/control serial interface.
 */
--
Leo Li
Software Engineer
Metrowerks -- Freescale Semiconductor
 
 
Office: +8610-65642272
LeoLi@freescale.com
