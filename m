Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04E0FDDE16
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 22:43:52 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C527171@zch01exm26.fsl.freescale.net>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<39c7d60cebf03badd106d7f75a08f449@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C526DD9@zch01exm26.fsl.freescale.net>
	<59453d80f2f111b72e8f24e7b489c23e@kernel.crashing.org>
	<CF39A363-25C6-4780-96EC-6750D77C287F@kernel.crashing.org>
	<2e7b08497aae9219233aed72628e46c6@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C527171@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8ce6f7f0f93921b9b6ed883fba247c2b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add the explanation and sample of RapidIO DTS sector
	to the document of booting-without-of.txt file.
Date: Mon, 18 Jun 2007 14:43:43 +0200
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You don't need to mention _all_ compatible devices in
>> the "compatible" property, only the few that matter;
>> typically the oldest one, and sometimes some intermediate
>> device that has extra features over the original one.
>
> The oldest one is difficult to find out sometime. Can we only set the
> self name in dts, such as "fsl, rapidio-8641", and add this 
> 'compatible'
> property to the driver ids arrays?

You can do that, but you typically don't need to -- the
whole idea of "compatible" is to avoid this, and not need
to have huge "pci id" style tables in the device drivers
that need constant updating.  But you _can_ do it, sure.

> Such as:
>
> static struct of_device_id of_rio_rpn_ids[] = {
> 	{ .compatible = "fsl, rapidio-8540",},
> 	{ .compatible = "fsl, rapidio-8560",},
> 	{ .compatible = "fsl, rapidio-8641",},
> 	{ .compatible = "fsl, rapidio-8548",},
> 	{},
> };
>
> How about that?

I would just put 8540 in the table and in all device trees
in this case.

>> It isn't useful to add "compatible" entries that no OS
>> probes for.
>>
>>>> Concrete names are good.
>>>
>>> While I agree concrete names are good, we put these 'blocks' in so
>>> many devices that using the device to match on is pointless.
>>
>> You *definitely* should put the device name for _this_
>> device in there, in case it needs some special workaround.
>>
>>> I'm all for making up a name like 'Grande', 'Del',
>> 'Janeiro'.  This is
>>> effective what we did with gianfar.  The name gets picked up pretty
>>> quickly by people.
>>
>> That can be used as the "base" name, yes.
>
> Do you have the name list? I can change my codes according them.

Nope.

> How about 'Mercurary', 'Venus', 'Earth', 'Mars', 'Saturn', 'Jupiter',
> 'Uranus', 'Neptune',
> Or 'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra',
> 'Scorpius', 'Sagittarius', 'Capricornus', 'Aquarius', 'Pisces' ?

I don't like making up names just for this, I don't see what good
this would do.  Using a pre-existing code name is fine of course,
as long as it is a unique identifier, since that's all that matters.


Segher
