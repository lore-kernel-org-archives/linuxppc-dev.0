Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8586BDDECE
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:52:22 +1000 (EST)
In-Reply-To: <CF39A363-25C6-4780-96EC-6750D77C287F@kernel.crashing.org>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<39c7d60cebf03badd106d7f75a08f449@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C526DD9@zch01exm26.fsl.freescale.net>
	<59453d80f2f111b72e8f24e7b489c23e@kernel.crashing.org>
	<CF39A363-25C6-4780-96EC-6750D77C287F@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2e7b08497aae9219233aed72628e46c6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add the explanation and sample of RapidIO DTS sector
	to the document of booting-without-of.txt file.
Date: Thu, 14 Jun 2007 09:52:06 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Not at all.  On an 8641 it could be
>>
>> 	compatible = "fsl,mpc8641-rapidio" "fsl,mpc8548-rapidio";
>>
>> which states "this is the 8641 thing and it is compatible
>> to the 8548 thing".  Perfectly clear.
>
> The concern is this isn't just compatible = "..8641.." "..8548.." but 
> something like:
>
> "..8641.." "..8641d.." "..8548.." "..8548e.." "..8543.." "..8543e.." 
> "..8572.." "..8572e.." "..8567.." "..8567e.." "..8568.." "..8568e.."

You don't need to mention _all_ compatible devices in
the "compatible" property, only the few that matter;
typically the oldest one, and sometimes some intermediate
device that has extra features over the original one.

It isn't useful to add "compatible" entries that no OS
probes for.

>> Concrete names are good.
>
> While I agree concrete names are good, we put these 'blocks' in so 
> many devices that using the device to match on is pointless.

You *definitely* should put the device name for _this_
device in there, in case it needs some special workaround.

> I'm all for making up a name like 'Grande', 'Del', 'Janeiro'.  This is 
> effective what we did with gianfar.  The name gets picked up pretty 
> quickly by people.

That can be used as the "base" name, yes.


Segher
