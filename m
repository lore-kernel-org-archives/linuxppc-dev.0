Return-Path: <tosettofabio83@libero.it>
Received: from averell.mail.tiscali.it (averell.mail.tiscali.it
	[213.205.33.55]) by ozlabs.org (Postfix) with ESMTP id F2307DE317
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 04:17:42 +1000 (EST)
Received: from [192.168.0.40] (84.220.94.115) by averell.mail.tiscali.it
	(8.0.016) id 4816E7A80093AB6C for linuxppc-dev@ozlabs.org;
	Mon, 5 May 2008 20:12:12 +0200
Message-ID: <481F4DFD.1000702@libero.it>
Date: Mon, 05 May 2008 20:12:13 +0200
From: Fabio Tosetto <tosettofabio83@libero.it>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: MPC5200b MMC over SPI into PSC6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I have an embedded system with an on-board processor powerpc 
MPC5200B
and Linux kernel 2.6.22,
I must turn over to MMC SPI on the PSC6.

First, I
have enabled PSC6:

in ../arch/ppc/platforms/lite5200.c added PSC6 in SPI mode


struct mpc52xx_psc_func mpc52xx_psc_functions[] = {
{       .id     = 3,

                 .func   = "uart",
         },
         {       .id     = 4,

                 .func   = "uart",
         },
{       .id     = 5,

                 .func   = "spi",
         },
};

in ..
/arch/powerpc/boot/dts/lite5200b.dts enabled PSC6 in SPI mode

               
// PSC6 in spi mode example
spi@2c00 { // PSC6
device_type = "spi";

compatible = "mpc5200b-psc-spi\0mpc5200-psc-spi";
cell-index = <5>;
reg =
<2c00 100>;
interrupts = <2 4 0>;
interrupt-parent = <&mpc5200_pic>;
};


Now on the menuconfig enabling these options:

$ make ARCH=powerpc
CROSS_COMPILE=powerpc-linux-gnu- menuconfig

Platform support  --->
    [*]
MPC5200 (L25R) bugfix support
    [*] Freescale Lite5200 Eval Board

Device
Drivers  ---> SPI Support --->
    [*] SPI support
   <*> Freescale MPC52xx
PSC SPI controller

this options settings the CONFIG_SPI_MPC52xx_PSC=y variable
into .config

When linux booting, if I debug ../driver/spi/mpc52xx_psc_spi.c,
see that:

bus platform: add driver mpc52xx-psc-
spi                                                                                


bus platform: remove driver mpc52xx-psc-spi
drivers/spi/mpc52xx_psc_spi.c:
of_register_platform_driver failed (-19)

why??
any idea??

Someone knows how
to enable mmc over spi on PSC6?


thanks Fabio
