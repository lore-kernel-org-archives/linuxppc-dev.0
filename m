Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 621DBDDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 05:19:31 +1000 (EST)
In-Reply-To: <4695298A.6090604@freescale.com>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
	<20070710161121.GA14556@ld0162-tx32.am.freescale.net>
	<22488704-4826-413B-BD18-F75C2743FB5B@kernel.crashing.org>
	<4694F7A2.6040403@freescale.com>
	<01035B4E-01EB-479A-9AA7-BCFBF6C60904@kernel.crashing.org>
	<46951EE0.6040603@freescale.com>
	<12728378-7DC8-41D9-BCF4-5F883F651E40@kernel.crashing.org>
	<4695298A.6090604@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5790B879-A6F0-4FE7-91FC-9FA812BF8231@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Date: Wed, 11 Jul 2007 21:19:19 +0200
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

>>> that if we really wanted to we could describe as a
>>> second reg resource in each channel, combined with a channel-ID   
>>> property.
>> You cannot describe one register in two different nodes.
>
> Why not?  It's read-only.

Because a register belongs to one, and only one, device
node.  There is no such concept as "read-only registers"
in Open Firmware btw.  How a device (or a driver for a
device) uses the registers is its own business; OF merely
describes what devices uses what address range.

>>> I'm not inclined to bother, though -- not because we don't   
>>> currently use
>>> it, but because I have a hard time seeing anyone needing to use it.
>> Unless you're sure no one ever wants to use it, it should be in
>> the device tree.
>
> There are lots of registers that are used that aren't in the device  
> tree.  This one's pretty low on the priority list to get added, IMHO.

It is in the original proposed tree already.  I see no reason
to take it out.

>>> There is no information in that register that is not the individual
>>> channels' registers.
>> People use it to get the status of all registers at once.  I/O reads
>> aren't cheap...
>
> On-chip I/O reads shouldn't be all that slow...

There's a full sync after every I/O read.  Anyway, it doesn't
matter; the register is there, why not describe it.

>>> It's by far the simplest way to tell the generic DMA driver "do not
>>> touch".  "fsl,mpc8548-dma" says "this is a generic, mem-to-mem  
>>> DMA  channel".
>> I would expect it to mean "this is the 8548 DMA controller".
>
> What if the mem-to-mem channels were explicitly labelled  
> fsl,mpc8548-dma-mem-to-mem?

Why would you?  Why would you put _any_ compatible property in
the individual channels, even; they aren't separate devices
after all.

>>> "fsl,mpc8548-audio-dma" says "this is a non-generic DMA channel,   
>>> hooked up to an audio codec".
>> So this DMA channel cannot be used for general purpose stuff
>> at all?
>
> I don't know if it *can* or not, though it'd be a pretty unusual  
> way of using it.  In any case, the device tree should be able to  
> handle the case where it can't.

Yes, but also the case where it _can_.

>> Sure, we agree on this.  It is prudent to describe in the sound
>> node which DMA channel is associated with the sound thing though,
>> even if this is a SoC and all that.  It is just describing the
>> hardware; if your sound driver wants to hardcode the DMA stuff,
>> that's fine with me, but that's no reason to not describe the
>> relation in the device tree.
>
> Sure, I was never saying that there shouldn't be phandle linkage  
> from the sound node to the dma channel node.  I just don't want the  
> mem-to-mem driver to have to go to great lengths to figure out  
> whether it owns the channel.
>
> Phandle linkage the other way could work, though; if the channel  
> has a phandle set in an attached-device property,

I'm not sure that would cleanly work in all cases, I'll have to
think about it.

> then the mem-to-mem driver leaves it alone.

Yeah that would work.  There are much simpler solutions though.

>> I see no reason to pretend the non-mem-to-mem channels are somehow
>> different from the mem-to-mem channels.
>
> But they are different, just like an SCC UART is different from an  
> SCC ethernet, even though they both go through the SCC.

The SCC is the same; if there was a node describing just the SCC
part, like we have nodes describing _just_ the DMA channel part
here, it would be the same situation.


Segher
