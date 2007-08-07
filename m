Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67085DDE46
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 02:11:49 +1000 (EST)
In-Reply-To: <20070807105346.GB13606@localhost.localdomain>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<b3d36996792216ddd9dbae12212a4168@kernel.crashing.org>
	<20070801132948.GB20200@localhost.localdomain>
	<d36303a31bb9cd2ab7cb38a09428e616@kernel.crashing.org>
	<20070807105346.GB13606@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2cc0345aaf781a6d01e33df08f12bc97@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Tue, 7 Aug 2007 18:11:42 +0200
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

>>>> The hardware should be described in the device tree.  This isn't
>>>> the same as simply copying all your Linux code into it ;-)
>>>
>>> Ugh. SD/MMC slot is the hardware, isn't it? It have wired SPI pins,
>>> and chip select pin. To set up this pin, I need mmc node, which means
>>> that I can't completely move mmc definitions to the board file, as
>>> suggested by Kumar Gala.
>>>
>>> Advices?
>>
>> You need to declare in the SPI node which GPIOs it uses for
>> what.  You shouldn't have the actual values to put into the
>> GPIO registers in the device tree; the kernel driver can
>> figure it out.
>
> Well, how SPI differs from UCC in that regard?

Not at all, I think.  You just copied a bad example that
shouldn't exist like that at all :-(

> This is how mpc832x_mds.dts,
> mpc832x_rdb.dts, mpc836x_mds.dts, ... doing things already for UCC 
> pins.
> And then what pio-map exists for?.. In my understanding pio-map tries 
> to
> describe hardware (GPIO) wiring, exactly how SPI (and UCC) nodes trying
> to use it.

Yeah.  It however contains lots more information that really
should be implicit in the driver using it (like, GPIO output
lines that are marked "no interrupt" -- what a surprise, duh).

As far as I can see the devices that need some GPIOs should
just say which GPIOs (on what GPIO controller) they use, and
that's about it, the kernel device drivers can handle the
rest (since they need to know lots more implicit information
_anyway_, there is no point in describing more details in the
device tree, esp. since many of those details describe only
how a device is used, not what it _is_).

Anyway, not your fault, I'd prefer not to see the madness
spread though :-)

> Heh.. anyway, it's really hard to find proper logic around device tree,
> do's and don'ts, so I'll just follow your suggestions in hope that I'll
> get it as time goes by. ;-)

:-)


Segher
