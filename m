Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C84FDDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 21:19:07 +1000 (EST)
In-Reply-To: <20070710161121.GA14556@ld0162-tx32.am.freescale.net>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<20070710161121.GA14556@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <22488704-4826-413B-BD18-F75C2743FB5B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 11 Jul 2007 13:18:57 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +    - compatible : Should be "fsl,mpc8xxx-dma"
>>
>> Should _include_, not should _be_.  And none of this xxx
>> business, of course.
>
> Especially since the 85xx/86xx version is not 100% compatible with the
> 83xx version.  How about fsl,mpc8349-dma and fsl,mpc8548-dma for  
> the two
> variants?

Fine with me.  Do put the exact model name in every .dts
file as well, e.g. for a hypothetical MPC8599:

	compatible = "fsl,mpc8599-dma", "fsl,mpc8548-dma";

so the kernel can match on the exact name if it needs a
quirk, but can use the more generic name otherwise.

>>> +    - extended : Set the DMA channel to work at extended chain  
>>> mode.
>>> +                 If not set, the DMA channel will work at basic
>>> +                 chain mode.
>>
>> Call it "extended-chain-mode", perhaps?
>
> Or don't call it anything.  The ability to do extended chain mode is
> implicit in being compatible with fsl,mpc8548-dma.

Right.  I'm not sure having the channels as separate subnodes
buys anything at all, btw.

>>> +    - reserved : Reserve the DMA channel to device.
>>
>> What does this do?  Reserve it for what device, and where?
>> The OS driver?
>
> Some hardware has DMA channels hardwired to certain peripherals,  
> such as
> an audio codec.  This keeps them from being used as general purpose  
> DMA
> channels.

I think you need this knowledge in the kernel drivers anyway,
or at the very least, the device node for for example that
audio codec needs to refer to the DMA channel in the device
tree, so this "reserved" property is unnecessary.

> I'd rather just treat the different DMA channels as independent  
> devices,
> rather than children of a dma "bus", and change the compatible name if
> they're not general purpose.  There's only one register that's shared
> among the channels, and it's a superfluous status summary register.

If you make separate nodes for the channels, they need to have
a parent.  I don't think it makes sense to have the channel
nodes and the "master" node as siblings -- maybe it all should
be just one node with a "#channels" property or such?


Segher
