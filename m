Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E381FDDE3B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 21:40:19 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C6F3D20@zch01exm26.fsl.freescale.net>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C6F3D20@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3325F1D3-5C03-492C-B1CE-7626DC791656@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 11 Jul 2007 13:40:04 +0200
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

>>> +    - extended : Set the DMA channel to work at extended
>> chain mode.
>>> +                 If not set, the DMA channel will work at basic
>>> +                 chain mode.
>>
>> Call it "extended-chain-mode", perhaps?
>
> Is it maybe too long?

Not really no.  It's only 19 characters, and it isn't used
all over the place, so that should be fine.

>>> +    - reserved : Reserve the DMA channel to device.
>>
>> What does this do?  Reserve it for what device, and where?
>> The OS driver?
>>
>
> Yes, it reserve for the special device, which must use the fixed
> channel. Thus, reserve channels requested by that device.
>
> And in the device node of dts file, you can use such as
> "dma-channel=<&dma-ch0>" to reference the below channel:
>
> dma-ch0: ch0@100 {
> ...
> }

Right, so you don't need a "reserved" property, that information
is in the tree already.

Alternatively, for ease of use, you could put a "reserved" bitmap
in the master DMA controller node.  I wouldn't make nodes per
channel anyway, just describe the channels using properties -- that
takes care of the "reg" vs. "ranges" thing too, etc.


Segher
