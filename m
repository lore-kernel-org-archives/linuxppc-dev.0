To: linuxppc-dev@lists.linuxppc.org
Subject: u64 fun and PCI DMA not working for things behind bridges?
From: Daniel Berlin <dberlin@redhat.com>
Date: 01 Mar 2001 00:32:42 -0500
Message-ID: <m2k86a2gw5.fsf@dynamic-addr-83-177.resnet.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In getting firewire working, and trying to get sbp-2 working, on
pismo, i noticed two things:
u64 comparisons seem broken in some cases, and PCI DMA doesn't work
all the time for the firewire device.

First, the u64 stuff
(these are %llx printk's, they have 0's to the left, verified by
looking at the actual memory, since i don't trust u64 on ppc right
now)

Feb 27 18:39:47 dynamic-addr-83-177 kernel: as->start = 0, addr = b2f2040
Feb 27 18:39:47 dynamic-addr-83-177 kernel: as->end = 0, as->end > addr == 0
Feb 27 18:39:47 dynamic-addr-83-177 kernel: as->end = fffffffc, as->end > addr == 0


note that as->end > addr is false.

It should be true.
It's *clearly* greater.

If i trunc them to u32's, it is greater, and besides the crap off to
the left going away (which wasn't relevant to the number anyway),
nothing is different.

The only structures that are troublesome, and don't work without
explicit fiddling, in sbp-2, is the login structure, which contains a
u64 for the password. It seems it somehow screws the fields next to
it, which happen to contain the address to put the login response, or
causes it to read/write those fields wrong.

The password is normally just set to 0.

I think it may be in the wrong byte or bit order, which would explain the
compares failing, and the fact that if I cpu_to_le32 the structure
when copying it from host memory, it gets the right addresses for the
login response, but the rest of it is wrong.

Reversing them before, and letting the controller read them through
physical dma doesn't work.


Oh, and nothing else needs to, or works properly, if byteswapped. We
shouldn't need to byteswap the login "orb" (sbp-2 term),  there's
something screwing us. And i bet it's my friend, u64.


I can't compile the drivers without optimization, or else i get
references to functions that don't exist in the kernel, for some
reason.

Simple u64 tests elsewhere seem to work, but i can definitively show
they don't work here (i've got piles of logs of the raw data of the
stuff it's doing those comparisons on).


Also, as i mentioned, physical dma doesn't seem to work right all the
time, and i'm pretty sure it's not the drivers.

The firewire device is behind the same bridge the GMAC is behind. Is
there something special I need to do to make physical dma work all the
time when the device you are dma'ing to/from is behind a bridge?

It could be a hardware implementation problem in the uni-north FW, of
course. I'm just trying to see if anyone has ever noticed anything.


Right now i have to resort to having the SBP-2 driver emulate physical
dma reads/writes by telling the firewire subsystem driver to redirect
all reads/writes into host memory through a routine that simply does
memcpys.
I also tell the controller it's not allowed to allow physical dma
accesses to be performed (there are filter registers that let you
specify what addresses you'll allow physical dma access to, and what
you want to go through the normal block read/write/quadlet read/write
process) , and that the other side must do it through normal block
reads/write packets.

This works, but it's a little slow, of course.


--Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
