Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 514F5DDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 09:45:48 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1346510yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 16:45:46 -0700 (PDT)
Message-ID: <9e4733910807141645l404881b0m1d17d88c26792c78@mail.gmail.com>
Date: Mon, 14 Jul 2008 19:45:46 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
In-Reply-To: <487B9D98.8010008@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
	<20080714165302.GG25448@sirena.org.uk>
	<fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
	<20080714183632.GI25448@sirena.org.uk>
	<487B9D98.8010008@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/14/08, Timur Tabi <timur@freescale.com> wrote:
> Mark Brown wrote:
>
>  > Desktop Management Interface, a standard BIOS interface for getting
>  > system data on x86 class hardware.  Of particular interest here is the
>  > fact that it contains various ID strings for things like motherboard and
>  > chassis - on Linux drivers can be automatically loaded based on these
>  > strings.  See drivers/misc/thinkpad_acpi.c for an example of a driver
>  > that does this.
>
>
> The only problem with this is that the OF probing code in the kernel binds
>  drivers to device tree nodes.  So when a driver claims a node, no other driver
>  will be probed with it.
>
>  So we can't have generic nodes that classify the motherboard and just let
>  everyone get probed on it.

Allowing multiple binds at the root causes the problem of something
like compatible="lite5200b,mpc5200-simple". Both platforms would bind
and that's not what you want.

I'm not a fan of each platform creating a platform device in
arch/powerpc/platforms/*. That implies that each platform would cause
another source file to be added each containing pretty much identical
code. It also makes the mpc5200-simple platform pointless. Of course
this scheme works and I'm doing it right now, but it's clearly not an
optimal solution.

Another scheme would be to add kernel code to always create virtual OF
devices like "lite5200b-fabric" that are derived off from the machine
name that achieved a bind.

A third scheme would be to convert the powerpc machine drivers
themselves to device drivers and move them out of
arch/powerpc/platforms/* into drivers/whatever. Then add the ASoC
fabric code to them. I don't know if you can load device drivers early
enough to load a powerpc machine driver from initrd.

A fourth scheme is to do it at compile time. But that means no
universal firmware images that support multiple hardware revisions. We
have this one today too.

-- 
Jon Smirl
jonsmirl@gmail.com
