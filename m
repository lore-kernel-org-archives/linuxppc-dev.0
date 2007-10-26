Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 79D98DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 21:26:02 +1000 (EST)
Message-ID: <4721CE82.1060202@ru.mvista.com>
Date: Fri, 26 Oct 2007 15:24:50 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
References: <20071024163412.GA17785@ru.mvista.com>	
	<471FC191.6020704@genesi-usa.com>	
	<200710241850.05467.david-b@pacbell.net>
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>
	<47208273.8050601@ru.mvista.com> <4720DA11.9030103@genesi-usa.com>
	<4720E560.8060206@ru.mvista.com> <47211270.8010606@genesi-usa.com>
In-Reply-To: <47211270.8010606@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Valentine Barshak wrote:
>> Matt Sealey wrote:
>>> Compatible property on /builtin@F0000000/usb@F0001000 is
>>
>> We should also keep "ohci-bigendian" and "ohci-be" in the match table.
> 
> Eh.. maybe.
> 
>>> I am currently moving on the assumption that the "correct" device
>>> tree for the Efika (notwithstanding the above) would be
>>>
>>> usb@F0001000 {
>>>     device-type = "usb-ohci"
>>>     compatible = "mpc5200-ohci,mpc5200-usb-ohci"
>>
>> It should also have compatible "usb-ohci" entry as a more general one.
>> Others are for device-specific quirks:
>> compatible = "mpc5200-usb-ohci","usb-ohci"
> 
> Why? It's in the device_type. You don't need to duplicate it as compatible
> with the same value as in the device_type.

The device-type thing shouldn't be used by Linux kernel.
Please, take a look at this discussion:
http://patchwork.ozlabs.org/linuxppc/patch?order=date&id=13514
Thanks,
Valentine.

> 
>>> Using mpc5200-ohci out is by far the safest idea, although it
>>> leaves in a rather platform-specific fix, I prefer singling out that
>>> platform and potentially causing nasty looks towards the
>>> direction of Genesi/bplan, than having ohci-bigendian continue
>>> to exist for the sake of it :D
>>
>> So, do you suggest to use "mpc5200-ohci" instead of "ohci-be" in the 
>> match table?
> 
> Yes. I think ohci-be and ohci-bigendian should die. After all, it
> might get mixed with Firewire if you are not being careful.
> 
> If we had to start again, device-type of "usb" (that just makes it
> easier all round, it allows a system based on the MPC5200B alone to
> make the assumption of OHCI), compatibles of "usb-ohci" (since this makes
> it very specific that it is not just USB, but the OHCI spec) and big-endian
> property would be all there would be.
> 
> Model property would give the "mpc5200-ohci" value. Since nothing checks
> model (and this is not set on the firmware here), figuring on
> "mpc5200-ohci" as a compatible entry is good enough. Device-specific
> quirks should (Segher? Clarify please) never be futzed into compatible
> properties. At least the IEEE 1275 spec makes it clear that the model
> property is meant to clarify the particular device in question and is
> for information, I think defining a device as "USB", then subordinately
> as "OHCI flavor of USB" and particularly "the USB controller on an
> MPC5200 chip" (model) is all we need here, and in fact in any device.
> 
> You could say the same about any other device - why is the current
> standard to give each node a unique name based on chip docs? 5200
> device tree spec says, use "gpt" as the name for the MPC5200 general
> purpose timers. Why not "timer" as the name, with "fsl,gpt" in the
> device_type or compatible property, and "mpc5200-gpt" in the model
> property? or "fsl,slt" compatible and "mpc5200-slt" model? Or
> "dma-controller" with a *model* of "bestcomm"?
> 
> Some of this makes me grind my teeth so much..
> 
