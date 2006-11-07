Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 690FF67C35
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 11:20:25 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <linuxppc-dev@ozlabs.org>
Subject: 2 problems with the i2c-mpc.c driver 
Date: Tue, 7 Nov 2006 01:20:18 +0100
Message-ID: <023a01c70202$818dea20$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1) Master I2C address
  Can't find how/where the controllers master I2C address is set.
  Seems like it is inherited from whatever the boot(u-boot in this case)
  was using. Seems a bit fragile to me.

2) Disturbance disables the I2C controller.
  Noticed that a disturbance on the I2C bus sometimes disables the
  the controller, will only recover after a reboot.
  Adding the following seems to cure the problem: 
 static void mpc_i2c_start(struct mpc_i2c *i2c)
{
        /* Clear arbitration */
        writeb(0, i2c->base + MPC_I2C_SR);
+       writeccr(i2c, 0);
+       udelay(5);
        /* Start with MEN */
        writeccr(i2c, CCR_MEN);
}
 I don't this this is the right fix, since it introduces an delay of 5 us.
 Any ideas?

 Jocke
