Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5306CDDE16
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:06:53 +1000 (EST)
In-Reply-To: <20070727114559.GB11463@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Wed, 1 Aug 2007 00:06:46 +0200
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

>>>  		spi@4c0 {
>>>  			device_type = "spi";
>>> +			device-id = <1>;
>>
>> Can we just use the reg value for bus_num in the kernel.
>
> Sure, technically nothing prevents this. But, QE specs names
> SPIs by these ids.

As a minimum the property name should start with "fsl," then.

> Plus, from the kernel side spi name will be
> not pretty, it will be spi1216.1.

What, the kernel cannot implement a counter itself?

>>> +			max-chipselect = <1>;
>>
>> I'm not sure how I feel about this in here, I'm thinking it should go.
>
> It's board-specific, i.e. how much chips connected to this SPI bus.

It is misnamed then.  It should be automatically derived from
the child nodes, though.

>>> +			mmc@01 {

@01 should be @1.  Except that it is wrong, since there is
no "reg" property.

>>> +				device_type = "mmc";

No device_type please.

>>> +				compatible = "mmc-spi";

Needs to be more specific.

>>> +				device-id = <1>;

Get rid of this.

>>> +				max-speed-hz = <bebc20>; /* 12500000 Hz */

Just max-speed.

>>> +				chip-select = <0>;

This should be named "reg".  And the parent needs #address-cells
and #size-cells properties.

>>> +				pio-handle = <&mmc1pio>;

What is this for?

>> we should do this in board code and not the device tree.
>
> Well, I've done this initially. But Vitaly hinted that this could
> be done in the DT instead, which made sense to me - mmc is the child
> device of SPI bus. Why do you think it shouldn't be in the DT? I'm
> not arguing, just want understand this.

The hardware should be described in the device tree.  This isn't
the same as simply copying all your Linux code into it ;-)


Segher
