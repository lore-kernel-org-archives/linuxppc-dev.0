Message-ID: <3923618A.F4D70742@charter.net>
Date: Wed, 17 May 2000 22:20:42 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Richard Hendricks <richard.hendricks@motorola.com>
CC: Nicolas-Peter Pohland <pohland@snom.de>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net> <3920AA9F.2DCA0B2E@charter.net> <3920ED16.A2D26629@snom.de> <3921B844.572E3C63@charter.net> <3922046E.D77E156@charter.net> <3922EE48.1E41DA1B@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:
>
> "Dan A. Dickey" wrote:
...
> > So, I'm attributing this recent success to:
> >         A)  Setting SYPCR in the rom code fairly early on.
> >         B)  Issuing a "rms der 0" to mpc8bug when it is connected.
>
> Interesting.  So clearing the SYPCR early in the ROM code is what
> was preventing you from getting the code to run stand-alone?  Kinda
> odd, considering the initial value of the watchdog is very long,
> and you were having problems getting your Aux LED to turn on
> right at the very beginning.

I believe that was at least a goodly portion of it.
It is interesting to note that the Aux LED still doesn't
blink unless the ADI & mpc8bug are connected.
Stand alone - no blinking light.  I'm going to
attribute this for the time being to the UPM not
being initialized - or some piece of hardware.
In any case, I was trying to use the Aux LED as
an indicator of how far the cpu got through the
code.  Getting to the point of an 8xxrom prompt
at which I can enter 'bootz', hit C/R, and see
linux boot up was enough for me to yank the assembly
version of the Aux LED blinking code.

I also think it was the delays I put in between
turning the light on/off that caused it to take too
long and for the watchdog to bite.

I might add that doing the "rms der 0" helped tremendously
as well.  I can now leave the ADI & mpc8bug connected
(for flashing new code) - but still allow linux to load
& start.  It doesn't without doing that (even though
8xxrom sets DER to 0!).
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
