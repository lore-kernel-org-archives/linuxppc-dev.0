Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DC2FDDE00
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 20:14:03 +1000 (EST)
In-Reply-To: <CC27DED0F8F39E48A7E75FD768688B7A8C16ED@zch01exm27.fsl.freescale.net>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<c6e4b0f3534e38db766d76fd6450f163@kernel.crashing.org>
	<CC27DED0F8F39E48A7E75FD768688B7A8C16ED@zch01exm27.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a7387ce0860d7d5bcd990f1364310221@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 V2] booting-without-of for Freescale MSI
Date: Fri, 9 May 2008 12:13:37 +0200
To: "Jin Zhengxiong" <Jason.Jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> If these MSI devices work really identical for 83xx, 85xx,
>> 86xx, there is no need to distinguish between them for
>> probing either -- you want to use the same driver for all, anyway
> .
> The driver can work for 83xx, 85xx and 86xx,  but the msiir offset
> is different for 83xx and 85xx/86xx cpu. I need this to get different
> msiir offset in the driver.

It's a different offset _within_ the region specified in "reg"?
Yeah, using different "compatible" is cleanest then, no doubt.

>>> +    - msi-available-ranges: use <start count> style
>> section to define
>>> which
>>> +      msi interrupt can be used in the 256 msi interrupts.
>>
>> Please make this property optional, default to "all available".
>>
> The value setting for this property is "all available", and this ranges
> maybe
> useful for some other MSI controller.

Sure, I didn't say to drop the property, just make it optional,
since most trees will want the same value anyway.


Segher
