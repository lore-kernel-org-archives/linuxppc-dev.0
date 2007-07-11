Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8DB3FDDE40
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:18:17 +1000 (EST)
Message-ID: <46951EE0.6040603@freescale.com>
Date: Wed, 11 Jul 2007 13:18:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<20070710161121.GA14556@ld0162-tx32.am.freescale.net>
	<22488704-4826-413B-BD18-F75C2743FB5B@kernel.crashing.org>
	<4694F7A2.6040403@freescale.com>
	<01035B4E-01EB-479A-9AA7-BCFBF6C60904@kernel.crashing.org>
In-Reply-To: <01035B4E-01EB-479A-9AA7-BCFBF6C60904@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> The generic DMA driver can look at the device tree, too.  It's more
> convenient to only have to look at the dma-controller node, true.
> But with the proposed tree you have to look at all the channel nodes
> already.

But if the only way to tell is a phandle from the sound device, it has
to look at the sound node as well, and somehow figure out where in the
sound node the phandle is stored.

>> I don't see the need for a master node -- there are no shared 
>> registers (other than a redundant read-only status summary
>> register) to synchronize access to.  Each channel would be an
>> independent device under the SoC bus.
> 
> 
> The "master" node is needed to describe its register block.  It 
> doesn't matter whether you want to use those registers currently or
> not.

It doesn't have a register block, as such.  There's one fairly useless
read-only register, that if we really wanted to we could describe as a
second reg resource in each channel, combined with a channel-ID property.

I'm not inclined to bother, though -- not because we don't currently use
it, but because I have a hard time seeing anyone needing to use it.
There is no information in that register that is not the individual
channels' registers.  I'd just lump it in with all of the other assorted
SoC registers that we don't describe in the device tree.

>> The benefit is that if a channel needs to be driven by (for
>> example) a sound driver, it can have a different compatible that
>> will be matched by the sound driver,
> 
> 
> Nah, the sound node should just point to the channel node, or point
> to the DMA controller and describe the channel # some other way.
> There is no need to make a special "sound DMA channel" device name.

It's by far the simplest way to tell the generic DMA driver "do not
touch".  "fsl,mpc8548-dma" says "this is a generic, mem-to-mem DMA 
channel".  "fsl,mpc8548-audio-dma" says "this is a non-generic DMA 
channel, hooked up to an audio codec".

Would you prefer something like "fsl,mpc8548-dma-special-purpose"? 
Though there's also the possibility that there might be no other node to 
indicate the function, and that the only way to program the device is to 
start DMA.

> Sure.  But you yourself already say "most of the time" -- and the
> device tree doesn't describe how the kernel uses the hardware, it
> simply describes the hardware itself.

Precisely.  If the fsl,whatever-audio-dma driver wants to call the
generic DMA code, it can do so without the device tree's help.  I see no 
reason to give the mem-to-mem DMA driver special status compared to 
other users of the DMA channels.

> The sound DMA channel is part of the DMA controller, it is only
> _connected_ to the sound controller, it shouldn't be described as
> being more closely connected to the sound stuff than it actually is.

It's not as if I'm suggesting making it a child of the sound node -- 
just that each channel be a separate SoC-level device, and only 
mem-to-mem channels match the mem-to-mem driver.

-Scott
