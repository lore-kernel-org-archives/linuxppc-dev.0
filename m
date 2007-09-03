Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DBAB7DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 09:12:50 +1000 (EST)
In-Reply-To: <46DC126C.9060603@freescale.com>
References: <20070823113349.GA11870@localhost.localdomain><20070823113600.GC18080@localhost.localdomain>
	<46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6c73dab2fcf21490edc64b9b7ec52295@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Date: Tue, 4 Sep 2007 01:12:20 +0200
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Not at all.  The device tree describe how the hardware _is_
>> set up (after firmware, bootloader etc.); now how it _should
>> be_ set up by the kernel.
>
> I agree with this general sentiment, but in the case of QE pin 
> configuration, then device tree, in a sense, does contain how the 
> hardware is set up.  The par_io section in the device tree describes 
> they layout of the wiring between the SOC and peripherals.  If the 
> par_io registers are not programmed correctly, the SOC won't be able 
> to communicate with the peripheral.
>
> Sure, the kernel currently reads the device tree and programs the 
> par_io registers accordingly, but that doesn't mean the information 
> *shouldn't* be in the device tree.

It is fine if the device tree describes how things are wired together;
that's part of the device tree's purpose, after all.

It is not fine if the device tree says _how to_ configure the hardware;
you are supposed to put your device drivers elsewhere, not in the
device tree!

>> It would make a lot of sense to do this work in the firmware
>> instead, but it doesn't make sense at all to put this stuff
>> into the device tree.
>
> 1) If the firmware does configure the pins, then the device tree 
> *will* describe how the hardware is set up.

Yes.  It won't show pario register contents though.

> 2) How would the firmware know how to do board configuration if it 
> doesn't have the instructions in the device tree?

This kind of thing is typically hardcoded into the firmware (just like
the device tree is) -- just put it somewhere _next to_ the device tree,
not _in_ it.  The device tree is not a config file for the firmware; it
is an interface between the firmware and its client (an OS, typically).

> Besides, every other board does it's par_io configuration based on the 
> device tree.  So if Anton is going to break that pattern, we should be 
> talking about moving all that code into U-boot, instead of just 
> putting in a one-time exception (especially since the patch contains 
> no explanation as to why these par_io pins are being configured 
> differently than every other board).

Yes, I definitely didn't mean to single out Anton's patch, sorry if it
sounded that way.


Segher
