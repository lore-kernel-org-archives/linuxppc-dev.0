Date: Thu, 19 Jul 2001 23:36:44 +0100
Subject: Re: powermac (other ppc?) events
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010719223636.DAB40DBB56@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> work as well.  As is, volume keys seem to rank low in the priority queue.
> something to get practice on.

Look, I don't have a proper opinion on how the keys are achieved ...

---

all I want is that the sound driver is:

1/ called through the standard ioctl() for volume - however many "volumes"
you want to adjust.

This is so that *your* interface will work with *any* dmasound-supported
hardware (without hacking dmasound for each chipset).

We currently support 3 1/2 chipsets - with two more in the pipeline + Apple
is releasing sound hardware variants faster than we can keep up with the
driver already ;-))

also think about how it might interact with USB audio ...

you ***really*** ***don't*** want to go down the road of hacking every sound
driver for volume keys.


2/ Let dmasound handle the headphone insertion - it is already dealing with
the hardware and the appropriate interrupts.

By all means - if there is a consensus that we *need* User Control over
whether headphone insertion disables the internal speaker (or not) - then I
am happy to use one of the OSS "special purpose" ioctl() values to control
this as a PMac-specific feature - which will work properly via the proper
ioctl().

just my 0.02 euro ...

but I am (at least unofficially) maintaining the driver at the moment.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
