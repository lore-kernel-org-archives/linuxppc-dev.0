Message-ID: <3A7DC4E7.38588294@mvista.com>
Date: Sun, 04 Feb 2001 16:08:55 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Gall <tom_gall@vnet.ibm.com>
CC: Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Power3/4 Was: Re: Fast Altivec
References: <3A7AE117.628B22A6@mvista.com> <20010202125143.D31120@altus.drgw.net> <3A7D8C19.B829A8D0@mvista.com> <3A7DB6B5.7370D32D@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Gall wrote:

> .... At the moment it is nice
> that one define handles issues for the entire family of boxes.

I learned years ago when I did a processor port it was important to
separate the processor and platform specific configuration definitions.
When you do that second platform that uses the same processor you will
discover how badly it was integrated :-).

> .... But you are right
> it could be split and I can see the case for making the split.

It seems like these are CHRP machines with some kind of extended address
bus mapping?  We either need to devise a new configuration name or
integrate the changes with some "CHRP extension" that isn't based on
the POWERx configuration.

>   Which set of changes are you interested in using for the 7450? You say the chip
> has 36 bit addressing, how does that work?

It can use a 36-bit physical address bus, so any processor register that
holds a physical address (SDR, page tables, etc) has "extended" bits
that
can be used when the proper configuration bits are set in the HID0.

I was going to use some of the I/O mapping functions (often with
comments
like "big hack" in them :-), to support this as well.  Generally, I am
looking at some VM changes that allow us to support beyond 4G
virtual/physical
with 32-bit processors (other than using the HIGHMEM hack).  Some of the
things in BRIDGE64 and POWERx are appropriate to use but seem to have
knowledge of the underlying platform, so a slightly different
configuration
name and minor code changes would be useful.  I just started looking and
still have lots of work to do here.

>   6392 messages yet to read... ug!  Boy am I behind in mail since LinuxWorld...

Heh...


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
