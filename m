Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3A6B7DDE18
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 04:51:25 +1000 (EST)
Message-ID: <4720E560.8060206@ru.mvista.com>
Date: Thu, 25 Oct 2007 22:50:08 +0400
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
In-Reply-To: <4720DA11.9030103@genesi-usa.com>
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
> Compatible property on /builtin@F0000000/usb@F0001000 is
> 
> ohci-bigendian
> ohci-be
> mpc5200-ohci
> mpc5200-usb
> 
> device_type is "usb", model is "mpc5200-ohci".
> 
> Although I worry about cluttering up the cleanup, it is probably just
> adding an "if property(big-endian) OR compatible(mpc5200-ohci)"
> to that small big-endian check there.
>

We should also keep "ohci-bigendian" and "ohci-be" in the match table.

> I am currently moving on the assumption that the "correct" device
> tree for the Efika (notwithstanding the above) would be
> 
> usb@F0001000 {
>     device-type = "usb-ohci"
>     compatible = "mpc5200-ohci,mpc5200-usb-ohci"

It should also have compatible "usb-ohci" entry as a more general one.
Others are for device-specific quirks:
compatible = "mpc5200-usb-ohci","usb-ohci"

>     big-endian
> }
> 
> Or some variation including all the relevant checked-for
> properties.
> 
> I don't like the old "ohci-bigendian" and "ohci-be" properties.
> Picking out "ohci-bigendian" and "ohci-be" was someone's drunken
> idea, I'm sure, so I am happy to let them die a horrible death
> and never rear up ever again.
:)
> 
> Using mpc5200-ohci out is by far the safest idea, although it
> leaves in a rather platform-specific fix, I prefer singling out that
> platform and potentially causing nasty looks towards the
> direction of Genesi/bplan, than having ohci-bigendian continue
> to exist for the sake of it :D

So, do you suggest to use "mpc5200-ohci" instead of "ohci-be" in the 
match table?

> 
> There is another solution; change the properties in the Linux
> device tree fixups, but I would loathe that solution as it adds
> yet another part of the kernel to track.
> 
> Unfortunately the current device tree is a complete, stupid mess,
> a result of a bunch of guys not looking at the problem, and I
> have said this before (rant mode :) - I think device_type,
> compatible should report the KIND of device it is, and the model
> property should be used to pick out the particular quirks of
> the chipset. We could have had a nice system where "usb" is paired
> with compatible "ohci", and model is "mpc5200". No dashes or
> spaces or 10 strings to compare..
> 
:)

Thanks,
Valentine.
