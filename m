Date: Sat, 2 Dec 2000 19:28:17 -0500
From: Jonathan Lane <jingai@shell.faradic.net>
Message-Id: <200012030028.eB30SHR04153@shell.faradic.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 3COM 3c905c-TX-M.... works, or not?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello, I've been fighting with various 10/100 NIC's for three days now,
including a LinkSys NC100 & LNE100TX, Netgear FA311, and now, a 3com
3c905c-TX-M.  The Netgear didn't work *at all*; the LinkSys cards
worked, but were incredibly flaky; and now it appears the 3com
*somewhat* works (ie, TX light flashes when I ping another machine
on the network), but I can't actually ping any other machines
on the network.  A 'cat /proc/interrupts' shows that there have
been no interrupts serviced for the card:

           CPU0
  1:          0   PMAC-PIC      eth1
  2:          0   PMAC-PIC      MACE-txdma
  3:          0   PMAC-PIC      MACE-rxdma
  4:          0   PMAC-PIC      SCC-txdma
  5:       4412   PMAC-PIC      SCC-rxdma
  6:          0   PMAC-PIC      SCC-txdma
  7:          0   PMAC-PIC      SCC-rxdma
  8:          0   PMAC-PIC      AWACS out
 12:         34   PMAC-PIC      53C94
 13:     223409   PMAC-PIC      MESH
 14:          0   PMAC-PIC      MACE
 15:     133432   PMAC-PIC      SCC
 16:          0   PMAC-PIC      SCC
 17:          0   PMAC-PIC      AWACS
 18:        140   PMAC-PIC      VIA
 19:          0   PMAC-PIC      SWIM3
 20:          0   PMAC-PIC      NMI - XMON
 24:       9202   PMAC-PIC      usb-ohci
BAD:          0

At bootup I get the following:

3c59x.c 16Aug00 Donald Becker and others http://www.scyld.com/network/vortex.html
  The PCI BIOS has not enabled the device at 1/0. Updating PCI command 0014->0015.
eth1: 3Com 3c905C Tornado at 0x1000,  00:01:02:c1:88:c2, IRQ 1
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.

And sometime after attempting to ping another machine, I get:

eth1: transmit timed out, tx_status 00 status e601.
eth1: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, full 0; dirty 16 current 16.
  Transmit list 00000000 vs. c0521a00.
  0: @c0521a00  length 8000002a status 0001002a
  1: @c0521a10  length 8000002a status 0001002a
  2: @c0521a20  length 8000002a status 0001002a
  3: @c0521a30  length 8000002a status 0001002a
  4: @c0521a40  length 8000002a status 0001002a
  5: @c0521a50  length 8000002a status 0001002a
  6: @c0521a60  length 8000002a status 0001002a
  7: @c0521a70  length 8000002a status 0001002a
  8: @c0521a80  length 8000002a status 0001002a
  9: @c0521a90  length 8000002a status 0001002a
  10: @c0521aa0  length 8000002a status 0001002a
  11: @c0521ab0  length 8000002a status 0001002a
  12: @c0521ac0  length 8000002a status 0001002a
  13: @c0521ad0  length 8000002a status 0001002a
  14: @c0521ae0  length 8000002a status 8001002a
  15: @c0521af0  length 8000002a status 8001002a
eth1: Resetting the Tx ring pointer.

Has anyone successfully gotten the 3C905-TX-M to work on a PowerPC
box?  Just FYI, the box in question is a UMAX S900 w/ Sonnet G3/350,
and the NIC is located in PCI slot 4.

I'm sure someone here has attempted to install a second ethernet
card in their PowerPC box, so if no one knows how to get this card
to work, can anyone recommend a card that *does* work?  This is
driving me nuts...

Thanks in advance,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
