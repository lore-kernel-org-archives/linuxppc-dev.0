Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D560BDDE0A
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:18:53 +1000 (EST)
In-Reply-To: <20070801132948.GB20200@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
	<20070801132948.GB20200@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d36303a31bb9cd2ab7cb38a09428e616@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Mon, 6 Aug 2007 20:18:47 +0200
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>>  		spi@4c0 {
>>>>>  			device_type = "spi";
>>>>> +			device-id = <1>;
>>>>
>>>> Can we just use the reg value for bus_num in the kernel.
>>>
>>> Sure, technically nothing prevents this. But, QE specs names
>>> SPIs by these ids.
>>
>> As a minimum the property name should start with "fsl," then.
>
> fsl,device-id = <1>;, correct?

Fine with me.  Someone more familiar with the FSL SoCs might
have a different opinion about polluting their namespace though.

>>> Plus, from the kernel side spi name will be
>>> not pretty, it will be spi1216.1.
>>
>> What, the kernel cannot implement a counter itself?
>
> Just counter is especially meaningless and confusing. It will
> work in that particular case, though. But then SPI bus number will
> depend on definition order in the dts file. This isn't how SPI
> bus numbers should be assigned. SPI bus numbers taken from specs,
> this is how people know which SPI is which.

Right, so the kernel platform code should number the SPI busses
based on their position in the device tree, etc.; that doesn't
mean you should put a Linux-specific "device name" property in
there.

>>>>> +				compatible = "mmc-spi";
>>
>> Needs to be more specific.
>
> Um.. for example? I can't imagine anything specific for this. ;-)

It should include a vendor name, a device name, and/or a board
name.  Something that uniquely defines the hardware programming
model for the device.

>>>>> +				pio-handle = <&mmc1pio>;
>>
>> What is this for?
>
> To set up output function of GPIO pin for MMC chip select.
>
> And well, I've just looked into par_io_of_config(), and I've found
> that pio-handle is mandatory (obviously), and thus let's back to:
>
>>>> we should do this in board code and not the device tree.
>>>
>>> Well, I've done this initially. But Vitaly hinted that this could
>>> be done in the DT instead, which made sense to me - mmc is the child
>>> device of SPI bus. Why do you think it shouldn't be in the DT? I'm
>>> not arguing, just want understand this.
>>
>> The hardware should be described in the device tree.  This isn't
>> the same as simply copying all your Linux code into it ;-)
>
> Ugh. SD/MMC slot is the hardware, isn't it? It have wired SPI pins,
> and chip select pin. To set up this pin, I need mmc node, which means
> that I can't completely move mmc definitions to the board file, as
> suggested by Kumar Gala.
>
> Advices?

You need to declare in the SPI node which GPIOs it uses for
what.  You shouldn't have the actual values to put into the
GPIO registers in the device tree; the kernel driver can
figure it out.

Hope this helps,


Segher
