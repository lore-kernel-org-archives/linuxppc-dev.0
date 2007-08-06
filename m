Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51226DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:09:49 +1000 (EST)
In-Reply-To: <20070801123400.GA20200@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<692e6dabbfb62dc6d6ace3ea7552ef68@kernel.crashing.org>
	<20070801123400.GA20200@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <44eb4173dacc69037ea9acfb7880818f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Mon, 6 Aug 2007 20:09:43 +0200
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

>>> +			spi1pio:spi_pin@01 {
>>
>> There should be whitespace after the label.  @01 should be
>> spelled @1.  Except there is no "reg" property.
>
> Hm. I've just tried to keep original style in this particular dts.
> Want to ack patch below?

Not unless you get rid of the extra zeroes, too :-)

> What is prefered style of <&label> vs. < &label > usage, btw?
>
> arch/powerpc/boot/dts$ grep "<&" -r . | wc -l
> 327
> arch/powerpc/boot/dts$ grep "< &" -r . | wc -l
> 92
>
> I can only guess - the first?

I think it looks neater, yes.  I wouldn't worry about it
too much though.

>> What is this
>> stuff, anyway?
>
> Which one? pio-map for spi? This is GPIO pins configuration, to use
> dedicated functions (SPI) for these pins, otherwise SPI will not work.

The weird pseudo-nodes, yes.  This really should be handled in
platform code, not in the device tree; if there is a need to
describe what GPIOs are used for what, that should be handled
differently.

> p.s. mpc8272ads.dts is broken wrt spaces/tabs, very.

Care to do a cleanup patch?  Good for your karma ;-)


Segher
