Date: Wed, 28 May 2003 13:33:37 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ibm_ocp_phy/enet.c: MII PHY startup()
Message-ID: <Pine.LNX.4.52.0305281329200.15436@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

it seems to me that the PHY specific startup() sequence defined in the
ibm_ocp_phy.c modules is never actually executed from ibm_ocp_enet.c.
It think that's a bug and probably never really shows up because the
underlying firmware usually takes care of PHY initialisation. Anyway,
I appended a patch below.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com

--- linux/drivers/net/ibm_ocp/ibm_ocp_enet.c.org	Mon Mar 24 18:07:55 2003
+++ linux/drivers/net/ibm_ocp/ibm_ocp_enet.c	Mon May 26 14:19:20 2003
@@ -322,6 +322,7 @@ ppc405_enet_open(struct net_device *dev)
 		 (dev->dev_addr[2] << 24) | (dev->dev_addr[3] << 16)
 		 | (dev->dev_addr[4] << 8) | dev->dev_addr[5]);

+	mii_do_cmd(dev, fep->phy->startup);
 	mii_do_cmd(dev, fep->phy->ack_int);
 	mii_do_cmd(dev, fep->phy->config);
 	mii_queue_schedule(dev);

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
