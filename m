Message-ID: <38448D2A.E11E4ADF@netx4.com>
Date: Tue, 30 Nov 1999 21:51:22 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXLite 823 PCMCIA troubles
References: <Pine.LNX.3.96.991130133128.22618B-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark S. Mathews wrote:
> 
> Howdy Folks,
> 
> We've been working with the embedded 2.2.13 kernel on an RPX-Lite CW with
> a XPC823ZT66A processor running at the 50MHz/8MHz setting.


It's not only the RPX Lite.....I have a variety of 8xx boards
and when I have trouble like this with a particular card, it
occurs in all of the boards.


> ............ but our
> accesses to the common memory regions of the card are twitchy.


Same thing I have seen.  The I/O and attribute regions seem
to work OK, but memory regions don't.....on more than one
type of card.


> .....but eventually we wind up with a machine-check.

Which points to some kind of bus timing or protocol problem.


> runs well on the x86, our PowerBook, and on a different 860 based platform
> (non-Linux, no MMU) so we're fairly confident it isn't the code.

Well now, that's interesting (the no MMU, not the non-Linux
part :-).  With the MMU disabled, the accesses behave as guarded.
This is something I have not properly implemented on the 8xx,
and with my somewhat sloppy use of eieio() and synchronization,
I am always waiting for this to come back and haunt me.  Notice
how I buried this important fact in this paragraph.  I will now
properly implement this (yet tonight).  Tell me the kernel version
you are using and I will send some updates for your testing.


How does someone (like me :-) determine what a PCMCIA interface
in something like a PowerBook uses for bus timing?


> One specific question...when setting up the PCMCIA bus timings, the 823
> book lists the settings in units of "clock cycles".  Which clock?


It is the CLKOUT (system/bus) clock.  On the 66MHz processor,
this better be 33 MHz (processor clock / 2).  For 50 MHz or
less, the CLKOUT is the processor clock.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
