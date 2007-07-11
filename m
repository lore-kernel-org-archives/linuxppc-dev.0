Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59629DDF0C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 21:27:56 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3CE1@zch01exm26.fsl.freescale.net>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<11840606621515-git-send-email-wei.zhang@freescale.com>
	<55F09B00-F81A-4B70-B0F7-2FEBDBB2B48A@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3CE1@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1460BC39-B1B7-4025-9D4C-368FB473A260@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/4] Add dma sector to mpc8641hpcn board dts
Date: Wed, 11 Jul 2007 13:27:43 +0200
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +		dma@21000{
>>> +			compatible = "fsl,mpc8xxx-dma";
>>
>> Please use a real name, not this "xxx" stuff.
>
> Does the "xxx" seems to be an evil name? :-)

You are stating this particular device is compatible to
the "mpc8xxx-dma" device, which doesn't exist.  If it is
supposed to mean it is compatible to the DMA controller
on any 8000-series device, that is incorrect; in the future,
there might be many such devices with an incompatible DMA
controller.

Just put in some real device model name.

>>> +			reg = <21000 100>;
>>> +			ranges = <0 21000 1000>;
>>
>> These overlap, that can't be right; it is just begging for
>> trouble.
>
> There is no overlap. The 'reg' is used for the register of DMA
> controller. And the ranges is used for belows channel registers.

And 21000..210ff is a subset of 21000..21fff.  So there _is_
overlap.

> Such as ch0@100, reg=<100 80>, in fact, the ch0 register address is
> 0x21100.

Sure, none of the "reg"s in any of the children overlap the
parent "reg", but the parent "reg" overlaps the "ranges".

>>> +			ch0@100{
>>> +				reg = <100 80>;
>>> +				extended;
>>
>> I think you want a little more detailed property name
>> than "extended" here?
>
> I've explained it in [PATCH 1/4] Add DMA sector to
> Documentation/powerpc/booting-without-of.txt file.
> As below:
> +    - extended : Set the DMA channel to work at extended chain mode.
> +                 If not set, the DMA channel will work at basic
> +                 chain mode.

Sure it's documented, but it would be good if the property
name itself would say a bit more than just "extended".  Property
names can be 31 characters, there's no need to make short names
(terse is good, content-free isn't).


Segher
