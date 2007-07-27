Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BE369DDDD5
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 21:46:27 +1000 (EST)
Date: Fri, 27 Jul 2007 15:45:59 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register
	mmc_spi stub
Message-ID: <20070727114559.GB11463@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
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

On Fri, Jul 27, 2007 at 03:14:06AM -0500, Kumar Gala wrote:
>
> On Jul 26, 2007, at 8:57 AM, Anton Vorontsov wrote:
[...]
>>
>> @@ -207,20 +222,36 @@
>>
>>  		spi@4c0 {
>>  			device_type = "spi";
>> +			device-id = <1>;
>
> Can we just use the reg value for bus_num in the kernel.

Sure, technically nothing prevents this. But, QE specs names
SPIs by these ids. Plus, from the kernel side spi name will be
not pretty, it will be spi1216.1. Reg value making little sense
to the userspace (or kernel-side SPI layer). Still want get
rid of device-id?

>>  			compatible = "fsl_spi";
>>  			reg = <4c0 40>;
>>  			interrupts = <2>;
>>  			interrupt-parent = <&qeic>;
>> -			mode = "cpu";
>> +			mode = "qe";
>> +			sysclk = <5f5e100>; /* 100000000 Hz */
>
> we don't need this in the spi node, its just the system clock frequency 
> which we can get other ways.

Will try, I guess "bus-frequency" property of soc8323 is what I need.

>> +			max-chipselect = <1>;
>
> I'm not sure how I feel about this in here, I'm thinking it should go.

It's board-specific, i.e. how much chips connected to this SPI bus.
SPI layer needs this. Otherwise I have to pass it from board file,
but isn't it fits nicely in the DT?

>> +			pio-handle = <&spi1pio>;
>> +
>> +			mmc@01 {
>> +				device_type = "mmc";
>> +				compatible = "mmc-spi";
>> +				device-id = <1>;
>> +				max-speed-hz = <bebc20>; /* 12500000 Hz */
>> +				chip-select = <0>;
>> +				pio-handle = <&mmc1pio>;
>> +			};
>
> we should do this in board code and not the device tree.

Well, I've done this initially. But Vitaly hinted that this could
be done in the DT instead, which made sense to me - mmc is the child
device of SPI bus. Why do you think it shouldn't be in the DT? I'm
not arguing, just want understand this.

Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
