From: "Ron Bianco" <ronb@junction.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: linux 2.4.x, PPC and  openPIC interrupt priorities
Date: Tue, 30 Jan 2001 20:35:29 -0800
Message-ID: <000501c08b3f$3d4645f0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Can anyone please tell me what, if any, distribution of 2.4.x linux is 'best' as a
starting point for porting to our custom 8240 board?  I realize 2.4.x, especially for
PPC, is being updated daily.   Any advice will be greatly appreciated.
I'm also somewhat aware of RTlinux and others, but don't have time to search, read
and compare the plethora of tech doc on kernel versions, changes, and PPC gotchas
right now.

The 8240 is basically an enhanced 603 with an open PIC compatible EPIC and PCI etc.
on chip.

Can anyone also tell me if the 2.4.x-testx kernel now, indirectly at least, handles
'external' interrupt priorities according to the way the open pic registers are
programmed.
i.e. it allows a lower priority interrupt handler to be interrupted by a higher
priority int?

Instead of the old 2.2.x and 2.3.x way of disabling external ints via the MSR  EE bit
until ANY int handler returns.

The EPIC will only assert the int signal to the CPU if a higher priority int comes
along, so the linux interrupt
dispatching code should, ideally, NOT globally disable ints via MSR[EE] when calling
a handler, for PPC anyway.

We are currently testing with HHL 2.3.16-sandpoint8240 and are finding too much
interrupt 'jitter' to be able to service our special PCI device properly while SCSI
disk accesses using the sym53c8xx driver, are going on.

Max.  latency has been found to be >300usec, which is too long for our special device
which interrupts every 167usec.

We have only 3 external ( PCI ) interrupts on our board.

Ethernet - i82559 lowest priority
SCSI     - 52c895 next
special  - highest priority

As far as I can tell so far, neither the eepro100 and sym53c8xx drivers disable ints
themselves.

Desperately yours, Ron

Ron Bianco
Computer Systems Technologist
Level Control Systems
email: ronb@junction.net
phone: 250-549-2558 Ext 8
web:  www.lcsaudio.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
