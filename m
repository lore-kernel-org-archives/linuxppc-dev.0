Return-Path: <stefan.nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 9A40F2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Nov 2004 18:27:55 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="=-vhwYjakl0fi0aYvlrRFO"
Date: Fri, 26 Nov 2004 08:27:48 +0100
Message-Id: <1101454068.10752.1.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Subject: [patch] Race condition #2 in arch/ppc/cpm2_io/fcc_enet.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-vhwYjakl0fi0aYvlrRFO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The initialisation sequence of the fcc ethernet driver contains race
condition that will crash the machine when a packet is received in the
wrong moment during system boot.

The oops usually shows ip_route_input() as the responsible function, but
that is not where things go wrong.
The problem is that when fec_enet_init() calls init_fcc_startup() during
device setup, fcc_restart() enables the receiver and the device will
start to receive packets while the rest of networking is not yet
prepared for this -> crash.
This situation can easily be created when the system is loaded with a
flood ping during boot, it will almost certainly crash (ping the
broadcast address on a isolated network to be sure the booting device
really gets it's share).

The patch moves the calls to fcc_restart() to fcc_enet_open(), so
packets will only start to come in when the kernel is ready for it.

I'm not 100% about all the implications this could have, but it seems to
work fine.

-- 
Stefan Nickl
Kontron Modular Computers


--=-vhwYjakl0fi0aYvlrRFO
Content-Disposition: attachment; filename=fcc_enet-startup_race.patch
Content-Type: text/x-patch; name=fcc_enet-startup_race.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/arch/ppc/cpm2_io/fcc_enet.c	2004-08-09 08:32:28.000000000 +0200
+++ fcc_enet.c	2004-11-25 18:41:22.000000000 +0100
@@ -2008,16 +2008,6 @@ init_fcc_startup(fcc_info_t *fip, struct
         *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_FETHIEN;
         *(volatile uint *)(BCSR_ADDR + 4) |=  BCSR1_FETH_RST;
 #endif
-
-#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
-	/* start in full duplex mode, and negotiate speed
-	 */
-	fcc_restart (dev, 1);
-#else
-	/* start in half duplex mode
-	 */
-	fcc_restart (dev, 0);
-#endif
 }
 
 #ifdef	CONFIG_USE_MDIO
@@ -2155,6 +2145,16 @@ fcc_enet_open(struct net_device *dev)
 {
 	struct fcc_enet_private *fep = dev->priv;
 
+#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
+	/* start in full duplex mode, and negotiate speed
+	 */
+	fcc_restart (dev, 1);
+#else
+	/* start in half duplex mode
+	 */
+	fcc_restart (dev, 0);
+#endif
+
 #ifdef	CONFIG_USE_MDIO
 	fep->sequence_done = 0;
 	fep->link = 0;

--=-vhwYjakl0fi0aYvlrRFO--
