Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 4293FDDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 05:56:02 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1717692qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 11:56:00 -0700 (PDT)
Message-ID: <49060EC3.1070704@genesi-usa.com>
Date: Mon, 27 Oct 2008 13:56:03 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<20081024032944.GE4267@yookeroo.seuss>
	<49014C69.8020408@firmworks.com>
	<20081024044511.GI4267@yookeroo.seuss>
	<490248C2.9020104@genesi-usa.com>
	<20081026234747.GD22339@yookeroo.seuss>
	<4905E0DC.104@genesi-usa.com>
	<20081027183421.GA1009@oksana.dev.rtsoft.ru>
In-Reply-To: <20081027183421.GA1009@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Anton Vorontsov wrote:
> The GPIO spec doesn't specify a controller bank. It says
> 
> - - - -
> gpio-specifier may encode: bank, pin position inside the bank,
> whether pin is open-drain and whether pin is logically inverted.
> - - - -
> 
> May encode. Or may not encode. FYI, for most (all) SOC GPIO
> controllers we don't use "bank" encoding in the gpio-specifier.

This is exactly 100% precisely why I asked about it, there should at
least be a binding for each specific controller where this is
relevant, but since there is very little variation on "use pin 15
please with these flags" (only what "pin 15" means is undefined
so far, and left to the driver/controller variation) there must
be a generic way to specify groups of IO pins which may not be
consecutive.

I don't get your example;

 > device {
 >	gpios = <&gpio 0 0 &gpio 1 0 &gpio 2 0>;
 > }
 >
 > ^^ Three gpios, 0, 1, 2. Based on a compatible entry Linux can
 >   translate them in any way.
 >
 >   For example GPIO0 - bit 15, GPIO1 - bit 20, GPIO2 - bit 1.

This kind of defeats the object. While the pin numbering may well
be board-specific, it makes sense to maintain it as it relates to
offsets into a register or offsets into a bank of registers the
same way that interrupt mappings on the MPC5200B are ripped out of a
table in the MPC5200B documentation.

What the above example does is give a completely arbitrary
number which only maps to a real pin or offset *inside the driver*
meaning 10 boards with the same chip all have to have different
drivers, gpio_chip libraries to allocate the pins - the driver
to note which pin is for which purpose, and gpiolib to make sure
some driver accessing them has not been loaded twice.

Right?

Even if I have my Efika sitting here I want to share my GPIO
library code between it and the lite5200b - be that making the
"sleep switch" code look for a certain gpio pin marker in the
device tree so it knows what to allocate (so the number isn't
hardcoded into the driver as a compile-time switch or a check
for the /soc node model)

The current model seems to me like it is not getting any benefit
whatsoever from being defined in a device tree, in fact it is
making certain GPIO functionality go back to the hardcoded-per-board
stuff we used to have in arch/ppc.

This is just proving the point that nobody is forward-thinking
about this stuff, and is just implementing hack over hack over
hack to get something to work, and refining it later. We're
already running kernels which need to be specially built for
specially built U-Boot versions, special options for the dtc,
and device trees which change every other week. Specifying the
bare minimum here for the functionality a single user uses
defeats the object of having a descriptive device tree.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
