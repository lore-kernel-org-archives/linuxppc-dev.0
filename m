Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id E7B3FDE145
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 13:57:34 +1000 (EST)
Message-ID: <4A14D12D.4050302@ovro.caltech.edu>
Date: Wed, 20 May 2009 20:57:33 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Sauce.Cheng" <chmhou@sina.com>
Subject: Re: question : DMA of PCI bridge
References: <23628338.post@talk.nabble.com> <4A137E4F.4040900@ovro.caltech.edu>
	<23647394.post@talk.nabble.com>
In-Reply-To: <23647394.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> my processor is MPC8247, on Linux 2.6.11
> 
> in MPC8247 manual reference, the interrupt of DMA unit belonged PCI bridge.
> that is different from SDMA and IDMA. through i do not know what 's the
> different. heard SDMA is used to transfer between CPM and 60x. DMA is used
> to transfer between 60x bus and PCI, or 60x bus - 60x bus. i am not sure.
> 
>> Whether or not you get packing bytes when you access a
>> 16-bit device and transfer the data to a 32-bit destination
>> depends on how the device is mapped. For example, a 16-bit
>> device can be implemented such that it responds to 8-bit,
>> 16-bit, and 32-bit requests, but the 32-bit requests will
>> require more wait-states, since the device has to be
>> read from twice before constructing a 32-bit word to
>> place on the PCI bus.
> 
> ya, that's it
> 
>> Its also possible that the DMA controller can be configured
>> to deal with different source and destination widths. However
>> without knowing what processor or DMA controller you are
>> asking about, theres not much to say.
> 
> in the manual reference charpter 9.13 DMA,  source and destination address
> can be configured. i can not find the hint about source and destination
> widths configured.


I won't have a chance to look at the MPC8247 manual, so
I'll just give a general comment.

If you are DMAing from an internal peripheral, then it's
width will be hard-coded and can be read from the user-manual.

If you are DMAing from a local bus then the local bus definition
should determine what happens. For example, on the MPC8349, you
can put 16-bit flash on the local bus, and configure the local
bus controller to know that it is 16-bits wide. A 32-bit access
by the CPU or DMA controller will generate two reads on the
local bus.

You can investigate to see whether the MPC8247 works similarly.

Cheers,
Dave
