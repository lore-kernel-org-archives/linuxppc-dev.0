Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 055002BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jan 2005 00:08:16 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j0D9tia4021393
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2005 02:55:44 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j0D9sMk1026688
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Jan 2005 03:54:23 -0600 (CST)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730813D2@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: linuxppc-dev@ozlabs.org
Date: Thu, 13 Jan 2005 17:49:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] 8272ADS FCC clock setting
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patches fix Clock pin Configuration of MPC8272ADS board FCC support, and clear up comment on it.

Signed-off-by: Li Yang <LeoLi@freescale.com>

Patch for 2.4.28:


--- linux-2.4.28/arch/ppc/cpm2_io/fcc_enet.c	2004-08-08 07:26:04.000000000 +0800
+++ linux-patched/arch/ppc/cpm2_io/fcc_enet.c	2004-12-23 14:02:04.980850470 +0800
@@ -158,14 +158,16 @@
 #define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
 #define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
 
-/* CLK12 is receive, CLK11 is transmit.  These are board specific. -*/
+/* FCC1 Clock configuration.  These are board specific.
+ */
 #ifdef CONFIG_ADS8272
+/* CLK11 is receive, CLK10 is transmit. */
 #define PC_F1RXCLK	((uint)0x00000400)
 #define PC_F1TXCLK	((uint)0x00000200)
-#define CMX1_CLK_ROUTE	((uint)0x36000000)
+#define CMX1_CLK_ROUTE	((uint)0x35000000)
 #define CMX1_CLK_MASK	((uint)0xff000000)
 #else
+/* CLK12 is receive, CLK11 is transmit. */
 #define PC_F1RXCLK	((uint)0x00000800)
 #define PC_F1TXCLK	((uint)0x00000400)
 #define CMX1_CLK_ROUTE	((uint)0x3e000000)
@@ -189,14 +191,16 @@
 #define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
 #define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
 
-/* CLK13 is receive, CLK14 is transmit.  These are board dependent. -*/
+/* FCC2 Clock configuration.  These are board specific.
+ */
 #ifdef CONFIG_ADS8272
+/* CLK15 is receive, CLK16 is transmit. */
 #define PC_F2RXCLK	((uint)0x00004000)
 #define PC_F2TXCLK	((uint)0x00008000)
 #define CMX2_CLK_ROUTE	((uint)0x00370000)
 #define CMX2_CLK_MASK	((uint)0x00ff0000)
 #else
+/* CLK13 is receive, CLK14 is transmit. */
 #define PC_F2RXCLK	((uint)0x00001000)
 #define PC_F2TXCLK	((uint)0x00002000)
 #define CMX2_CLK_ROUTE	((uint)0x00250000)
@@ -220,8 +224,9 @@
 #define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
 #define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
 
-/* CLK15 is receive, CLK16 is transmit.  These are board dependent. -*/
+/* FCC3 Clock configuration.  These are board specific.
+ * CLK15 is receive, CLK16 is transmit.
+ */
 #define PC_F3RXCLK	((uint)0x00004000)
 #define PC_F3TXCLK	((uint)0x00008000)
 #define CMX3_CLK_ROUTE	((uint)0x00003700)


Patch for 2.6.9:

--- linux-2.6.9/arch/ppc/8260_io/fcc_enet.c	2004-10-19 05:54:07.000000000 +0800
+++ linux-patched/arch/ppc/8260_io/fcc_enet.c	2004-12-23 13:58:50.698840185 +0800
@@ -158,19 +158,22 @@
 #define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
 #define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
 
+/* FCC1 Clock configuration.  These are board specific.
+ */
 #ifdef CONFIG_SBC82xx
-/* rx is clk9, tx is clk10 */
+/* CLK9 is receive, CLK10 is transmit. */
 #define PC_F1RXCLK     ((uint)0x00000100)
 #define PC_F1TXCLK     ((uint)0x00000200)
 #define CMX1_CLK_ROUTE ((uint)0x25000000)
 #define CMX1_CLK_MASK  ((uint)0xff000000)
 #elif defined(CONFIG_ADS8272)
+/* CLK11 is receive, CLK10 is transmit. */
 #define PC_F1RXCLK	((uint)0x00000400)
 #define PC_F1TXCLK	((uint)0x00000200)
-#define CMX1_CLK_ROUTE	((uint)0x36000000)
+#define CMX1_CLK_ROUTE	((uint)0x35000000)
 #define CMX1_CLK_MASK	((uint)0xff000000)
 #else /* other boards */
-/* CLK12 is receive, CLK11 is transmit.  These are board specific. */
+/* CLK12 is receive, CLK11 is transmit. */
 #define PC_F1RXCLK	((uint)0x00000800)
 #define PC_F1TXCLK	((uint)0x00000400)
 #define CMX1_CLK_ROUTE	((uint)0x3e000000)
@@ -194,14 +197,16 @@
 #define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
 #define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
 
-/* CLK13 is receive, CLK14 is transmit.  These are board dependent. -*/
+/* FCC2 Clock configuration.  These are board specific.
+ */
 #ifdef CONFIG_ADS8272
+/* CLK15 is receive, CLK16 is transmit. */
 #define PC_F2RXCLK	((uint)0x00004000)
 #define PC_F2TXCLK	((uint)0x00008000)
 #define CMX2_CLK_ROUTE	((uint)0x00370000)
 #define CMX2_CLK_MASK	((uint)0x00ff0000)
 #else
+/* CLK13 is receive, CLK14 is transmit. */
 #define PC_F2RXCLK	((uint)0x00001000)
 #define PC_F2TXCLK	((uint)0x00002000)
 #define CMX2_CLK_ROUTE	((uint)0x00250000)
@@ -225,8 +230,9 @@
 #define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
 #define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
 
-/* CLK15 is receive, CLK16 is transmit.  These are board dependent. -*/
+/* FCC3 Clock configuration.  These are board specific.
+ * CLK15 is receive, CLK16 is transmit.
+ */
 #define PC_F3RXCLK	((uint)0x00004000)
 #define PC_F3TXCLK	((uint)0x00008000)
 #define CMX3_CLK_ROUTE	((uint)0x00003700)


--
Leo Li
Software Engineer
Metrowerks -- Freescale Semiconductor
 
 
Office: +8610-65642272
LeoLi@freescale.com
