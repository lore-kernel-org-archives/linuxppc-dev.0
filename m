Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 39250DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 08:39:24 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so458342ywh.39
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 14:39:23 -0700 (PDT)
Message-ID: <4904E38A.9070005@genesi-usa.com>
Date: Sun, 26 Oct 2008 16:39:22 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com>
	<4900F90B.80703@firmworks.com><4901032F.3090805@genesi-usa.com>
	<49011C42.2020101@firmworks.com> <49024646.3050300@genesi-usa.com>
	<20081024222059.1835015F004D@mail181-va3.bigfish.com>
In-Reply-To: <20081024222059.1835015F004D@mail181-va3.bigfish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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



Stephen Neuendorffer wrote:
>> One thing I had a crazy dream about was a GUI-based device tree
>> builder for platforms.
> 
> Why is this crazy?  This is essentially what we do today with PowerPC
> and Microblaze processors in Xilinx FPGAs.  Even for ASIC SOCs, there
> are several commercial 'connect-your-IP on the bus' tools that could (if
> SOC providers thought it was important) generate the 'canonical' device
> tree automagically.

Indeed I have to sit in front of Quartus all day at the moment and the
BDF window, pin planner etc. and the constraints scripts for the megacores
just seemed to me to be a great way to spit out a device tree without
doing any real work.

> I think the real question is: if part of the device tree describes
> 'hardware' (either in the SOC or on the board that, more or less,
> doesn't change) and part represents 'hardware configuration' (e.g. My
> board has my one-off hardware hanging off the gpio bank connected to the
> 40 pin header), then how do we separate the two so that the hardware can
> be in a canonical form separate from the configuration.

Personally, I think that goes against the whole point of the device
tree specification anyway. Or at least the greatest benefit - which is
to allow hardware designers to present to software developers a
reasonable description of what can and usually is an esoteric design
decision (which port goes where and what undetectable hardware is
used for X and Y) without exposing the software developer to the
programming model of each individual device (contrast any other system
where you might have a huge list of registers and positions, and use
a rom monitor to manually poke at certain registers, and need the
board schematics to get anywhere you can't read a chip name off the
board to use)

The definition of the binding defines what every peripheral should
look like if it's present - if the peripheral is multiplexed inside
the chip, then you can just copy-paste one feature and not use the
other. A difference in PHY for something is one thing you just can't
detect sometimes; on different boards, this will be different, but
it is all part of the hardware configuration, and not much to do with
the hardware itself (if you have 12 serial controllers but USB and
ethernet usage means you lose 5 of them to multiplexing, or a SerDes
shared between PCI Express, SATA or RapidIO but only one can be
active.. or a configurable clock module for internal devices which
would have the same quirks as an interrupt controller.. or even an
interrupt controller configured to cascade or slaved to something
else)

> there are even three device tree fragments: one provided by an SOC
> provider, one by a board provider, and one by the user, which can all be
> nicely separated once the great device tree update happens... :)

If you have an SoC provider device tree fragment does it entertain
every possibility in the chip, or just the most common? Does the
board provider dt fragment then allow "disable" certain features in
the previous fragments? See examples above where defining 12 serial ports
on the SoC dts AND usb and ethernet functionality, just can't work,
and the board configuration of these devices is entirely relevant.

Updating a device tree at the user end is very useful but I do not
think that there is any fundamental difference between the hardware
itself and the board configuration from a DT point of view, except
that you need a binding or an example (but not a canonical device
tree excerpt) to base your final tree from. What is inside the SoC
rarely matches what is escaped from the chip, so a premade
fragment you could just load becomes rather redundant. Just a
useful reference would be better and that's what we have already.

As for user fragments we have that on OpenFirmware already* and
the idea that we may actually standardize on this kind of stuff
sort of excites me as it validates the point to remove all the
device tree fixups from Pegasos and Efika in prom_init.c and use
something a little less of the order of "you have to recompile
your kernel every time". Be it a dtb fragment for U-Boot or a
Forth script for real OF, this is such a great idea, I don't
know why it's not already there :)

* http://www.powerdeveloper.org/platforms/efika/devicetree

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
