Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 91CF067D59
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 00:23:16 +1100 (EST)
Message-ID: <4549F141.5050905@transmode.se>
Date: Thu, 02 Nov 2006 14:23:13 +0100
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: mpc83xx SPI driver never calls its probe function
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am trying to get the driver/spi/spi_mpc83xx.c driver going and I am stuck.

I have tried to add spi_board_info and a platform_device:

static struct fsl_spi_platform_data bcm_platform_data = {
    .initial_spmode = 0,
    .bus_num = 1,
    .max_chipselect = 1,
/* board specific information */
    .activate_cs = bcm_cs_activate,
    .deactivate_cs = bcm_cs_deactivate,
    .sysclk =    266,
};
static struct spi_board_info spi_board_info[] __initdata = { {
    .modalias    = "bcm5322",
    .platform_data    = &bcm_platform_data,
    .max_speed_hz    = 120000,
    .bus_num    = 1,
    .chip_select    = 0,
},
};


struct platform_device bcm_5322 = {
    .name        = "bcm5322",
    .id        = 1,
    .dev        = {
        .platform_data = &bcm_platform_data,
    },
};
and register that with
 platform_device_register(&bcm_5322);
 spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info))

I also got a protocol driver that does:
static struct spi_driver bcm_driver = {
    .driver = {
        .name    = "bcm5322",
        .owner    = THIS_MODULE,
    },
    .probe    = bcm_probe,
    .remove    = __devexit_p(bcm_remove),
};
and then calls  spi_register_driver(&bcm_driver);
and I can't get the into the *probe functions. No matter what
combination I try,
the *probe functions for both the protocol driver and the spi_mpc83xx
driver are
never called.

I need some advice on how to enable my
protocol driver and the spi_mpc83xx driver.

 Jocke
