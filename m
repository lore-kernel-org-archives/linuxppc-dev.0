Message-ID: <395B0CA7.3B3AC0E5@netx4.com>
Date: Thu, 29 Jun 2000 04:45:27 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: guinan@bluebutton.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX IDE
References: <Pine.LNX.4.21.0006290329430.23317-100000@gemini.home.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jamie Guinan wrote:

> m8xx_setup.c doesn't seem to want both IDE and PCMCIA ATA devices
> to exist at the same time, though.  Not sure what to do about that,


It's an interrupt routing issue.  In fact, all of the support
for SouthBridge/8259 controller parts on an 8xx is an interrupt
routing issue.  Mapping the internal interrupts from something
like the PCMCIA into the same space as the PCI/ISA has never
worked in the 8xx port.  You basically get to configure an
"8xx PC" or an "8xx embedded".  Cort and I are constantly working
on some better interrupt mapping scheme, some of it "sticks" in
the kernel sources.  The entire Linux kernel is either "PC" or
not.

I don't know of any production boards that support PCI with ISA
on an 8xx.  You can program the UPM to provide ISA bus timing,
or for a few pennies put a programmable device on the 8xx bus
if you want an IDE device.

> .....  If I can hack
> them to both work at the same time for my own purposes, I'll
> be happy.

You can.....It just won't run on anything else when you are done.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
