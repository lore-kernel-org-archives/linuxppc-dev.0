Mime-Version: 1.0
Message-Id: <v04220800b5492487abdb@[10.0.0.42]>
In-Reply-To: <20000517140836.A12638@lambda.u-strasbg.fr>
References: <39226066.BF822A70@mpifr-bonn.mpg.de>
 <Pine.LNX.4.10.10005171253140.16549-100000@opal.biophys.uni-duesseldorf.de
 > <20000517140836.A12638@lambda.u-strasbg.fr>
Date: Wed, 17 May 2000 22:15:24 -0700
To: luther@dpt-info.u-strasbg.fr,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Pismo status
Cc: Albrecht Dreﬂ  <ad@mpifr-bonn.mpg.de>,
        Tim Wojtulewicz <Tim.Wojtulewicz@nau.edu>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:08 PM +0200 5/17/00, Sven LUTHER wrote:
>On Wed, May 17, 2000 at 12:54:22PM +0200, Michael Schmitz wrote:
>>  > Tim Wojtulewicz wrote:
>>  > > No it's definitely supposed to have a fan.  It comes on in MacOS.
>>  > > The problem is that the PMU is not fully supported yet, so it doesn't
>>  > > understand that the processor is too hot.  I'm trying to find
>>  >                       ^^^^^^^^^^^^^^^^^^^^
>>  > Does this mean that I can damage the machine if I just run a high-load
>>  > program?!?
>>
>>  I strongly doubt that. The PMU should handle this autonomously, regardless
>>  of Linux support for the PMU.
>
>Also, i think the ppc cpu will halt itself when becoming too hot,

No, it will not.

The PowerPC 750 (G3) and 7400 (G4) can both fire off an interrupt
when the on-die temperature sensor reading rises above a trigger
value (or falls below a second trigger value).  This feature *could*
be used by an operating system to slow down the CPU (through the
instruction cache throttling feature) or halt it to prevent
overheating.  However, there is no hardware feature which can halt
the CPU without software control.

>  and not let
>itself burn. At elast it was so since the earlier 680x0 cpus.

As far as I know none of the 680x0 CPUs even had an on-die
temperature sensor, let alone a thermal shutdown feature.



I just talked with somebody who worked on the 101 project (popularly
and incorrectly known as "Lombard").  At least for that machine, the
fan is controlled as follows:

The normal mode is that MacOS controls the fan through the PMU.  The
PMU is connected to a thermistor located somewhere on the
motherboard.  MacOS scans the value of this thermistor every so often
and uses the fan to cool the machine if it's getting warm.  MacOS
takes advantage of the speed control feature of the fan, so it won't
crank the fan up to full speed if it doesn't have to.

If MacOS fails to turn the fan on for some reason, the PMU acts as a
backup controller -- it is also monitoring the thermistor and will
force the fan to turn on at full speed if a moderately high (but not
yet unsafe) temperature is reached.

If the PMU's fan override fails to stop the computer's temperature
from rising, and the temperature begins to approach dangerous levels,
the PMU will simply shut the machine down without asking.  (Most Macs
since the Mac II have had a thermal shutdown feature like this,
including the desktops.)

So, at least for 101, the fan should still come on without operating
system support, followed by an abrupt shutdown if the computer gets
way too hot.


The current PowerBook G3, 102 (the one with FireWire, popularly and
in this case correctly known as "Pismo"), does have a different PMU
than 101.  Apple did a major upgrade to the PMU used with all Core99
chipset machines, 102 included.  But it's fairly unlikely that Apple
changed the fan control technique very much.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
