Message-ID: <BE1C564723B3D21191FD0000F840E39801D81499@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Interfaces supported on PPC860?
Date: Thu, 6 Apr 2000 12:04:28 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am planning on running Linux on an existing custom 860-based board, and on
a second board which is still being designed.  The application will include
TCP/IP over Ethernet and PPP interfaces.

Can someone please give me feedback on how difficult this will be?
Specifically, are all of the interfaces I require currently supported in the
kernel?
Or will I have to tweak the kernel code?
Or will I have to write some new drivers?
What could I change on the new board to work better with Linux?
Do the serial drivers support RTS/CTS flow control?

If I should be reading some existing document or web-page instead of asking
the list, please kindly redirect me.  I have looked at the mpx8xx-2.2.13.tgz
code from ppc.kernel.org (I think that's where I got it from), and I have
successfully built and loaded it on a BSE ipEngine.  I haven't looked at the
2.3.x series code yet.


Interfaces of the existing board:

Flash: 1MB(AMD) + 8MB(Intel)

SCC1:	Ethernet (external PHY), using RXD, TXD, RTS, CTS, CD, and RCLKI
	(ethernet chip supplies 20MHz clock on RCLKI)

SCC3:	Async serial: RXD, TXD

SCC4:	Ethernet loopback and enable (using RXD and TXD lines)

SMC1:	Async serial: RXD, TXD

SMC2:	Async serial: RXC, TXD

PortC: general purpose I/O, for a user-space driver of a simple LCD display
and keyboard.



Interfaces of the new board:

Flash: 1MB(AMD) + 8MB(Intel)

SCC1:	Ethernet (external PHY), using RXD, TXD, RTS, CTS, CD, and RCLKI

SCC2: Async serial: RXD, TXD (and flow control if possible)

SCC3:	Async serial: RXD, TXD (and flow control if possible)

SCC4:	Async serial: RXD, TXD (and flow control if possible)

SMC1:	Async serial: RXD, TXD

SMC2:	Async serial: RXC, TXD

PortA: Ethernet loopback and enable control signals

SPI:	Communication with another processor.
	Does the Linux kernel use this at all today?
	If not, I'd probably try to expose it to user space.

PCMCIA: no use for it now, but looking to the future

--
Dave Brown <dbrown03@harris.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
