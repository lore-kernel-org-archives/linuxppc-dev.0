Date: Thu, 18 May 2000 07:48:22 -0700 (MST)
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Pismo status
In-reply-to: <v04220800b5492487abdb@[10.0.0.42]>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: luther@dpt-info.u-strasbg.fr,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>,
        Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Message-id: <Pine.SOL.3.95.1000518074410.17922A-100000@dana.ucc.nau.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 May 2000, Timothy A. Seufert wrote:

>
> No, it will not.
>
> The PowerPC 750 (G3) and 7400 (G4) can both fire off an interrupt
> when the on-die temperature sensor reading rises above a trigger
> value (or falls below a second trigger value).  This feature *could*
> be used by an operating system to slow down the CPU (through the
> instruction cache throttling feature) or halt it to prevent
> overheating.  However, there is no hardware feature which can halt
> the CPU without software control.
>

So in other words, without a little bit of help from the OS, the fan won't
come on when it the temperature hits this trigger value.  The temperature
would of course, continue to rise.

> The normal mode is that MacOS controls the fan through the PMU.  The
> PMU is connected to a thermistor located somewhere on the
> motherboard.  MacOS scans the value of this thermistor every so often
> and uses the fan to cool the machine if it's getting warm.  MacOS
> takes advantage of the speed control feature of the fan, so it won't
> crank the fan up to full speed if it doesn't have to.

Has any code been written for LinuxPPC that will let us monitor this
sensor?  I know there's a whole lm_sensors package for i386 and the like,
but is there something like this for us?

> If MacOS fails to turn the fan on for some reason, the PMU acts as a
> backup controller -- it is also monitoring the thermistor and will
> force the fan to turn on at full speed if a moderately high (but not
> yet unsafe) temperature is reached.
>
> If the PMU's fan override fails to stop the computer's temperature
> from rising, and the temperature begins to approach dangerous levels,
> the PMU will simply shut the machine down without asking.  (Most Macs
> since the Mac II have had a thermal shutdown feature like this,
> including the desktops.)
>
> So, at least for 101, the fan should still come on without operating
> system support, followed by an abrupt shutdown if the computer gets
> way too hot.

Yes, my fan does come on Linux.  But it takes a long time, and the case
gets very warm before it does.  I assume this means the PMU has finally
decided it's too hot and turned on the fan.  I know it's most likely not
Linux doing it.

> The current PowerBook G3, 102 (the one with FireWire, popularly and
> in this case correctly known as "Pismo"), does have a different PMU
> than 101.  Apple did a major upgrade to the PMU used with all Core99
> chipset machines, 102 included.  But it's fairly unlikely that Apple
> changed the fan control technique very much.

Yes, I had heard they upgraded the PMU, but I wasn't aware of how much
they had changed it.  Is it just a matter of knowing some extra bits we
can switch on and off in the PMU, or is it more than that?

Tim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
