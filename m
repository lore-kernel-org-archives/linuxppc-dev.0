Date: Sat, 29 Dec 2001 10:14:13 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200112291814.fBTIED100179@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Lockup problem with 8260
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm getting a lockup problem. Our kernel is based on Montevista's HHL 2.4.2.
The system has cache problems where the cache doesn't work as desired. I
don't know if that is related. There is a pci bridge in the system, that
I've managed to initialize properly, and the pci system seems to be working
fine.

There are two ethernet ports on the board, and we're using the fcc_enet.c
driver. There is a usb controller on the board, which is a pci device. It
uses the usb-ohci.c driver. The cache problems we're having relate to
external devices acting as a bus master writing into the 8260's dram. The
8260 doesn't detect the changes, instead it uses stale data from its cache.
This problem is endemic to our board and is very irritating. As a hack to
workaround the problem, in the case of the usb driver, I had to move all the
data io buffers into a 4 megabyte local bus ram which is non-cacheable.
So if the usb system tells the usb-ohci driver to send a packet out to the
usb controller, I've first got to copy it to the local bus ram, initiate
the transfer from there, wait until the interrupt signals the data is done,
then copy the buffer from the local bus ram back to the dram buffer. This
hacking into the driver is really grotesque and we shouldn't have to do that.
The 8260 is supposed to have a coherent cache, but for whatever reason our
hardware isn't working properly. No one knows enough here to know how to
fix the problem, or if it is fixable. Is it a configuration issue? Is it
something with the pci bridge we're using (Which is a tundra powerspan).
Also Wolfgang in another thread said he thinks that could be a problem with
the A.1 mask of the 8260 we're using, but I suspect it's not that simple,
this cache trouble is so pervasive it has to be something misconfigured.

ANYWAY, that cache stuff is just background. The lockup bug happens when 3
things happen:
1) Load the usb module with no usb devices plugged in
2) Have one of the ethernet ports plugged into our LAN
3) Do heavy file IO, by repeatedly doing cat /sbin/* > /dev/null

If the usb isn't initialized, the lockup doesn't happen. If I unplug the
ethernet plug, the lockup doesn't happen. If I don't do the heavy file io,
I think it locks up eventually but not as quickly.

The file io makes heavy use of the function __copy_tofrom_user which just
is an equivalent to memcpy but it flushes the cache as it does the copy, I
think. With the BDI2000 connected I can examine the state of the machine
after the lockup. A lot of the time the cpu is frozen on the same instruction
in the function _copy_tofrom_user, the instruction is
 lwz r9,12(r4)
That instruction loads the 32 bit word at location (r4+12) and puts it into
r9. When it is frozen there, r4 is always on an address with the low 5 bits
containing 0x14. The 8260's cache line size is 32 bytes. Before the
fetching of the word 12(r4) it has done 4(r4) and 8(r4). So at this
instruction the address just crossed a cache line. I don't know if that
is relevant, but I think it is. The 8260 I believe will prefetch from memory
an entire cache line once it is accessed. That means 8 memory fetches.

When the usb is initialized, the usb driver tells the usb controller the
address of a 256 byte block of memory in the 8260's memory space that the
usb can use for communication. Once the usb is initialized, about 2000
times per second it is writing a counter into offset 0x80 of that buffer.
That is the usb frame number. It is incrementing at about 2000/second, so
I assume it is being written on every increment but I don't know for sure.
The usb is not generating any hardware interrupts at all until something
is plugged into a usb port. There is a software timer invoked by the
usb driver which happens a few times a second, where it polls the usb
controller to see if anything has been plugged in. I have tried disabling
this software timer, so I am certain that no code in the usb driver is
ever being executed. The lockup still occurs. I believe the usb's
contribution to the problem is just the writing of the word to that address
2000 times a second.

When the ethernet cable is plugged in, even with no noticeable net traffic,
there are packets coming across. Mostly ARP requests. Those are passed to
all hosts on a network. The form is like "what is the IP address associated
with this MAC address" and vice-versa. Those happen pretty frequently,
perhaps a few times a second. When a packet comes it it generates an
interrupt which is serviced by the ethernet driver. I believe those
interrupts are the ethernet's contribution to the problem.

When the machine locks I can't single step anymore, the BDI2000 reports
COP freeze. The machine is in some dead state where nothing can get it out
except a reset. The BDI2000 tech support guys think it is in the checkstop
state. In the docs on the 8260 the cpu goes into the checkstop state if
certain events happen and the machine check exception is disabled. The
events are address parity error, data parity error, or the machine check
external line being driven low by an external device. There is some other
cause which I forget. Now, we're not running with the machine check exception
disabled, it is enabled. The hardware maker says there is nothing driving that
machine check line low on the 8260. A fellow I spoke to thinks the cpu can go
into the checkstop state if you get a machine check exception, then while
servicing that you get another one. He didn't say it that way, he just
said you get one, then another one.

Anyway I'm at my wit's end on this one. Maybe someone more experienced can
look at these facts and the answer will jump out. That's what I'm hoping
at least :^). Thanks for any advice.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
