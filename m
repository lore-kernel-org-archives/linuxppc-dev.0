From: Allen Curtis <acurtis@onz.com>
Reply-To: acurtis@onz.com
To: dan@embeddededge.com
Subject: FCC patch..really
Date: Tue, 27 Aug 2002 17:08:04 -0700
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_GP1JDZL7SFPTVJNBXQAD"
Message-Id: <200208271708.04797.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--------------Boundary-00=_GP1JDZL7SFPTVJNBXQAD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit


--
All things come to those who wait. Some of us just have to wait a little
longer...
--------------Boundary-00=_GP1JDZL7SFPTVJNBXQAD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fcc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fcc.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1115  -> 1.1116
#	arch/ppc/8260_io/fcc_enet.c	1.15    -> 1.16
#	arch/ppc/8260_io/Config.in	1.9     -> 1.10
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/26	acurtis@ws01.onz.com	1.1116
# Added ability to configure the 8260 clocks used by FCC ethernet.
# --------------------------------------------
#
diff -Nru a/arch/ppc/8260_io/Config.in b/arch/ppc/8260_io/Config.in
--- a/arch/ppc/8260_io/Config.in	Tue Aug 27 16:24:40 2002
+++ b/arch/ppc/8260_io/Config.in	Tue Aug 27 16:24:40 2002
@@ -2,6 +2,16 @@
 # MPC8260 Communication options
 #
 mainmenu_option next_comment
+
+comment 'MPC8260 Options'
+bool 'Disable data cache' CONFIG_DCACHE_DISABLE
+bool 'Use TMCNT for RTC' CONFIG_8260_RTC_TMCNT
+bool 'Enable local RAM support' CONFIG_8260_LRAM
+if [ "$CONFIG_8260_LRAM" = "y" ]; then
+  hex '  Local RAM base address' CONFIG_8260_LRAM_BASE 0xF7000000
+  hex '  Local RAM size' CONFIG_8260_LRAM_SIZE 0x00800000
+fi
+
 comment 'MPC8260 CPM Options'
 bool 'Enable SCC Console' CONFIG_SCC_CONSOLE
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
@@ -19,8 +29,47 @@
   bool 'CPM FCC Ethernet' CONFIG_FEC_ENET
   if [ "$CONFIG_FEC_ENET" = "y" ]; then
     bool 'Ethernet on FCC1' CONFIG_FCC1_ENET
+    if [ "$CONFIG_FCC1_ENET" = "y" ]; then
+      choice 'RX Clk Source'	\
+      	"CLK9		CONFIG_FCC1_RXCLK_CLK9	\
+      	 CLK10		CONFIG_FCC1_RXCLK_CLK10	\
+      	 CLK11		CONFIG_FCC1_RXCLK_CLK11	\
+      	 CLK12		CONFIG_FCC1_RXCLK_CLK12"	CLK12
+      choice 'TX Clk Source'	\
+      	"CLK9		CONFIG_FCC1_TXCLK_CLK9	\
+      	 CLK10		CONFIG_FCC1_TXCLK_CLK10	\
+      	 CLK11		CONFIG_FCC1_TXCLK_CLK11	\
+      	 CLK12		CONFIG_FCC1_TXCLK_CLK12"	CLK11
+    fi
     bool 'Ethernet on FCC2' CONFIG_FCC2_ENET
+    if [ "$CONFIG_FCC2_ENET" = "y" ]; then
+      choice 'RX Clk Source'	\
+      	"CLK13		CONFIG_FCC2_RXCLK_CLK13	\
+      	 CLK14		CONFIG_FCC2_RXCLK_CLK14	\
+      	 CLK15		CONFIG_FCC2_RXCLK_CLK15	\
+      	 CLK16		CONFIG_FCC2_RXCLK_CLK16"	CLK13
+      choice 'TX Clk Source'	\
+      	"CLK13		CONFIG_FCC2_TXCLK_CLK13	\
+      	 CLK14		CONFIG_FCC2_TXCLK_CLK14	\
+      	 CLK15		CONFIG_FCC2_TXCLK_CLK15	\
+      	 CLK16		CONFIG_FCC2_TXCLK_CLK16"	CLK14
+    fi
     bool 'Ethernet on FCC3' CONFIG_FCC3_ENET
