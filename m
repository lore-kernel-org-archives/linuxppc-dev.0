Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	ncunningham@clear.net.nz,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040127104701.GB18666@elf.ucw.cz>
References: <1075154452.6191.91.camel@gaston>
	 <Pine.LNX.4.44.0401271130010.23778-100000@opal.biophys.uni-duesseldorf.de>
	 <20040127104701.GB18666@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1075200963.17953.198.camel@gaston>
Mime-Version: 1.0
Date: Tue, 27 Jan 2004 21:56:04 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> What is "PMU locking"? Is there some part of powermac harware that
> kills machine if you sleep too long with interrupts disabled?

The PMU is the "Power Management Unit". It's a microcontroller
that does a bunch of things, some PM related, but also the ADB
emulation for the keyboard & trackpad on laptops, the real time
clock, battery management, etc...

We communicate with it via an SPI, it's asynchronous (interrupt
driven) protocol (banging things to a shit register basically).

The kernel is continuously talking to the PMU. If for some reason
communication stops in the middle of a message exchange, the PMU
can time out and shuts the box down.

"PMU suspend" is a hook I added to the driver that completes
pending requests and stops answering to "event" interrupts (those
interrupts are sent by the PMU when we need to read it's incoming
event messages, like keystrokes, environement events, etc...).

When we get such an interrupt, we send a command to read the
event and get the data in the reply. The PMU can timeout in the
middle of that exchange, but won't timeout if we don't ask for
the data at all...

On suspend-to-RAM, since the PMU driver drives the whole suspend
process, there is no real problem, it does things the right way.

But with suspend-to-disk, it's just yet-another device, and so we
need to make sure we properly stop pending communication. The quick
hack I did (added a sysdev with suspend/resume hooks for it) may not
be perfect yet :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
