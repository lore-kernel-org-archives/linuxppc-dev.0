Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03626DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:44:14 +1000 (EST)
In-Reply-To: <46951EE0.6040603@freescale.com>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<20070710161121.GA14556@ld0162-tx32.am.freescale.net>
	<22488704-4826-413B-BD18-F75C2743FB5B@kernel.crashing.org>
	<4694F7A2.6040403@freescale.com>
	<01035B4E-01EB-479A-9AA7-BCFBF6C60904@kernel.crashing.org>
	<46951EE0.6040603@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <12728378-7DC8-41D9-BCF4-5F883F651E40@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 11 Jul 2007 20:43:58 +0200
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

>> The generic DMA driver can look at the device tree, too.  It's more
>> convenient to only have to look at the dma-controller node, true.
>> But with the proposed tree you have to look at all the channel nodes
>> already.
>
> But if the only way to tell is a phandle from the sound device, it has
> to look at the sound node as well, and somehow figure out where in the
> sound node the phandle is stored.

Yes, like I said, not very convenient.  I don't find a property
per channel to be all that convenient either, but hey that's
just me I suppose.  Either way, the "reserved" property isn't
*needed*.  It's misnamed too btw; the hardware doesn't reserve
anything (how could it?); maybe the channel is unusable for
general purpose stuff though, dunno.

>>> I don't see the need for a master node -- there are no shared  
>>> registers (other than a redundant read-only status summary
>>> register) to synchronize access to.  Each channel would be an
>>> independent device under the SoC bus.
>> The "master" node is needed to describe its register block.  It  
>> doesn't matter whether you want to use those registers currently or
>> not.
>
> It doesn't have a register block, as such.  There's one fairly useless
> read-only register,

There's your register block.  21000..210ff or what was it.

> that if we really wanted to we could describe as a
> second reg resource in each channel, combined with a channel-ID  
> property.

You cannot describe one register in two different nodes.

> I'm not inclined to bother, though -- not because we don't  
> currently use
> it, but because I have a hard time seeing anyone needing to use it.

Unless you're sure no one ever wants to use it, it should be in
the device tree.

> There is no information in that register that is not the individual
> channels' registers.

People use it to get the status of all registers at once.  I/O reads
aren't cheap...

> I'd just lump it in with all of the other assorted
> SoC registers that we don't describe in the device tree.
>
>>> The benefit is that if a channel needs to be driven by (for
>>> example) a sound driver, it can have a different compatible that
>>> will be matched by the sound driver,
>> Nah, the sound node should just point to the channel node, or point
>> to the DMA controller and describe the channel # some other way.
>> There is no need to make a special "sound DMA channel" device name.
>
> It's by far the simplest way to tell the generic DMA driver "do not
> touch".  "fsl,mpc8548-dma" says "this is a generic, mem-to-mem DMA  
> channel".

I would expect it to mean "this is the 8548 DMA controller".

> "fsl,mpc8548-audio-dma" says "this is a non-generic DMA channel,  
> hooked up to an audio codec".

So this DMA channel cannot be used for general purpose stuff
at all?

> Would you prefer something like "fsl,mpc8548-dma-special-purpose"?

Just don't overload the "compatible" property with extra semantics.
Just add some extra property (I'm not happy about "reserved", but
_some_ new property is the way to go).

> Though there's also the possibility that there might be no other  
> node to indicate the function, and that the only way to program the  
> device is to start DMA.
>
>> Sure.  But you yourself already say "most of the time" -- and the
>> device tree doesn't describe how the kernel uses the hardware, it
>> simply describes the hardware itself.
>
> Precisely.  If the fsl,whatever-audio-dma driver wants to call the
> generic DMA code, it can do so without the device tree's help.  I  
> see no reason to give the mem-to-mem DMA driver special status  
> compared to other users of the DMA channels.

Sure, we agree on this.  It is prudent to describe in the sound
node which DMA channel is associated with the sound thing though,
even if this is a SoC and all that.  It is just describing the
hardware; if your sound driver wants to hardcode the DMA stuff,
that's fine with me, but that's no reason to not describe the
relation in the device tree.

>> The sound DMA channel is part of the DMA controller, it is only
>> _connected_ to the sound controller, it shouldn't be described as
>> being more closely connected to the sound stuff than it actually is.
>
> It's not as if I'm suggesting making it a child of the sound node  
> -- just that each channel be a separate SoC-level device, and only  
> mem-to-mem channels match the mem-to-mem driver.

I see no reason to pretend the non-mem-to-mem channels are somehow
different from the mem-to-mem channels.


Segher
