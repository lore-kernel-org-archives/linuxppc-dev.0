Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7315FDDDE1
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 17:07:18 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m9E62EBt015376
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 23:07:10 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m9DGVpxZ008747
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:31:51 -0500 (CDT)
Date: Mon, 13 Oct 2008 11:31:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC8321,
	ethernet and i2c problems after upgrade from 2.6.25 to 2.6.27
Message-ID: <20081013163151.GD19080@ld0162-tx32.am.freescale.net>
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 13, 2008 at 02:01:55PM +0200, Joakim Tjernlund wrote:
> Secondly i2c, I have this in my platform driver:
> static struct i2c_board_info __initdata tmcu_i2c_devices[] = {
> 	{ I2C_BOARD_INFO("rtc-ds1307", 0x68),
> 	  .type = "ds1337",
> 	},
> };
> 
> int __init tmcu_i2c_board_devs(void)
> {
> 	int ret;
> 	ret = i2c_register_board_info(0, tmcu_i2c_devices,
> 				      ARRAY_SIZE(tmcu_i2c_devices));
> 	return ret;
> }
> arch_initcall(tmcu_i2c_board_devs);

i2c-mpc.c now registers as a dynamically-numbered bus; you need to either
use the device tree, or call i2c_new_device().

-Scott
