Return-Path: <joakim.tjernlund@transmode.se>
Received: from mail.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 34338DE3ED
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 23:01:58 +1100 (EST)
Subject: MPC8321, ethernet and i2c problems after upgrade from 2.6.25 to 2.6.27
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 14:01:55 +0200
Message-Id: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So I upgraded my tree for our custom mpc8321 boards.
I2c and ethernet stopped working.

Ethernet: I am using the ucc_geth driver and now
it seems like it won't TX any pkgs.
ethtool -S eth0  shows that the RX countes are increasing but
the TX ones stays a zero. 

Secondly i2c, I have this in my platform driver:
static struct i2c_board_info __initdata tmcu_i2c_devices[] = {
	{ I2C_BOARD_INFO("rtc-ds1307", 0x68),
	  .type = "ds1337",
	},
};

int __init tmcu_i2c_board_devs(void)
{
	int ret;
	ret = i2c_register_board_info(0, tmcu_i2c_devices,
				      ARRAY_SIZE(tmcu_i2c_devices));
	return ret;
}
arch_initcall(tmcu_i2c_board_devs);

This no longer works, but if I add
rtc@68 {
		compatible = "dallas,ds1337";
		reg = <68>;
	};
to my device tree so the whole I2c node looks like this:
	i2c@3000 {
		#address-cells = <1>;
		#size-cells = <0>;
		cell-index = <0>;
		device_type = "i2c";
		compatible = "fsl-i2c";
		reg = <3000 100>;
		interrupts = <e 8>;
		interrupt-parent = <&ipic>;
		dfsrr;

		rtc@68 {
			compatible = "dallas,ds1337";
			reg = <68>;
		};
	};
it works again. Is my static init of the rtc device faulty or is this
a bug in the kernel?

 Jocke
