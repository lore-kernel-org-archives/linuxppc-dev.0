Date: Wed, 7 Nov 2001 22:17:05 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: <hollis@austin.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<davidm@amberdata.demon.co.uk>, <Sven.Dickert@planb.de>
Subject: Re: RFC: i8259.c cleanup
In-Reply-To: <20011107110630.G9471@austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0111072015560.17428-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Nov 2001 hollis@austin.ibm.com wrote:

> I laid out what I saw in
> http://lists.linuxppc.org/linuxppc-workstation/200109/msg00030.html . I could
> be wrong, but our code doesn't seem to match the datasheet very well.

Have you ever see code matching the datasheet, or a chip matching the
datasheet for that matter ? :-)

Oh, and I don't think that there is any integrated 8259 in a chipset which
completely follows the implementation of the discrete part.

>
> I think fixing what we have is the least intrusive, but I tried and failed, so
> it was nice to write code that actually worked. :) I guess the PCI intack
> stuff is too varied to be useful though...
>
> Would you say poking the 8259 directly is more "right" than using 0xbffffff0
> (or equivalent)?

Certainly not. Most ISA bridges (which are the part which contains the
dual 8259 Pathetic Interrupt Controller), are tested in an x86
environment, which generate PCI interrupt acknowledge cycles. So hitting
hardware bugs is much less likely than with polling.

> > Good, but you should add resource request for the edge/level control
> > register while you are at it (0x4d0/4d1). And you should not require
> > 32 bytes for the 8259. On my boards, the super I/O control port is
> > 0x2e-ox2f.
>
> That's what I forgot... that code requests directly from ioport_resource,
> which is what gets us into trouble on vgacon. We should use request_region
> instead of request_resource. Unfortunately vgacon is initialized before the
> VMM, and since request_region calls kmalloc we die very early. :/ I didn't
> check to see if that's a problem here.
>
> The problem with using request_resource(&ioport_resource) in vgacon is that
> our PHB's initialize later, try to reserve their own IO regions (eg
> 0x0->0xffffffff), and fail because vgacon already took 0x3c0 or so.

I'd say that the problem is that the PHB is initialized too late while it
should be one of the first things to be initialized.

I know that there are interactions with debugging/early console. I did
something like this for my MVME boards, switching the host bridge from
PreP to CHRP mappings. There is a transient period in which any kind of
debugging is impossible: you don't have any I/O accessible. But in any
case this kind of remapping is much better done early, actually before
giving control to the kernel in my bootloader...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