+    if [ "$CONFIG_FCC3_ENET" = "y" ]; then
+      choice 'RX Clk Source'	\
+      	"CLK13		CONFIG_FCC3_RXCLK_CLK13	\
+      	 CLK14		CONFIG_FCC3_RXCLK_CLK14	\
+      	 CLK15		CONFIG_FCC3_RXCLK_CLK15	\
+      	 CLK16		CONFIG_FCC3_RXCLK_CLK16"	CLK15
+      choice 'TX Clk Source'	\
+      	"CLK13		CONFIG_FCC3_TXCLK_CLK13	\
+      	 CLK14		CONFIG_FCC3_TXCLK_CLK14	\
+      	 CLK15		CONFIG_FCC3_TXCLK_CLK15	\
+      	 CLK16		CONFIG_FCC3_TXCLK_CLK16"	CLK16
+    fi
+
+    bool 'Force FCC Full-Duplex Mode' CONFIG_FCC_FULL_DUPLEX
+
     bool 'Use MDIO for PHY configuration' CONFIG_USE_MDIO
     if [ "$CONFIG_USE_MDIO" = "y" ]; then
       choice 'Type of PHY'	\
@@ -31,7 +80,4 @@
       fi
   fi
 fi
-
-comment 'Generic MPC8260 Options'
-bool 'Disable data cache' CONFIG_DCACHE_DISABLE
 endmenu
diff -Nru a/arch/ppc/8260_io/fcc_enet.c b/arch/ppc/8260_io/fcc_enet.c
--- a/arch/ppc/8260_io/fcc_enet.c	Tue Aug 27 16:24:40 2002
+++ b/arch/ppc/8260_io/fcc_enet.c	Tue Aug 27 16:24:40 2002
@@ -1,5 +1,5 @@
 /*
- * BK Id: %F% %I% %G% %U% %#%
+ * BK Id: SCCS/s.fcc_enet.c 1.16 08/22/02 15:52:23 curtisa
  */
 /*
  * Fast Ethernet Controller (FCC) driver for Motorola MPC8260.
@@ -163,9 +163,41 @@

 /* CLK12 is receive, CLK11 is transmit.  These are board specific.
 */
-#define PC_F1RXCLK	((uint)0x00000800)
-#define PC_F1TXCLK	((uint)0x00000400)
-#define CMX1_CLK_ROUTE	((uint)0x3e000000)
+#define FCC1_RXCLK_SHIFT  (31 - 4)
+#if defined(CONFIG_FCC1_RXCLK_CLK9)
+#  define PC_F1RXCLK	((uint)0x00000100)
+#  define FCC1_RXCLK	((uint)4 << FCC1_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC1_RXCLK_CLK10)
+#  define PC_F1RXCLK	((uint)0x00000200)
+#  define FCC1_RXCLK	((uint)5 << FCC1_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC1_RXCLK_CLK11)
+#  define PC_F1RXCLK	((uint)0x00000400)
+#  define FCC1_RXCLK	((uint)6 << FCC1_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC1_RXCLK_CLK12)
+#  define PC_F1RXCLK	((uint)0x00000800)
+#  define FCC1_RXCLK	((uint)7 << FCC1_RXCLK_SHIFT)
+#else
+#  define FCC1_RXCLK	0
+#endif
+
+#define FCC1_TXCLK_SHIFT  (31 - 7)
+#if defined(CONFIG_FCC1_TXCLK_CLK9)
+#  define PC_F1TXCLK	((uint)0x00000100)
+#  define FCC1_TXCLK	((uint)4 << FCC1_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC1_TXCLK_CLK10)
+#  define PC_F1TXCLK	((uint)0x00000200)
+#  define FCC1_TXCLK	((uint)5 << FCC1_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC1_TXCLK_CLK11)
+#  define PC_F1TXCLK	((uint)0x00000400)
+#  define FCC1_TXCLK	((uint)6 << FCC1_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC1_TXCLK_CLK12)
+#  define PC_F1TXCLK	((uint)0x00000800)
+#  define FCC1_TXCLK	((uint)7 << FCC1_TXCLK_SHIFT)
+#else
+#  define FCC1_TXCLK	0
+#endif
+
+#define CMX1_CLK_ROUTE	(FCC1_RXCLK | FCC1_TXCLK)
 #define CMX1_CLK_MASK	((uint)0xff000000)

 /* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
@@ -187,9 +219,41 @@

 /* CLK13 is receive, CLK14 is transmit.  These are board dependent.
 */
