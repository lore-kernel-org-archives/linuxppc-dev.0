Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F4D0DDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 15:52:55 +1000 (EST)
In-Reply-To: <59453d80f2f111b72e8f24e7b489c23e@kernel.crashing.org>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<39c7d60cebf03badd106d7f75a08f449@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C526DD9@zch01exm26.fsl.freescale.net>
	<59453d80f2f111b72e8f24e7b489c23e@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CF39A363-25C6-4780-96EC-6750D77C287F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add the explanation and sample of RapidIO DTS sector
	to the document of booting-without-of.txt file.
Date: Thu, 14 Jun 2007 00:53:11 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
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

>> Some silicons of Freescale processor are the same RapidIO controller,
>> such as mpc8540/mpc8560 are the same (v0.0), mpc8548/mpc8641 are the
>> same (v1.0). For v1.0 RapidIO controller, should we use mpc8548 or
>> mpc8641? Those will make people confused.
>
> Not at all.  On an 8641 it could be
>
> 	compatible = "fsl,mpc8641-rapidio" "fsl,mpc8548-rapidio";
>
> which states "this is the 8641 thing and it is compatible
> to the 8548 thing".  Perfectly clear.

The concern is this isn't just compatible = "..8641.." "..8548.." but  
something like:

"..8641.." "..8641d.." "..8548.." "..8548e.." "..8543.." "..8543e.."  
"..8572.." "..8572e.." "..8567.." "..8567e.." "..8568.." "..8568e.."

>> Using IP Block Revision is a
>> clear choice.
>
> I don't think so.  For one thing, it describes a version of
> a cell design, not a version of an actual device.  For another
> thing, if I hear "8641" I know what you're talking about (sort
> of, anyway), but I draw a blank stare if you say "v1.0".  I'm
> sure I'm not the only one.  Concrete names are good.

While I agree concrete names are good, we put these 'blocks' in so  
many devices that using the device to match on is pointless.

I'm all for making up a name like 'Grande', 'Del', 'Janeiro'.  This  
is effective what we did with gianfar.  The name gets picked up  
pretty quickly by people.

- k
