Date: Mon, 30 Jul 2001 00:16:22 +0100
Subject: Re: Turning on sound in the new iBook
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Bastien Nocera <hadess@hadess.net>,
	Paul Harrison <pfh@csse.monash.edu.au>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010729232006.D79A82F011@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Chaps,

> Just got around trying it, and it works in the sense that "cat /vmlinux
>  > /dev/dsp" produces sound ;)
> The sound although contains a *lot* of noise. You're mentioning on your
> page a modification to dmasound_core, could you share it with us ?

Someone (Jack Moffitt IIRC) reported to me that the Tumbler needed to be
U16.  Having looked at the Darwin code I can find no evidence of this in
Apple's stuff ... however, it might not be up-to-date.

There are a lot of assumptions in dmasound that are related to the AWACS -
especially in the bits that deal with things like the mksound().

I am working on rationalising the driver to partition out stuff that relates
to the AWACS/Screamer/Burgundy - so that the dbdma drive part of it (shared
between _core.c and _awacs.c can be used).

Ironically, it is the mksound() [SysBeep()] code that is giving me most
grief... (in thinking of a better way to do it so that it is not so
chip-dependent).

I'd like to get this done first - because it paves the way for more sensible
driver structure - and, in particular, making the SMP locking sensible.

---

IMHO the most important tumbler/DACA task is getting the keywest-i2c stuff
to be interrupt driven - it is nasty having polled code that might lock up
the kernel for seconds.

---

If the tumbler really needs to be U16 - I can modify the standard code to
make that as another 'exception'.

time is, as always, the killer here...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
