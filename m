Return-Path: <Stefan.Nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id B579E67B4E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 19:20:03 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859345@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859345@ismail.innsys.innovsys.com>
Content-Type: multipart/mixed; boundary="=-az8/w9RffLQ2frkEZ2+5"
Date: Mon, 11 Apr 2005 11:19:57 +0200
Message-Id: <1113211197.13011.27.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] RE: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-az8/w9RffLQ2frkEZ2+5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-04-08 at 09:39 -0500, Rune Torgersen wrote:
> I'm not sure what is going on, but that patch causes me to get "eth0: tx
> queue full!." messages as soon as I try to use the ethernet
> (Same thing happened if I just tried to remove the fcc_restart from
> init_fcc_startup)

Well ...

I don't like to make up theories I can't test but I guess what's going
on is this: fcc_restart() does two things, it sets up the transmit
machinery by calling fcc_stop() (fep->tx_free = TX_RING_SIZE;), and it
actually turns on the FCC.

I'm not a network driver guru but from what we've seen I'd say when the
driver calls netif_start_queue(), it
1) must already be prepared to xmit
2) must not call fcc_enet_rx() before

So fcc_restart() needed to be split up because calling it before
netif_start_queue() has the risk of rx'ing a packet too early, and
calling it afterwards is too late for the tx side.
Maybe it'd already help to add "fep->tx_free = TX_RING_SIZE;" to the
tx_bd init in init_fcc_param()...

But regarding my current indisposition with hardware, I'd suggest to
choose the smaller of the two evils, that is calling fcc_restart()
before starting the queue, leaving but a tiny race condition on rx side.

Signed-off-by: Stefan Nickl <Stefan.Nickl@kontron.com>

-- 
Stefan Nickl
Kontron Modular Computers


--=-az8/w9RffLQ2frkEZ2+5
Content-Disposition: attachment; filename=fcc_enet_startup_crash_v3.patch
Content-Type: text/x-patch; name=fcc_enet_startup_crash_v3.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.5/arch/ppc/8260_io/fcc_enet.c.bak	2005-04-08 09:37:40.000000000 +0200
+++ linux-2.5/arch/ppc/8260_io/fcc_enet.c	2005-04-11 11:02:30.000000000 +0200
@@ -2158,16 +2158,6 @@ init_fcc_startup(fcc_info_t *fip, struct
 	*(volatile uint *)(BCSR_ADDR + 12) &= ~BCSR3_FETHIEN2;
 	*(volatile uint *)(BCSR_ADDR + 12) |=  BCSR3_FETH2_RST;
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
@@ -2372,24 +2362,28 @@ fcc_enet_open(struct net_device *dev)
 	fep->sequence_done = 0;
 	fep->link = 0;
 
-	if (fep->phy) {
-		fcc_restart(dev, 0);	/* always start in half-duplex */
-		mii_do_cmd(dev, fep->phy->ack_int);
-		mii_do_cmd(dev, fep->phy->config);
-		mii_do_cmd(dev, phy_cmd_config);  /* display configuration */
-		while(!fep->sequence_done)
-			schedule();
-
-		mii_do_cmd(dev, fep->phy->startup);
-		netif_start_queue(dev);
-		return 0;		/* Success */
-	}
-	return -ENODEV;		/* No PHY we understand */
+	if (!fep->phy)
+		return -ENODEV;		/* No PHY we understand */
+
+	mii_do_cmd(dev, fep->phy->ack_int);
+	mii_do_cmd(dev, fep->phy->config);
+	mii_do_cmd(dev, phy_cmd_config);  /* display configuration */
+	while(!fep->sequence_done)
+		schedule();
+
+	mii_do_cmd(dev, fep->phy->startup);
 #else
 	fep->link = 1;
-	fcc_restart(dev, 0);	/* always start in half-duplex */
-	netif_start_queue(dev);
-	return 0;					/* Always succeed */
 #endif	/* CONFIG_USE_MDIO */
+
+#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
+	fcc_restart (dev, 1);	/* start in full duplex mode */
+#else
+	fcc_restart (dev, 0);	/* start in half duplex mode */
+#endif
+
+	netif_start_queue(dev);
+
+	return 0;		/* Always succeed */
 }
 

--=-az8/w9RffLQ2frkEZ2+5--
