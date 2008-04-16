Return-Path: <tosettofabio83@libero.it>
Received: from smtp-out4.libero.it (smtp-out4.libero.it [212.52.84.46])
	by ozlabs.org (Postfix) with ESMTP id 416BFDE271
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 21:26:46 +1000 (EST)
Received: from mailrelay07.libero.it (192.168.32.94) by smtp-out4.libero.it
	(7.3.120) id 4628C8830A70DCE0 for linuxppc-embedded@ozlabs.org;
	Wed, 16 Apr 2008 13:26:43 +0200
Message-ID: <7804866.414101208345202994.JavaMail.defaultUser@defaultHost>
Date: Wed, 16 Apr 2008 13:26:42 +0200 (CEST)
From: "tosettofabio83@libero.it" <tosettofabio83@libero.it>
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200B MMC over SPI into PSC6
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Reply-To: "tosettofabio83@libero.it" <tosettofabio83@libero.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, I have an embedded system with an on-board processor powerpc MPC5200B 
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
		spi@2c00 {		// PSC6
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

thanks Fabio Tosetto
