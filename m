Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B51D5DDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 21:33:14 +1000 (EST)
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71])
	by metis.extern.pengutronix.de with esmtp (Exim 3.36 #1 (Debian))
	id 1HZ3Mb-0007hV-00
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Apr 2007 13:09:17 +0200
Received: from sha by leda.ptxnet.pengutronix.de with local (Exim 4.63)
	(envelope-from <sha@localhost.localdomain>) id 1HZ3Ma-0002dB-MU
	for linuxppc-dev@ozlabs.org; Wed, 04 Apr 2007 13:09:16 +0200
Date: Wed, 4 Apr 2007 13:09:16 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: SPI devices and OF
Message-ID: <20070404110916.GA9910@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm currently writing a driver for the mpc5200 spi controller (the
dedicated one, not the PSC ones).
The driver has the form of a of_platform_driver. My problem is that I
don't know how to define the spi devices on the spi bus. My current
approach is having something like this in the OF tree:


	spi@f00 {
		device_type = "spi";
		compatible = "mpc5200b-spi\0mpc5200-spi";
		reg = <f00 20>;
		interrupts = <2 d 0 2 e 0>;
		interrupt-parent = <500>;
		mmc@0 {
			device_type = "mmc_spi";
			compatible = "mmc_spi";
		};
	};

I can then parse the children in my spi driver with

	while( (child = of_get_next_child(odev->node, child))) {
		struct spi_board_info info;

		info.max_speed_hz = 
		info.bus_num = 
		info.chip_select = 
		...
		spi_register_board_info(&info, 1);
	}

I think it will work this way but I found no way getting the
platform_data for the spi devices.

I could also define the spi devices in a board specific c file but there
I would not know which spi bus is which if there is more than one.

Any thoughts on this or am I completely on the wrong track?

Sascha
