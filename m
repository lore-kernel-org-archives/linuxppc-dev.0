Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 184F6DDF2D
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:56:54 +1000 (EST)
In-Reply-To: <20070603182020.GA10355@iram.es>
References: <20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
	<34eddd7ce58e7983017077454d592332@kernel.crashing.org>
	<20070603101052.GA3313@iram.es>
	<ee4d3e25c4b6ede84483399249929632@kernel.crashing.org>
	<20070603124357.GA6419@iram.es>
	<3ffee021f3b721bde0253b1310d4958a@kernel.crashing.org>
	<20070603182020.GA10355@iram.es>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3f4dd692e859c6c1ffdec94a9134522f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Sun, 3 Jun 2007 20:56:47 +0200
To: Gabriel Paubert <paubert@iram.es>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Otherwise the "feature" of this RTC is that its interrupt
>>> is not connected.
>>
>> Dunno what you mean here?
>
> On a standard PC, the RTC is connected to interrupt
> 8 of the 8259 pair.

Ah okay.  This RTC is a completely different device
though.  It does have an interrupt line, but it might
very well not be connected anywhere.

>>> Actually I wonder
>>> whether using PNP0B00 is correct in the residual data here.
>>
>> It's not correct at all, no.
>
> Ok. I don't know well the PNP spec.

b00 means PC-AT style RTC.

> I don't really remember
> also what the chip identification means in the residual data,
> but it is always MOT3040.

I searched for that too, but couldn't find anything else
than Linux-on-PReP related stuff ;-)

> OTOH, there is a but in more
> recent versions, that claims that the NVRAM data size is
> 32768 and not 8192...

You can fix that in the device tree :-)

>> Not sure how best to describe this thing -- one master
>> node with a kid for both nvram and rtc; one node; or
>> perhaps one node for rtc, with a child node for nvram.
>
> Hey, at least you now understand why I was asking the question :-)

Yeah, it's a bit nasty case.  Since it _is_ one device,
you really want to describe it as such -- but it also
is nice to describe the nvram functionality separately.
I think I'd go for

rtc@i74 {
	device_type = "rtc";
	reg = <1 74 4>;
	compatible = "MK42whatever";

	nvram {
		device_type = "nvram";
		#bytes = <1ff0>;
	}
}

or something like that.  You'll have to do the device
matching as one device, but the driver has to know they
are one device *anyway* :-)

> This is the only device on these boards that really causes
> me trouble, for all the others I think I can get a reasonable
> description in the device tree.

Great to hear, looking forward to seeing it.


Segher
