Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5A3F0DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 23:30:51 +1000 (EST)
Date: Wed, 1 Aug 2007 17:29:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register
	mmc_spi stub
Message-ID: <20070801132948.GB20200@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2007 at 12:06:46AM +0200, Segher Boessenkool wrote:
>>>>  		spi@4c0 {
>>>>  			device_type = "spi";
>>>> +			device-id = <1>;
>>>
>>> Can we just use the reg value for bus_num in the kernel.
>>
>> Sure, technically nothing prevents this. But, QE specs names
>> SPIs by these ids.
>
> As a minimum the property name should start with "fsl," then.

fsl,device-id = <1>;, correct?

>> Plus, from the kernel side spi name will be
>> not pretty, it will be spi1216.1.
>
> What, the kernel cannot implement a counter itself?

Just counter is especially meaningless and confusing. It will
work in that particular case, though. But then SPI bus number will
depend on definition order in the dts file. This isn't how SPI
bus numbers should be assigned. SPI bus numbers taken from specs,
this is how people know which SPI is which.

>>>> +			max-chipselect = <1>;
>>>
>>> I'm not sure how I feel about this in here, I'm thinking it should go.
>>
>> It's board-specific, i.e. how much chips connected to this SPI bus.
>
> It is misnamed then.  It should be automatically derived from
> the child nodes, though.
>
>>>> +			mmc@01 {
>
> @01 should be @1.  Except that it is wrong, since there is
> no "reg" property.
>
>>>> +				device_type = "mmc";
>
> No device_type please.
>
>>>> +				compatible = "mmc-spi";
>
> Needs to be more specific.

Um.. for example? I can't imagine anything specific for this. ;-)

>>>> +				device-id = <1>;
>
> Get rid of this.
>
>>>> +				max-speed-hz = <bebc20>; /* 12500000 Hz */
>
> Just max-speed.
>
>>>> +				chip-select = <0>;
>
> This should be named "reg".  And the parent needs #address-cells
> and #size-cells properties.
>
>>>> +				pio-handle = <&mmc1pio>;
>
> What is this for?

To set up output function of GPIO pin for MMC chip select.

And well, I've just looked into par_io_of_config(), and I've found
that pio-handle is mandatory (obviously), and thus let's back to:

>>> we should do this in board code and not the device tree.
>>
>> Well, I've done this initially. But Vitaly hinted that this could
>> be done in the DT instead, which made sense to me - mmc is the child
>> device of SPI bus. Why do you think it shouldn't be in the DT? I'm
>> not arguing, just want understand this.
>
> The hardware should be described in the device tree.  This isn't
> the same as simply copying all your Linux code into it ;-)

Ugh. SD/MMC slot is the hardware, isn't it? It have wired SPI pins,
and chip select pin. To set up this pin, I need mmc node, which means
that I can't completely move mmc definitions to the board file, as
suggested by Kumar Gala.

Advices?

> Segher

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
