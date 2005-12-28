Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D5FF368949
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 02:02:37 +1100 (EST)
Message-ID: <43B2A902.3090008@varma-el.com>
Date: Wed, 28 Dec 2005 18:02:26 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: David Jander <david.jander@protonic.nl>
References: <200512271730.28563.david.jander@protonic.nl>	<20051227214949.GA8236@mail.gnudd.com>
	<200512281000.12073.david.jander@protonic.nl>
In-Reply-To: <200512281000.12073.david.jander@protonic.nl>
Content-Type: text/plain; charset=windows-1252
Cc: socket-can@pengutronix.de, r.schwebel@pengutronix.de,
	linuxppc-embedded@ozlabs.org
Subject: Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Jander wrote:
> Hi all,
> 
> On Tuesday 27 December 2005 22:49, Alessandro Rubini wrote:
> 
>>I need to port ocan to support SJA1000 on an ARM device, as a client
>>asked for it.  Also, another client asked for a 2.6 port, so all of
>>this will happen pretty soon (2-3 weeks). I don't know if that makes
>>any difference.
> 
> 
> That could of course make a difference.... eventually.
> The problem I see with Ocan is that it has a very different API than all the 
> others. I know of at least two others, which try to be compatible (or at 
> least easily portable between) with each other: lincan and can4linux. I am 
> not sure but I think they started from the same base, and somehow agreed to 
> stay API-compatible.

Robert Schwebel et al have worked socket based CAN (i.e. implement CAN
as _net_ dev, not as char), as consequence you will not have problem
with major/minor numbers, duplicated code in drivers for different
chips, could share CAN dev between diff processes _without_ misc. third
party shared libraies, stacked CAN protocols (CANopen/NMEA2000 could be
abstract kernel module)... But currently it is not open for everyone
(due to beta status, AFAIK)

Alessandro, please check Pengutronix work first, may be it will be
helpfull to you to,
Also I permit oneself to quotate _you_ ;) from LDDv3 pp6-7:

"The three classes are:

Character devices

A character (char) device is one that can be accessed as a stream of
bytes (like a file); a char driver is in charge of implementing this
behavior. Such a driver usually implements at least the open, close,
read, and write system calls. The text console (/dev/console) and the
serial ports (/dev/ttyS0 and friends) are examples of char devices, as
they are well represented by the stream abstraction. Char devices are
accessed by means of filesystem nodes, such as /dev/tty1 and /dev/lp0.
The only relevant difference between a char device and a regular file is
that you can always move back and forth in the regular file, whereas
most char devices are just data channels, which you can only access
sequentially. There exist, nonetheless, char devices that look like data
areas, and you can move back and forth in them; for instance, this
usually applies to frame grabbers, where the applications can access the
whole acquired image using mmap or lseek.

Block devices

Like char devices, block devices are accessed by filesystem nodes in the
/dev directory. A block device is a device (e.g., a disk) that can host
a filesystem. In most Unix systems, a block device can only handle I/O
operations that transfer one or more whole blocks, which are usually 512
bytes (or a larger power of two) bytes in length. Linux, instead, allows
the application to read and write a block device like a char device—it
permits the transfer of any number of bytes at a time. As a result,
block and char devices differ only in the way data is managed internally
by the kernel, and thus in the kernel/driver software interface. Like a
char device, each block device is accessed through a filesystem node,
and the difference between them is transparent to the user. Block
drivers have a completely different interface to the kernel than char
drivers.

Network interfaces

Any network transaction is made through an interface, that is, a device
that is able to exchange data with other hosts. Usually, an interface is
a hardware device, but it might also be a pure software device, like the
loopback interface. A network interface is in charge of sending and
receiving data packets, driven by the network subsystem of the kernel,
without knowing how individual transactions map to the actual packets
being transmitted. Many network connections (especially those using TCP)
are stream-oriented, but network devices are, usually, designed around
the transmission and receipt of packets. A network driver knows nothing
about individual connections; it only handles packets."

so CAN _is_ Network interface, but not char device
(how it often implemented).

P.S. Robert, when I check last time, it was mature enogh, so may be time
to open mail-list and svn?

--
Regards
Andrey Volkov
