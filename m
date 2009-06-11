Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0BE44B716E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 06:19:11 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4F9B5DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 06:19:10 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC] fs_enet/mii-fec.c: fix MII speed calculation
Date: Thu, 11 Jun 2009 22:19:03 +0200
Message-Id: <1244751543-21977-2-git-send-email-wd@denx.de>
In-Reply-To: <fa686aa40906080737h64bad3cfv32155e5b819d650b@mail.gmail.com>
References: <fa686aa40906080737h64bad3cfv32155e5b819d650b@mail.gmail.com>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MII speed calculation was incorrectly based on the CPU clock
(ppc_proc_freq) instead of the bus clock; it worked only by chance and
for some CPU clock frequencies.

This patch makes it use the correct clock and adds some error
handling.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <galak@kernel.crashing.org>
---

This is mostly a fix for an old bug - it's starnge that this went
unnoticed so far. It worked only because the incorrectly computed
value was truncated due to the fact that the MII_SPEED field in the
rebister is only 6 bits wide - but, depending on the system clock
frequency, non working systems (MII_SPEED set to zero or DIS_PREAMBLE
set to one) might result as well.

This patch is marked a RFC for the following reasons:

1) drivers/net/fs_enet/mii-fec.c now uses mpc5xxx_get_mii_speed()
   which makes it 5xxx specific. I don't really like this, but did
   not see a clean way to avoid it either.

2) We probably should also use mpc5xxx_get_mii_speed() in
   drivers/net/fec_mpc52xx.c and drivers/net/fec_mpc52xx_phy.c, which
   also contain code to calculate the MII speed. But then we should
   also add some error checking to the code there, and we should make
   sure that only the bits that belong to the MII_SPEED field get
   written when setting the MII speed.

   I'm not sure if such changes are considered necessary, and if, if
   they should be added to this patch or handled in a separate one.


 arch/powerpc/sysdev/mpc5xxx_clocks.c |   37 ++++++++++++++++++++++++++++++++++
 drivers/net/fs_enet/mii-fec.c        |    9 ++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
index 34e12f9..3e9584b 100644
--- a/arch/powerpc/sysdev/mpc5xxx_clocks.c
+++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
@@ -31,3 +31,40 @@ mpc5xxx_get_bus_frequency(struct device_node *node)
 	return p_bus_freq ? *p_bus_freq : 0;
 }
 EXPORT_SYMBOL(mpc5xxx_get_bus_frequency);
+
+/**
+ *	mpc5xxx_get_get_mii_speed - Get the MII_SPEED value
+ *	@node:	device node
+ *
+ *	Returns the MII_SPEED value for MPC512x and MPC52xx systems.
+ *	The value gets computed such that the resulting MDC frequency
+ *	is 2.5 MHz or lower.
+ */
+
+int
+mpc5xxx_get_mii_speed(struct of_device *ofdev)
+{
+	unsigned int clock, speed;
+
+	clock = mpc5xxx_get_bus_frequency(ofdev->node);
+
+	if (!clock) {
+		dev_err(&ofdev->dev, "could not determine IPS/IPB clock\n");
+		return -ENODEV;
+	}
+
+	/* scale for a MII clock <= 2.5 MHz */
+	speed = (clock + 2499999) / 2500000;
+
+	/* only 6 bits available for MII speed */
+	if (speed > 0x3F) {
+		speed = 0x3F;
+		dev_err(&ofdev->dev,
+			"MII clock (%d MHz) exceeds max (2.5 MHz)\n",
+			clock / speed);
+	}
+
+	/* Field is in bits 25:30 of MII_SPEED register */
+	return speed << 1;
+}
+EXPORT_SYMBOL(mpc5xxx_get_mii_speed);
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index 28077cc..a2693b4 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -36,6 +36,7 @@
 #include <asm/pgtable.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
+#include <asm/mpc5xxx.h>
 
 #include "fs_enet.h"
 #include "fec.h"
@@ -152,13 +153,17 @@ static int __devinit fs_enet_mdio_probe(struct of_device *ofdev,
 	if (!fec->fecp)
 		goto out_fec;
 
-	fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
+	i = mpc5xxx_get_mii_speed(ofdev);
+	if (i < 0)
+		goto out_unmap_regs;
+
+	fec->mii_speed = i;
 
 	setbits32(&fec->fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
 	setbits32(&fec->fecp->fec_ecntrl, FEC_ECNTRL_PINMUX |
 	                                  FEC_ECNTRL_ETHER_EN);
 	out_be32(&fec->fecp->fec_ievent, FEC_ENET_MII);
-	out_be32(&fec->fecp->fec_mii_speed, fec->mii_speed);
+	clrsetbits_be32(&fec->fecp->fec_mii_speed, 0x7E, fec->mii_speed);
 
 	new_bus->phy_mask = ~0;
 	new_bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
-- 
1.6.0.6
