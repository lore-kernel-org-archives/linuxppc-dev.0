From: hollis@austin.ibm.com
Date: Wed, 7 Nov 2001 11:06:30 -0600
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org, davidm@amberdata.demon.co.uk,
	Sven.Dickert@planb.de
Subject: Re: RFC: i8259.c cleanup
Message-ID: <20011107110630.G9471@austin.ibm.com>
References: <20011106171559.D9471@austin.ibm.com> <Pine.LNX.4.33.0111071013050.19315-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111071013050.19315-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 07, 2001 at 10:38:27AM +0100, Gabriel Paubert wrote:
>
> The question is why the polling code did not work, subtle timing problems
> or is the code plain wrong ? I suspect that some 8259 accesses were not
> serialized well enough.

I laid out what I saw in
http://lists.linuxppc.org/linuxppc-workstation/200109/msg00030.html . I could
be wrong, but our code doesn't seem to match the datasheet very well.

I think fixing what we have is the least intrusive, but I tried and failed, so
it was nice to write code that actually worked. :) I guess the PCI intack
stuff is too varied to be useful though...

Would you say poking the 8259 directly is more "right" than using 0xbffffff0
(or equivalent)?

> > The patch also cleans up some whitespace (parts of i8259.c were apparently
> > copied and pasted from one xterm to another), adds a few comments, and adds
> > resource_request's for both 8259's.
>
> Good, but you should add resource request for the edge/level control
> register while you are at it (0x4d0/4d1). And you should not require
> 32 bytes for the 8259. On my boards, the super I/O control port is
> 0x2e-ox2f.

That's what I forgot... that code requests directly from ioport_resource,
which is what gets us into trouble on vgacon. We should use request_region
instead of request_resource. Unfortunately vgacon is initialized before the
VMM, and since request_region calls kmalloc we die very early. :/ I didn't
check to see if that's a problem here.

The problem with using request_resource(&ioport_resource) in vgacon is that
our PHB's initialize later, try to reserve their own IO regions (eg
0x0->0xffffffff), and fail because vgacon already took 0x3c0 or so.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
