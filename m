Return-Path: <Dhinakaran.K@Lntemsys.com>
Received: from mail145.messagelabs.com (mail145.messagelabs.com
	[216.82.242.163]) by ozlabs.org (Postfix) with SMTP id 81D5EB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 Nov 2009 22:18:22 +1100 (EST)
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: SPI driver for linux 2.6.29
MIME-Version: 1.0
Message-ID: <OFE4E1EE44.9F32C829-ON6525766A.003B58A7-6525766A.003DF846@lntemsys.com>
From: Dhinakaran K <Dhinakaran.K@Lntemsys.com>
Date: Tue, 10 Nov 2009 16:47:47 +0530
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
     I've a PPC8313e based board running linux2.6.29 on it. Also I've a 
FRAM interfaced to it via SPI. This FRAM almost similar to SPI based 
EEPROM, so I'm trying to use EEPROM's driver AT25.

Kernel Configuration :
        SPI support --> selected
                Freescale MPC83xx/QUICC Engine SPI controller --> selected 
(Actually I've replaced MPC83xx's controller driver with modified 
MPC8XXX's(from 2.6.31) one for it was not getting probed,)
                User mode SPI device driver support  --> selected

DTS File;
                spi@7000 {
                        cell-index = <0>;
                        compatible = "fsl,spi";
                        reg = <0x7000 0x1000>;
                        interrupts = <16 0x8>;
                        interrupt-parent = <&ipic>;
                        mode = "cpu";
                        fram@0{
                                                compatible = 
"ramtron,fm25";         -->(Modified at25 as fm25 )
                                                spi-max-frequency = 
<100000000>;
                                                reg = <0>;
                                                };

                        };

                and we are forcing following values in AT25 driver
                        byte_len        = 65536;
                        name            = fram-spi
                        page_size       = 65535;
                        flags           = EE_ADDR2;
Problem:
        Drivers are getting complied. But I'm not sure how to acces(i.e, 
read/write) the actual SPI-FRAM device. 
Should I use 
        1. /dev/spi/X nodes created by spidev driver 
                When I use this node, open fails with ERRNO 6
                        or
        2. /sys/bus/spi/devices/spi32766.0/eeprom file.
                When I use this sysfs file,Im not able to read / write 
properly

Queries:
        1. What will be device nodes for this custom at25(fm25) driver, 
which registers to spi.c driver?
        2. Is spidev.c involved in this picture?


Any help/directions in this regard will of great help.




Thanks n Regards
dhina
