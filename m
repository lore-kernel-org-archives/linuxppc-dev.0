Mime-Version: 1.0
Message-Id: <v04220800b4e5212c2027@[10.0.0.42]>
In-Reply-To: <20000302152244.014464@mailhost.mipsys.com>
References: <20000302152244.014464@mailhost.mipsys.com>
Date: Fri, 3 Mar 2000 00:39:47 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Need reports about PCI I/O conflicts
Cc: dledford@redhat.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:22 PM +0100 3/2/00, Benjamin Herrenschmidt wrote:
>Hi all !
>
>I need reports about the PCI I/O space conflicts that have been mentioned
>here. According to Apple, there is no known OF bug.
>
>Please include your machine model, the dump of /proc/pci, and eventually
>the result of lsprop on the offending card /proc/device-tree entries.

Do you need this info for my system, or was what I sent you enough?
Do you want a straight dump of /proc/pci, or one that has been
filtered for human consumption by lspci?

>Note about the Adaptec problem reported earlier, this is apparently not
>an OF bug, but a combination of an OF "feature" along with a bug in
>Michel patches.
>
>What I think happens is that the firmware (and I suspect this is done by
>the Adaptec OF code on the card, not by OF itself) will "disable" the IO
>accesses and decides that the card should use only memory-mapped
>registers on PPC.

Hmmmm, consider the following:  In my system I have two Adaptec
cards, a 2940UW and a 39160.  Both are having the I/O base problem I
described to you, but only one card has OF code: I'm running the old
version 3.0 Mac firmware on the 2940UW, which predates New World
booting and has no OF code at all.

I have to run this because all firmware versions will hang during
MacOS boot when scanning a certain device on my bus, unless wide
negotatiation is turned off for that device.  (aic7xxx has absolutely
no trouble scanning the same SCSI chain, so I'm pretty sure this is
an Adaptec Mac firmware bug.)  Unfortunately, Adaptec took away the
ability to disable wide negotiation in the newer Mac firmware
versions.

If anybody knows a contact at Adaptec to report this bug, I'd
appreciate it -- I dread trying to make it known through their
apparently user-hostile tech support system.

>It does this by writing 0 in the io space register, but
>doesn't disable IO accesses to the card in the PCI config header (or
>maybe they get re-enabled by the kernel fixup code).

I think the fixup code is re-enabling it if it can:

   PCI: setting IRQ 24 on device 01:18.
   PCI: Correcting IOaddress 0 on device 01:18, now fe000001.
   PCI: Enabling I/O for device 01:18
   PCI: setting IRQ 25 on device 01:20.
   PCI: Correcting IOaddress 0 on device 01:20, now fe000001.
   PCI: Correcting IOaddress 0 on device 01:21, now fe000001.

01:18 is the 2940UW, 01:20 and 01:21 the two channels of the 39160.

I remember looking at the code which enables I/O for a device, but it
wasn't clear to me at that time how it decided whether to enable I/O.


By the way, Doug, can you comment on whether the 39160 should get one
or two IRQs?  I/O and memory base registers are clearly not shared
between the channels, but according to these boot messages, only one
channel gets assigned an IRQ.  (I've confirmed this with lspci.)

I'm guessing only one is required, due to the need to conserve IRQs
in the PC world, but you never know.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
