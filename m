Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE1D6DDEEB
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 23:55:26 +1000 (EST)
Message-ID: <46DC126C.9060603@freescale.com>
Date: Mon, 03 Sep 2007 08:55:56 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in
	QE, register mmc_spi stub
References: <20070823113349.GA11870@localhost.localdomain><20070823113600.GC18080@localhost.localdomain>
	<46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
In-Reply-To: <ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> Not at all.  The device tree describe how the hardware _is_
> set up (after firmware, bootloader etc.); now how it _should
> be_ set up by the kernel.

I agree with this general sentiment, but in the case of QE pin configuration, 
then device tree, in a sense, does contain how the hardware is set up.  The 
par_io section in the device tree describes they layout of the wiring between 
the SOC and peripherals.  If the par_io registers are not programmed 
correctly, the SOC won't be able to communicate with the peripheral.

Sure, the kernel currently reads the device tree and programs the par_io 
registers accordingly, but that doesn't mean the information *shouldn't* be in 
the device tree.

> It would make a lot of sense to do this work in the firmware
> instead, but it doesn't make sense at all to put this stuff
> into the device tree.

1) If the firmware does configure the pins, then the device tree *will* 
describe how the hardware is set up.

2) How would the firmware know how to do board configuration if it doesn't 
have the instructions in the device tree?

Besides, every other board does it's par_io configuration based on the device 
tree.  So if Anton is going to break that pattern, we should be talking about 
moving all that code into U-boot, instead of just putting in a one-time 
exception (especially since the patch contains no explanation as to why these 
par_io pins are being configured differently than every other board).

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
