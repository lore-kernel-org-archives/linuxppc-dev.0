Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id A54AFDDFD5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 04:14:23 +1100 (EST)
Subject: Re: MPC8321, ethernet and i2c problems after upgrade from 2.6.25
	to 2.6.27
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20081013163151.GD19080@ld0162-tx32.am.freescale.net>
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
	<20081013163151.GD19080@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 19:14:19 +0200
Message-Id: <1223918059.32141.62.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 11:31 -0500, Scott Wood wrote:
> On Mon, Oct 13, 2008 at 02:01:55PM +0200, Joakim Tjernlund wrote:
> > Secondly i2c, I have this in my platform driver:
> > static struct i2c_board_info __initdata tmcu_i2c_devices[] = {
> > 	{ I2C_BOARD_INFO("rtc-ds1307", 0x68),
> > 	  .type = "ds1337",
> > 	},
> > };
> > 
> > int __init tmcu_i2c_board_devs(void)
> > {
> > 	int ret;
> > 	ret = i2c_register_board_info(0, tmcu_i2c_devices,
> > 				      ARRAY_SIZE(tmcu_i2c_devices));
> > 	return ret;
> > }
> > arch_initcall(tmcu_i2c_board_devs);
> 
> i2c-mpc.c now registers as a dynamically-numbered bus; you need to either
> use the device tree, or call i2c_new_device().
> 
> -Scott

Thanks, but is this really so? Reading include/linux/i2c.h makes me
wonder if not the i2c_register_board_info() should still work.
Calling i2c_new_device() from an initcall() procedure does not
seem easy/possible, you need the adapter to do that. Maybe I just
missing something obvious?

 Jocke
