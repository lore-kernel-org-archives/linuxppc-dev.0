Return-Path: <Stefan.Nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id CB84467B21
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 20:49:08 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050407163607.GN3396@smtp.west.cox.net>
References: <f476b44c655d9125f95b6d3ddc225576@embeddededge.com>
	<DCEAAC0833DD314AB0B58112AD99B93B85933A@ismail.innsys.innovsys.com>
	<20050407163607.GN3396@smtp.west.cox.net>
Content-Type: multipart/mixed; boundary="=-3Ogt3FZwaClP4ObqV5n4"
Date: Fri, 08 Apr 2005 12:49:00 +0200
Message-Id: <1112957340.12792.23.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-3Ogt3FZwaClP4ObqV5n4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-04-07 at 09:36 -0700, Tom Rini wrote:
> > The patch Stefan Nickl gave to me works perfectly, and all it does is
> > basically move the fcc_restart.
> > The kernel was still calling fcc_restart twiche per FCC at startup (one
> > time on init_fcc_startup, and then again in fcc_open), now it just calls
> > it twice in fcc_open. Seems to work.
> 
> Would someone please post what's needed vs current'ish 2.6 so we can get
> the proper fix up & in? :)  With the Signed-off-by & all that.. Thanks.

I took a little longer because I was not happy with the simple
cut'n'paste version. I believe the actual problem is that fcc_restart()
mustn't be called before netif_start_queue(). So the original version
only shortens the race period, it does not actually resolve it.

Unfortunately I'm deprived of suitable hardware as the focus of my work
has shifted in the last months, so I urge everyone out there to give it
a try.

Signed-off-by: Stefan Nickl <Stefan.Nickl@kontron.com>

-- 
Stefan Nickl
Kontron Modular Computers


--=-3Ogt3FZwaClP4ObqV5n4
Content-Disposition: attachment; filename=fcc_enet_startup_crash_v2.patch
Content-Type: text/x-patch; name=fcc_enet_startup_crash_v2.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.5/arch/ppc/8260_io/fcc_enet.c.bak	2005-04-08 09:37:40.000000000 +0200
+++ linux-2.5/arch/ppc/8260_io/fcc_enet.c	2005-04-08 12:01:55.000000000 +0200
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
+	netif_start_queue(dev);
+
+#if defined(CONFIG_USE_MDIO) || defined(CONFIG_TQM8260)
+	fcc_restart (dev, 1);	/* start in full duplex mode */
+#else
+	fcc_restart (dev, 0);	/* start in half duplex mode */
+#endif
+
+	return 0;		/* Always succeed */
 }
 

--=-3Ogt3FZwaClP4ObqV5n4--
