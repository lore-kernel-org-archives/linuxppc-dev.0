Subject: [PATCH] MPC85XX TSEC driver: fix for mdio speed
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="=-a3aU3+FYXTF5XUJej2aW"
Message-Id: <1088504263.4834.14.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 12:17:44 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-a3aU3+FYXTF5XUJej2aW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In gianfar_phy.c, the divisor for the MDIO interface to the PHYs
is set to a safe value as part of running a phy_cmd.
However, there is one MDIO transaction that happens before any command
is sent: reading the PHYs manufactuere identifier in get_phy_info.

This patch adds a "dummy command" to use the side effect of
phy_run_commands.

Background is that the initial revision of our hardware only works
reliably with the slowest divisor as long as the FEC PHY is the only
(MDIO) bus load. We kept reading slightly distorted ID from the FEC's
PHY when the 2 Marvells were not yet up.

--
Stefan Nickl
Kontron Modular Computers


--=-a3aU3+FYXTF5XUJej2aW
Content-Disposition: attachment; filename=gfar_mdiospeed.patch
Content-Type: text/x-patch; name=gfar_mdiospeed.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -Nru a/drivers/net/gianfar_phy.c b/drivers/net/gianfar_phy.c
--- a/drivers/net/gianfar_phy.c	2004-06-29 12:07:12 +02:00
+++ b/drivers/net/gianfar_phy.c	2004-06-29 12:07:12 +02:00
@@ -496,6 +496,8 @@
 	int i;
 	struct phy_info *theInfo = NULL;

+	/* make sure the interface speed is safe from the first access */
+	phy_run_commands(dev, (const struct phy_cmd[]){{miim_end}});

 	/* Grab the bits from PHYIR1, and put them in the upper half */
 	phy_reg = read_phy_reg(dev, MIIM_PHYIR1);



--=-a3aU3+FYXTF5XUJej2aW--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
