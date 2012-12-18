Return-Path: <jjo.braun@gmail.com>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE3D92C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 20:44:43 +1100 (EST)
Received: by mail-ie0-f179.google.com with SMTP id k14so504788iea.24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 01:44:41 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 18 Dec 2012 10:44:39 +0100
Message-ID: <CADwvPCuBcSnXz1LYYf2ydfdCcz1tV5eBZufEDh5LCaZrmY7W4Q@mail.gmail.com>
Subject: tqm5200s phy link toggles between up and down
From: Johannes Braun <jjo.braun@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I hope someone could help me with my problem. Currently I am porting
a new kernel (3.3.8) for a tqm5200s based board.
The previous kernel was 2.6.23. The new kernel version is needed because
of support for a wireless card.

The new kernel has problems with my ethernet PHY. The problem occurs only
with our hardware. Not with the TQ eval board.
The eval board uses a Intel PHY. Our board uses a Marvel 88E6085 PHY.
I have tested the new kernel on the eval board and everything runs fine.
But After booting the kernel on our hardware, the ethernet connection is
going up and down and loops between these two states.

This is the log output:
[   38.608305] PHY: f0003000:00 - Link is Down
[   41.708310] PHY: f0003000:00 - Link is Up - 10/Half
[   43.744304] PHY: f0003000:00 - Link is Down
[   46.844309] PHY: f0003000:00 - Link is Up - 10/Half

I also had a look inside the driver in
Drivers/net/ethernet/freescale/fec_mpc52xx.c
and made a printk output to the link adjust method,
which is called everytime before the link is going down.

 /* based on generic_adjust_link from fs_enet-main.c */
static void
mpc52xx_fec_adjust_link(struct net_device *dev)
{
   struct mpc52xx_fec_priv *priv = netdev_priv(dev);
   struct phy_device *phydev = priv->phydev;
   int new_state = 0;

   printk( KERN_INFO "%s->%s: entering...",
     __FILE__, __func__ );

   if (phydev->link != PHY_DOWN) {
      if (phydev->duplex != priv->duplex) {
         struct mpc52xx_fec __iomem *fec = priv->fec;
         u32 rcntrl;
         u32 tcntrl;
...
...

This is the output with the above printk:
[   35.589485] PHY: f0003000:00 - Link is Down
[   40.752753] drivers/net/ethernet/freescale/fec_mpc52xx.c
->mpc52xx_fec_adjust_link: entering...
[   40.761494] PHY: f0003000:00 - Link is Up - 10/Half
[   42.796746] drivers/net/ethernet/freescale/fec_mpc52xx.c
->mpc52xx_fec_adjust_link: entering...
[   42.805485] PHY: f0003000:00 - Link is Down
[   49.000755] drivers/net/ethernet/freescale/fec_mpc52xx.c
->mpc52xx_fec_adjust_link: entering...
[   49.009497] PHY: f0003000:00 - Link is Up - 10/Half


As I noticed the problem occurs also with a 2.6.24 kernel.
Seems that the driver was rewritten and moved from drivers/net/fec_mpc52xx/
to drivers/net/ethernet/freescale/fec_mpc52xx.c.

I am note shure where to search for the problem. The PHY link seems to be in
some kind of auto-negotiating loop of going up and down? Has anyone had this
problem before, or does someone has a tip to fix this problem?

Best regards
Johannes