-#define PC_F2RXCLK	((uint)0x00001000)
-#define PC_F2TXCLK	((uint)0x00002000)
-#define CMX2_CLK_ROUTE	((uint)0x00250000)
+#define FCC2_RXCLK_SHIFT  (31 - 12)
+#if defined(CONFIG_FCC2_RXCLK_CLK13)
+#  define PC_F2RXCLK	((uint)0x00001000)
+#  define FCC2_RXCLK	((uint)4 << FCC2_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC2_RXCLK_CLK14)
+#  define PC_F2RXCLK	((uint)0x00002000)
+#  define FCC2_RXCLK	((uint)5 << FCC2_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC2_RXCLK_CLK15)
+#  define PC_F2RXCLK	((uint)0x00004000)
+#  define FCC2_RXCLK	((uint)6 << FCC2_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC2_RXCLK_CLK16)
+#  define PC_F2RXCLK	((uint)0x00008000)
+#  define FCC2_RXCLK	((uint)7 << FCC2_RXCLK_SHIFT)
+#else
+#  define FCC2_RXCLK	0
+#endif
+
+#define FCC2_TXCLK_SHIFT  (31 - 15)
+#if defined(CONFIG_FCC2_TXCLK_CLK13)
+#  define PC_F2TXCLK	((uint)0x00001000)
+#  define FCC2_TXCLK	((uint)4 << FCC2_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC2_TXCLK_CLK14)
+#  define PC_F2TXCLK	((uint)0x00002000)
+#  define FCC2_TXCLK	((uint)5 << FCC2_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC2_TXCLK_CLK15)
+#  define PC_F2TXCLK	((uint)0x00004000)
+#  define FCC2_TXCLK	((uint)6 << FCC2_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC2_TXCLK_CLK16)
+#  define PC_F2TXCLK	((uint)0x00008000)
+#  define FCC2_TXCLK	((uint)7 << FCC2_TXCLK_SHIFT)
+#else
+#  define FCC2_TXCLK	0
+#endif
+
+#define CMX2_CLK_ROUTE	(FCC2_RXCLK | FCC2_TXCLK)
 #define CMX2_CLK_MASK	((uint)0x00ff0000)

 /* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
@@ -211,9 +275,41 @@

 /* CLK15 is receive, CLK16 is transmit.  These are board dependent.
 */
-#define PC_F3RXCLK	((uint)0x00004000)
-#define PC_F3TXCLK	((uint)0x00008000)
-#define CMX3_CLK_ROUTE	((uint)0x00003700)
+#define FCC3_RXCLK_SHIFT  (31 - 20)
+#if defined(CONFIG_FCC3_RXCLK_CLK13)
+#  define PC_F3RXCLK	((uint)0x00001000)
+#  define FCC3_RXCLK	((uint)4 << FCC3_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC3_RXCLK_CLK14)
+#  define PC_F3RXCLK	((uint)0x00002000)
+#  define FCC3_RXCLK	((uint)5 << FCC3_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC3_RXCLK_CLK15)
+#  define PC_F3RXCLK	((uint)0x00004000)
+#  define FCC3_RXCLK	((uint)6 << FCC3_RXCLK_SHIFT)
+#elif defined(CONFIG_FCC3_RXCLK_CLK16)
+#  define PC_F3RXCLK	((uint)0x00008000)
+#  define FCC3_RXCLK	((uint)7 << FCC3_RXCLK_SHIFT)
+#else
+#  define FCC3_RXCLK	0
+#endif
+
+#define FCC3_TXCLK_SHIFT  (31 - 23)
+#if defined(CONFIG_FCC3_TXCLK_CLK13)
+#  define PC_F3TXCLK	((uint)0x00001000)
+#  define FCC3_TXCLK	((uint)4 << FCC3_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC3_TXCLK_CLK14)
+#  define PC_F3TXCLK	((uint)0x00002000)
+#  define FCC3_TXCLK	((uint)5 << FCC3_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC3_TXCLK_CLK15)
+#  define PC_F3TXCLK	((uint)0x00004000)
+#  define FCC3_TXCLK	((uint)6 << FCC3_TXCLK_SHIFT)
+#elif defined(CONFIG_FCC3_TXCLK_CLK16)
+#  define PC_F3TXCLK	((uint)0x00008000)
+#  define FCC3_TXCLK	((uint)7 << FCC3_TXCLK_SHIFT)
+#else
+#  define FCC3_TXCLK	0
+#endif
+
+#define CMX3_CLK_ROUTE	(FCC3_RXCLK | FCC3_TXCLK)
 #define CMX3_CLK_MASK	((uint)0x0000ff00)

 /* MII status/control serial interface.
@@ -1813,7 +1909,7 @@
 	ads_csr_addr[1] &= ~BCSR1_FETHIEN;	/* Enable */
 #endif

-#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
+#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260) || defined(CONFIG_FCC_FULL_DUPLEX)
 	/* start in full duplex mode, and negotiate speed
 	 */
 	fcc_restart (dev, 1);
@@ -1946,9 +2042,9 @@
 	fccp = fcp->fccp;

 	if (duplex)
-		fccp->fcc_fpsmr |= FCC_PSMR_FDE;
+		fccp->fcc_fpsmr |= FCC_PSMR_FDE | FCC_PSMR_LPB;
 	else
-		fccp->fcc_fpsmr &= ~FCC_PSMR_FDE;
+		fccp->fcc_fpsmr &= ~(FCC_PSMR_FDE | FCC_PSMR_LPB);

 	/* Enable transmit/receive */
 	fccp->fcc_gfmr |= FCC_GFMR_ENR | FCC_GFMR_ENT;

--------------Boundary-00=_GP1JDZL7SFPTVJNBXQAD--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
