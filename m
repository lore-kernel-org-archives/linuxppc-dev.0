In-Reply-To: <22C48749-C9D2-11D8-B201-000393DBC2E8@freescale.com>
References: <22C48749-C9D2-11D8-B201-000393DBC2E8@freescale.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/mixed; boundary=Apple-Mail-1--205572371
Message-Id: <6429F663-D53A-11D8-8835-000393C30512@freescale.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] MPC85XX TSEC driver: fix for mdio speed
Date: Tue, 13 Jul 2004 21:06:17 -0500
To: Stefan.Nickl@kontron.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Apple-Mail-1--205572371
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

> From: Stefan Nickl<Stefan.Nickl@kontron.com>
> Date: June 29, 2004 5:17:44 AM CDT
> To: linuxppc-embedded<linuxppc-embedded@lists.linuxppc.org>
> Cc: Kumar Gala<kumar.gala@motorola.com>
> Subject: [PATCH] MPC85XX TSEC driver: fix for mdio speed
>
> In gianfar_phy.c, the divisor for the MDIO interface to the PHYs
> is set to a safe value as part of running a phy_cmd.
> However, there is one MDIO transaction that happens before any command
> is sent: reading the PHYs manufactuere identifier in get_phy_info.
> This patch adds a "dummy command" to use the side effect of
> phy_run_commands.
> Background is that the initial revision of our hardware only works
> reliably with the slowest divisor as long as the FEC PHY is the only
> (MDIO) bus load. We kept reading slightly distorted ID from the FEC's
> PHY when the 2 Marvells were not yet up.
> --
> Stefan Nickl
> Kontron Modular Computers
>

Ooh, good catch.  Kumar Gala forwarded me this, since I wrote the
driver (And now I have subscribed to linuxppc-embedded, as I should
have ;).  Rather than a dummy read, though, it might be better to
abstract the code which configures the bus, and put it in a function
that both get_phy_info and phy_run_commands can call.

Here's a patch that does that.  Could you check that it fixes your
problem?  If so, we'll push it out.


--Apple-Mail-1--205572371
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	x-unix-mode=0644;
	name="phy_buspatch.txt"
Content-Disposition: attachment;
	filename=phy_buspatch.txt

Index: drivers/net/gianfar_phy.c
===================================================================
RCS file: /cvsroot/linuxppc/linuxppc-2.4/drivers/net/gianfar_phy.c,v
retrieving revision 1.3.4.3
diff -u -r1.3.4.3 gianfar_phy.c
--- drivers/net/gianfar_phy.c   2004/05/24 17:42:02     1.3.4.3
+++ drivers/net/gianfar_phy.c   2004/06/29 21:32:09
@@ -42,6 +42,8 @@
 #include "gianfar.h"
 #include "gianfar_phy.h"

+static void get_phy_bus(struct gfar *phyregs);
+
 /* Write value to the PHY for this device to the register at regnum, */
 /* waiting until the write is done before it returns.  All PHY */
 /* configuration has to be done through the TSEC1 MIIM regs */
@@ -430,6 +432,10 @@
        u32 phy_ID;
        int i;
        struct phy_info *theInfo = NULL;
+       struct gfar_private *priv = (struct gfar_private *)dev->priv;
+       struct gfar *phyregs = priv->phyregs;
+
+       get_phy_bus(phyregs);

        /* Grab the bits from PHYIR1, and put them in the upper half */
        phy_reg = read_phy_reg(dev, MIIM_PHYIR1);
@@ -456,6 +462,19 @@
        return theInfo;
 }

+static void get_phy_bus(struct gfar *phyregs)
+{
+       /* Reset the management interface */
+       gfar_write(&phyregs->miimcfg, MIIMCFG_RESET);
+
+       /* Setup the MII Mgmt clock speed */
+       gfar_write(&phyregs->miimcfg, MIIMCFG_INIT_VALUE);
+
+       /* Wait until the bus is free */
+       while (gfar_read(&phyregs->miimind) & MIIMIND_BUSY)
+               cpu_relax();
+}
+
 /* Take a list of struct phy_cmd, and, depending on the values, either */
 /* read or write, using a helper function if provided */
 /* It is assumed that all lists of struct phy_cmd will be terminated by */
@@ -466,16 +485,8 @@
        u16 result;
        struct gfar_private *priv = (struct gfar_private *) dev->priv;
        struct gfar *phyregs = priv->phyregs;
-
-       /* Reset the management interface */
-       gfar_write(&phyregs->miimcfg, MIIMCFG_RESET);

-       /* Setup the MII Mgmt clock speed */
-       gfar_write(&phyregs->miimcfg, MIIMCFG_INIT_VALUE);
-
-       /* Wait until the bus is free */
-       while (gfar_read(&phyregs->miimind) & MIIMIND_BUSY)
-               cpu_relax();
+       get_phy_bus(phyregs);

        for (i = 0; cmd->mii_reg != miim_end; i++) {
                /* The command is a read if mii_data is miim_read */

--Apple-Mail-1--205572371
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



Sorry for the long delay:  this window fell behind some others while I
was investigating a couple of the other things you mentioned, and then
my stack got corrupted.

Andy Fleming
PowerPC Software Enablement
Freescale Semiconductor, Inc.
--Apple-Mail-1--205572371--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
