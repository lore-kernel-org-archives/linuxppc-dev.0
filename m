Message-ID: <3921B7BD.4C882F0C@charter.net>
Date: Tue, 16 May 2000 16:03:57 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Richard Hendricks <richard.hendricks@motorola.com>,
        duncanp@research.canon.com.au
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net> <39203732.AD113B13@charter.net> <39204117.73C9FE3B@charter.net> <39216021.8FF44C3E@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:
> Dan,
>   By any chance, do you not have +12V applied?

Pretty sure I do - it is supposed to be.  I don't have
a meter handy, so I can't actually measure it - but the
wire is there and so on (and it *is* attached to a power
supply).

>  Also, how are you
> programming your Flash ROM?  Try downloading it and reading the
> memory locations with MPC8bug (normally MPC8bug puts the Flash
> up at 0x02800100), then power off for a minute or two, then
> reset the board normally through MPC8bug and read the memory
> locations again.  It almost sounds like your Flash isn't getting
> programmed at all...

I'm pretty sure it *is* getting programmed.
I'm loading it with a "loadf theSRECfile 10000".
It loads the sections into ram, and then into flash.
After power off/on the board, I can still disassemble
the flash region (02800000) and see what I intended to
be put there.  (Yes, Xreset is at 02800100, and _start is
at 02802000).

> Do an mdi at 0x02800100 to see if your code is properly getting
> programmed.  I've got a feeling that I might know what's going on.

Good, cause I sure don't.  :)

One other point - I think I've determined that the
debug port interrupt *is* being caused by some sort
of timeout (watchdog perhaps?).  I looked a bit more
at the Motorola Init860.s and after setting up
SYPCR early enough, I don't seem to be getting that
interrupt any more.  I only managed to try that once
last night before needing to get to bed, and haven't
had a chance to look at it yet today.  Later tonight
I'll look again and see what I can see...
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
