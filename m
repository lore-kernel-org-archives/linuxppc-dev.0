Message-Id: <200005311840.UAA00709@piglet.grunz.lu>
Date: Wed, 31 May 2000 20:40:57 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Lite-On ethernet controller
To: huberj@wpi.edu
cc: jgarzik@mandrakesoft.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000531094520.B652@mclinux.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  31 May, this message from Josh Huber echoed through cyberspace:
>> > lspci -vv output attached because it's too wide.


00:05.0 Ethernet controller: Lite-On Communications Inc: Unknown device c115 (rev 25)
        Subsystem: Asante Technologies, Inc.: Unknown device f001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 30
        Region 0: I/O ports at 1c00 [size=256]
                  ^^^^^^^^^    ^^^^
        Region 1: Memory at c3002000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at c1240000 [disabled] [size=256K]

The IO port region above might be your problem. What machine type is
this? Do you have any ISA slots in your machine? Form the i8259
interrupt controller I deduce it's not a PowerMac...

Have you looked at the driver whether it runs on IO ports or
memory-mapped? Since the two regions above probably represent different
views on the same register file, I'd go memory-mapped (i.e. using region
1 above), if possible.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
