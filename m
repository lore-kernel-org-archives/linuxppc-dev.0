Date: Thu, 7 Feb 2002 19:17:41 -0800
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Armin <akuster@pacbell.net>
Subject: PPC405gp enet Soft Reset
Message-ID: <20020207191741.A26185@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I seem to be having a problem with the soft reset of EMAC
mode register when I have no ethernet connection to by phy.

After this code in init_ppc405_enet(void) the SRST bit does
not clear until after I stick in a cable.

		/* Reset the EMAC */
		emacp->em0mr0 = EMAC_M0_SRST;
		eieio();
		for (delay = 0; delay < 1000; delay++) ;
		emacp->em0mr0 = emacp->em0mr0 & ~EMAC_M0_SRST;
		eieio();
                printk( KERN_INFO "em0mr0 %08x", emacp->em0mr0 );


This causes problems in find_phy, since phy_reg never gets set to
a value and read_mdio fails.

I have a Rev E chip, but since I always booted over the net with the
Walnut board I don't think I even tried to boot without an ethernet
connection.

Just checking to see if anyone else has noticed what their 405gp does
when it doesn't have a connection during the linux boot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
