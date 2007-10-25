Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32CC5DDDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 03:59:52 +1000 (EST)
Message-ID: <4720DA11.9030103@genesi-usa.com>
Date: Thu, 25 Oct 2007 19:01:53 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
References: <20071024163412.GA17785@ru.mvista.com>	
	<471FC191.6020704@genesi-usa.com>	
	<200710241850.05467.david-b@pacbell.net>
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>
	<47208273.8050601@ru.mvista.com>
In-Reply-To: <47208273.8050601@ru.mvista.com>
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

Compatible property on /builtin@F0000000/usb@F0001000 is

ohci-bigendian
ohci-be
mpc5200-ohci
mpc5200-usb

device_type is "usb", model is "mpc5200-ohci".

Although I worry about cluttering up the cleanup, it is probably just
adding an "if property(big-endian) OR compatible(mpc5200-ohci)"
to that small big-endian check there.

I am currently moving on the assumption that the "correct" device
tree for the Efika (notwithstanding the above) would be

usb@F0001000 {
	device-type = "usb-ohci"
	compatible = "mpc5200-ohci,mpc5200-usb-ohci"
	big-endian
}

Or some variation including all the relevant checked-for
properties.

I don't like the old "ohci-bigendian" and "ohci-be" properties.
Picking out "ohci-bigendian" and "ohci-be" was someone's drunken
idea, I'm sure, so I am happy to let them die a horrible death
and never rear up ever again.

Using mpc5200-ohci out is by far the safest idea, although it
leaves in a rather platform-specific fix, I prefer singling out that
platform and potentially causing nasty looks towards the
direction of Genesi/bplan, than having ohci-bigendian continue
to exist for the sake of it :D

There is another solution; change the properties in the Linux
device tree fixups, but I would loathe that solution as it adds
yet another part of the kernel to track.

Unfortunately the current device tree is a complete, stupid mess,
a result of a bunch of guys not looking at the problem, and I
have said this before (rant mode :) - I think device_type,
compatible should report the KIND of device it is, and the model
property should be used to pick out the particular quirks of
the chipset. We could have had a nice system where "usb" is paired
with compatible "ohci", and model is "mpc5200". No dashes or
spaces or 10 strings to compare..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Valentine Barshak wrote:
> Grant Likely wrote:
>> On 10/24/07, David Brownell <david-b@pacbell.net> wrote:
>>> On Wednesday 24 October 2007, Matt Sealey wrote:
>>>> Can we just make sure real quickly that the changing of compatibles
>>>> doesn't break existing, not-easily-flashable firmwares?
>>> Yeah, I'm not keen on such breakage either...
>>
>> Add my voice to the chorus.  It's okay to change the binding, but make
>> sure the old binding is still supported.
>>
>> Cheers,
>> g.
>>
> 
> Actually, I thought that changing the DTS stuff for mpc52xx boards would 
> suffice. Sorry, I was unaware of Efika firmware here. I'll keep old 
> bindings as well.
> Does the device tree have "ohci-bigendian" or "ohci-be" compatible 
> property on Efika?
> Thanks,
> Valentine.
