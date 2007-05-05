Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E586ADDECD
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 06:49:57 +1000 (EST)
In-Reply-To: <20070505191306.GB23524@lixom.net>
References: <1178381611.3393.25.camel@zod.rchland.ibm.com>
	<1178382006.3393.37.camel@zod.rchland.ibm.com>
	<e1d22829fe3f12509018791541073706@kernel.crashing.org>
	<20070505191306.GB23524@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <cbcd7823ea9b0f17f998670915719a05@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 6/7] Holly DTS
Date: Sat, 5 May 2007 22:49:50 +0200
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		PowerPC,750@0 {
>>
>> Needs to be PowerPC,750CL etc.
>
> Why _needs_?

Because that's what the PowerPC binding says:

	Open Firmware standard property. The value of the
	is property shall be of the form: =93PowerPC,<name>=94,
	where <name> is the name of the processor chip which
	may be displayed to the user.


> Apple never used anything else than PowerPC,G5, no matter
> what generation chip.

I don't care what Apple did in their device trees,
they made many mistakes.

>>> +  	tsi109@c0000000 {
>>> +		device_type =3D "tsi-bridge";
>>
>> Don't put a "device_type" here, it is useless
>> (and undefined).  There are more like this, but
>> perhaps Linux (wrongly) probes on "device_type"
>> for those, so the kernel would need updating
>> first.
>
> Josh is just using the precedence that the other platform gives, the
> driver is keying off of device_type. While that should be fixed, =
that's
> a separate issue.

Yes I know, I tried to explain that already, but
seems I failed :-)

> I'm sure they'd welcome a driver patch from you.

It's on my todo list.

>>> +		bus-frequency =3D <0>;
>>
>> 0?
>
> Filled in by bootloader/wrapper?

I don't think it is?

> Other dts'es are similar. Could be nice
> to have a comment next to it if that's the case.

Yeah.  There's also this ?? syntax now I believe.


Segher
