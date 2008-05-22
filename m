Return-Path: <tosettofabio83@libero.it>
Received: from polito.it (unknown [130.192.3.44])
	by ozlabs.org (Postfix) with ESMTP id 0184BDE00D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 20:43:00 +1000 (EST)
Message-ID: <48354E2B.8010003@libero.it>
Date: Thu, 22 May 2008 12:42:51 +0200
From: Fabio Tosetto <tosettofabio83@libero.it>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: SD-MMC over SPI on PSC6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: dbrownell@users.sourceforge.net, garyj@denx.de,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net, g.liakhovetski@gmx.de,
	drzeus-mmc@drzeus.cx
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

The MMC over SPI is connected to MPC5200b, here's how:

  MPC5200B
----------------                                        
                       
|                                                                 
|------------------
         PSC1_2 |--->------------Chip_Select (out)---------|      
                       
|                                                                 |
                       |                        
                                         |     SD CARD
         ETH_17 |---<------------IRQ (in)------------------|   MMC over SPI
                       |                                                
                 |
                       
|                                                                 |
         PSC6_0 |---<------------SPI_RXD (in)------------|
                       
|                                                                 |
                       
|                                                                 |
         PSC6_2 |--->------------SPI_TXD (out)-----------|
                       |                                                 
                |
                       |                                                 
                |
         PSC6_3 |--->------------SPI_CLK (out)-----------|
                       
|                                                                 
|------------------
----------------

Now on the menuconfig enabling these options:

$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- menuconfig

Platform support  --->
   [*] MPC5200 (L25R) bugfix support
   [*] Freescale Lite5200 Eval Board

Device Drivers  ---> SPI Support --->
   [*] SPI support
  <*> Freescale MPC52xx PSC SPI controller

Now I have applied those patch:
http://www.mail-archive.com/spi-devel-general@lists.sourceforge.net/msg00150.html

Now on the menuconfig enabling these options:

$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- menuconfig

Device Drivers  --->  MMC/SD card support --->
 [*] MMC debugging
<*> MMC block device driver
<*> MMC host test driver
<*> MMC/SD over SPI

Is correct applied those patch and enable those options into menuconfig?

thanks Fabio
