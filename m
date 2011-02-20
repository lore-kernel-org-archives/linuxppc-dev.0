Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A9C9B7187
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 07:05:22 +1100 (EST)
Subject: Re: Info : Using a PowerMac G5 as a server
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <AANLkTi=bkvv0E6VhHtq9vEvADhPxWfQROkfUMaBqZq4f@mail.gmail.com>
References: <AANLkTi=bkvv0E6VhHtq9vEvADhPxWfQROkfUMaBqZq4f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Feb 2011 07:05:00 +1100
Message-ID: <1298232300.8833.20.camel@pasglop>
Mime-Version: 1.0
Cc: Tony Breeds <tonyb@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Surprisingly, the Linux kernel does a very good job on this machine in
> terms of hardware support and stability : everything works perfectly.
> But the global OS fails pathetically in the two said points.
> Here are my findings so far, I hope it will help people in the same situation :
> 
> 1/ Booting a PowerMac G5 headless
> 
> This hasn't so much to do with Linux per se, but rather with Yaboot
> which seems to be the de-facto standard bootloader on the OpenFirmware
> platform.
> For some reason, at some point in the booting process, yaboot relies
> on a screen being present. If no screen is attached, it will hang. So
> much for headless booting.
> Now I've figured out several workarounds :
>  -> Fake a screen by plugging in a resistor into your VGA port (or to
> your DVI port using an adapter). This sure works, but it's rather
> redneck
>  -> For some reason, the part of yaboot that actually depends on the
> script is the "ofboot.b" forth script. This scripts' purpose is to
> give you an option of booting off of a CD. I really don't get it since
> OpenFirmware itself lets you boot off of a CD just by pressing "C" on
> boot. So basically if you skip ofboot.b, you're good to go. When
> installing yaboot with ybin, ybin sets the "boot-device" variable in
> OpenFirmware to point to ofboot.b. So if you point boot-device
> straight to the yaboo binary, you should be able to boot headless
> without any issue. Here are several ways to do it :

You may want to Tony Breeds. I'm not sure what happen when ofboot.b
tries to "fixup" the input/output devices, but we could certainly make
it easier for ofboot.b to be optional.

>        - Go to the OpenFirmware prompt (Command-Option-O-F on boot),
> and type "setenv boot-device=hd:2,yaboot" (modify the hd:2
> accordingly), then "boot"
>        - You might be able to achieve the same effect using the
> "nvram" tool straight from linux
>        - I think simply removing the "magicboot" line off of
> yaboot.conf might fix it as well
> 
> IOW, it _is_ possible to boot a PowerMac G5 headless on Linux without
> any hardware modification.

Yeah but I think OF gets into all kind of funny state if you try to open
the graphics device with nothing connected, and that's an OF bug, it
shouldn't happen.

> 2/ Rebooting automagically after a power failure
> 
> Now this is less fun : I still don't have any solution to offer. To
> understand the situation, you should know that this has to be set in
> the power-management chip.
> Previous PowerMacs used a "PMU" chip, which was fully supported. All
> you had to do was to echo "server_mode=1" to /proc/pmu/options.
> 
> Thing is, G5's use a new chip, named "SMU". And AFAIK, there's no such
> option for those machines…

Yes, there is. We reverse engineered that a while back and somebody even
wrote a little tool to control it, though I don't remember where that
can be found... If necessary, we can try to dig again, the RE wasn't
that hard.

Cheers,
Ben.

> So if anyone ever knows any element of answer on this, I'd be really
> interested !
> 
> Kind regards,
> 
>  - Romain
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
