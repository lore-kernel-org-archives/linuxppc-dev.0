Date: Fri, 12 Jan 2001 14:18:37 +0000
Subject: Re: iBook Modem via daca, was RE: iBook's daca ...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Christof Petig <christof@petig-baender.de>,
        "Halfmann, Klaus" <klaus.halfmann@feri.de>
Cc: Linux PPC Development <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010112142106.CAF01DB9FD@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 12, 2001, Christof Petig wrote:
> "Halfmann, Klaus" wrote:
>> Many thanks for the people that care about sound on the iBook.
>> While you find out about the i2c interface, please find out
>> how to make the modem audible, too. It must be hidden somewhere
>> around there. Someone (perhaps BenH) then should decide how this
>> can be incorporated into the serial driver (cobalt modem).

> Of course it is related to the i2c interface (the mixer is accessed via
> i2c). The code is there but mixing doesn't work at all.

but the way that the iBook does it is different from the other models.

The iBook injects the Modem sound in analogue -after- the DAC - and it may
be possible for the modem to sound at the same time as another audio signal.

For other models, the modem signal comes in on the ADC side (as an input the
AWACS or Burgundy) and has to be "passed through" or routed digitally.

we need a solution that will work for all models (e.g. Lombard which works
as per second case)... because there are many now with built-in modem
versions.

----

I have a proposal to change the mixer abstraction for dmasound so that the
input selection is dealt with be one of the "special purpose" OSS ioctl
values.

This would get rid of the annoying use of sliders to control two-state
signals. (and, of course, the possibility of the user selecting multiple
inputs to be 'on' at the same time - which is not physically possible in the
hardware).

It would mean, also that we would need a small user-land application to act
like the MacOS sound control panel.

it will also mean that another app (e.g. comms package) could call that
ioctl to enable modem sound through during dial-up.


proposal is not as good as code - I know... *sigh*
I am almost back to speed (still a few problems with the BK tree, actually).

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
