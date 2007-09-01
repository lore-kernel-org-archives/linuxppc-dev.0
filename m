Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14342DE1AF
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Sep 2007 10:00:03 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
References: <20070823113349.GA11870@localhost.localdomain><20070823113600.GC18080@localhost.localdomain>
	<46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in	QE,
	register mmc_spi stub
Date: Sun, 2 Sep 2007 01:59:45 +0200
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	par_io_config_pin(3, 13, 1, 0, 0, 0); /* !SD_CS,    O */
>>> +	par_io_config_pin(3, 14, 2, 0, 0, 0); /* SD_INSERT, I */
>>> +	par_io_config_pin(3, 15, 2, 0, 0, 0); /* SD_PROTECT,I */
>>
>> Why are you doing this here, and not in the device tree?
>
> I saw you used pio node, but later changed to make it hardcoded.  
> What's
> the reason?  IMO, device tree is used to describe the hardware 
> settings,
> pio node is a perfect match.

Not at all.  The device tree describe how the hardware _is_
set up (after firmware, bootloader etc.); now how it _should
be_ set up by the kernel.

It would make a lot of sense to do this work in the firmware
instead, but it doesn't make sense at all to put this stuff
into the device tree.

> Moreover, changing the device tree is much
> easier than changing the code.

How so?  You don't like C code?  :-)


Segher
